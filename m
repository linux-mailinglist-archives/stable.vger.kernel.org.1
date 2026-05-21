Return-Path: <stable+bounces-253547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFE7I+kFD2qFEQYAu9opvQ
	(envelope-from <stable+bounces-253547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:17:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F6A5A58CD
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFF70317004D
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AD33C76AF;
	Thu, 21 May 2026 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRA8fPKU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390DD3CC320
	for <stable@vger.kernel.org>; Thu, 21 May 2026 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368647; cv=none; b=b7yMXs+2DkGLSdzazq5LaGtS7qAo2dceD1bhi8HWphKd5fjifiqmaQY24qRMS80HYM5GXWTnZSeImH1sCiggf4tH7BtOFPJaXF7Lqcae5O6c9VfopRDra4p3FqiibMYH+n6uYalPUidiOZYMsiSkX5VHBL6XK2Hc9ClZZpjeVhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368647; c=relaxed/simple;
	bh=11XpadIVbnWDgGbnLsDIYuVi8q6V/iekBQR9d9ytC84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7FdYxh6/ApZ3WIJBWwc4axXJzeVY3IVl7DFNZochK6yiHkyViuqQnqneKOKlTvxPknfLCYbTFRxDqCYWcmrNFy3Z/3fN6R8LtiqlCqIAoku3PP1XRtvJUswjrKVgN8srhO3JfuoSUpy/BfDPVFOZX1e6xpmmCVts25MpwuUvVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRA8fPKU; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bd5047a2a4cso933436966b.3
        for <stable@vger.kernel.org>; Thu, 21 May 2026 06:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368645; x=1779973445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMhZs4Eu6gRgBabm++8DBCSAa+Wm8K3ZfuFNhzHSur8=;
        b=nRA8fPKUW5w4J2GuSD67gF0OdiiJ/bUCo8wKNL3z7+lOMguCsgIm2ELRb38zoXvalp
         pBBAXpiZ1R1S/GiwR6ctUaxgI1S03mDYpN+/8AtdprzEfMOGKf3Ck2OE6kfFDvp2iDXI
         gv9TM7TTER7gMoLH2rkSvLwKdDkAiyeeqe6zf5IzsJW3WFho9uK+TXwylsmGy1BPwLdv
         Gdt+aeiBb2MraLEJlc9rGV9AAFwWkMiJ//Sxy5IDVlgvZfB+QL+zk6Vc9lY6O2LKCfgc
         /fQHu8kvWuhn4aKrDb5Hlf0Ckqq3rJh04L4QAFSRLecCLW21wbhG7DMv+GZ+3JS+dFgE
         nFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368645; x=1779973445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MMhZs4Eu6gRgBabm++8DBCSAa+Wm8K3ZfuFNhzHSur8=;
        b=UjFlKjY29gQ5Xc6dykViZxT25cu8KwXYQ+j23PyC4mNxG2oRQpwNlBdLdFmE5xEQgW
         GTksgwFrpUFLteKhj+piULlDlfJePKCVBLZKy7pFbmPrik3XX8e17NL42LJFx9nxCVD3
         zJF1LTDSCoR+Mxf3NkszkMv6tB/BnjV9mVvKPRFFsupPteKDYm+3QzYms70u/QZlOhDD
         M0W6JWKXLiZ82mu8A22m2h0yRnffbHdkx9wARVebKOSZ/4ZQWFdepnoBuL08PLNW2tsA
         RbZ2cRe+D+qGtKBHsDScQHVzcF4cmas0dBlStS3kpInINcJDliZG8MPIsTlORm8HTN8Z
         1QKw==
X-Forwarded-Encrypted: i=1; AFNElJ+MXWBDmSiiv96HqtHmtlYVxTbhIfiGfxNS+rdELIuukGObMQABEDG8J4F33Z7qz0I1fcmt/v4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWTzTqI5YUIW3gGhY+VM17izTQPOLi/JleTprZew+NPz3xEBcT
	ZaoFtsxl6DfWNJF8z9kaPINHFmWnrp+fDPyZ+suugSQv/SurnzFlfhWsjvXrldCVIrw=
X-Gm-Gg: Acq92OFJ3FtEK5sW8xuSgTGnGIFA/PcXedFD9704BdsKdrMp5sp8r8CsRvfZHQHOGlv
	qv3cDksXtWdR1HD46qR5XkmNtrTM/CWRCLwodTVIegkXemJfAsMfMd9naC0OBEQPtMMT5cB6HQK
	/JKZi2d26ExR33wRJc5wCnuac+nwXnhFtzYv9yPg7N1SoGygkDxpksy+VngXbqSfOZ/FFkCU9xO
	ASUHtHJlveFcmQl/L4bn1hfy4niqdm2wOKXDrUTo1grz7oSe5bve7CJ7d0s1qgw4R292iu6ikyu
	wl7aM5yL8csBTeB63EQwOOs6yaLdwafeGsr9cw46pf2j3A+TPe3EAvQ8+fDmiv1FtO4lCzUd9VT
	NMlm1RSzormQ4lgNY9DaLH2m3IPBKnb+DzIoyQbz2hVMHZPhGXJPPoXl3N/c9Xr57UrDL+goKUl
	3fMiiVdSiQDI4rCpF+Iwg7fDMTOCIjJtQlTSXjUwXs/8LKX3H4nAOOGopZBl/osl6qVcbMTL20p
	eEgWfdMk+K9F3GV/IUC3vC0KNgR/8JT9FfI2+2N6cczWhLqHLvxpEXjxW4x9VWVt/GS3zZeynJY
	SfNGRNe90STzT0DIN2HHCTs72eZq
X-Received: by 2002:a17:906:fe05:b0:bd4:8bb6:3d52 with SMTP id a640c23a62f3a-bdc1564035dmr156822366b.36.1779368644437;
        Thu, 21 May 2026 06:04:04 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bdc8a505905sm43766266b.37.2026.05.21.06.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:04:04 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	stable@vger.kernel.org,
	hossu.alexandru@gmail.com
Subject: [PATCH v6 4/7] staging: rtl8723bs: fix OOB write in HT_caps_handler()
Date: Thu, 21 May 2026 15:03:27 +0200
Message-ID: <20260521130330.754181-5-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521130330.754181-1-hossu.alexandru@gmail.com>
References: <20260521130330.754181-1-hossu.alexandru@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253547-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 12F6A5A58CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
2.54.0


