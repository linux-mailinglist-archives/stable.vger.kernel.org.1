Return-Path: <stable+bounces-241517-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCBzM/l88GlSUAEAu9opvQ
	(envelope-from <stable+bounces-241517-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:25:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAA2481559
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6AE1830907C7
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 09:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B76B34F247;
	Tue, 28 Apr 2026 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMqVH99v"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF213191D3
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367901; cv=none; b=Zk6vIl8KsV5NWaxPrtiRrubZwZ10xfhDEcLItR17SDxLIRU9Mp2LMwZhr7kBHOmWYzBL/yaXIn8fU69U0skjSKP8Y8PDEsO0Ie2NpAxhy7nC83KUSt5r0+sVgbPZjvdFJtAPihc0uL21sHmd9qkqhRBUzF16Ot2EeBhSETxxhFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367901; c=relaxed/simple;
	bh=oHlhoX2XD37ttuQs+I+7ABrsXNk0vNHMk8q0WeMaVsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aa0CCRb+fyl1hj101EZbMBSAHprbMPb1C4NVCZtP3R/uvbHg1GJ7DV8mmjhmOlJdTioHoZMEgjQSqc9KmwPIaazuTDZGgwRsLwskjcbgqb2xL7Z1uDdSWUKzP2UuJGd3P3kcaFiDGuPbR2gqaIfifwZObzMikM7Bv+r0+e9NG8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMqVH99v; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so6946190f8f.3
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 02:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777367898; x=1777972698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7DB7L+MoopCfaj05ayyoXdqOZG6gM4ZReiwvIg30wk=;
        b=IMqVH99v+YhQ23WsK9EXACtPjm5QQedK0RQg2qm25zuZVB7bCcHDgr4E3Y1okOmEIq
         0fidKLwdpEUctupaCGIXvwPc0DJwZTrDqzZV/JKZtGQpI/u5dBinCAIu0djKw+HX2kNJ
         x2zHR7Kb4wsMIfVrW9WJcqZ+cMbzowASS38ukqUyW+uDmCwWPdW5nUJgbFNi1iCfOz8/
         xZvMOTdlvtd2RiHC4FTw2HQq5PXa9ksGbGt/2RW83duBqqdoNr01OWd0jlaq+I33z+Sz
         74FgkDIK2Am6LhkbqmCGTYGBzLhBaaz2eSJF9ZQnteATp03Gzt8JXqpR0wpruxCIrmjB
         RFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777367898; x=1777972698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L7DB7L+MoopCfaj05ayyoXdqOZG6gM4ZReiwvIg30wk=;
        b=DNfeiT87zrqtpML1fIMge0qlhkGqXuKK++c+9Jk89IYpT8l25yRmeYaUVvDBbnyoKc
         ODEj+IYO6Lov91kIK0wwZjdCsx9PBfiAXtgP8SzaZh3ov9t0f48fIaqKlMFO9NLMqLWE
         XHVqh7bM2DvKmFeyBkAeBm5GWK9bwpyIgvyMwV3CCEJFR4NMSlb2Tg4HM9DSfjFP9bXP
         Ia4AWR4N3sim1Z9cNk82KF2DWxRrfdBkevz3qq9tVVTszTwwPlrun35/UVO3b4VPvlox
         MM3e6ZtLtJA/8rWwZDurP2sP6KYKOr6/JGajHf4jOMVslvojldhBz7z4moNZaxK1hCL3
         zvFg==
X-Forwarded-Encrypted: i=1; AFNElJ8HMYmr8FpNDyuhtrsW28wzrZ6h3jP+JSXr/KSY6f41c8b5UnJosZO0sMagRIg8x6nXxkB05lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSyzkzuX4kFlaeqAmBxhGu8mQjYIpdnI6hmrEEnp0WwVS2onFn
	o2WYCiiaVypsaMq9H2K8FmxxZ5fXNMLFSY2a8WlSX7YJGFCzt+ghJOHq
X-Gm-Gg: AeBDiev0dPfpiS7IJzzdr6UX2qEeWd86eKLMI8EDpmNNvMOyX1LRAhW6AmwSvjtldDm
	a/0qMnFIB5JmDdhMnX6+gYB4QK/bXOpUK7D1D8QQhaGWv3UKL4go8Gw4E2YXuKIHxDh20r+UHmF
	Oz6u2UFFPo3iH5UiRohLU2bcMrRqJPpZ4EbBWVmXbNjRDnCTJX9fXy8CQrc4rVg1DhltvQeZSrV
	vKGHJXS+g9vaJlC6pTEhBZu1Av387S204mlQYPikz3T8pUA/qzEzB2rV5PfbVDtsy1mwqduBpeQ
	x3QaDk6cIIoHdnYCLXQkEsniPxrZdNgsfrWH9APhv0qf9jXe/5gswchXhB2QHhxRkp1GTRlL6Fx
	kSqRg6Qwz84gwHzvjXsgtRbJmZ0HUkaazOtJdywC4NQyNDLLoJrxQ52HIuq+qeihI/eYzkbWSAg
	3HZxUrLE9KAVZXThacP4LT+DW8NQmeoYSiOVkJkvmGfg3pjf5OiC2vYf/jqr0iEkZ9bADOvmb3n
	rQtLwQrjjcAL3rh3rd1hXQrNF/6M6w3TTMUTRAvnLAS3aGVz44eUq7DDF84npnwmfiK+KqYZXyW
	bFjAsg==
X-Received: by 2002:a05:6000:18a4:b0:43d:7e11:1b72 with SMTP id ffacd0b85a97d-44648f28e43mr4198132f8f.9.1777367897958;
        Tue, 28 Apr 2026 02:18:17 -0700 (PDT)
Received: from ahossu.localdomain ([82.78.232.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d02f6a1sm4902502f8f.13.2026.04.28.02.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 02:18:17 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: error27@gmail.com,
	luka.gejak@linux.dev,
	hossu.alexandru@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] staging: rtl8723bs: fix OOB write in HT_caps_handler()
Date: Tue, 28 Apr 2026 11:16:20 +0200
Message-ID: <20260428091621.739680-2-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428091621.739680-1-hossu.alexandru@gmail.com>
References: <20260428091621.739680-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6DAA2481559
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-241517-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

HT_caps_handler() iterates pIE->length bytes and writes into
HT_caps.u.HT_cap[], which is a fixed 26-byte array (sizeof struct
HT_caps_element). Because pIE->length is a raw u8 from an over-the-air
802.11 AssocResponse frame and is never validated, a malicious AP can
set it up to 255, causing up to 229 bytes of out-of-bounds writes into
adjacent fields of struct mlme_ext_info.

Truncate the iteration count to the size of HT_caps.u.HT_cap using
umin() so that data from a longer-than-expected IE is silently ignored
rather than written out of bounds, preserving interoperability with APs
that pad the element. An early return on oversized IEs was considered
but rejected: it would bypass the pmlmeinfo->HT_caps_enable = 1
assignment that precedes the loop, silently disabling HT mode for APs
that append extra bytes to the HT Capabilities IE.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
Changes in v3:
- Use umin() instead of min_t() (Dan Carpenter)
- Keep truncation approach; early return would bypass
  HT_caps_enable = 1, disabling HT mode for vendor-padded IEs
  (Luka Gejak, AI review)
- Expand commit message to document the early return tradeoff
- Add changelog

AI review (flagged early return as regression-inducing):
  https://sashiko.dev/#/patchset/2026041408-grill-mahogany-d1e3%40gregkh
Greg KH v1 reply (requested truncation over early return):
  https://lore.kernel.org/linux-staging/2026042630-tightness-runner-2121@gregkh/

 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index e0d73c267786..dd34f229df12 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -936,7 +936,8 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 
 	pmlmeinfo->HT_caps_enable = 1;
 
-	for (i = 0; i < (pIE->length); i++) {
+	for (i = 0; i < umin(pIE->length,
+			     sizeof(pmlmeinfo->HT_caps.u.HT_cap)); i++) {
 		if (i != 2) {
 			/* Commented by Albert 2010/07/12 */
 			/* Got the endian issue here. */
-- 
2.53.0


