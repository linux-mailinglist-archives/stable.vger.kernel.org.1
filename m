Return-Path: <stable+bounces-220290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BUYB60vo2nb+AQAu9opvQ
	(envelope-from <stable+bounces-220290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:10:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F931C580B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C50A930D011D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3DE386ECF;
	Sat, 28 Feb 2026 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPzD1gCi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6F2386EC6;
	Sat, 28 Feb 2026 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300194; cv=none; b=RD193UhHonhYj0H1I4U25lHjcHyhpfCYSjI6Dq3EXZxCUyJ6/FgTRkr8z1mX6wVraxc2uJ5tYRgRkCqK5cyQzH5ixbTvohF/9h9po+oIiJCHkJ5eynZn27ZXbvvXwkGgmSnnJkFiil5fLZUfM/ObEZc9zgd0d1yqCZ0xbGYtqMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300194; c=relaxed/simple;
	bh=N17G3sxYWFycVNeydnt5jj9kJK1CfhUB6xGvl3w60Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5Eh5UIiH64xHeJAJ+qjxHfiUQ0BtxsqCCccSvPl6eq1KdndnS8a0SALpWkwS8JKsle1dpQzH0Rt3CAp2sAZQMmKq1611v9EUz0dUU/4Lq0sHxAopHbwPXlS4xQ0M+czC5H4w+V/5jEFLhP9j6c5/yaNz1q/ZvUdfPo7BPzrS1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPzD1gCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81C2C116D0;
	Sat, 28 Feb 2026 17:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300194;
	bh=N17G3sxYWFycVNeydnt5jj9kJK1CfhUB6xGvl3w60Io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XPzD1gCiUPgO/+DEhv6tLAI6WQfNjUW5Rrj7YX3IpJAJZoUtTZROQcwD8ZWnvDjGN
	 KB2b7rA5zyuxUbNSENjs4ZYlx9308N8cZsBMiPdAecAoCEUBj+cr8w2Snik6OySfU6
	 Zp61LS1zMmdcAdItjxbApXJpttug1ECkosmybs7aVPEThbPoprzdjrFX5qP3q1KNpy
	 CshebIGZ2+Eq/NKnx+lGkpZJQ4+KzMJuJAL/LXv906oRvmJNacRz/43qmm8uzUi5Q3
	 jfRVlA8inNTeNtThRIAKpEQPEMWpXZx/m8fbKD4jSt1yTTiMIpDL3p/PNgGLpCgOuY
	 is70FzFOU7Byw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thorsten Schmelzer <tschmelzer@topcon.com>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 212/844] HID: multitouch: add eGalaxTouch EXC3188 support
Date: Sat, 28 Feb 2026 12:22:05 -0500
Message-ID: <20260228173244.1509663-213-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220290-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B2F931C580B
X-Rspamd-Action: no action

From: Thorsten Schmelzer <tschmelzer@topcon.com>

[ Upstream commit 8e4ac86b2ddd36fe501e20ecfcc080e536df1f48 ]

Add support for the for the EXC3188 touchscreen from eGalaxy.

Signed-off-by: Thorsten Schmelzer <tschmelzer@topcon.com>
Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h        | 1 +
 drivers/hid/hid-multitouch.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 5a18cb41e6d79..6d8b64872cefe 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -437,6 +437,7 @@
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7349	0x7349
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_73F7	0x73f7
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_A001	0xa001
+#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_C000	0xc000
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_C002	0xc002
 
 #define USB_VENDOR_ID_EDIFIER		0x2d99
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index f21850f7d89e4..7daa8f6d81870 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2212,6 +2212,9 @@ static const struct hid_device_id mt_devices[] = {
 	{ .driver_data = MT_CLS_EGALAX_SERIAL,
 		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_A001) },
+	{ .driver_data = MT_CLS_EGALAX_SERIAL,
+		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_C000) },
 	{ .driver_data = MT_CLS_EGALAX,
 		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_C002) },
-- 
2.51.0


