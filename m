Return-Path: <stable+bounces-245857-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO01BIpmA2qa5gEAu9opvQ
	(envelope-from <stable+bounces-245857-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:42:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E62525F7C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E98C03075F37
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8A63E0724;
	Tue, 12 May 2026 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VPaG61Db"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FED3CE0A4;
	Tue, 12 May 2026 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607733; cv=none; b=Cg5MufGiL6tqde2ijUN5R+SN9WZYgEqqSV1yQ+zGtSIERlVvC1qRGgcVgmZwH6Nl73QwwRmY81XO8CGDI5xOI1zyvXCrrwsLUpl09kl29yJmtMl/e1su9WcQnavtlTpsyY04fbRejONjq4LfyjKPjdpk57Dr2diy8nG5U5eka0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607733; c=relaxed/simple;
	bh=jCEA1woiup61ziZEAyFOVwnSHGW8/kM1ZZOM4E7rnqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U64obTto7R0JH/hE1A/ti/xi1mz6RoV28A+emxAal4OX1Zf8ZKHIFXIunugcn+D/faQXR0cIFpPfSNkQt7lIyID1Ycyd4ouxmz3oYzp3QgbojyjGhyKQwH0c3NU3C5YWm55DznnfQp/dsi4Youm29wxw79BfxUHSTfrrChu+oUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VPaG61Db; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D29EC2BCB0;
	Tue, 12 May 2026 17:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778607732;
	bh=jCEA1woiup61ziZEAyFOVwnSHGW8/kM1ZZOM4E7rnqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VPaG61Db8yU/IIQqVBfiCx5w1yvet4VSh20gtl9Wl7Kre4tjuwyFSkM3TUzYDZG8V
	 wtTV1VXC1LovwMqUF2qeQ8pjXM3GYX+ATxUU7TzzmQTdh0RXaGSwo0uMpgXEwIDglE
	 pfkJw3gWjxclL0hy3sUx+xX6jdv4pZFGe0/ItzsI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Jan=20Sch=C3=A4r?= <jan@jschaer.ch>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 6.12 007/206] ACPI: video: Add backlight=native quirk for Dell OptiPlex 7770 AIO
Date: Tue, 12 May 2026 19:37:39 +0200
Message-ID: <20260512173932.973751195@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 47E62525F7C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245857-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Schär <jan@jschaer.ch>

commit ad7997f5a01af6f711fe6b6a2df578b964109d49 upstream.

The Dell OptiPlex 7770 AIO needs the same quirk as the 7760 AIO. The
backlight can be controlled with the native controller, intel_backlight,
but not with dell_uart_backlight.

I dumped the DSDT using acpidump, acpixtract and iasl, and confirmed
that it contains the DELL0501 device. When loading the
dell_uart_backlight driver with `rmmod dell_uart_backlight`, `modprobe
dell_uart_backlight dyndbg`, it reports "Firmware version: GL_Re_V18".

Fixes: cd8e468efb4f ("ACPI: video: Add Dell UART backlight controller detection")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Jan Schär <jan@jschaer.ch>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Link: https://patch.msgid.link/20260411092606.47925-1-jan@jschaer.ch
Signed-off-by: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/video_detect.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -878,6 +878,14 @@ static const struct dmi_system_id video_
 		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7760 AIO"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Dell OptiPlex 7770 AIO */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7770 AIO"),
+		},
+	},
 
 	/*
 	 * Models which have nvidia-ec-wmi support, but should not use it.



