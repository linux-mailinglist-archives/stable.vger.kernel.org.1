Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFDF79AF1A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243022AbjIKU66 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240127AbjIKOhN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:37:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23A0F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:37:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442CBC433C8;
        Mon, 11 Sep 2023 14:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443028;
        bh=qX6ElHOxShOMBww12w07i8hXQ7ocn+/ua5kHcH+HVAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=StHRk/X9pOkg29CCizty5FA6GkcQ9L4hnsbEYI7CO7ve9M/aWDNCO8lG4I5qik2Q5
         dzBezOizwJfZ8wCuAOTm21r5uZAKO5KHbV2x0iWgmIjJ2gZbG6jy6yzCfhUiHTnrGt
         eXtHVfMwq2oOCo/EsdjSH9WcAKjHUyvXANis4awk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fedor Pchelkin <pchelkin@ispras.ru>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 232/737] wifi: ath9k: fix races between ath9k_wmi_cmd and ath9k_wmi_ctrl_rx
Date:   Mon, 11 Sep 2023 15:41:31 +0200
Message-ID: <20230911134657.078143245@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit b674fb513e2e7a514fcde287c0f73915d393fdb6 ]

Currently, the synchronization between ath9k_wmi_cmd() and
ath9k_wmi_ctrl_rx() is exposed to a race condition which, although being
rather unlikely, can lead to invalid behaviour of ath9k_wmi_cmd().

Consider the following scenario:

CPU0					CPU1

ath9k_wmi_cmd(...)
  mutex_lock(&wmi->op_mutex)
  ath9k_wmi_cmd_issue(...)
  wait_for_completion_timeout(...)
  ---
  timeout
  ---
					/* the callback is being processed
					 * before last_seq_id became zero
					 */
					ath9k_wmi_ctrl_rx(...)
					  spin_lock_irqsave(...)
					  /* wmi->last_seq_id check here
					   * doesn't detect timeout yet
					   */
					  spin_unlock_irqrestore(...)
  /* last_seq_id is zeroed to
   * indicate there was a timeout
   */
  wmi->last_seq_id = 0
  mutex_unlock(&wmi->op_mutex)
  return -ETIMEDOUT

ath9k_wmi_cmd(...)
  mutex_lock(&wmi->op_mutex)
  /* the buffer is replaced with
   * another one
   */
  wmi->cmd_rsp_buf = rsp_buf
  wmi->cmd_rsp_len = rsp_len
  ath9k_wmi_cmd_issue(...)
    spin_lock_irqsave(...)
    spin_unlock_irqrestore(...)
  wait_for_completion_timeout(...)
					/* the continuation of the
					 * callback left after the first
					 * ath9k_wmi_cmd call
					 */
					  ath9k_wmi_rsp_callback(...)
					    /* copying data designated
					     * to already timeouted
					     * WMI command into an
					     * inappropriate wmi_cmd_buf
					     */
					    memcpy(...)
					    complete(&wmi->cmd_wait)
  /* awakened by the bogus callback
   * => invalid return result
   */
  mutex_unlock(&wmi->op_mutex)
  return 0

To fix this, update last_seq_id on timeout path inside ath9k_wmi_cmd()
under the wmi_lock. Move ath9k_wmi_rsp_callback() under wmi_lock inside
ath9k_wmi_ctrl_rx() so that the wmi->cmd_wait can be completed only for
initially designated wmi_cmd call, otherwise the path would be rejected
with last_seq_id check.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230425192607.18015-1-pchelkin@ispras.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/wmi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index d652c647d56b5..04f363cb90fe5 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -242,10 +242,10 @@ static void ath9k_wmi_ctrl_rx(void *priv, struct sk_buff *skb,
 		spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 		goto free_skb;
 	}
-	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 
 	/* WMI command response */
 	ath9k_wmi_rsp_callback(wmi, skb);
+	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 
 free_skb:
 	kfree_skb(skb);
@@ -308,8 +308,8 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
 	struct ath_common *common = ath9k_hw_common(ah);
 	u16 headroom = sizeof(struct htc_frame_hdr) +
 		       sizeof(struct wmi_cmd_hdr);
+	unsigned long time_left, flags;
 	struct sk_buff *skb;
-	unsigned long time_left;
 	int ret = 0;
 
 	if (ah->ah_flags & AH_UNPLUGGED)
@@ -345,7 +345,9 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
 	if (!time_left) {
 		ath_dbg(common, WMI, "Timeout waiting for WMI command: %s\n",
 			wmi_cmd_to_name(cmd_id));
+		spin_lock_irqsave(&wmi->wmi_lock, flags);
 		wmi->last_seq_id = 0;
+		spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 		mutex_unlock(&wmi->op_mutex);
 		return -ETIMEDOUT;
 	}
-- 
2.40.1



