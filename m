Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ED77BE198
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377447AbjJINv5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377454AbjJINvy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:51:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055BEDF
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:51:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4852EC433C8;
        Mon,  9 Oct 2023 13:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859512;
        bh=PRuwCQtxtZB6IZVPlkSCtnYFGC+L0rg7cNKVf//LS6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aRUltmJ1lTIyCW25CEUJ2FqhCUFqDQju7ItTWODNn5v1wZbDWmfR8qxISRexgM+eY
         iw98VtevdGbPXWtMDGVbu6HJNV9eAXyu09E0mVNYYQP/tWuj9wtI+Ft+i48H5uZcxr
         9y+sKwWbicpy5O3de8RFav+oNusVQ195PvBf+B+8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 45/91] scsi: megaraid_sas: Enable msix_load_balance for Invader and later controllers
Date:   Mon,  9 Oct 2023 15:06:17 +0200
Message-ID: <20231009130113.085347117@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.518916887@linuxfoundation.org>
References: <20231009130111.518916887@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>

[ Upstream commit 1175b88452cad208894412b955ee698934968aed ]

Load balancing IO completions across all available MSI-X vectors should be
enabled for Invader and later generation controllers only.  This needs to
be disabled for older controllers.  Add an adapter type check before
setting msix_load_balance flag.

Fixes: 1d15d9098ad1 ("scsi: megaraid_sas: Load balance completions across all MSI-X")
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index bdfa36712fcc4..ac4800fb1a7fb 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5364,7 +5364,8 @@ static int megasas_init_fw(struct megasas_instance *instance)
 					instance->is_rdpq = (scratch_pad_2 & MR_RDPQ_MODE_OFFSET) ?
 								1 : 0;
 
-				if (!instance->msix_combined) {
+				if (instance->adapter_type >= INVADER_SERIES &&
+				    !instance->msix_combined) {
 					instance->msix_load_balance = true;
 					instance->smp_affinity_enable = false;
 				}
-- 
2.40.1



