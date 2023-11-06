Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362977E2533
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjKFN3S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjKFN3R (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:29:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358EAA9
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:29:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785FEC433C7;
        Mon,  6 Nov 2023 13:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277354;
        bh=x1p3x4DYjMThK0X1jQu5vc6ZogdJiSAugci61pV96rA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MKxo9fhDGpq7AQvX+IfsMPvY1/ePM5/9l49GnRDgwmBx1FV1HShnABDf0BDVQtHEO
         ipDqT7ZEEjGPlTamY5+oCyXFurl1YbDnz3O9boJb/O5PPdYjKvrPODZdkXAxC00Oy9
         8xbXZ63JAq9ypd7mI5PY0Ezz2yMZhu8SvOwJFq60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liming Sun <limings@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 096/128] platform/mellanox: mlxbf-tmfifo: Fix a warning message
Date:   Mon,  6 Nov 2023 14:04:16 +0100
Message-ID: <20231106130313.523127719@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liming Sun <limings@nvidia.com>

[ Upstream commit 99c09c985e5973c8f0ad976ebae069548dd86f12 ]

This commit fixes the smatch static checker warning in function
mlxbf_tmfifo_rxtx_word() which complains data not initialized at
line 634 when IS_VRING_DROP() is TRUE.

Signed-off-by: Liming Sun <limings@nvidia.com>
Link: https://lore.kernel.org/r/20231012230235.219861-1-limings@nvidia.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 194f3205e5597..767f4406e55f1 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -588,24 +588,25 @@ static void mlxbf_tmfifo_rxtx_word(struct mlxbf_tmfifo_vring *vring,
 
 	if (vring->cur_len + sizeof(u64) <= len) {
 		/* The whole word. */
-		if (!IS_VRING_DROP(vring)) {
-			if (is_rx)
+		if (is_rx) {
+			if (!IS_VRING_DROP(vring))
 				memcpy(addr + vring->cur_len, &data,
 				       sizeof(u64));
-			else
-				memcpy(&data, addr + vring->cur_len,
-				       sizeof(u64));
+		} else {
+			memcpy(&data, addr + vring->cur_len,
+			       sizeof(u64));
 		}
 		vring->cur_len += sizeof(u64);
 	} else {
 		/* Leftover bytes. */
-		if (!IS_VRING_DROP(vring)) {
-			if (is_rx)
+		if (is_rx) {
+			if (!IS_VRING_DROP(vring))
 				memcpy(addr + vring->cur_len, &data,
 				       len - vring->cur_len);
-			else
-				memcpy(&data, addr + vring->cur_len,
-				       len - vring->cur_len);
+		} else {
+			data = 0;
+			memcpy(&data, addr + vring->cur_len,
+			       len - vring->cur_len);
 		}
 		vring->cur_len = len;
 	}
-- 
2.42.0



