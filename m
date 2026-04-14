Return-Path: <stable+bounces-237953-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF5zIQSF3mnjFQAAu9opvQ
	(envelope-from <stable+bounces-237953-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 20:18:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0D63FD8FF
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 20:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41ED0300E59A
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 18:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBDF318ED6;
	Tue, 14 Apr 2026 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGkNTiXn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5438530FC1E
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776190719; cv=none; b=Cu+dmVQWR+Cues9ZxmRda8GkwQ6QMOvXhZ05EMpg5ooGToMYm+Su0cd5IE8vLbHJRtEsIDn37puE8tqRBPU0KGdUB71TOveVAIJx7NhubjWNHhP9r2bIaUdxG/KHvCn01AeMu5LhUSZAjtSO7pJw9CzGtNQWJ2Tsy+8zL8oDxjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776190719; c=relaxed/simple;
	bh=EGJT4vB2scMx5ZWJV+8qy4ZrRJT5zSxWDwW6BXeB3O8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iCQFc8ownTqlNxB1U5g8kQ+qoy+NX98CrTL+2wMYRLwPF6vEPKh5E6k4xBIpXZiRvKfczftNcvWELXxGqRAvs8dRbEurH44cjQRFcwAK+rLj5P6q1fOn+X4zRBoPPXMy2WtmcLJ4buSHBGo83seMGewBRd+e+beAkXKVx1AUUAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGkNTiXn; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82f2385724aso2243018b3a.0
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 11:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776190718; x=1776795518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uzM1wzYSCOjVyEsgMAHvBw3QH520uGNl0L9o4Z7S3BQ=;
        b=lGkNTiXnP1QNC0nGHkV+f6KuEMYmcionQtcqJnaQFoLOmrgP6zXdd+BUXXJeCTOz83
         56e5zPH/5i6Nj2Wt4X2ZQZNmb1PTZKRAppXS+2f2mdYQS0+jLqguMqt/J5R94FPXQWWO
         3yAWpOXFtl3SjDfYfCvUla1SrDL1pBsbTOfxNXfqG6b8YeFb2vCRmIU4LWa8Ic5E8C85
         I+3dVWIfvAGkLPxuxbSg6FVL94+3dje+RrnvawptUwbyj2n98kwPfgCv7u/lxi37xUti
         bl9j1SNuc/4sSqF+YK09VTDznerEP9VKe4YuKoXaJSMRFhayecdtMnFuxvy3//XV9DCB
         swFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776190718; x=1776795518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzM1wzYSCOjVyEsgMAHvBw3QH520uGNl0L9o4Z7S3BQ=;
        b=GVfjKstf/UhBlsUqEgwlbiCk/O3g/2Xr9wQxoHtWtnic7vzHkWubV/lfcn7E9yen1J
         NGOWRyBZlR4iZMIBhPV0wOefihlIPQW7+uMZBlQxeV03MngKVyZKTrpuUvw9JB+uXX4M
         U+YA75p1Ozus5L1c1NW2YwbgpLBU+AhZWQEu91vssxFE7kbif5CN7Ydhquv2UMS/DVFo
         NGCtqYTNPobx0SNpNtyxi6zEI8ktDPMpu/YhqIP5A44X0os5M9rAgpt4HySktcjqgj66
         3P8G3m8hbs49JOv0Z7ks/KZeeSOAFeeDHT90Nfl6oUpwT9EYzlVxhpKHPwAfOA0aFqHK
         5bPA==
X-Forwarded-Encrypted: i=1; AFNElJ/PCUPNJZsW5INvm0R5Yzs76Bbs/Z2Lv5L8Jn0UEuNL36M5aYkrdhoZ3qQAMUjpUseG90ZEZCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz57W3yoEqOIaP2CqAaEQH+g1eg0s4fZiXuaCQnU7oW/kD5g/52
	gXBzMKaCTlcMYz9eFLI8sZ/63cd/aW3KP4Azf7Z342VVAhpRg3wcPZC8
X-Gm-Gg: AeBDietPM6oVp6HE21CJc6V2rtdMH/JW0Qws8UbvUKmuZOcKahurx/qW3wjRGmkwK0Z
	jqqcro943fDiHqHYqPSOEczcyHjn68jRswpuSc2hMhZbG1caKI2tZHcLXaofAIVHeC9Zt31AoeC
	wT0QqZAiUKKY/cQkrR6tiiTgGf60eRhCvaqyaL2UrW6HMfMyzeo4Rh/vYQPc9ktreKUebfpJuy/
	KohoBvFNGv+hQCEUMDCRD0TCVlqAxS+ZsXEAr0mzoDtzs3GRMEUu7XoQefO7LVT9uxrKylahdSG
	jlkUXa3KitfygKUeg5/Mpbg5JqVR0j13BhMh+pjyCxFKCZ7JuzIOnPskWoISEmnc/gjPoMEIDoy
	4HpEbI3yDPfmOPqK913WusaGX1EMVYezagr51UElXppyljHVf3nHCifN808c9jhPbKsB/pkGXtA
	DvTMjCRBCo0hqP+Fn/IKyvVMjWrkJJXj/NQofqMSgU61ulgayKrOxV4B8=
X-Received: by 2002:a05:6a00:4009:b0:82f:3f28:2244 with SMTP id d2e1a72fcca58-82f3f2836bfmr8490236b3a.1.1776190717655;
        Tue, 14 Apr 2026 11:18:37 -0700 (PDT)
Received: from anarsoul-xps15.lan ([2001:569:7c09:b500:8461:f909:7a3b:1c4c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4d5413sm14028936b3a.40.2026.04.14.11.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 11:18:37 -0700 (PDT)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vasily Khoruzhick <vasilykh@arista.com>,
	stable@vger.kernel.org,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH v2] EDAC/i10nm: Don't fail probing if ADXL is missing
Date: Tue, 14 Apr 2026 11:17:16 -0700
Message-ID: <20260414181735.87023-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237953-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anarsoul@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arista.com:email,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A0D63FD8FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Vasily Khoruzhick <vasilykh@arista.com>

ADXL is not present in Coreboot- or Slimbootloader-based BIOSes and as
result, the driver fails to probe there.

Since commit 2738c69a8813 ("EDAC/i10nm: Add driver decoder for Ice Lake
and Tremont CPUs"), i10nm_edac supports driver decoder. Switch to driver
decoding when ADXL is not present.

Cc: stable@vger.kernel.org # v6.1+
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Vasily Khoruzhick <vasilykh@arista.com>
---
v2: - use imperative tone in commit message
    - add r-b tag

 drivers/edac/i10nm_base.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 89b3e8cc38b1..69a4a255e4c8 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -79,6 +79,7 @@ static struct res_config *res_cfg;
 static int retry_rd_err_log;
 static int decoding_via_mca;
 static bool mem_cfg_2lm;
+static bool no_adxl;
 
 static struct reg_rrl icx_reg_rrl_ddr = {
 	.set_num = 2,
@@ -1208,8 +1209,14 @@ static int __init i10nm_init(void)
 	}
 
 	rc = skx_adxl_get();
-	if (rc)
-		goto fail;
+	if (rc) {
+		/* Decoding errors via MCA banks for 2LM isn't supported yet */
+		if (rc != -ENODEV || mem_cfg_2lm)
+			goto fail;
+		i10nm_printk(KERN_INFO, "ADXL not found, falling back to MCA-based decoding.\n");
+		no_adxl = true;
+		decoding_via_mca = true;
+	}
 
 	opstate_init();
 	mce_register_decode_chain(&i10nm_mce_dec);
@@ -1243,7 +1250,8 @@ static void __exit i10nm_exit(void)
 
 	skx_teardown_debug();
 	mce_unregister_decode_chain(&i10nm_mce_dec);
-	skx_adxl_put();
+	if (!no_adxl)
+		skx_adxl_put();
 	skx_remove();
 }
 
-- 
2.53.0


