Return-Path: <stable+bounces-238196-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OigKK/g32kzZwAAu9opvQ
	(envelope-from <stable+bounces-238196-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:02:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD3D407430
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 248F7316EDC8
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD65A3803C5;
	Wed, 15 Apr 2026 18:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLlFVF+S"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48647246BD5
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776279362; cv=none; b=iQUW9260wgQcntkplWLUNeUPzmhMv+8GfpICZcx+Ti6pce+fj4NYKeKpzUluH14/xS6dAGGgQASNQ241CO/4wkOgEeb8EZaOH00b+x5uhY/tcr9T3Z64R+SK1pw8DQ6veicvSDomW03djxGQe4xG2SaVsCu0Xi9aBytrDshtOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776279362; c=relaxed/simple;
	bh=qDgAnsBoeU7H8hWJYwfJld1PdWPKZ6IzYlZmakmFvzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRRKMjXTzxT1mSRz96JaeIL0IxstQdarJHUk9AxOcAkv2BhslUkeiXHdWPmP/k8AzShiWV/p/+M9mqb9UuaeU+J6lK/KaIheDFtgYMthYhZb4iTmSjobsRU+j4MKO+wjLLAudtGxBxwVUimx8DAlRlDcCZI1gD5c/RygWKlgr/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pLlFVF+S; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56d89f35940so2482203e0c.2
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776279360; x=1776884160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=terxqci1pBdDnjeH/sF4SrPTjsWluedBaTM7xGqnc9A=;
        b=pLlFVF+Sw/y4YDyLOcXP2eUxw4oOGcO6vRhjfsSquWIepcewlPV0caMqrm7Zj3DYTs
         Vru9q2OvUyNT/hhpytMr0gvA2JIv0EawBDftd6IslCyUMMdpuRuds7d6ApQzF2kWZ1zI
         MygZ4n+pCP+jM+EOzuPfsKqyrQWF3AYu5J0f3OK4UDY6AeLZD3XfVZDLrxj63/VMJIUW
         IIuIF4IVVoM/zTDDE0nKDq/5LBmSYGyE9E5w+hFh5sKdcjYllAZj9gugl9XD3+i1vV2Y
         Sv1+MANIj6wgQMJLXrfC83s35Q4Qrj6Rg45cnacurVYO6ysNSS91NOShi6Wr2+9gSHHz
         abgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776279360; x=1776884160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=terxqci1pBdDnjeH/sF4SrPTjsWluedBaTM7xGqnc9A=;
        b=nLEB3CX7mJ/eT+tqr4sjsbplpchtg4z2D84zIYiceC3XP2ohrvLZM0iV5XOSfDYKRQ
         WjFArYxVegkn5veqSJu/NflJua8KSCoiNqUPFF6kRvMVOZKQ2OlBBAL9YlAZwrnKPd68
         GsTfFRQ7IZ+5KiFMl7w4cMabHBYq7vHtYqjdkig3Ujy6g44UpesjJgsBnUq7RSKF8mNq
         Bk1W7rUm7w0kTxOxPgz9oulsyXM8jS4K9f6aFm9HFGmV/13fHXFXBEHSumyulxR1YoS+
         tpe5M5hyPUkSRmPo9hog0rd1HeZVbhhWVeTGvJa9Plj1//qZ/Vppu6e9mV2DQaEPQnYu
         2tZA==
X-Forwarded-Encrypted: i=1; AFNElJ9woZ70M/DK01I0Y8w23Nk4MzP+G1zp8Ybp0hpaqGtFdR/4icF6tFIZMd0r6saJqcgDPIFW1+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySbaaXo1oZLFKtqMvTxAUiH/1ZVzOdMhEVcM327v+ShE46i9f6
	NFxvLa7/ONPS0rUbSB+ir/q1fuy87MUCfjEkGEC3SynxOuCQ8jLU4eI4
X-Gm-Gg: AeBDieuAUKq4nzFoxvl5lPpKgrWjx57+df8bwNjBnAzB0mJ6994PkVTrZFdzk1Zrj9l
	pXIJuN7raCIWgdRhLyBWEGbGQ2MvXqvW/KBul8EOz/gGR2cNlyytviNf9qyu3cPtyjIQkHPhHfz
	nyw735MXcOOzkSrN7NDDj6Nw8Z32OM70GiBeD3gArRyqafBGtdxuiTUOlbueeSJuZDoPC9aBG99
	L/MXiYeeJBefFVCEJeI9ZvFm3VQPcvq+OlpGAo61r7dTAN5uymsIrQ/PPel0H25EikXBRxy3WQR
	VcufOFCPSXD4tcMUQB1WYsNU06lBD6aSKBxbXU1Hu/eYWLgnWMYwxwkGW1VrypwrZ8VvvHB/S9Q
	Jt/0/Q6ku61hny8tpH+3EBt1VVu6Iq3qmvhdLTv0IHibUQJdKjZfq2uW8QJFvA9+Y0nnhLrwAaf
	JBOoYVoiXs2ddaA2DU6S/7Q318RE9m/ccVSx6XSOzqJuuEO3KlrXDj
X-Received: by 2002:a05:6122:65a1:b0:56c:d1b0:3626 with SMTP id 71dfb90a1353d-56f3bd1af66mr12017282e0c.15.1776279360273;
        Wed, 15 Apr 2026 11:56:00 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.233])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56f89feb56esm1647484e0c.15.2026.04.15.11.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:55:59 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: dan.carpenter@linaro.org,
	error27@gmail.com,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>
