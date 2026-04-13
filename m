Return-Path: <stable+bounces-237650-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFy6FkhS3WkFcQkAu9opvQ
	(envelope-from <stable+bounces-237650-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 22:30:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC65C3F31B4
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 22:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 429AB300F780
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291CB394790;
	Mon, 13 Apr 2026 20:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPgkWkUK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBDC3909A6
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776112195; cv=none; b=r7b8nqovqJuvWCqhM9LuU0+9uvAlGexU4UubZpkM3xVleh6yawz84tJiGnt9h7LLIgTto/imaRDNU+s9GN5AUiP2aR/A45Z3GhSih4KVQgiRVuaRvUBU32C8UneSDPLSg5KpCRP2krdSP9DwZMZyH8igUCEGhc+nWyWwJ9THWR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776112195; c=relaxed/simple;
	bh=JPVaL4c5/9h9h4/5l7XJiy0RobptP8/C1TcDRP2ZUOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6U6XsWvge6ul/ZImpWu1QTEXWupvy5m4x0gNaUBTxPPRRaMU0lXMSdiWXxIe0QA7ZYP6a+NCJYipyORFPKO5ItJMY75r6tB+DXHScOYLm7Smf71o1OXXBQ/jXGZaH83Z9XDkQhep8riiknBz+VFLh0fqM03maj3764Y85KTY0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pPgkWkUK; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-670f6ae9c7dso2930408a12.2
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 13:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776112192; x=1776716992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J76QkE9NJQFuHh61XUi+3w9vtC/liTP6j3ZjmrLLecE=;
        b=pPgkWkUKTz7pz2laU9xQ7roHBEMAVFy/2ceHimJEcPBjQ/4BtSVvA5WzwEeCSVQ16O
         ZHd+SDShIe1CHHdI4v109c+i9hIKO3Ih9Xwjkvh9jXc0IgJtfcNcwXiME8W+Fp8vGgm1
         YJ/Q3X5tRddk0kONObnW2Y5woWTmE6/f7gih67gw0HuGxoj2UtdBIy1Xa1orqsemY6Jc
         WVaQgUlJu9P//WMcaOhLkV/m7t4w6ercI4BG/fM1DClaqIbLTHyunylnPQAE+xCSOaRp
         4JUhiqeCBxA5pXE82I5LCenvlnBJygd695u2Mmmz+o4TZKx+S1MFEbBj4BHuTtfRP6Gs
         w+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776112192; x=1776716992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J76QkE9NJQFuHh61XUi+3w9vtC/liTP6j3ZjmrLLecE=;
        b=EhNHxFh+XJpAiARXUeBiilwWxSwhrk71opqZ2NRoKUi8WWomFMgVkXoqopig8Ywpq6
         HJxrhSOhphM5PMZoPxBnaPbF0LzqbcTY7+OPO9BaOy4KK37C/b9QRBCekJEcyGlArAtN
         rb1ou16JG/krgHyWm8Xsf5leWXW0loV5KY32MTNwFJOBpOCYDr9nvZKNKRJAHMXFy7Zp
         3ZYbZWUvpTjgEMimUJv6U+KaGH4Y4CsJMeiG0o7iRnRcOJ4SX2yV4vrpv40duU+FsFT3
         DLL4q1liWQN9xtmnYlB17jk99rYfwalsddMcEaNH1jb8S2R9ySoRQKX3GYMjKzjsqjzh
         GOhQ==
X-Forwarded-Encrypted: i=1; AFNElJ87uNDBedD+u5tUrSMceyfqLSMJs28Kg0jD2iMcVxYP4IgpnxMoWvvh8QiKPb5MISlGx1iMDKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKMskDKoR+Sw/s3fmIEi5hwnAQInat9abonLTI4jNF0813UY5E
	jJp3FR3RuxiaKn53oc07k0SqGGO8s6cUtsgDygZG7WDtR75WdNIa/CUu
X-Gm-Gg: AeBDietDZC+xmaIF48VM/eLp4PQEIoIaT9TeIkIf7QxrH2vt8WFvz7oq60QtBwM6u5a
	JwssaHgDZZFdipJp6oNQX0CCRKEBDDfuc7C5/uRHj1f/dprEvGn7cTsUuQpPwSNhsqWjPjvELIt
	OZfHCWvjLrALhr1SkABvmvn67P8w+8nDx0vUPdcZiwYg8xDwQuPcmlLE1aWf68smnz71P85xqAJ
	G3FIpWnAwVsxWROdW7IPJ4b75P2xaXrlj8jQSkaghSryODlMwT5NIC/0v1+zUYjqYN+yuSQbThc
	azQQB7aU7CAQOTS+8M6ErZyjyOhNciB9bMyrCVQNBtLnII9wYw0hfr3X+n16d2La1MYSFdZkU+e
	y2nX/kO/mBxkZCdu2agNRpgnBz/x+RFWSnvwO343QbGXSbcBBquxMZLnvqkYwIeR/jArmrd4JPB
	QMdX55jrGKdUH7+9LTnhyZ6usRwk8lGCzyHTqDkFHLIFDp0p2OPLTODU9KwWmO7OjndZTx059xU
	WgjyVZpDbFVBiJ4QoSTyFxjxI7C5F2ZyYefR8T0yNnGvxm4FvZ4KrM/2EoR84Wki+nDzYJpDT2i
	AFesEQ==
X-Received: by 2002:a17:907:6b8e:b0:b94:1d92:7eb with SMTP id a640c23a62f3a-b9d7279302bmr734143466b.18.1776112191780;
        Mon, 13 Apr 2026 13:29:51 -0700 (PDT)
Received: from ahossu.residents.sin.openfiber.nl ([88.202.160.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e5c582fsm353034166b.31.2026.04.13.13.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 13:29:51 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	hansg@kernel.org,
	stable@vger.kernel.org,
	Alexandru Hossu <hossu.alexandru@gmail.com>
Subject: [PATCH] staging: rtl8723bs: fix heap overflow in OnAuthClient shared key path
Date: Mon, 13 Apr 2026 22:28:24 +0200
Message-ID: <20260413202824.740653-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-237650-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linaro.org,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC65C3F31B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rtw_get_ie() returns the raw IE length from the received frame, which
can be up to 255. This length is used directly in memcpy() into
chg_txt[128] with no bounds check, allowing a heap overflow of up to
127 bytes when a rogue AP sends an Auth seq=2 frame with a Challenge
Text IE longer than 128 bytes.

IEEE 802.11 mandates the Challenge Text element carries exactly 128
bytes of challenge data. Reject any element whose length field does not
match sizeof(pmlmeinfo->chg_txt) (128).

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 5f00fe282d1b..90f27665667a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -891,7 +891,7 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&len,
 				pkt_len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_);
 
-			if (!p)
+			if (!p || len != sizeof(pmlmeinfo->chg_txt))
 				goto authclnt_fail;
 
 			memcpy(pmlmeinfo->chg_txt, p + 2, len);
-- 
2.53.0


