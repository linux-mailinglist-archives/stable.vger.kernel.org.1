Return-Path: <stable+bounces-212900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKYEGAD+fGnLPgIAu9opvQ
	(envelope-from <stable+bounces-212900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 19:52:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D637BDFE5
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 19:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83A653009095
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 18:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054C337F735;
	Fri, 30 Jan 2026 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOyjmmfg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5887D369975
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769799165; cv=none; b=rfvXCcgKQOGuRQZbvNoZtaceiDXi75RQfCsUl0YLLQbWPQ1Xz4CN2tiRxmbDfzTeWDMGr21f1/glU8f/Os4kOxt02tabFBiEyMO+xt9e5XVntnbUsXKWbXI25u4LFzIzND0ZwrDD+ODYQEdhXfyz5vkSO+xtByZhKPKZn1rRKws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769799165; c=relaxed/simple;
	bh=54jF80axLN2UJAh0SY0zu8J2BqHK+0mKcS7a+qODr54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKQ0m68oAJ0rVZCZdzY3ulA7thnCUBHJBgb2YdVkhZUkI5HHZHc1uoCHQe/d3aJD//M9tG5h9EHNQir1R3vPh44bvMF4fnfg+sxpXCDw6mYG0htMr/URUdj2NJjqCbWseo/tnv+/jlNPHfVVqnboqn+67fQ8IK1NDAzs5Noce0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOyjmmfg; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-432d256c2e6so2173754f8f.3
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 10:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769799163; x=1770403963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2f4MfuhNu/cLjFrGUoAiSMm/1GSuujiaDwedPKXZAI=;
        b=HOyjmmfg+DJiPpdEh0t8+vbE8F5m+ZqpMtEq14wmveZi/HskYNSMYExHVvrcKulBBY
         zh8tGeAJLwxgS4Cs9SkOtRUSk6aysOWGDUGLE7XvZrHNK48TZlyEuvE5AC2S8Oq3kTDp
         fdP4XjPzJ/4RlF94kEpF6I7mj4ZRVgLpV8SLZGNI+kxijmftoxw/jpuEkBoSTcAVwRGx
         OkrB0L2iRpLygJvDFxOVZxuxpYEm+6bPHf1ZRLa6Q4P5PJ9HIAHiOgGM264DeT+R+knV
         KwNzYDMBRBVQefE0Tjom0hw7zLmgEFBQOC6OSnuDztIIK6ggGsGFPisns5INJvewQTQG
         hldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769799163; x=1770403963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z2f4MfuhNu/cLjFrGUoAiSMm/1GSuujiaDwedPKXZAI=;
        b=Lza5YOSJaxdJOqzeYFTEgvviUNYP9Km+GQ/MfH8WERkf9/i2d7c/pThXMbaYh2vAxs
         4o9C0mknuQFwBjjxdtDBY8RzsfOUwWO7J9BE+QyrVXZtpBui6n9cf3lJBIkYb+JdyTsn
         eLf55PTYikuctqbnrXd9hwDZIdxdDVRedDJgyMclOGZ+qKGiCxkl+adX7yk6SPestB2t
         0b7D/Wmo7AJRz+6w3redpk6QWeiKqV0G7foQJs4dZJ7//fB2WkdopHQ2QXhXyJi5mQKW
         HxzEMHdBXWGgQQBQdVsgW5lYjxZk+UNwwlDm/RteA3YIwvw0kfoW7gvs47pTCsfevfvs
         gGkw==
X-Gm-Message-State: AOJu0YzCJTYUNmpWxaV4jsSN8LcSjTbCm9qWFcA8dAxPAyeitwugWIQy
	d3gLm8+D3zDTtGVRuhjfWcRe8hymA1KDKlqKdlMeyISGDgoUZaTbCD0=
X-Gm-Gg: AZuq6aLET/iDWIQOG+tNFIWBiWYjvgMh2HNbSxGgcd/GC6XbVJYQVDLszbCBmPgreCF
	1HkJkQehhYfVuCfSN6ZXVDLom8BOGsEkCFC1LrMkk7XMjr/axORUr3eUY5z+ODlAjyUBbgWuLEw
	osMMvXX6sGuSuYfN1zfr+YyoHzUsXxB6DjGt5d5K5yOV3qfn0iWi31EEMzLYG6Y0mCO9x0dr813
	/ZlQhGZSqwAtPxn6ibA5i3HgTF3323fs/UpB+bGkGO4hokUyMsAW44nAFs0lxLahRgYGe1V7H0t
	zuTf2QsuTRtEFSSo4RaZbFqSo+rf8p0ovD686gmkqgWKzZrhHYSvBHMQ8KlSJjmwTTSnf9HEaXj
	FEq4h6PsrR187gUiClgMhU2XoMYdAQ8fS3j1PUMNqdynMgj4SOGstkRbzKaCgijEF4EAjbhqxPW
	z2in4FTJ7LiNx3Y7mnjl7JJtsXWDk6KI1GEBYihsBAH2TUAoImGaPFuGMqCGLG9w==
X-Received: by 2002:a05:6000:401e:b0:430:feb3:f5ae with SMTP id ffacd0b85a97d-435f3ad7646mr5304918f8f.55.1769799162415;
        Fri, 30 Jan 2026 10:52:42 -0800 (PST)
Received: from LGPC ([31.223.131.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131cf4asm25026202f8f.28.2026.01.30.10.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 10:52:41 -0800 (PST)
From: Luka Gejak <lukagejak5@gmail.com>
To: lukagejak5@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH v6 1/5] staging: rtl8723bs: fix potential out-of-bounds read in  rtw_restruct_wmm_ie
Date: Fri, 30 Jan 2026 19:52:15 +0100
Message-ID: <20260130185219.206910-2-lukagejak5@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130185219.206910-1-lukagejak5@gmail.com>
References: <20260130185219.206910-1-lukagejak5@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-212900-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[lukagejak5@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D637BDFE5
X-Rspamd-Action: no action

The current code checks 'i + 5 < in_len' at the end of the if statement.
However, it accesses 'in_ie[i + 5]' before that check, which can lead
to an out-of-bounds read. Move the length check to the beginning of the
conditional to ensure the index is within bounds before accessing the
array.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Luka Gejak <lukagejak5@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 98704179ad35..7dfc2678924e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2000,7 +2000,10 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 	while (i < in_len) {
 		ielength = initial_out_len;
 
-		if (in_ie[i] == 0xDD && in_ie[i+2] == 0x00 && in_ie[i+3] == 0x50  && in_ie[i+4] == 0xF2 && in_ie[i+5] == 0x02 && i+5 < in_len) { /* WMM element ID and OUI */
+		if (i + 5 < in_len &&
+		    in_ie[i] == 0xDD && in_ie[i + 2] == 0x00 &&
+		    in_ie[i + 3] == 0x50 && in_ie[i + 4] == 0xF2 &&
+		    in_ie[i + 5] == 0x02) {
 			for (j = i; j < i + 9; j++) {
 				out_ie[ielength] = in_ie[j];
 				ielength++;
-- 
2.52.0


