Return-Path: <stable+bounces-223344-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGyuAJ7kqmkTYAEAu9opvQ
	(envelope-from <stable+bounces-223344-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 15:28:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 757B6222AC2
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 15:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5B1330BD497
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 14:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AFF3B52F5;
	Fri,  6 Mar 2026 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zfm+i/ct"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A437A3AE713
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772806987; cv=none; b=pevgsySobWyj7z71S2Ue6GiMuRGQJ1BOgAZFag/WKm8D56COGcOtDisgu90CNTou4fg5aqzzkjpLHvxvcYIana0+7dkDvGhtB50pz1QZ/poBDLDpLssC26hJN9DrwF+lMq9Ct+B6aPjR4sBTyEGQzP0WwfYhP7P+1l0UWfuEl8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772806987; c=relaxed/simple;
	bh=GmCXbPoc8/TfHGNMgmsNF/jXheLGU1o7tY0xuml1IPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eoEsFW4Jf8UGw/8dr8FO2rYmDIzijmlF81a2wKdetglWs1HP2TuydD7KzLCmMefr90zfg6p1CSgZhiQNy4DvEkLKLvpxFvLBdmq8hTLRAJupep0r5BRG3f7XDm6tezLWlZ2vwXNS7I1xRPJuq1df4HTf3CbyjEMWJ8T2EDXsah8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zfm+i/ct; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94acd026e45so2304445241.3
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 06:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772806983; x=1773411783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dueXMGXpxv0xbCVmzWXvE/Ffw9BJfJL0ZtVGlTEf6/0=;
        b=Zfm+i/ctjvhDXWS2Lhqs5rBZMtJKY1HiaHpnWI0w6pUnv2rjNRX63Zi0XG7mc83oyn
         1J1jVErXSgH7YwOmP+01DomYkB5bLaRJOitrpOfYTG/GsgGfXW1vxGUS6N5qc1cIZDw4
         pZghCPE4Sdcd0dEcbkPf2+zAbssAqy/HAuOHGTgNoF4uXOG0mvEvJ5Y9pVWjo4MQYOps
         pgq18vi582kh2hdDBB1y4/S2T6Hr9nEiNv/aObeIha8Ank9TW9XCzZUG2HyYPZYqhg9m
         p72/e89Zxzaez13+dXip3YqyoFMI3rA9I64Jq0X/gc65uvyk/eroPoMwDOEntwVledCw
         jr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772806983; x=1773411783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dueXMGXpxv0xbCVmzWXvE/Ffw9BJfJL0ZtVGlTEf6/0=;
        b=DnTKAb4bSQMXEf1aLUzn57M+2MR47GSztMmibYM1nMh1WH34BLN3YKrq/BvathcJZL
         bzwhsXDEeQwuF5Y3ROGkKGSEoLeOrzLqALT65LLDn7uU8Z2BQTII4NjlWMDeY6wc013Y
         4QjwkI1uAVQhkWkXrBBeD0+TQEvBeixmosK4uByfkwIh3pCxjFf+r71K6vwz8EBcrmTh
         f3I8nFceCLXkV70PpgrVJZDsl2sIC//DlpsE4Mf0V0Y8rUluAAD+v6mUlEnKv/Q0gszH
         31VWBB1bCTowuCom3jTKSTXNekKJ74bQUNyrl/hDiy6tiP8rHFB2WMNNIuZU97PUmDqT
         9/5A==
X-Forwarded-Encrypted: i=1; AJvYcCXdi9ee8KnR374GZo6auz8Uv82VZTiOw5wUq/5QNtnqjM4SY8nl5GWcWdcU2BUBCLWRLeAImKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk6nsfp/6zH21OtCNHFfqNQCTDJA1dgAKDzsWxJvA7C/3gDr9H
	rWx9iI2DiK5flQTmy0zSpPZvl6SRpFVMqThQ9roB2aVVeEmkQL6OJp0s
X-Gm-Gg: ATEYQzy/Fd3CleMnbxFRlG3zBW8AQtvVoiJfAtHEHAen7gfJvPuhcxSoRNZNheF9wmg
	ygAAXbBLRVATcP7P9unLLSF4WXiWDVjqJj4CG2grs1aWaG3fB7u0q/3+MX1y6T4lNhQQZWaVUWT
	jObeboP8OYHnzKb15Y1EPKEAGeZfqVkGWeL6oTX4kmEDBXQTW6ryl+130smLd/SycPCm/e922xG
	QFCn6HGGPHlKKZpjC/WDgKtBRTMxMlstrgUkAxC/fiMgZ8gxnxj/X+x9dKsKJtpwp57Eo6+qm1i
	hK+7uUrfvgwS1Z71VVUjXEY4xngcdW/cRGWJimWIHSfLDGmohfEvj281CwTHfsajqMMKBjSlz0A
	JYsoGrFMSrUs53D/uRNffsQWAwq0Kt5vWPrZyPDuG3SODQKU7QhHntjalpLLKHTUeK0Kl5pnEVS
	swLMPa50E949V1PxkIbaO4h9FAWp2Hq01lmFdU2u/caR07L/on2Esm9yWBGpK3mjRiq5TWGNA7y
	B9D9oA=
X-Received: by 2002:a05:6102:1613:b0:5ff:22f5:e37e with SMTP id ada2fe7eead31-5ffe5f5af8bmr731824137.10.1772806983101;
        Fri, 06 Mar 2026 06:23:03 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:1b3:a802:8875:ddd6:ede8:90d6:abeb])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94e7b36d64bsm1540781241.6.2026.03.06.06.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:23:02 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: srini@kernel.org
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Christian Eggers <ceggers@arri.de>,
	stable@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] nvmem: imx: assign nvmem_cell_info::raw_len
