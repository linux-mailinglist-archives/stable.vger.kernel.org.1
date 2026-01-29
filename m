Return-Path: <stable+bounces-212801-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INzCNmCXe2nOGAIAu9opvQ
	(envelope-from <stable+bounces-212801-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 18:22:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D200B2C97
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 18:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EBC8306DB06
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 17:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6516A346E6A;
	Thu, 29 Jan 2026 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgbHnIJe"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AC6346AC3
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707198; cv=none; b=EIN1EzQ9wCYw300NEscdMhXD6jTzzaGSHWJ1peVCXnKO4JYxa8KCNxx1nC4+7WvdPWzwMMTCzaqnP56cCalB1cWXBBel6gzleh8IdwnCavrv/O+xzO0yGoVhpTNoK5Cy38rh/cFw3WYRP9NJHm42FeCLsGDhUSVWuNwLRnqYKqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707198; c=relaxed/simple;
	bh=N1H694rnIB23NL5FZSIZ1GxBz254s/FfmyDM3xDVb18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pNImrnoDeOr5paaBIlSdW9VtM7ZcMLK3MxJ6etTLLi7bOPu/kHFdq8A35mfOFNWA7zA9KHpH0Xl/Y9e66WyWfAdEgE+4enWPZt6t9JwTo+Z6exi8ozgwkYX9Cn3uBaZoLouMj+kqvOUNDvINjHuZADJpgIglRmV5zsBrgjPw3Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgbHnIJe; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5f5423b0980so434571137.0
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 09:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769707195; x=1770311995; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M4xXb7B0Ioz0Swo1DQNaF1EA4i8cqAzWN8A2le+WcD0=;
        b=hgbHnIJeDR2NuoYRspzUcvH1rEN1hVuusOlw6nKyPcwRD1GC9zwKpWEalLFdQRcU2r
         16S6oWL4tEHz8Zwsq6l3Ww+DQmwPhbmp8Rx874RHW1LYFQdVTaXPIDv9siFcTY7NY7yy
         7id9j7e7E7Owd0c24wlqkCZ52duowB8AKHTxVg9ruWGNdUc8Dq1zK/GGUhchh/aBG8eD
         zeznDNrtyT3P1J3aYZ0lHK4sdh15jELBDIrDdSsocz8P2z/Z86aJ6hJi8a0a+hDutd7h
         trG90hgE0uHZEqlVjetPDogG04MKlhAe31VhdzFjG507Wn/hDTRk5YoNjzq3AfdVjr+m
         XDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769707195; x=1770311995;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4xXb7B0Ioz0Swo1DQNaF1EA4i8cqAzWN8A2le+WcD0=;
        b=gdj1nFYkMuyyY1GjzcyTsPdujmO4Tk1DXDII4frYIQCpb9+RQNlhiBVqU1e+Glvgmr
         p2qeMZPUgEueBiT6AV3qB7CRh/6U6v/abtIenxPmkDk6VLMk6x6x5y7J2N01xw2z27kh
         oeDGT+2mPEqSv5MMSXhgf5A7TL9yY3x+DYZWbZawDkSkUlg3nLrboNalwdU0dQC4Yi4H
         PEywxX5fbS4a0/rzZWPBceNR2BVsdrKkMjR9dUQFH9AhJsAw57+B3AdRQFEeh06YxK+M
         SyswBYx/iEQ9oR7OACsMPymGa21JrTu6C0+CyEskoX37RYdj4crwZrdawqXBariRtW9T
         qsJg==
X-Forwarded-Encrypted: i=1; AJvYcCWnh9Kve5WVfVwuF2pGwIKOGxzPrpO7OeNivQO8lvoWX04Z1/FRqgZz92JtNlrkYF11H2vT02A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGUxHcO+DmHSwxkpNnGNom22rafy7USVTCzpKYvkajhUPybS50
	GtyEx4k2JYsjxbTTGQ8RDbaI0YK6SnTfRIZIcfpHZWahN4UMn36eI5DO
X-Gm-Gg: AZuq6aKpMig2eiokFo184YzaVuZNvtNg3RfN7Z6XNK4WfoY6EZkf+0py7efcIasPrD2
	dQrV53Y14hjC0oZsKrjLvr1gnnsQ0KJdEDeObne8blcAbno4gh7oL1uzkZgOJxfwQmpbNAiHHdR
	rbCETUMCwSqiPZIEFuFE3BMm8f531JMmxDHA5YsQayucfzsl8qqH1dGMnrJetFrfvYwfMrhHqrG
	+mk1th3caR5EsUTSx07kbrBYKWk6qvjqQWNES0dd+/dnv/leUCMyqpopQeIif07zPvjVzVzwu9z
	RApQpsrj23t44WaaSpCmC3XZll+k7cJJTmDooIUeivkhLnYbOObjhSskQEQSWKmZfmf+2oGzVaf
	5As+l8313fNrrtZ8jcvuvwsVjpRh4Kgzgm1FsU4nBRQ+ux+8tvqMJH2gapn+1rXqQcbq0CFuISn
	z7L7lxv84WumIY
X-Received: by 2002:a05:6102:d86:b0:5ef:b3fa:c89a with SMTP id ada2fe7eead31-5f8e26ffc83mr66056137.32.1769707194124;
        Thu, 29 Jan 2026 09:19:54 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723ef486sm1307892241.5.2026.01.29.09.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 09:19:53 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 29 Jan 2026 12:19:24 -0500
Subject: [PATCH] platform/x86: alienware-wmi-wmax: Add G-Mode support to
 m18 laptops
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-m18-gmode-v1-1-48be521487b9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyNL3VxDC9303PyUVN00A4vExDSLJMu05CQloPqCotS0zAqwWdGxtbU
 A2nXB31sAAAA=
X-Change-ID: 20260129-m18-gmode-f08aaf8b9fcb
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Olexa Bilaniuk <obilaniu@gmail.com>, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=N1H694rnIB23NL5FZSIZ1GxBz254s/FfmyDM3xDVb18=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJnV0za8s7bLDlzvlDXVdEZwjtMHhi7h5r27v+ndyve0b
 nq3a+X/jlIWBjEuBlkxRZb2hEXfHkXlvfU7EHofZg4rE8gQBi5OAZjIMWZGhpY6rrXiIirt5k8u
 uGf91/LqmPbqej1L5bYfpjUda9Z6xjP89y9j/q/p35Se/WeVi3rBjfAFXxJv2d18n1rHVpBceCS
 IGwA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,dell.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-212801-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuurtb@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D200B2C97
X-Rspamd-Action: no action

Alienware m18 laptops support G-Mode. Therefore, match them with
G-Series quirks.

Cc: stable@vger.kernel.org
Tested-by: Olexa Bilaniuk <obilaniu@gmail.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index e69b50162bb1..d1b4df91401b 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -175,7 +175,7 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m18"),
 		},
-		.driver_data = &generic_quirks,
+		.driver_data = &g_series_quirks,
 	},
 	{
 		.ident = "Alienware x15",

---
base-commit: 662c9cb86fc322038647d8808e751f5c6c0cc13f
change-id: 20260129-m18-gmode-f08aaf8b9fcb

-- 
 ~ Kurt