Subject: [PATCH v4 5/5] staging: rtl8723bs: fix negative length in WEP decryption
Date: Wed, 15 Apr 2026 19:55:01 +0100
Message-ID: <20260415185501.440492-6-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415185501.440492-1-delenetchior1@gmail.com>
References: <20260415185501.440492-1-delenetchior1@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,linux.dev,kernel.org,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238196-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[delenetchior1@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,get_maintainer.pl:url]
X-Rspamd-Queue-Id: CDD3D407430
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In rtw_wep_decrypt(), the payload length is computed as:

    length = frame->len - prxattrib->hdrlen - prxattrib->iv_len;

All operands are unsigned. If the frame is shorter than the sum of
the header length and the IV length, this subtraction wraps around
and length becomes a huge unsigned value. That value is then used
to drive an arc4_crypt() call that reads and writes past the end
of the receive buffer.

An attacker within WiFi radio range can exploit this by sending a
crafted short WEP-encrypted frame. No authentication is required.

Validate that the frame is large enough to contain a WEP payload
before computing length.

Found by reviewing length arithmetic in the WEP decrypt path.
Not tested on hardware.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
---
v4: add Fixes: tag and Cc: stable (Dan Carpenter); carry Luka Gejak's
    Reviewed-by.
v3: rebased on staging-next; sent as numbered series with proper
    Cc from get_maintainer.pl.
v2: rebased on staging-next (v1 was based on v7.0-rc6 and did not
    apply).

 drivers/staging/rtl8723bs/core/rtw_security.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index a00504ff29109..f3bc2240749a4 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -113,6 +113,12 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
 		memcpy(&wepkey[0], iv, 3);
 		/* memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[psecuritypriv->dot11PrivacyKeyIndex].skey[0], keylength); */
 		memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[keyindex].skey[0], keylength);
+
+		/* Ensure the frame is long enough for WEP decryption */
+		if (((union recv_frame *)precvframe)->u.hdr.len <=
+		    prxattrib->hdrlen + prxattrib->iv_len)
+			return;
+
 		length = ((union recv_frame *)precvframe)->u.hdr.len - prxattrib->hdrlen - prxattrib->iv_len;
 
 		payload = pframe + prxattrib->iv_len + prxattrib->hdrlen;
-- 
2.43.0


