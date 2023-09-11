Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0121079B54D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351560AbjIKVnW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241896AbjIKPRR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:17:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D099EFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:17:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAEAC433C7;
        Mon, 11 Sep 2023 15:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445432;
        bh=94hndFtG2tnKoTYqE6sLT8sKQqblwsox1wsdXepnDj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ovr3XTvzXlvVy09e2NaBrbyfJVbDifC1JCBOdIzsLR+sbRqZeqcC1wASyQaNiwXO0
         Aw14M7DjHflsoBsn2xaZtmXoT15na0gv56mO5s+E0Pu3JTaUcsYSzGfYeBi8AMHR0H
         4YL3hLBpIlVwNAfRGn2kkYHoXD6i0DBB0a58NAaY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alex Williamson <alex.williamson@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 346/600] kvm/vfio: ensure kvg instance stays around in kvm_vfio_group_add()
Date:   Mon, 11 Sep 2023 15:46:19 +0200
Message-ID: <20230911134643.899568279@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 9e0f4f2918c2ff145d3dedee862d9919a6ed5812 ]

kvm_vfio_group_add() creates kvg instance, links it to kv->group_list,
and calls kvm_vfio_file_set_kvm() with kvg->file as an argument after
dropping kv->lock. If we race group addition and deletion calls, kvg
instance may get freed by the time we get around to calling
kvm_vfio_file_set_kvm().

Previous iterations of the code did not reference kvg->file outside of
the critical section, but used a temporary variable. Still, they had
similar problem of the file reference being owned by kvg structure and
potential for kvm_vfio_group_del() dropping it before
kvm_vfio_group_add() had a chance to complete.

Fix this by moving call to kvm_vfio_file_set_kvm() under the protection
of kv->lock. We already call it while holding the same lock when vfio
group is being deleted, so it should be safe here as well.

Fixes: 2fc1bec15883 ("kvm: set/clear kvm to/from vfio_group when group add/delete")
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20230714224538.404793-1-dmitry.torokhov@gmail.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/vfio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index af3d0cf06e4c6..365d30779768a 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -180,10 +180,10 @@ static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
 	list_add_tail(&kvf->node, &kv->file_list);
 
 	kvm_arch_start_assignment(dev->kvm);
+	kvm_vfio_file_set_kvm(kvf->file, dev->kvm);
 
 	mutex_unlock(&kv->lock);
 
-	kvm_vfio_file_set_kvm(kvf->file, dev->kvm);
 	kvm_vfio_update_coherency(dev);
 
 	return 0;
-- 
2.40.1



