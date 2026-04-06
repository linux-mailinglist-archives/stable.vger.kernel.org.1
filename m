Return-Path: <stable+bounces-233436-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QK3DIR0U1GleqwcAu9opvQ
	(envelope-from <stable+bounces-233436-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 22:14:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D58B3A6E99
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 22:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13F5E3037171
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 20:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90FD39C01E;
	Mon,  6 Apr 2026 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PB9uVzGY"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8004039B953
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 20:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775506445; cv=none; b=hLmaXvYd8oiBKkgjcohSStPPKRsoCUq9+GgdYVBY7J6gXPxKqhJSeCxAxIttmCBJRf36l/hjznDz1BXrDTgj6n+zXLx7HJIYeBKASYhBr29kfy3qi2wcaLc7vHuaUDGTcTDLdSTuSmV5V3WaQtOQXAspizmpe69B8sbCzsP7KHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775506445; c=relaxed/simple;
	bh=QpvEj1emH+D7uyjHFu5brDKzkv5iOsNgAWo3QDRZ4T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TyZRqtA89UddkuF1fG8KmPSLByBZhXO8psN3fw3mcVQSbFCxaq94lA/ok9yPKs5Rlyurkxg0iunchwzGxgzK5ctfajiLe35PMvdZfTrH+BqIne2SB8HKAMYqllxclxMWi4UZ1uqN7Wf853nzRHjF14bGusQuUsPqCGFma5JJTGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PB9uVzGY; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c0b72dac7so1571726c88.0
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 13:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775506444; x=1776111244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hj5KeLYeiV8K9ipCUKl33iACfT1+nJcLiRAjRSTKr8k=;
        b=PB9uVzGYA6vJaXCeU0dy9dKynpZCyKgtvtBDZw8hD+PfdYLZl5zxKlKDWkYFeV3Zol
         rvZ+l14i/o/F1wJy8i2C1JgQfIMwXQe2aDS2velbLC1x2iG31grWZmO6qlpqm/kmfsof
         cF+NalFxSEoSKGuCvBRjmTQ8iqYOJOAZEm406kXQYEcxYL0P0+cAkuBGpMz6pG2Ze8DW
         WGqFXZ1iMW21AUBOgcYh9RrJWDKnhASs759bbq35sY/xN7uLmUaTi532bemPBXRrsczI
         SQjVDtSgTo2lsXzKb5WsmRn2Tjp80Md18KAfKTynDp2N+T0gajmijdCjueeb2af3Xdqn
         EcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775506444; x=1776111244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hj5KeLYeiV8K9ipCUKl33iACfT1+nJcLiRAjRSTKr8k=;
        b=ftsJYDK2gAQnqZLCsHWVsXlJWn8M01ILncEKkoTpCSx84AYmYxMOjaSshysp6n2lQD
         2OypNW5FNJ/zr3EzZaAzLtoasmruC8nh1YyK6LsSncA+wJ10MhdWtdrFD/gOB8o0DHU0
         G7WsbWJtxLjR3vrg8/rRhDHHd1SeeTQ9pE3ypy9ZFRKC17VphKy/WTrbzvp5jlpN0bkx
         HuJhJX2Dzx1B7IsoPNrckVmrB9sdbE78Hy59mQ0TqLml8/jM/lIAYE70Mvcm077lpi4r
         m7er/dOLMmaza5K+1F4k5aXpMr5wJzML3DSvi1eMfAKEbQQCdfKaZN3OtwHs5HDnPpZ4
         yHIg==
X-Forwarded-Encrypted: i=1; AJvYcCVqddDwhLBI6ZVTXpNeXqt2aJZV0rLOdt4rfcF36QLROjcVCFM9EfE0FlGYx5AIxIg4r8cu9mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDNqaXNTOxXhK1q/Ki3/MERjo/Oz19Fou2vXKeZUIVc6xlLRwo
	PbiPEP//6vcGTVrLLyscpjFRicukRJs2uQbZnaSqBGlPD7zpGFak9A55
X-Gm-Gg: AeBDiesJ3+Zc2ZwtzgZ+ToYOanDtg/S1yvbfrcDPLCrzYYfPCWoJrU82MjT01K7Tvbc
	wse12N1pRy0SYxzNPunNyBkKZsfcWnG48eGlBw455+99gbjYbtDDkQwc9L+z0Yrr+p7D58kcs5C
	AbZqAdwK1ZnW5VRgUMU+rCLftG4ChhRl2ffR52waQGgkF9I6ag7mhejVdDnmUngL6RvIQyeI4lW
	n2copJb45aVPtttZd8flG8R4s4kLC+TgzxwRBZja88UxHobNxEB6h6Wk2BRgvsbQTDf8lacwNjs
	aQfSa0CW0WygAw0yYUk4Y67iEkQLIDyJtuPBKsVYtGEpJ4QFXpRWlSak2Woz2E4B0bT3QhgPwQI
	/G4SV/SjuxYyxNg5/s3QRCvlTx9Rx+kmDgH7KcSJzPXowZndaOygXyXeQdwbfEVBoru9nMJBoXm
	hL2mKTTZ1TA7paV/ELDWiI/jdgK1ldMgXv492ogkqYasS7In6/OMVv/lieAg2wunMRn12IX/zZw
	4Xr
X-Received: by 2002:a05:7022:f30f:b0:12c:43:839b with SMTP id a92af1059eb24-12c00438781mr2653107c88.35.1775506443579;
        Mon, 06 Apr 2026 13:14:03 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bed93f861sm17022333c88.0.2026.04.06.13.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 13:14:03 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Rong Zhang <i@rong.moe>,
	Kurt Borja <kuurtb@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v8 01/16] platform/x86: lenovo-wmi-helpers: Fix memory leak in lwmi_dev_evaluate_int()
Date: Mon,  6 Apr 2026 20:13:45 +0000
Message-ID: <20260406201400.438221-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406201400.438221-1-derekjohn.clark@gmail.com>
References: <20260406201400.438221-1-derekjohn.clark@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233436-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 0D58B3A6E99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Rong Zhang <i@rong.moe>

lwmi_dev_evaluate_int() leaks output.pointer when retval == NULL (found
by sashiko.dev [1]).

Fix it by moving `ret_obj = output.pointer' outside of the `if (retval)'
block so that it is always freed by the __free cleanup callback.

No functional change intended.

Fixes: e521d16e76cd ("platform/x86: Add lenovo-wmi-helpers")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260331181208.421552-1-derekjohn.clark%40gmail.com [1]
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/platform/x86/lenovo/wmi-helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/lenovo/wmi-helpers.c b/drivers/platform/x86/lenovo/wmi-helpers.c
index 7379defac500..018d7642e2bd 100644
--- a/drivers/platform/x86/lenovo/wmi-helpers.c
+++ b/drivers/platform/x86/lenovo/wmi-helpers.c
@@ -46,7 +46,6 @@ int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8 instance, u32 method_id,
 			  unsigned char *buf, size_t size, u32 *retval)
 {
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *ret_obj __free(kfree) = NULL;
 	struct acpi_buffer input = { size, buf };
 	acpi_status status;
 
@@ -55,8 +54,9 @@ int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8 instance, u32 method_id,
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
+	union acpi_object *ret_obj __free(kfree) = output.pointer;
+
 	if (retval) {
-		ret_obj = output.pointer;
 		if (!ret_obj)
 			return -ENODATA;
 
-- 
2.53.0


