Return-Path: <stable+bounces-257903-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPWEAo0hG2oN/ggAu9opvQ
	(envelope-from <stable+bounces-257903-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:42:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B48061033C
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B65130E55E5
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E196349CCF;
	Sat, 30 May 2026 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IXSwgaCr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A752E7379;
	Sat, 30 May 2026 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162557; cv=none; b=by00rNj4UL2j77ZSW1GE7vkcLEz2WY1k/nLoWVr6OxWP/WSASt+jTlWAkwtsbqbkTGbZ8YvOM99pz2zN5QdE5F0Ohec+5Tl/QVfXk3HB+Xfk0KOws7E5B5Mbe6k3Y1d7sJrDIF+mNvh8VRXGAywo+JXG5vuvAgQvQpJEWviMVdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162557; c=relaxed/simple;
	bh=Jhvx2u8xlbwHEPySYVVV8L1BHxkL9NLHmjl22oFbh2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKkeJQC7uNTMDyyNeQmP19eo1GOaxXrv/9IoODy4hwSago4PX1V9AO6KWToowdxFsJhMBUfnn7XdQOC90yRYQDMqk+FTMGTSy9d/lcurWksHEMMDR8hTNE70JpJD/3m6Gjofr9B7E7GhWigFpskYKWzdppbVi8/b2atkWcO/PPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IXSwgaCr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340431F00893;
	Sat, 30 May 2026 17:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780162556;
	bh=EuGqE3AnyOKfEvvWOtWnYFBFWd2Fy9JpD3ICxcsYX0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IXSwgaCrhvG6ez2U2ZEwIXfwT5hZ5IQPzAI1qNRFrBKutiXATiR1RVxekIS0Ja4yd
	 wgFRcMVJne11NbXg8BHP+D6FVqdJVpTphHoKtKrBm+CK1Ijjzd1tlmSLFcW9FNgNqn
	 gLu9RcZBixgQNMzQv945k8wngm2TrmQ50h1SEu0E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 958/969] platform/x86: intel-hid: Check ACPI_HANDLE() against NULL
Date: Sat, 30 May 2026 18:08:02 +0200
Message-ID: <20260530160327.224276955@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257903-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 5B48061033C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 5c69e090ae5dd93d910f70db0796357080707d26 ]

Every platform driver can be forced to match a device that doesn't match
its list of device IDs because of device_match_driver_override(), so
platform drivers that rely on the existence of a device's ACPI companion
object need to verify its presence.

Accordingly, add a requisite ACPI_HANDLE() check against NULL to the
platform/x86 intel-hid driver.

Fixes: ecc83e52b28c ("intel-hid: new hid event driver for hotkeys")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/1971512.tdWV9SEqCh@rafael.j.wysocki
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/hid.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index 761d88929ef97..ddf46fceb1c37 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -638,12 +638,16 @@ static bool button_array_present(struct platform_device *device)
 
 static int intel_hid_probe(struct platform_device *device)
 {
-	acpi_handle handle = ACPI_HANDLE(&device->dev);
 	unsigned long long mode, dummy;
 	struct intel_hid_priv *priv;
+	acpi_handle handle;
 	acpi_status status;
 	int err;
 
+	handle = ACPI_HANDLE(&device->dev);
+	if (!handle)
+		return -ENODEV;
+
 	intel_hid_init_dsm(handle);
 
 	if (!intel_hid_evaluate_method(handle, INTEL_HID_DSM_HDMM_FN, &mode)) {
-- 
2.53.0




