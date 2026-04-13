Return-Path: <stable+bounces-237331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJSAHu8f3WnYaAkAu9opvQ
	(envelope-from <stable+bounces-237331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:55:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3CC3F0395
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39531304C416
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215B3318BB3;
	Mon, 13 Apr 2026 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gtSz0x6j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F05317152;
	Mon, 13 Apr 2026 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099178; cv=none; b=b0DmYKfuS4E5yBasMuz1CxPg5cvycKev2IKJ9d2CS0Jp0aJFXfWg4aOxyVgRaVE/Tz0SpPclpc4+U/rAwU+xfnvROIv3VdSLPjDWDq1DL3bBbkg80vM0Ndpxb95v9gCgaImRGqUn5X/wwWhvs7iQzlgcLOR0pjgaGX1NKklNEDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099178; c=relaxed/simple;
	bh=CjTnLIkfSlh+raT4XDx3l34sFCqqvnPpQuP2fh01rEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBFpsStlgTIUiUTW5NKvucWnX7KQHFJ4VszLrBDheJrf/QUdrDNiofvyuiFo/a2/80qWE2l3dxYWNnegncJXwv1OCUMoAYFDGo9/imXIZx/o2HzRe30vqDE4tGrI380QfDUxQdL9GQAZuMWabJb2o6621RXhzzuzxUn15uX+bwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gtSz0x6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67282C2BCB7;
	Mon, 13 Apr 2026 16:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099178;
	bh=CjTnLIkfSlh+raT4XDx3l34sFCqqvnPpQuP2fh01rEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gtSz0x6jSuC43R/l8jIVcwsAdK6senDX5scF7ISYvZd7G+x7WkixXJNx/m9lxIcIm
	 liYDI5KDSi5eoM0RGcdr2cIBPpAGzoFI9X6e0GgcB8gjCf6bpchrCvH/HpoIuzjXkX
	 PvWmCzj1fE/4nhGREtRbZrH+IC0nTadnbFz+0dGA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leif Skunberg <diamondback@cohunt.app>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 239/491] platform/x86: intel-hid: Enable 5-button array on ThinkPad X1 Fold 16 Gen 1
Date: Mon, 13 Apr 2026 17:58:04 +0200
Message-ID: <20260413155828.004805910@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237331-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,intel.com:email,qualcomm.com:email]
X-Rspamd-Queue-Id: 1D3CC3F0395
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leif Skunberg <diamondback@cohunt.app>

[ Upstream commit b38d478dad79e61e8a65931021bdfd7a71741212 ]

The Lenovo ThinkPad X1 Fold 16 Gen 1 has physical volume up/down
buttons that are handled through the intel-hid 5-button array
interface. The firmware does not advertise 5-button array support via
HEBC, so the driver relies on a DMI allowlist to enable it.

Add the ThinkPad X1 Fold 16 Gen 1 to the button_array_table so the
volume buttons work out of the box.

Signed-off-by: Leif Skunberg <diamondback@cohunt.app>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Link: https://patch.msgid.link/20260210085625.34380-1-diamondback@cohunt.app
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel-hid.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index 9bc2652b15e71..12d695adf3f74 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -93,6 +93,13 @@ static const struct dmi_system_id button_array_table[] = {
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad X1 Tablet Gen 2"),
 		},
 	},
+	{
+		.ident = "Lenovo ThinkPad X1 Fold 16 Gen 1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad X1 Fold 16 Gen 1"),
+		},
+	},
 	{
 		.ident = "Microsoft Surface Go 3",
 		.matches = {
-- 
2.51.0




