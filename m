Return-Path: <stable+bounces-260749-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x+wqLmEMI2qAhAEAu9opvQ
	(envelope-from <stable+bounces-260749-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 19:50:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C48A64A508
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 19:50:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=A8B73ZVy;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260749-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260749-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 097453047BE2
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 17:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D944237756F;
	Fri,  5 Jun 2026 17:44:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ECC37D124
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 17:44:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681465; cv=none; b=q+/dS6LoY6Dmh510A/P+/kZzO+eCE2/46ICcr8JjnFjrEWjNVBnZqcYXc9RvLcA+JEq2qaW3EIbVOEFnmuSua2UO3jdnmsB11VDu58FSU9/6rroh14kvNmCJzdVSSZfZhK0STG/pdOMrGxzUqneWclzok7UpnoE2CCjz7OG7SgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681465; c=relaxed/simple;
	bh=E9w6f0xrSSYtvlb3ya5JkD8VpRPp9n43dUx3ws1rFiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TjmpXG3t7lI8nVxNfcn0TqNnoFdrYq2mQx9xhn9r9ridJnT/Gw7hUGVeZSVtouPbLztIE8DysDyGiRAHMO+alAY6wfc26Zd1+5sj76rtmqZFwhUnnxteVjdLLCay2cW75CL+Wpqq3kFDuvccquoWO+Bc8NWk9ZzsLAYKDj2cmtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8B73ZVy; arc=none smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-842358aaf36so950133b3a.2
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 10:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780681455; x=1781286255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RU4D9IDGoqS0yzp32EWwU+AQX5TFq61qrIjDkY+Qek4=;
        b=A8B73ZVy8Y4NjpTJCLlJbYTNWMtTdC+U+mrzxuzwgv3McG00350MpE9wtKpperxSNH
         xZqoLsK7n5a6k7+4HB/EmY/KhLF9HcE8xPmPgAHHNkq845ZSpmu/u/tnHr43Pl1ihrLv
         Hxb8z8/skl+ysS10qBIw77c/XAzWv+w9EOD7dskJMg1jGyfDY8cTWr1UzvNGwyxfIWUd
         bta6FkgM8VJ0VnKG7s7GSo54bPbAROqxoBCbeQdPMHFvdH6QJjioLIGrq+JJSZgcp4d+
         8srhoGyPIqdVPG/iUThTbxgAZEZYMk+j8JtRQ+RvRDdN+dUCtJaA4Hg1Q876RaKQvtQr
         TaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780681455; x=1781286255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RU4D9IDGoqS0yzp32EWwU+AQX5TFq61qrIjDkY+Qek4=;
        b=UTD23k9rpfcdFam6pjqgaSzETKzvIFtsWB+11g8+W6Bkx5XlG6oLa4FEbBL5MjpQ1C
         OZbV4s/eze4IsnRRIFyEESzVMVub5Vfb0v+VSSyCUCwQv2voO5TT8I7n6vUmq3LslVQe
         q0gj8nHLaHTYTBIe5KKqnN3usHG/QTRbFWaLyBcolLx/CLeVDtS17Ekk1PJsz6pbBHom
         L+qn1xl1VKFEQpR+dbLE67go0Z4RSE7ZFXeew3DYuVehVwEMogUYn2+CIpLop6UenTMz
         scSfEWpHQtB2AdeX0pHoHlUNsmwzK3QT7GBG4aBgdZYG73GTAsPW5a8qhHk7b9R0Ic71
         LiIw==
X-Gm-Message-State: AOJu0YxAfFRRH7vXgzhh7WBBmegsZDDgOV+t4cYqt7atZPooqLd/Hvri
	bM3jzYAFEOzec6cT19ODyG62koG5EEzsvWEr36jAeYHsTvFx+Py9oeKBrlOE9Ht+
X-Gm-Gg: Acq92OGFp8SwpsUxAgCpKOMfSbKk/SZ0r3Y994CjbUxc3574DsNRzgfoGYfqdwRhPxe
	6bMP4yFmEbehk4jlnRi1qT+JFqJbZLP6G6bva0OAKC+F1DGwLQ5wKovzS9hgNjXpkg6Jqc2wjvm
	UHvDiulFy9RCQ12fnNZCVEqLDpgURhPnZAWMYz/SlKZw8nB+Bhaw5QiMkbp1qB2Z8wTfzcU9/7p
	gqusblv+R20d85YDICY1UQdTLQ5nDev4guTK9Z06hOs1ZZzrjB8qqjo3SKJx+rkXNrLrH4bQ7MX
	5842uUd3QyDGMeb4pF8iYa/CEfLfCWfJ1kM5vZVl8TJUMB/M1pPSf2g3jQCgJXylXCmVEIyvTeO
	LCm4mq6fINwSAqDqXxXq1vpPm+JymjoQNDa5s/zC172nfhOpyU/LxQ0EqV5t8LsJPA97E/XH3gR
	bqVm+3wkKWD0PtgZI6Awvhj0C0KuDw14yPcpwqY/GyH/4h7laFR8EeSqSOjHa1Jx0VRnNzPUXB9
	nF5uyW2t8b/BIW0nmezOk4ISljq8HrF3z/vkA==
X-Received: by 2002:a05:6a00:3cd6:b0:842:678a:a7dc with SMTP id d2e1a72fcca58-842b0e1300emr4965508b3a.2.1780681455459;
        Fri, 05 Jun 2026 10:44:15 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282494285sm9288888b3a.25.2026.06.05.10.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 10:44:15 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: sammiee5311@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] platform/x86: intel-hid: Protect ACPI notify handler against recursion
