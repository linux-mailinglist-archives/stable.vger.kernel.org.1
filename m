Return-Path: <stable+bounces-241265-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKc2ATwc72lk6wAAu9opvQ
	(envelope-from <stable+bounces-241265-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:20:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAE246EF35
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E53F3015A52
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764B5399011;
	Mon, 27 Apr 2026 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt+6BZC4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B9C39936F
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277989; cv=none; b=sv1a36YwE2uJMJ3yDtTjLq50jeswzCAm6EImFC/LmSjRyjPqtfV4tXU6F5PpG9MnMOq/UNHCj6Dl2vwYdHQnv7BMG4BbqYpCp2kAWQr27fy4IhApAyo3DkbWMXuUKPRaakK06WuRz19dgCK8zuia6nAtMhSwCGx7w+HfLueRWCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277989; c=relaxed/simple;
	bh=GTrf3Sp/Bor9RDVfbFBCNK2/Ily1loPwsIGEXx/nFxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gO+qrtKbnrQ+NE29Q4c/xDoV2Xj4mtrX7VbZ/yHfDLOEuGHv5sJqolEHGYbePqud1GzEAC/T7bDZNFJ58KCnCeQa/PfjlajWKXWIlj+QScmAOQvpKcnF8397i1ZpfBe9k4RVmRsPb025cadjhBWmNYnphLcENsNwDwyYKxzQWdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gt+6BZC4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso80854945e9.0
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 01:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777277986; x=1777882786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muh4d06e6MKOx3RLMPSkijOmHQZUXxEoajlYypFsrtk=;
        b=Gt+6BZC46nAZvXN/bw1SwWhkIYGQB0j2x0wcslv3hV3Gk63OyivczygtTvpEOzglFp
         74jYoaSYEdDWD6QQJ4Rdx4kfxC52Zfy9pIQjLtyboOtikJ6b7MKEQlOH9JxGPunct90I
         6SubOfCZsEuQIFRFjt0b/Ty8mYye0naqaWXTNPj0jDbooYtd1nDgQewYQPuKDimr138v
         cLSnfkbUlbUqtLn7R38f9jQuZV1TCv37k81luWwx6LFvxpOX+rstE6ESXGzJ1yfoczvB
         gjB7i/gW+LZpt4vdnPIow+hiR4wvQHexfSmfpDVR5doRqKV5fr4/U/uXeK0eYPVqzOIu
         YV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777277986; x=1777882786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=muh4d06e6MKOx3RLMPSkijOmHQZUXxEoajlYypFsrtk=;
        b=MKWRdaD3ZbC+yS9wqJkaqrg8LV+yg7+kpIhpcoOYP0AW8aaSDXvcAxB2lbEbJ+CRsk
         iQARxh2QkVA+ZQqccNvQA5yGAMx5QvXhwl3iVK5Hm08AhdLG4tprlRTFAK4qxQoTWCYa
         QK8gFX10qRS6WZJaDuIYMOkDGBuuJ1lpWmJgr71e7pt8Gd+ZwOb4fYhI9l8wUI6V7gIO
         kriF4U229hTQh8wprgL3W2bVXH/Ts8KadjjI3RauHPdqkS8c47dK8RK48pqqkHsY0jyw
         VwuJOzxQ8KUECCd5CLNG3HqkZEa19dl/wajMsJSTP+hpr/+TT4vxqa26Rd+9X2GyoLRS
         6xwA==
X-Forwarded-Encrypted: i=1; AFNElJ+qMzBE5TOyzF7KP+R1Hpbol1TRAxWaB/aR+Qwb1JRuyGOTIW8URzMP+4t1nZvpjpy1/Hqu6NA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2KL8AsCBffY5ehhx53AnbT0I8b4Z2AkAJLYJ+kwTFQqr3E4wa
	uxXb8Kf+yuDz1PycCQY15HREPCwqmccSq1mOW7sD3HC1kQO6wtxtRGVr
X-Gm-Gg: AeBDievKpFeobSrf+bnl1YVpsT04GjGqJYJ88KToLHyWjkcO+sNzK99Y63WKY5e6pUq
	LIu+UHofqhw6qZXDMdX+P/x4Sc7SFWJQGNPhkP/npBP/US2hIaB+0LLplBfpIkGlhGs4lUPnbtC
	drz5+oed+8f7w1I3ds3tAYwknsDYdz09rSjCHzkLKa+qm5UHLukMRglHMJH7u9l7kyRNYBrJIlF
	CG5Ik4gEpzz+FtIQljYaM66H81BNKI+cE9wLI5sqmOl8KHJAgQeer+Hwkt6VRUWNlKdoAgDpMRo
	/3aiX5/vfQZOIDr03eBrPG9RvGROSCgDNFOAHFmy0xD9tpT1xym64YLBaR9iCUAOq5Jn3FhJewu
	lFgbDYUrlFFMA3afH+dgi9yaHhPPl+vhf0cIwEEjlnXwG/e+fk6KLzSOVQT0C9ml/beohTymkwl
	/HVjIcLniNM5S8cvP8eM6MU0nD/zW4B0wfzP5ads+dWLQiG5Vw1RESr3YirxC3Nj1FX3EuIInKU
	8znBYaF/yEbu+PQr4IqWprX/b17/VziMjwPsIzkeTIqjsdonop7GAe2sVBHDuXHU5Q5Zew=
X-Received: by 2002:a05:600c:a088:b0:48a:75b9:5e07 with SMTP id 5b1f17b1804b1-48a75b95e3dmr616135e9.11.1777277985956;
        Mon, 27 Apr 2026 01:19:45 -0700 (PDT)
Received: from ahossu.localdomain ([82.78.232.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a18csm90455670f8f.20.2026.04.27.01.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 01:19:45 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: error27@gmail.com,
	luka.gejak@linux.dev,
	Alexandru Hossu <hossu.alexandru@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] staging: rtl8723bs: fix OOB write in HT_caps_handler()
Date: Mon, 27 Apr 2026 10:17:47 +0200
Message-ID: <20260427081748.3407939-2-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427081748.3407939-1-hossu.alexandru@gmail.com>
References: <20260427081748.3407939-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AAAE246EF35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-241265-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

HT_caps_handler() iterates pIE->length bytes and writes into
HT_caps.u.HT_cap[], which is a fixed 26-byte array (sizeof struct
HT_caps_element). Because pIE->length is a raw u8 from an over-the-air
802.11 AssocResponse frame and is never validated, a malicious AP can set
it up to 255, causing up to 229 bytes of out-of-bounds writes into
adjacent fields of struct mlme_ext_info.

Truncate the iteration count to the size of HT_caps.u.HT_cap using
min_t() so that data from a longer-than-expected IE is silently ignored
rather than written out of bounds, preserving interoperability with APs
that pad the element.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index e0d73c267786..3247565f41bd 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -936,7 +936,8 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 
 	pmlmeinfo->HT_caps_enable = 1;
 
-	for (i = 0; i < (pIE->length); i++) {
+	for (i = 0; i < min_t(unsigned int, pIE->length,
+			       sizeof(pmlmeinfo->HT_caps.u.HT_cap)); i++) {
 		if (i != 2) {
 			/* Commented by Albert 2010/07/12 */
 			/* Got the endian issue here. */
-- 
2.53.0


