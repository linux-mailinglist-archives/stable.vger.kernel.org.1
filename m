Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED96D7A7CB0
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbjITMDU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbjITMDS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:03:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30222D7
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:03:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F99FC433C8;
        Wed, 20 Sep 2023 12:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211390;
        bh=/0WfPI1Ft2i08Cs+fGSVR+Hr/0FJ7vLweA/NXpJN6MQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WG8UKN+yiJssOIsXqQWqaVsctyY3n9fgEvmz8TDzpINM2+k0ahuL2iLnWn3IfwdJa
         25UVgPjdcv+DlmpQCWUezb+57W/QwDM9o2sQ+FToAfNNvFJNP7a07tZ8AU9RdSywvr
         X1DS0NxxWSMx9XgW8iufX+bhdYsDafktOKXTdRZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fedor Pchelkin <pchelkin@ispras.ru>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 049/186] wifi: ath9k: protect WMI command response buffer replacement with a lock
Date:   Wed, 20 Sep 2023 13:29:12 +0200
Message-ID: <20230920112838.693876103@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit 454994cfa9e4c18b6df9f78b60db8eadc20a6c25 ]

If ath9k_wmi_cmd() has exited with a timeout, it is possible that during
next ath9k_wmi_cmd() call the wmi_rsp callback for previous wmi command
writes to new wmi->cmd_rsp_buf and makes a completion. This results in an
invalid ath9k_wmi_cmd() return value.

Move the replacement of WMI command response buffer and length under
wmi_lock. Note that last_seq_id value is updated there, too.

Thus, the buffer cannot be written to by a belated wmi_rsp callback
because that path is properly rejected by the last_seq_id check.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230425192607.18015-2-pchelkin@ispras.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/wmi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index 7b4e922181190..e0ecd2e867477 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -279,7 +279,8 @@ int ath9k_wmi_connect(struct htc_target *htc, struct wmi *wmi,
 
 static int ath9k_wmi_cmd_issue(struct wmi *wmi,
 			       struct sk_buff *skb,
-			       enum wmi_cmd_id cmd, u16 len)
+			       enum wmi_cmd_id cmd, u16 len,
+			       u8 *rsp_buf, u32 rsp_len)
 {
 	struct wmi_cmd_hdr *hdr;
 	unsigned long flags;
@@ -289,6 +290,11 @@ static int ath9k_wmi_cmd_issue(struct wmi *wmi,
 	hdr->seq_no = cpu_to_be16(++wmi->tx_seq_id);
 
 	spin_lock_irqsave(&wmi->wmi_lock, flags);
+
+	/* record the rsp buffer and length */
+	wmi->cmd_rsp_buf = rsp_buf;
+	wmi->cmd_rsp_len = rsp_len;
+
 	wmi->last_seq_id = wmi->tx_seq_id;
 	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 
@@ -329,11 +335,7 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
 		goto out;
 	}
 
-	/* record the rsp buffer and length */
-	wmi->cmd_rsp_buf = rsp_buf;
-	wmi->cmd_rsp_len = rsp_len;
-
-	ret = ath9k_wmi_cmd_issue(wmi, skb, cmd_id, cmd_len);
+	ret = ath9k_wmi_cmd_issue(wmi, skb, cmd_id, cmd_len, rsp_buf, rsp_len);
 	if (ret)
 		goto out;
 
-- 
2.40.1