Date: Sat,  6 Jun 2026 02:44:09 +0900
Message-ID: <20260605174409.130311-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260749-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sammiee5311@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sammiee5311@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sammiee5311@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C48A64A508

Since commit e2ffcda16290 ("ACPI: OSL: Allow Notify () handlers to run on
all CPUs") ACPI notify handlers like the intel-hid notify_handler() may
run on multiple CPU cores racing with themselves.

On convertibles and detachables (matched by DMI chassis-type 31 and 32 in
dmi_auto_add_switch[]) the SW_TABLET_MODE input device is registered
lazily from notify_handler() on the first tablet-mode event, via
intel_hid_switches_setup(). When two such events race on different CPUs
both can pass the !priv->switches check and register the priv->switches
input device twice, resulting in a duplicate sysfs entry and a subsequent
NULL pointer dereference.

This is the same class of bug fixed by commit e075c3b13a0a ("platform/x86:
intel-vbtn: Protect ACPI notify handler against recursion") for the
sibling intel-vbtn driver.

Protect intel-hid notify_handler() from racing with itself with a mutex
to fix this.

Fixes: e2ffcda16290 ("ACPI: OSL: Allow Notify () handlers to run on all CPUs")
Cc: stable@vger.kernel.org
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/platform/x86/intel/hid.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index 085093506dda..6b4bac5f7051 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -7,11 +7,13 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 #include <linux/dmi.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/string_choices.h>
 #include <linux/suspend.h>
@@ -230,6 +232,7 @@ static const struct dmi_system_id dmi_auto_add_switch[] = {
 };
 
 struct intel_hid_priv {
+	struct mutex mutex; /* Avoid notify_handler() racing with itself */
 	struct input_dev *input_dev;
 	struct input_dev *array;
 	struct input_dev *switches;
@@ -565,6 +568,8 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 	struct key_entry *ke;
 	int err;
 
+	guard(mutex)(&priv->mutex);
+
 	/*
 	 * Some convertible have unreliable VGBS return which could cause incorrect
 	 * SW_TABLET_MODE report, in these cases we enable support when receiving
@@ -720,6 +725,10 @@ static int intel_hid_probe(struct platform_device *device)
 		return -ENOMEM;
 	dev_set_drvdata(&device->dev, priv);
 
+	err = devm_mutex_init(&device->dev, &priv->mutex);
+	if (err)
+		return err;
+
 	/* See dual_accel_detect.h for more info on the dual_accel check. */
 	if (enable_sw_tablet_mode == TABLET_SW_AUTO) {
 		if (dmi_check_system(dmi_vgbs_allow_list))
-- 
2.43.0


