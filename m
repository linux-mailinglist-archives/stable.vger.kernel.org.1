Return-Path: <stable+bounces-235740-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GH6sOpt12mn82ggAu9opvQ
	(envelope-from <stable+bounces-235740-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 18:23:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3573E0C99
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 18:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6F3830182B0
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 16:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E50F3B7B76;
	Sat, 11 Apr 2026 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhA+C8EK"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFDC39280A
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775924621; cv=none; b=UexJPX0OaHk2koPN81Y7owVxNxmDMlZXKNrayno96wZasBsPW52AY+j1pABTmSeuRtkTPbVJivoNiI10iQ41CWcUXAS33Ko5zFnxIu5WXT3CVUw8mPG9eiC4dTkkHScpt5pb0oQOtsEQemL6rYv0pB7bZUPHmBnr8+EQhDJZ+xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775924621; c=relaxed/simple;
	bh=as/Y6rgrCLbxvFJK4woRt4WCiXpZGU5Bmcl75dpz1Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFME6tCNlTel+hdgS/8Dw+bMSaR6NCg63j5dRl/FYGP2zZiCghwCne7h1z7qmQ/4qcGawyrdpfmazJmpQQxA48qNuFqYvSUC8/UmgRTdHG1KeugbLzlPbNfS0uGXi+VBfoQYR59MyVkuuKNKAzrUmj8hszXB5nmW4NrPhuSczwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhA+C8EK; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ce22328930so4695961eec.0
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775924619; x=1776529419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Epvlpqxnk7CA+C9ymJCfGqy8SHrtqDJZ4fsM6TY9RM=;
        b=nhA+C8EK63vA/lCT3ei+/e4Iojle5HzxgZoPE9+317fXrJyyVzVVDNsfj1V+ROVftI
         FYpmeRbjVWaU+2fXDGfcEdHYzAGHcQDNuHApB0Iy7hXvTqQT2fWOdp7Y2kjk+8iM3Gun
         ng45l3ssKI2dKiZTx0bhKHD+cOuQloaYdZaOh7amDnB3SYlx1nHdAVL9mynfieWFfvDt
         QWwF/bWR0Aw1z+gkUqI3B1pF5q2IwoteVS86yoDE+nrUVplOB/i6MMbLtnYTqG3SnItl
         cWVjRSH/zGd5YCGOOKDCKaqOZMU3PKdTJ5M7Br7UALiv+F66mroK/DeoSUGTdRx4GPAU
         Gy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775924619; x=1776529419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Epvlpqxnk7CA+C9ymJCfGqy8SHrtqDJZ4fsM6TY9RM=;
        b=rx5FEEDiwkmZ+nVJSuKeGWSteh3aHM6cPB23W4ZIpq4049Qew+33C2HTgcchcmU9Kz
         BVhg9OXZ0kfQZhwOtUwxS6UDRHZsYzax183oLrxeVN4ZGH58NxOuE2iQfmSALamj/KWF
         4DP/EpUB1cpMxwt/Dc1KKUr716gpwaANbE1Q+A/LDRDtLxl4zXN3sO4wGq/+PuWvu7ys
         +Ij37TS1jvh23kSfeN0bcotYSKXo/0uK7yaSCbKMuM4gq8/WPsK+7Xq33R9rOtX3BGs2
         ZmBK/HEW6dj5P3nYZvX2MwHzB9KM/KAx3gJI/4Gx+l6jM3W/Gl+Iji/0m8H75KLxohYM
         LUSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzn6z4qZ0JBz3xvLvW/roLbD2naQAmt75kc3fYCU8/fhffD6UBqpsPboqR8tJf3DuyG/VdVI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNL3+iBYL6g4KU5DJzuZyR/gnW2o3jqc10LBswIse1BvUrmy5p
	Q0/mblkll6/dj23HLwi/W5yAo36kxY42ihGtmKq5Tu5cMxPJgF8U3VMi
X-Gm-Gg: AeBDievhQwWif5jUJ7S77RuofgTtc0EUR9TEYlZHThKFd7XNM2sFWcZtN8CVcXUUds1
	/fCi4wjzIdCDAYaXdGzc63KW/GJ8BYRzMX+NBh8JhUafJZMzBOQl/Eq7sHcSQQrm9dSgn0vaCi9
	KepeZ7C2WX9W4wfi7+xGCaMfSSEoyHgIHb4KSVGX+xRSsE8fZbcfdMKkEb6jux2jG1oCsGYnTE4
	XDMnCDucs4Rpz1p0RjaQ9PS30/vu67Mbiq+3Amruiu/R9ewCxYhlGrt99ZO7Mu8Hvyi/m91TqAD
	GbvRvoT8M+7ot8z+K29nPkczonhm+26UMvxCAElFDdgP2dRfhd1lkxOcXgVPFl6ba8z95tdOqA5
	C9CQdunIwLXkTUiixocgVwxSXlRqtzOMNYTNhE8GNFrYJ/7MXa2yj4sTmlwn5dXhsrvN1LJNloL
	41XJa0lPwoOru1ruEvTs5FzRhf9Ii3Vzrk33mmK3j+XNmKdUi5ckzhT0FE6Y3uWrRpJxb6JXfLE
	/9Bg8c2RE+d2nY=
X-Received: by 2002:a05:7300:8c9e:b0:2d3:d3f:2429 with SMTP id 5a478bee46e88-2d583ed5c11mr4689989eec.0.1775924618851;
        Sat, 11 Apr 2026 09:23:38 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55ce46a65sm9358907eec.0.2026.04.11.09.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 09:23:38 -0700 (PDT)
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
Subject: [PATCH v9 01/16] platform/x86: lenovo-wmi-helpers: Fix memory leak in lwmi_dev_evaluate_int()
Date: Sat, 11 Apr 2026 16:23:19 +0000
Message-ID: <20260411162334.25682-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411162334.25682-1-derekjohn.clark@gmail.com>
References: <20260411162334.25682-1-derekjohn.clark@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-235740-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,rong.moe:email,squebb.ca:email]
X-Rspamd-Queue-Id: 8D3573E0C99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Rong Zhang <i@rong.moe>

lwmi_dev_evaluate_int() leaks output.pointer when retval == NULL (found
by sashiko.dev [1]).

Fix it by moving `ret_obj = output.pointer' outside of the `if (retval)'
block so that it is always freed by the __free cleanup callback.

No functional change intended.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Fixes: e521d16e76cd ("platform/x86: Add lenovo-wmi-helpers")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260331181208.421552-1-derekjohn.clark%40gmail.com [1]
Signed-off-by: Rong Zhang <i@rong.moe>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
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


