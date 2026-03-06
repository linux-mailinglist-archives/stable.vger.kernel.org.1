Return-Path: <stable+bounces-223368-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +K70J5EJq2k/ZgEAu9opvQ
	(envelope-from <stable+bounces-223368-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 18:06:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E729225A48
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 18:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9F8B302C935
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 17:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F083988F8;
	Fri,  6 Mar 2026 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYbMP0xE"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E77F3EDABE
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772816693; cv=none; b=rWfzucd/aLSkFDzmysMLaETVoGEgFS/0ZC9lvEeOetctITIvmK4hARTCqS0cmkAQSswSO7QIuPxf4eL7EgK4LbjKLrXJcehE5notfPAll5dAFMvy6qD05CfAPhtHuaF4M/9nllVUHqLokNwaOSDcbS3aMF8vpwL/e/JNV1N/NFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772816693; c=relaxed/simple;
	bh=KgU5qIlmN4yivxWth4nZMfVPkNBmx99YR47kvHMtCt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bp+MJEHbv4jXYu1i3KdeZyC0wi+Qiav7tyiaqb/n2mvKY1by6k7XN4FYw0UiNB6RWfWSz+Z4JlOPmLMkwuZcwK2rPuhe0liNgG4U941D0D69FRqGvL91R95+GDQy/s4yAgYkOshWg7UFcPg7SNR76DVgIQglKpNKxAlHdUuVCl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYbMP0xE; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56a8584e3a2so7567807e0c.1
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 09:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772816691; x=1773421491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R4KjQPrU7WLJvf7ZmVhX2kRs77Fj2PYQR90hIAEseI=;
        b=QYbMP0xEizri31PzmLzUyzI2u6+AdxONThV2YD3by80vjDSerjOl3L29p1vv4QK4Jd
         RRLh8UctMlXg9AFTZIgp4BGWOsOQUhQWZCT5gtHCTHAyhE7rFMgHqrEJrzf27B1DPJIU
         fJ937AzHD/KXVR8pGL/qr3jIhE4RwfQ6XjOkLmzZvDZ6ff+6QsP4TX5zXtXZJnjWGY1s
         Cu59G4t5uIfPuKHrTLPVW+equY+yLtJMgTFYAkGeIzgMgru6AIEh6hSe8VFUvi0xiu9G
         uce/deLTCOJJipwtSwBbgzZdTV4xUlgaPCh63aSJhrlX6ZKrsW+VVHRew/Ekr5XplZTE
         X0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772816691; x=1773421491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6R4KjQPrU7WLJvf7ZmVhX2kRs77Fj2PYQR90hIAEseI=;
        b=vnvEKWGfoEfwSmaluIiUXlqhpkWRNu4sO9aAxWEazQsJ3ByXTF+5zlI8vdoylvkfwq
         bitPz+DODjbi1pg8bsfUzN1/jLM2MGk7Q2WwOHAE+rDIyJJrsjX183GuGxv1u3Isu2AF
         hG963Ua55Xg/h43cwg27unZuPPWSwgU3SPpo+j76w4eLZxujqV9YfeMoIFGTYDHtmX8T
         gBcoxwNXtY/2bI0ujlyxujQhP8JWl7saA++Ms3IZ1OVGVOFHMl43sNiBcM0Nd3yHBFCZ
         Bmgca9c9F2gWY/1XgLFlNWdEFc56nPpajlz3ks0R+HY/c3GaOVmEpLeCOnYY27fLUnZ9
         YNRA==
X-Gm-Message-State: AOJu0YzPrlbqsXCHmhJSjehr8e8DRcE/Y8priC1Rs4420LKlM8V0X44C
	bL11+q1KK6ekob4/5NcmB3t2Zp0yQz0datgQabmA6U3c3l2iJuFjvuaSOZCBmQ==
X-Gm-Gg: ATEYQzzYznCcfgL0vV1ZktaoIspPaDaoWUINXP09hP0/lNhdg/n/bSRrbcLF60WFFzD
	PI9j/GsrHHRzka45niOfyklHr1qPDvs3zevKKUF7UEH7AuNt3nFpcHetLHWL0TTD70Xxh7at6Or
	I769DqDlNMsmpEgtjGqVPma6+1mih+TRFKPU9xtAHpaIWnfArflyKLWF6nZ4hLPi3lcK3bjFBU6
	2sJy2iacr3O3xh1ThhzlpKJ52STikIFO+ErVrVLT8Mblp9oybHi6F59CPp0N1sf/+UkMq1n9rNC
	pNk68PiWYn3fuR/OFWZKU5B2v8yemm5HszMXEKoUZDOaJOwqUfjEPelsMIJ4bSLbGJDo1f0h7+C
	Qw7iRum0lW98fC4kCeg33auBanglcUdP/6HBmR39dn0JXiuUkRBDS6v3CZXljjmHlv0DZawYuwi
	mpA3vRtk+BXA30VnwDr15c/T1QPZcmL5o6g30SGK25hTsoBjjVNJasTU8/sWgnOcQewHo1v5w84
	31oOUQ=
X-Received: by 2002:a05:6122:829d:b0:568:e716:5faa with SMTP id 71dfb90a1353d-56b07e716b2mr1017214e0c.13.1772816690635;
        Fri, 06 Mar 2026 09:04:50 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:1b3:a802:8875:ddd6:ede8:90d6:abeb])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b0f889ed2sm332967e0c.13.2026.03.06.09.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 09:04:50 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: stable@vger.kernel.org
Cc: broonie@kernel.org,
	alexander.stein@ew.tq-group.com,
	linux-sound@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 stable-6.18 2/2] ASoC: fsl_xcvr: provide regmap names
Date: Fri,  6 Mar 2026 14:04:21 -0300
Message-Id: <20260306170421.1430704-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306170421.1430704-1-festevam@gmail.com>
References: <20260306170421.1430704-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1E729225A48
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,ew.tq-group.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-223368-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[festevam@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.988];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Alexander Stein <alexander.stein@ew.tq-group.com>

commit 08fd332eeb88515af4f1892d91f6ef4ea7558b71 upstream.

This driver uses multiple regmaps, which will causes name conflicts
in debugfs like:
  debugfs: '30cc0000.xcvr' already exists in 'regmap'
Fix this by adding a name for the non-core regmap configurations.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Link: https://patch.msgid.link/20251216084931.553328-1-alexander.stein@ew.tq-group.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- None.

 sound/soc/fsl/fsl_xcvr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 06434b2c9a0f..a268fb81a2f8 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -1323,6 +1323,7 @@ static const struct reg_default fsl_xcvr_phy_reg_defaults[] = {
 };
 
 static const struct regmap_config fsl_xcvr_regmap_phy_cfg = {
+	.name = "phy",
 	.reg_bits = 8,
 	.reg_stride = 4,
 	.val_bits = 32,
@@ -1335,6 +1336,7 @@ static const struct regmap_config fsl_xcvr_regmap_phy_cfg = {
 };
 
 static const struct regmap_config fsl_xcvr_regmap_pllv0_cfg = {
+	.name = "pllv0",
 	.reg_bits = 8,
 	.reg_stride = 4,
 	.val_bits = 32,
@@ -1345,6 +1347,7 @@ static const struct regmap_config fsl_xcvr_regmap_pllv0_cfg = {
 };
 
 static const struct regmap_config fsl_xcvr_regmap_pllv1_cfg = {
+	.name = "pllv1",
 	.reg_bits = 8,
 	.reg_stride = 4,
 	.val_bits = 32,
-- 
2.34.1


