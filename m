Return-Path: <stable+bounces-233464-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM9UN5RF1GnVsQcAu9opvQ
	(envelope-from <stable+bounces-233464-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 01:45:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4996E3A8479
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 01:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66422308D6E0
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 23:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5301139EF1C;
	Mon,  6 Apr 2026 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuIR1AHV"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD4539FCD2
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775518994; cv=none; b=RIMx5mdb0H9lOiryZi8c9c6A4CUZjUBU/3og499GaUT+IJU2Z/JS8QwOJvDa/OFzV0ArRQzs3X64pO7LgZieX2z23hYjyD9/+/fBYCIBNib3mq/q7/Th6gAvHXr2Fg3pWfyq7npb13TajjFPYysXmVW4NRFH/dvyMNBRCOegb+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775518994; c=relaxed/simple;
	bh=ES5Wx77hnfPJwf+p4gTlHwl/GrAofS3FOUzFe1CqPcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkoQpHpeAN9HhF+3NfW/srWgOab9qxRL20rW6K/2Z9/tNa8NE2s1hbqTSRUZl9XNyI24rcWVX/k80gSed+MXD19J4lmCJl9mQosiuujurm54pN5SxTnorzG1J8Qg/fUxSBDkVY5RinsLgrf1wfk06Y0jbBUC+nfs/SDOrFMEAQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuIR1AHV; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79db5e18ac6so49426917b3.1
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 16:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775518992; x=1776123792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKiu2zHNYp38GBjq5TVo1PRhtRMef2XaxqRl1STw6Cw=;
        b=cuIR1AHV7jlKoDPYpneaTLQVxL/7yusEX+r4MM3kixSEpq5wgjjQLsxr1W3JrvbrwO
         G5KG7vNVIbEsGsDgkBU4sst1EkOiwWck9QB37LRh28iI99P2eoh35Q5jzIEs05kjxJCD
         ORaIsRXMifN3nwdYGcvowX4ijuvgO2EPNbaHqlEt1Z6Z2mB5HsgmqJh8I6iAtpvBaSF1
         wIqbuF8oxl1KGPP4vooHxl08G5//R5M1AHvjPhU70GBELcF0dG6ot2T7Skds5YS5gq7A
         dRhQVllNapnvjIBZVurVLts/MLHNp9fAT/KgIT1OY5Y3djZZcnt8UW0ovZRoJOtWgYxj
         5NJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775518992; x=1776123792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gKiu2zHNYp38GBjq5TVo1PRhtRMef2XaxqRl1STw6Cw=;
        b=gsKZSRBI4P4J31ToPdRArolcggHS08UKytfboXn7HUqPq9LePMcyv+lXzNsWeirPsM
         AUAep/IKgBDCAPiymDYk4Gh0rIYuCm/d3lqc7+0BmGjf2MO9KqFZz0B0Z8Xv9uVLob9Y
         7JU/NeuRXlKXi2lG0HI1/6lR6r/KYHm69lODvCMwgy38mlC28RIIVKHsdqxXPc4OvuNT
         4/9vG8I1F6bKk216FQNPkYXnBOaG3GOLlffxsi/SZDtWTgh8x/rKungvHFIQCSVMqoLw
         M4H/uNIuQDakEcxzSbLN/ti5xS5nALdsBNoivT5jONRJ5ZqDsTwthNPsDYhyqnw7tRzZ
         ed1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJCmntn4MYxPNF/rpfXHyw/0NseBgkDzHVskpujGTOUE6BMtP1KDWdsbMG9nD/ZMIDiWwuWhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbIp5TeR8hWd/dl3Nojn0pvJ89X6I2Q1KRnuQclBlLXlZSN2CZ
	OWcoBQHTIfYLsPSkncksUMfcogwF8asoq0ATXo2j+NgxX/Y0lXCO6D63
X-Gm-Gg: AeBDiesulCubrg9pgpJRXNxLdTraoHfVQsFAQKK9EPywHi4WDiaYcPFgGH2ZRcfkTIc
	XvsNdhKTCjCIqq5PExeGjJshDG4Zbcz+gUXxJAqXX06JMoA7kpAiJZLPPj1ssAZKWsUdev2ptQA
	iXr55esObVRukAc0jn3m6lIdntqMiMUYe5iwV8AQX9TG5GO2P0fgKJDvbvtnq2R7S3hccLtjKnr
	NGMTcmebV0CYL1EFyDP0qocqwu2EE7xBIux0CIqzNOdWOemJdV1pk/A69y9wxkywDP8EtaEyXFx
	/31i8J1XTkkuWuq4v5qkEVPOjEGdmH4SHFgyPKkYO5jhJZOnZZauMxqs0OQ1JP2AKBEoJq9Pyd5
	VLk3QhhCQ6mZMt5X7+OCCPgU57IkWbyOj1rdCnxUNe7h/98q+wt/+ijrwj0SWYrMjF+ETda5FmE
	WpLU7tu5WjMD3lka+hemI64i7T+Yq7W8dfiPKWP70qerJj93/3KaUogj/Hw1fW
X-Received: by 2002:a05:690c:9c0a:b0:79a:b409:b5e0 with SMTP id 00721157ae682-7a3b8501632mr147407187b3.0.1775518991760;
        Mon, 06 Apr 2026 16:43:11 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370df16aasm59144037b3.40.2026.04.06.16.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:43:11 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-kernel@vger.kernel.org,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless 2/2] wifi: mt76: mt7996: clear cipher state on key removal for WED offload
Date: Mon,  6 Apr 2026 19:42:04 -0400
Message-ID: <20260406234205.29857-3-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406234205.29857-1-joshuaklinesmith@gmail.com>
References: <20260406234205.29857-1-joshuaklinesmith@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233464-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4996E3A8479
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Same issue as mt7915: link->mt76.cipher is set on key installation
but never cleared on removal. The WA firmware retains the stale
cipher in BSS_INFO, sets the protection bit on WED-offloaded
frames, and drops all plaintext traffic when encryption is
switched to open/none.

Reset link->mt76.cipher to zero and call mt7996_mcu_add_bss_info()
when the last group key is removed.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 84f731b387..bf5fda6925 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -235,6 +235,21 @@ mt7996_set_hw_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		} else {
 			if (idx == *wcid_keyidx)
 				*wcid_keyidx = -1;
+
+			if (!sta && link->mt76.cipher) {
+				struct ieee80211_bss_conf *lc;
+
+				lc = link_conf_dereference_protected(vif,
+								     link_id);
+				if (!lc)
+					lc = &vif->bss_conf;
+
+				link->mt76.cipher = 0;
+				mt7996_mcu_add_bss_info(link->phy, vif, lc,
+							&link->mt76,
+							msta_link, true);
+			}
+
 			continue;
 		}
 
-- 
2.43.0


