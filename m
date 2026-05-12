Return-Path: <stable+bounces-246087-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEJ9ACxrA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246087-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:02:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D9A526931
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84E02316285A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91D13BB129;
	Tue, 12 May 2026 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nd199hIj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992393955DB;
	Tue, 12 May 2026 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608324; cv=none; b=cn5kevd3QEh4EPbvpFq+oQhUHmHftZrVslX83pV7u5S7DtfeRQW6y9fmvPOJdEtPFYY5T9xdhZMyPEgsmwppacFmbiqwViPqQQWunBO6g3AvBY0ARONy+IGo6OPMsfn+tLVBNKU46ClQSCEQvqaA64xeSeM+8qnLbXVoZ4WHzhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608324; c=relaxed/simple;
	bh=3PwNKzuw5fNswCslRv5mKvXez3PjQbERFumJBY5iN7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkjKMD0b7WZQ39FEejGBUle9K2tgTJvcRX/eBbUhynSpMJG+8lYEvGNAdl0WCuaKLr/NFiOHcXBBmTbxCc55ZK2sGtVVXRLHKAIm6PyOa5WeLLSiAfbpgWMlHm53cjzzBYY1C+Shgv+S0RyklE0XjVYG65J/JrTdlfsBExJRlEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nd199hIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A10C2BCB0;
	Tue, 12 May 2026 17:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608324;
	bh=3PwNKzuw5fNswCslRv5mKvXez3PjQbERFumJBY5iN7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nd199hIjCyw9H5Eu2jp9PUUSfBatF9VRUNlBovoeq+nKmIcvk3r4QgQoX2KQqJmrC
	 sV0JLdHLMN3Z2dkCiQwkVCyjEmsHnndSh/OpsXcWdUObq6TAsHWB3eq6A1FuzRmT/f
	 CZX4GAVEVX2LJoaheE1Y/vIxqVLvXxqdH1P7YNhE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Jan=20Sch=C3=A4r?= <jan@jschaer.ch>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 6.18 007/270] ACPI: video: Add backlight=native quirk for Dell OptiPlex 7770 AIO
Date: Tue, 12 May 2026 19:36:48 +0200
Message-ID: <20260512173938.609906599@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 85D9A526931
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246087-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rjwysocki.net:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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



