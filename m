Return-Path: <stable+bounces-243960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECp/Cm55+Wnz8wIAu9opvQ
	(envelope-from <stable+bounces-243960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:00:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6884C69DC
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A0B43012D62
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B673BE15C;
	Tue,  5 May 2026 05:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQESCUo2"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8A43BFE42
	for <stable@vger.kernel.org>; Tue,  5 May 2026 05:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957202; cv=none; b=ObeznKKynXLaQZnvkFvt36K3h5xw4rINAe9SPzJuKUmEZ3K7V1o9zRtLyUm58mR8+zfI0+KIQPYIbcCqoyCxKkV3qva4ZkP+hCBkBhYKmG1u0rZWrAUOMFLWhIrAbnLFxC1aMCPgFGQaNeR0Nc9Q5GxiuZo9fYjLR7I1lD9R7vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957202; c=relaxed/simple;
	bh=5rynYdstDSidD8j/koIGOQVJQmbG3RqF9LlqykFyDW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQsU86Mh7WZkIaH5Z0t0vGKu3TUBSM1hka+wEAnfhXfgVZhPCe0LZr2xsHzpchP/YvzBClbg0ZsKgj19YCm7Lwwa0Ksus9KoiPPB+6Ub6jk6jkdEVNDJ1q/wB8f4bXEJ7sWsCInp+2LF5e9zXba4iIvZoxAN8rELyTtv0SEDlI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQESCUo2; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-130b2295ed0so878984c88.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 22:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957201; x=1778562001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9AIIjE/oL3/1g9erZ/rZjvg7OI/hW1eJeMwxNk6yK4=;
        b=XQESCUo2ymAJhm0ey7Gcij7Cl0XNN4sT+sOKXie5w7H0eeUjsjQ8m7J9MGKM8dlPae
         tRp1R4ugY5Gi8mmOx4adhPaaMLJfRvr8CLxd1gLfhvRPol7E5MxyvLM7OigxB/snBssf
         nfBpw06uvB2ozTjesVHZJCOY0cDswExWNm6UnkTTG63bImJJj3zjWHcn0vn0jRbR7VRW
         bwP1jzdPVbflOKpHYE7yrL+TbdWjWxfILNmQKvOX3cbcTOVLbXLuchJOSeaRkxI2e++Z
         ygmcm7YtYiF9VVC0Eh2FDMIRrQh4ofiPQTrEOhGIm2Icduho2tMLYnIZKeA7d/U/gWSF
         YC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957201; x=1778562001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+9AIIjE/oL3/1g9erZ/rZjvg7OI/hW1eJeMwxNk6yK4=;
        b=jPhhg/+iLISdRfj0wboL6eXk+Fq4jOSPalhDRT1ROGZ9+Ypdun4lQ4iWKODTuti3jr
         M7V4Le1DLcg/93GzB8JmrYtDq2r7h5+J2BX8U1DWE3VWiafX6FugBecvZxdsikfv79A6
         qMQz8ZTu0vekPQJXkIT7Or7lzDahu7MC1+8+4y9PvECa718LRLucTlSYLHOSL4rT/4Oy
         omTbU20P9tu2R1VY30ifRIqnSo2ZT418kwgi7dyOYCIgiFwQkBiqGrrmJRhXE5P2Nnsv
         shjCaOCT4ZQiUMet8llEJ8o0DS3x4E/mmHEFwtm3AQT6tRLS480jrRGyzbA47iDC0tBo
         fhDQ==
X-Forwarded-Encrypted: i=1; AFNElJ/OeXk1jQAM2aODY0+CAZflqQIWsMErj4h8bqlgRPwjqcRSL3yI6eLJThZpRXjmpFH3E9Etqdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFSCg9qsh6wQJPWYxf/7ojjOiCk9qtbYO5I34jqu9FhTcvJG0o
	IHXhtZoJyGD699T7+uwAToDHa8gdrBmmApWxSG+eTwNKie+81IfH1ZUo
X-Gm-Gg: AeBDietauk9WRKbFTnnuj4KimbVVw8fFap4+JmyNAS/jA1SrAVati1h5vlBHgUBxn1M
	Ru1o7Ly3chjXfw+6vAdG/DyKvSaGNfV4tyCUdht7kVwEM0gWGydLPqsS9UxRdMhWPlwQwTm6kFi
	5YvMoem+LYJgSrvpGHTQsOFxG4S7LtAstsRdTphczAqGlSuHMbKtqW9URPkikGoX1OrTANoqCJj
	yHq9H+aYE42xQjpIHJTokxnPYlItSEdtXaUPXldEOl9xYYF+VnZCRpUcEVE9eZxa52eF+lhu49D
	evNWDz/hxx09tH9FgYm66CkCQnAwnMRPpUiF3+MhVHVezKzfvxqAgGTnSHb2R4DTSMKuhFI2qcJ
	Qo0OK+/OpiK/Zjp87tE3J7eYTAHW8d2eLKcou2mPIgKgWAE92YCTy3D8W9DnQcvkFPqHaBlgq4Q
	hwfnvt7hTf3FPk4jRnAEbzx/QvN8zue0Sf9fWiWGGqaCp8v2Ngvw/gGGnM1wLVbzKo1CZeA6LX8
	TQ4mnaipaYuKprJyIthKCdpUg==
X-Received: by 2002:a05:7022:4392:b0:12a:713b:896a with SMTP id a92af1059eb24-130b1752d68mr981710c88.17.1777957200796;
        Mon, 04 May 2026 22:00:00 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.21.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 21:59:59 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 03/20] Input: rmi4 - fix type overflow in register counts
Date: Mon,  4 May 2026 21:59:33 -0700
Message-ID: <20260505045952.1570713-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
References: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EC6884C69DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243960-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

The number of registers in the RMI4 register descriptor is populated
by counting the bits in the presence map using bitmap_weight(). Since
the presence map can contain up to 256 bits (RMI_REG_DESC_PRESENSE_BITS),
storing this count in a u8 can overflow to 0 if all 256 bits are set.

Change the num_registers field in struct rmi_register_descriptor
from u8 to u16 to prevent potential integer overflow and ensure safe
processing of devices reporting large descriptors.

Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index e84495caab15..5f769fcc758d 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -65,7 +65,7 @@ struct rmi_register_desc_item {
 struct rmi_register_descriptor {
 	unsigned long struct_size;
 	unsigned long presense_map[BITS_TO_LONGS(RMI_REG_DESC_PRESENSE_BITS)];
-	u8 num_registers;
+	u16 num_registers;
 	struct rmi_register_desc_item *registers;
 };
 
-- 
2.54.0.545.g6539524ca2-goog


