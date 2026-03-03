Return-Path: <stable+bounces-222849-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJq/Kiu7pmk7TAAAu9opvQ
	(envelope-from <stable+bounces-222849-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 11:42:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9641ECDED
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 11:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B575C301F596
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 10:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A43039EF31;
	Tue,  3 Mar 2026 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKa8zYLa"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B662539D6FC
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534560; cv=none; b=gU4S+9Y8Ki97pOQjLj7HNN8ovLtH/isOn5efxRMNl7lYalI8rcjmZkqHRQBcI8ysZHk/Z67keqE5nHk48r2P8bd+RDp6KIKe2eNc350GMm438ve32bP6DrHKtn+1Uv+7JhwVwlbdG50NCsNogSmgiZ32fw4x5VT1GqEjSQRAF20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534560; c=relaxed/simple;
	bh=cTfCjSWE6DlYZvFhl9M9SGZxOuZ0XAe+ZqJ5L8+vvr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JaOQkvQ5XNxLPIbObsATWcBa141FAYpdqRkkeShpNKv1/ZCPCY24Swqsrwy4fXilP/I5MN4OTgQOg6bP+0TSsCUJ6LuwwtuVNIL2LACKdA9GC7xZayP6VYMp3GJDTyiNNXuyE7e9Sl8J3PdqQXLrbbAOesIvAbbV+zj1LYXBs/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKa8zYLa; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-660b292aa53so432035a12.2
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 02:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772534556; x=1773139356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pxd24Iulws8d53t6pgE+XfsiOpX6Mj37rlGdYorOY14=;
        b=GKa8zYLaMQQGxk7uzHmdpMER0CBpa1zxD+/+3Bk5TB67WogVkIc6s9qQ/p2RRz29Ba
         carn2PvYkSqgr1JuATd2k4u5H5eT59yGIHxzkdMHYF2Z7H4t9P+DZLnMNpKqMcz3kBRe
         4gCaIOUKZSkczz5RGFbD1z8JM+XXJGFIZsZ7vR8ZjHkvfKmdvt9zpf6+905/NMgwX/Pw
         YQfs/bzzDsXres9zvBTIcpWt7o2Ql5/v61A9csCBMxVns1iQCDDiyGtPIlgy+mFEr3tA
         UASrsyiiVw7WzM1FKFll4cJYh8RfwPLp7sMe8AMO0e82WML3PxNGaTcjcwKKrYrGIZxw
         BA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772534556; x=1773139356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pxd24Iulws8d53t6pgE+XfsiOpX6Mj37rlGdYorOY14=;
        b=pekD/4ApSxfKGKdxlbQhIis3nR4WVN8T4pBkCLUHzRTIoDjfa9KCnbnrLhpCa93Xe1
         tTJUJkcQlG1VuVhAy95x3rjj9P23RKMysnQuK4F0jbaUWYXC7Dww4Xvq4lAlaU6wZcs9
         5/kMOtX3yOq/K6zBEHxlhINcrdDXFImAuwNHOkqmF0P6r0s/c2LnY52gRBwbpsrXsNzT
         WqBTRWd3fUX5CJ6kCI7Z2bUyzbSHGbF94NXVMKFRfxz58aqDMEJU1+EG6pMLoccL4aOK
         88D6xAp7CujOu2roRFRV09IgaibOX81Closz2tljSkleD4iPxBpWl8oKlVcxYAuVRKyf
         v4gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWghq8lJF8YppPdBKn/ZGRemfeMDfbii7wtGs1PdpXSEuQ2O4+/KOLhTCKXAGqVdl5+U61E7SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydF3yYVqnXXObgS3+tuIdl+KeoryyqKooy7aP/VWgd/6BMau8Y
	+mUmzPcplqZ55GTZDZjHS+TLMstSm5RN8Z02uLHKoGcQ/JBbZzpGMd52
X-Gm-Gg: ATEYQzzevbhLt33pKXUK4+BYdGSGjoGTQsDnoyLBooC9FufMu+eTQg0teqRLDS23r5G
	2QyYI2Js0GCAnnTRcx8Br9KJIdpW/ELWNEra9eiwin8B2TPwugxkiBB9Ad6N+9GsMTCpXkP8sFw
	em2WK5eXU0GlKaTU9Vvc6k+An2dcUb09kqEj+muaNGjR8X+Vkz5h6wOvRbMinwb6vAlBv3UY8sd
	uTYUKo8ZEcYTfcl6Lp6eJITYGMiiQ0aap0i/pRsBH+6vQs1SqDIkcYaQMXOwFb2LmincJJEIcd1
	AkKZKsgfLZdwR++pK5EGcLJC8czoaBbmo5pvp7ta+2RT29Opybek0eTv42ND6rW/JDEZajqEoi5
	73C/HNUnD49skEZmQWDScWTcW8yJNNsPeiOoymzT1yajVfZ/L/+xbAonPH4GaiwBARbp0KqX31y
	usZvRcioGMtz56Xazt34dIdKoH0u80ohhuJHU=
X-Received: by 2002:a05:6402:2346:b0:65c:3d82:fbc1 with SMTP id 4fb4d7f45d1cf-65fdd6b63b2mr10300390a12.4.1772534555563;
        Tue, 03 Mar 2026 02:42:35 -0800 (PST)
Received: from zenbook ([176.98.224.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fac06e28csm4174229a12.27.2026.03.03.02.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 02:42:34 -0800 (PST)
From: Sheroz Juraev <goodmartiandev@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Sheroz Juraev <goodmartiandev@gmail.com>
Subject: [PATCH] wifi: iwlwifi: mld: stop TX during firmware restart
Date: Tue,  3 Mar 2026 15:42:17 +0500
Message-ID: <20260303104217.180715-1-goodmartiandev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AF9641ECDED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222849-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goodmartiandev@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

When iwlwifi firmware crashes (e.g., NMI_INTERRUPT_UNKNOWN on Intel
BE201/Wi-Fi 7), iwl_mld_nic_error() sets mld->fw_status.in_hw_restart
to true. However, iwl_mld_tx_from_txq() does not check this flag before
dequeuing frames from mac80211 and pushing them to the transport layer.

Since the firmware is dead, iwl_trans_tx() returns -EIO for each frame,
which then gets freed immediately. Under high-throughput conditions
(e.g., Tailscale UDP traffic or active SSH sessions), this creates a
tight dequeue-send-fail-free loop that wastes CPU cycles and generates
rapid skb allocation churn, leading to memory pressure from slab
fragmentation.

The RX path already has this guard (iwl_mld_rx_mpdu checks
in_hw_restart at rx.c:1906), and so does the TXQ allocation worker
(iwl_mld_add_txqs_wk at tx.c:156). Add the same guard to
iwl_mld_tx_from_txq() to stop all TX during firmware restart.

Frames left in mac80211's TXQs are naturally drained after restart
completes, when queue reallocation triggers iwl_mld_tx_from_txq()
via iwl_mld_add_txq_list(), or when new upper-layer traffic invokes
wake_tx_queue.

Tested on ASUS Zenbook 14 UX3405CA with Intel BE201 (Wi-Fi 7) on
kernel 6.19.5 where the firmware crashes approximately every 10-15
minutes under Tailscale traffic.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sheroz Juraev <goodmartiandev@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/tx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index 3b4b575aa..c5eb36652 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -959,6 +959,16 @@ void iwl_mld_tx_from_txq(struct iwl_mld *mld, struct ieee80211_txq *txq)
 	struct sk_buff *skb = NULL;
 	u8 zero_addr[ETH_ALEN] = {};

+	/*
+	 * Don't transmit during firmware restart. The firmware is dead,
+	 * so iwl_trans_tx() would return -EIO for each frame. Avoid the
+	 * overhead of dequeuing from mac80211 only to immediately free
+	 * the skbs, and the potential memory pressure from rapid skb
+	 * allocation churn during high-throughput restart scenarios.
+	 */
+	if (unlikely(mld->fw_status.in_hw_restart))
+		return;
+
 	/*
 	 * No need for threads to be pending here, they can leave the first
 	 * taker all the work.
--
2.47.2

