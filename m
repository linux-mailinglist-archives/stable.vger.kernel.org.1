Return-Path: <stable+bounces-214613-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMgPMWKehWlKEAQAu9opvQ
	(envelope-from <stable+bounces-214613-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 08:55:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41058FB267
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 08:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C44CC301F9CC
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 07:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CA4346791;
	Fri,  6 Feb 2026 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXt8Cvoc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9800A34678C
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770364501; cv=none; b=b705W4B8NHNT32iLAsM5c4HCgBIWCRCQD5mPL64hNw744p+sPmpz2OanV7Mpgql6NpWE5GeTP27dePGWTlv0WB6UoVuNA2ZlT+5sOU8znnwXbgjYd19fSc4UF2wUscoTZWHNF2TA30czsjI7qSMWK4FzN0Bci4Ah8EaDZxNisG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770364501; c=relaxed/simple;
	bh=Ny05s/gc+yVG1LmGDAqH30JecyHKc/c0Oc5NWLJGwcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4/60yXQdsIKm2FN4r7xBbMWBy39+JyxKCqYEZsKGT9EDVJk1dVuRqWc71+HMU0HKbI9cyTTKxZYp04Lmuv4qK7k8TSsooTElb3zt1vIuV6Kv5i48ior6YEKsIGaWGAMiZgU1D8FcV8nXvPa3J1+1bvkIY4mLUD7Zh4MvzbbHMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXt8Cvoc; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43596062728so2007680f8f.1
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 23:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770364500; x=1770969300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Abtb1OgYuy0S1picWhTVTgjBvUwD0Cb9oXrZEBk5Z7U=;
        b=AXt8CvocCjNaoS0EDoMzudKaxGRmRWIZnwl4knUZ8vC5ds4XcWgqMPATa2shpswFHx
         4O58A6IVuHw+XoUS7xXuN4SANMp/W5lvafWWUjv5fjxw8zVpAF61aEprxOcRJan2pRLg
         jJKEXtLrFUWWZREdvBjcnG75oX7rEKxX3ybxIMu28e3JuYtGp8CFUje0w4fGzz3vWyK2
         GF3v/OEOdv322IUb5EWJzQD1+UvwBSl22/v2QPka7dDYLfsR9a9sfQ57eOj4JowZR6/E
         TwTrFXW4bdDX7TTAEcz+iIquh2H0gN069tD0K+8efDCJ1rtu8AW3+qI7Ru0w0a6lVNlr
         og3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770364500; x=1770969300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Abtb1OgYuy0S1picWhTVTgjBvUwD0Cb9oXrZEBk5Z7U=;
        b=KJm1y7IgjglwF/XFmLiHzPyipJzfSmm2n+WWgPL/RIDOskG30WvjXNTFtwUMklsvOo
         uJx2Ly+WpKWVNd3rkSCTY587PtGb9WjRTMNePoLUKXm2B/9aKxoNvupYT3R60GiyiKyA
         OyG5U/fjUv8yrdjLLX3GHn5bsgTjEaMzNcnV1OGfeycqklF/96NYY4ypRgsXbEvWI/+9
         g6TS1IiWv7GqrNJX+mvdRCb3ts8CIc8OWXEhWozcksBFOTd7oxQPwh9DPp2XZXmpB+ky
         q49RsTd+S+JUW0aRxZBhFEnl4VIP2Yt2w5EJgIlMai4/ep7lPI4x6Y+XQqYHjY4JC5WC
         0NOw==
X-Forwarded-Encrypted: i=1; AJvYcCWwHjNJE7PK9jcW5NcsJrp29wdaZueexyCmcKIfOLdaL/NY2I5tlgqb1XNlC32i6acYA+TuQQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/YD26KlzHq2bOVkbfuOv54nArd50wcQztMR/+1gdoa8ECN8Am
	jvxiAck73E556XBWTT8ljvhXFa6prpH8Y0g7NTLIy7GxvXqgW8JpITA=
X-Gm-Gg: AZuq6aKcCOwI3A+GMZLPzfLl4vzeiwHIz+0V0VJSMeQLt8uG7P/+DatHPR4BYrjOLr3
	Nk2dLZqPw4pMTl5N6/UdTYKSw5KwpbhnHeBEtOq6BgiDBXCbtOQeMIUYPg8+StFYWHS/U7L8n1X
	yHD2rbxTdQJNEB5RniaRRPYmSPZsFF7m+H2ERs2MHdJvvKSXTM/8ziofxk09hNMbQ2VyoBXUbG0
	WunB/x1JM67RFskl6MtrsWsixAlD5ejFebAgHkn9F++N2SNNBSUumf3kSYtF5M1kfY0NsrDez62
	cWPxXJkho1aoadEN1LimjNM8fnCfEpTetY/Wo49GwVmYB5rWMqOxKrVuh/DLOhV3VOhL8oV6Tgn
	SUnd4GifbLrXBp3g3yJCCSQcs0wc0gbo4vuXZrRa1+pVJQWLA2IzMerH7kJYrY1vkA5gLTPm7LL
	4Y4qgx39Qf3BgXKjRO+lRUnxtLqLp4mBgpLMBKBo/q+/EsiBMHwrqbBxnorI5F4bc=
X-Received: by 2002:a05:6000:4301:b0:436:1597:7c7c with SMTP id ffacd0b85a97d-436209a0dc0mr9908471f8f.13.1770364499853;
        Thu, 05 Feb 2026 23:54:59 -0800 (PST)
Received: from LGPC ([31.223.131.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd3b8sm3836039f8f.11.2026.02.05.23.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:54:59 -0800 (PST)
From: lukagejak5@gmail.com
X-Google-Original-From: luka.gejak@linux.dev
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Luka Gejak <luka.gejak@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v2 01/26] staging: rtl8723bs: fix potential out-of-bounds read in  rtw_restruct_wmm_ie
Date: Fri,  6 Feb 2026 08:54:14 +0100
Message-ID: <20260206075439.103287-2-luka.gejak@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206075439.103287-1-luka.gejak@linux.dev>
References: <20260206075439.103287-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214613-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukagejak5@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41058FB267
X-Rspamd-Action: no action

From: Luka Gejak <luka.gejak@linux.dev>

The current code checks 'i + 5 < in_len' at the end of the if statement.
However, it accesses 'in_ie[i + 5]' before that check, which can lead
to an out-of-bounds read. Move the length check to the beginning of the
conditional to ensure the index is within bounds before accessing the
array.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 8e1e1c97f0c4..0b82b1f2f1ec 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2000,7 +2000,10 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 	while (i < in_len) {
 		ielength = initial_out_len;
 
-		if (in_ie[i] == 0xDD && in_ie[i + 2] == 0x00 && in_ie[i + 3] == 0x50  && in_ie[i + 4] == 0xF2 && in_ie[i + 5] == 0x02 && i + 5 < in_len) { /* WMM element ID and OUI */
+		if (i + 5 < in_len &&
+		    in_ie[i] == 0xDD && in_ie[i + 2] == 0x00 &&
+		    in_ie[i + 3] == 0x50 && in_ie[i + 4] == 0xF2 &&
+		    in_ie[i + 5] == 0x02) {
 			for (j = i; j < i + 9; j++) {
 				out_ie[ielength] = in_ie[j];
 				ielength++;
-- 
2.52.0


