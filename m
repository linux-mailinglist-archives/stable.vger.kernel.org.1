Return-Path: <stable+bounces-212899-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNf2F7b9fGnLPgIAu9opvQ
	(envelope-from <stable+bounces-212899-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 19:51:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 803DDBDFBD
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 19:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02E3C300E46C
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 18:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A3936604A;
	Fri, 30 Jan 2026 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFBHV9bk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DBE3859CB
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769799088; cv=none; b=hqDgA+sWu2+nrJeJgB+eoATDh7nCh3GSWXnhSK3EevBm9RNBLhpf1lbH/NO+G28ZyoN85PonqKqOclMZsZy4dJBTpOG8yd8C78INj8o1ZxVf17EbSqX3AJuquuamLNJNAWDGrUR0xgtoXC7+iq8o0aphkIcO5AOUcb3t1WVtkLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769799088; c=relaxed/simple;
	bh=54jF80axLN2UJAh0SY0zu8J2BqHK+0mKcS7a+qODr54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ob6e2H26iYG04b640lhGd46J48PKTABtExstYYeSHA2wzhk3CHsHmNkhnppyBlglOae2DeDSxEFPlhi8RUyD65KJtnECGecuEMYyLPEH/XLOGrrUMSAqKyRnW6PTZUttcBkYSC6IdENQ7SZnju7TFZATDQ9b7iWRBSLH7aGSvHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFBHV9bk; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so2247899f8f.2
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 10:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769799084; x=1770403884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2f4MfuhNu/cLjFrGUoAiSMm/1GSuujiaDwedPKXZAI=;
        b=nFBHV9bk+fopyRoopFFl+iDJ7uSgzNBLTgkLskNfpfdDZ2WyizsgH21v0hmzvHFgJG
         gffv1gobqkFzko1RpsC6z+L01q8DXVvq5mUuwL01tUNKO03SSE4FzQbW6oBwaz9Iof2u
         GA6JptJdkmbisKXPznDH2wA2y79WEiK7OzUAFzTC/EbgjOItHv5cZX1m/zDBLVvdYCan
         6z+vWhF7cUxBUGOP+ujLZc/m4QYtNuAPiBca40bGMSxWbOcR4vLLP5ov3BZdp76F72mc
         fNDAWdTuOCgcPcnfI1a6MWKVMKfCvmKX/pkKqOCxfah4hs+F0/CZrXZPj2+Pb2guijgm
         d5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769799084; x=1770403884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z2f4MfuhNu/cLjFrGUoAiSMm/1GSuujiaDwedPKXZAI=;
        b=qvSKr39/LrZu2pk6d5gHG8wdFvMrp+hTjDtGyTMCqywwL9v9rQk1C7uFVGRpMaWllZ
         HKcW5dKHgD0/SED/ojToqdp/Onq3lSMdBTL0lBrkLRHxuq4du69I/58HNn5kE7G/oqOU
         xPU7fcSv4Ja3+biMyWItSvHV9nAUQQxhlFIgOY7ztuMUp65lzWh2pBPu2vMTS3UA7qYH
         cc8UYHdDI5sPyfkb9pP2XFAXtrVQYI32d15TuGSHWkIiYsZvFMrNYsHaJriUqwlkI3U6
         fZWdhdwPW2h+lnlyUMrQcGsoFIcDJajbLgdhyNu0DNGC2JvgRBWOVBtSagAkjvKdDysE
         qDrQ==
X-Gm-Message-State: AOJu0YzF8NQqvQsGoHIwfmC3z/wFR9lxsN8hHDBaAw1dx+LXcZR/6Y3S
	dc+JmZTzCcuEJCBtAlbui3N/mI+Jyb6aPR7o6fcQHFG6iYC9Znzu6xM=
X-Gm-Gg: AZuq6aKejf0xX/U6DhldmPfMQBXBMgi05O+O8q2uUnGidhoiCspwkvWcLU/KllgPI0d
	VjRUhGtnFq8G5mDVvMGz2rjOGxveTIUnVv2aTKn48loe5UJbSLWW+yAtqsDHlQRuAUJuSQVc/A6
	Cg1oWLKdm7OQxjTtqsMqhqPV6vm/QhXEiEV834vsQ8uzw1O7DKbZsROagQcvFQmWhz0T1SkCnRS
	YyDXl/dpzwczgo8+Z9qZ24iyAbRRJMi1KQlO/S662/+C865K6U0gZ7MDngbyCJdHhJUhI3WpRGn
	3WiK8E7zh+lfm1E9eRXC4H4ftazwHQlPRP9IbNX0lXPmszClUJoqUUbJ5/eI7yZAQQB+ZQjegTb
	3bPL98CFkgKVsVRQYHhmckMdQfSPlmIFeVZ+JAIfPG1iTW1vxNgwBiiUi5nQlWFTjhGfjvlXSdz
	jgcu/KkeCMu+rjDC3b/qKp1EjjA9ncuIX/2qwTqcSPAnbBAzgKSlnNiohRxL7YSw==
X-Received: by 2002:a05:6000:2002:b0:430:f494:6a9c with SMTP id ffacd0b85a97d-435f3a7b463mr6232012f8f.17.1769799084101;
        Fri, 30 Jan 2026 10:51:24 -0800 (PST)
Received: from LGPC ([31.223.131.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e46cesm24007200f8f.7.2026.01.30.10.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 10:51:23 -0800 (PST)
From: Luka Gejak <lukagejak5@gmail.com>
To: lukagejak5@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH v6 1/5] staging: rtl8723bs: fix potential out-of-bounds read in  rtw_restruct_wmm_ie
Date: Fri, 30 Jan 2026 19:50:56 +0100
Message-ID: <20260130185100.206381-2-lukagejak5@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130185100.206381-1-lukagejak5@gmail.com>
References: <20260130185100.206381-1-lukagejak5@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-212899-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 803DDBDFBD
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


