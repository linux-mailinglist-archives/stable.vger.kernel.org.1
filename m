Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC3C6FA982
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbjEHKwP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbjEHKvz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:51:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C2B2FCFC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:51:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 313C362918
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF7AC433D2;
        Mon,  8 May 2023 10:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543081;
        bh=SSfty5k5frekUJIoyYf4pgyqGQ8iyw42iJoT+FBngcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WRf4K1tId9Og7UwvFgG2XgVqtBhxoB4ZKquQvAIFZ4Dnsr4t2HF8slbcaRo48Wz0p
         JQmei7NbFRuZ6E9MG7qvQBDigwvZ9IlTx0Frb0okz3ZdrOSkC4pjfCFcAYnhPhm/Dg
         BfwXSKd5dLN1NBU499fjPdtPv/pxJDy7tcfMMaf0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Cindy Lu <lulu@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 6.2 644/663] vhost_vdpa: fix unmap process in no-batch mode
Date:   Mon,  8 May 2023 11:47:50 +0200
Message-Id: <20230508094450.933620156@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Cindy Lu <lulu@redhat.com>

commit c82729e06644f4e087f5ff0f91b8fb15e03b8890 upstream.

While using the vdpa device with vIOMMU enabled
in the guest VM, when the vdpa device bind to vfio-pci and run testpmd
then system will fail to unmap.
The test process is
Load guest VM --> attach to virtio driver--> bind to vfio-pci driver
So the mapping process is
1)batched mode map to normal MR
2)batched mode unmapped the normal MR
3)unmapped all the memory
4)mapped to iommu MR

This error happened in step 3). The iotlb was freed in step 2)
and the function vhost_vdpa_process_iotlb_msg will return fail
Which causes failure.

To fix this, we will not remove the AS while the iotlb->nmaps is 0.
This will free in the vhost_vdpa_clean

Cc: stable@vger.kernel.org
Fixes: aaca8373c4b1 ("vhost-vdpa: support ASID based IOTLB API")
Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20230420151734.860168-1-lulu@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/vdpa.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -819,11 +819,7 @@ static void vhost_vdpa_unmap(struct vhos
 		if (!v->in_batch)
 			ops->set_map(vdpa, asid, iotlb);
 	}
-	/* If we are in the middle of batch processing, delay the free
-	 * of AS until BATCH_END.
-	 */
-	if (!v->in_batch && !iotlb->nmaps)
-		vhost_vdpa_remove_as(v, asid);
+
 }
 
 static int vhost_vdpa_va_map(struct vhost_vdpa *v,
@@ -1080,8 +1076,6 @@ static int vhost_vdpa_process_iotlb_msg(
 		if (v->in_batch && ops->set_map)
 			ops->set_map(vdpa, asid, iotlb);
 		v->in_batch = false;
-		if (!iotlb->nmaps)
-			vhost_vdpa_remove_as(v, asid);
 		break;
 	default:
 		r = -EINVAL;