Date: Fri,  6 Mar 2026 11:22:35 -0300
Message-Id: <20260306142235.1401319-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 757B6222AC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,lists.infradead.org,vger.kernel.org,arri.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-223344-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[festevam@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,arri.de:email]
X-Rspamd-Action: no action

From: Christian Eggers <ceggers@arri.de>

Avoid getting error messages at startup like the following on i.MX6ULL:

nvmem imx-ocotp0: cell mac-addr raw len 6 unaligned to nvmem word size 4
nvmem imx-ocotp0: cell mac-addr raw len 6 unaligned to nvmem word size 4

This shouldn't cause any functional change as this alignment would
otherwise be done in nvmem_cell_info_to_nvmem_cell_entry_nodup().

Cc: stable@vger.kernel.org
Fixes: 4327479e559c ("nvmem: core: verify cell's raw_len")
Signed-off-by: Christian Eggers <ceggers@arri.de>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/nvmem/imx-ocotp-ele.c | 1 +
 drivers/nvmem/imx-ocotp.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
index 7807ec0e2d18..4585da51f7f4 100644
--- a/drivers/nvmem/imx-ocotp-ele.c
+++ b/drivers/nvmem/imx-ocotp-ele.c
@@ -131,6 +131,7 @@ static int imx_ocotp_cell_pp(void *context, const char *id, int index,
 static void imx_ocotp_fixup_dt_cell_info(struct nvmem_device *nvmem,
 					 struct nvmem_cell_info *cell)
 {
+	cell->raw_len = round_up(cell->bytes, 4);
 	cell->read_post_process = imx_ocotp_cell_pp;
 }
 
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 7bf7656d4f96..108d78d7f6cb 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -589,6 +589,7 @@ MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
 static void imx_ocotp_fixup_dt_cell_info(struct nvmem_device *nvmem,
 					 struct nvmem_cell_info *cell)
 {
+	cell->raw_len = round_up(cell->bytes, 4);
 	cell->read_post_process = imx_ocotp_cell_pp;
 }
 
-- 
2.34.1


