Return-Path: <stable+bounces-256217-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFW7CSKtGGpymAgAu9opvQ
	(envelope-from <stable+bounces-256217-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:01:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D81D5FA133
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3593130813AB
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBB62EF652;
	Thu, 28 May 2026 20:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mvci30ae"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E83217F27;
	Thu, 28 May 2026 20:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001085; cv=none; b=HJ5Yc35w8UbVHSj6jYduZCbRPnIcMW9D3oIxD5Re7/OQeGRmFRKTL89VuNhkXwe6OSl0YMa1qV9WkK40GusJylaQFPPVoQSzl2uVn8icTfmTuf5SJF9Mp0KiUJ6FKEx9Xx+GT+8uhAJbiG7mIpV87fYySK0MdY1KvA13Zjcf1cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001085; c=relaxed/simple;
	bh=mz2+8f59vAzFQNdQ9r2UcQj3DuCnlVKaLrxA0wYeBPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQyOHH00QhF0IHgDlD7TOREDyCkoCS3nSnmMxdNHBZZ4OfeKbzS0uxvdC4rKoGBKfOEbZ8HnxBvW9nEFvJLTAO3oOp1KyxyFDT89EYBsEIcgr7J2w008rZJvNjpUEzC0IpT48APAQd97Wm5Xh0PLr3oQ4kms9d3xy7zFz12W1m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mvci30ae; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BFF1F000E9;
	Thu, 28 May 2026 20:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001083;
	bh=Ln4W3e9/ulVp6Exufj45eqRmGNpOhqedMVtdKwvVSpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mvci30ae6PiNX1pcR45BLhd1ib6SGKaZUhM7Tl/aYSDEdYJKP+9UQLdDfKSpg2/vD
	 hBMrvSxMYN+g00zLa6kzufYFY3gsKUHZCTyvWtFsMF413BzcvnV24170bn4YALumGF
	 /zLEgiW7Q7HuSnhRo9dYZ72ElsRw98WOpQYoaUtk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 248/272] platform/x86: adv_swbutton: Check ACPI_HANDLE() against NULL
Date: Thu, 28 May 2026 21:50:22 +0200
Message-ID: <20260528194636.069729474@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256217-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6D81D5FA133
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit e7a9a6ea40e352cd7977f6a8c80bdeadf65ad838 ]

Every platform driver can be forced to match a device that doesn't match
its list of device IDs because of device_match_driver_override(), so
platform drivers that rely on the existence of a device's ACPI companion
object need to verify its presence.

Accordingly, add a requisite ACPI_HANDLE() check against NULL to the
platform/x86 adv_swbutton driver.

Fixes: 3d904005f686 ("platform/x86: add support for Advantech software defined button")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/5115425.31r3eYUQgx@rafael.j.wysocki
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/adv_swbutton.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/adv_swbutton.c b/drivers/platform/x86/adv_swbutton.c
index 6b23ba78e028f..f7bc252650d5a 100644
--- a/drivers/platform/x86/adv_swbutton.c
+++ b/drivers/platform/x86/adv_swbutton.c
@@ -48,10 +48,14 @@ static int adv_swbutton_probe(struct platform_device *device)
 {
 	struct adv_swbutton *button;
 	struct input_dev *input;
-	acpi_handle handle = ACPI_HANDLE(&device->dev);
+	acpi_handle handle;
 	acpi_status status;
 	int error;
 
+	handle = ACPI_HANDLE(&device->dev);
+	if (!handle)
+		return -ENODEV;
+
 	button = devm_kzalloc(&device->dev, sizeof(*button), GFP_KERNEL);
 	if (!button)
 		return -ENOMEM;
-- 
2.53.0




