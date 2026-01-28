Return-Path: <stable+bounces-212370-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEu4M3k4eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212370-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:25:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 331D8A598D
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13AC93117E0E
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A772EA172;
	Wed, 28 Jan 2026 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MVzeaz6m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656E82C2346;
	Wed, 28 Jan 2026 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615292; cv=none; b=EnGnZUMxCViwTsuow1yjg7zHQFp0gWezUKaWEEsjJ9bjCF07Ry6KdsnqPOGpbUprgHJwSHuiclWCk1XDzVJn1yue0kNPZNGKUYjwCl82VMOVcb+xt9/UU3bFji2/WIpQhfjBA7EXMsXjdrXwdM9tnxCukqebk8eIUlBj2oGR214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615292; c=relaxed/simple;
	bh=11jQvHeKf1jhLonLBi9BAnL0tQ7hMb/WrPRcKfIueGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRA/h5qjfAQrUHGvRXFz8nntoMZjz9KjBAE2IUQwBTgZhn79ektwg/tBiTRzIjBU+jiWorcqI3ZyBvhXD7W579Lz9k0ImQ+rzqr797sIxcTNvq5WqPBpc1rVAwjci+lSA4WlDcH6X2plWBlsFzXjhJCrs6Xfrjdq1lTbxPVM/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MVzeaz6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C682FC4CEF1;
	Wed, 28 Jan 2026 15:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615292;
	bh=11jQvHeKf1jhLonLBi9BAnL0tQ7hMb/WrPRcKfIueGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVzeaz6mC8RlAArc9vlMTUXmK1M7jrKhksbTVPaovL3XrOl4ePE2Us8g0yyVBBZQI
	 ATcYta5nWeBgGVSHxP3mivb0AlGaPqr26gNjn7Nc37OT5Z7YJlMH4ka19XoKEec6T1
	 43RxYMwVCIDo/I/Es/JeQPeEJMfB3+N3eubjONOo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.12 135/169] platform/x86: hp-bioscfg: Fix automatic module loading
Date: Wed, 28 Jan 2026 16:23:38 +0100
Message-ID: <20260128145338.865936181@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212370-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,amd.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 331D8A598D
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit 467d4afc6caa64b84a6db1634f8091e931f4a7cb upstream.

hp-bioscfg has a MODULE_DEVICE_TABLE with a GUID in it that looks
plausible, but the module doesn't automatically load on applicable
systems.

This is because the GUID has some lower case characters and so it
doesn't match the modalias during boot. Update the GUIDs to be all
uppercase.

Cc: stable@vger.kernel.org
Fixes: 5f94f181ca25 ("platform/x86: hp-bioscfg: bioscfg-h")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20260115203725.828434-4-mario.limonciello@amd.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
@@ -57,14 +57,14 @@ enum mechanism_values {
 
 #define PASSWD_MECHANISM_TYPES "password"
 
-#define HP_WMI_BIOS_GUID		"5FB7F034-2C63-45e9-BE91-3D44E2C707E4"
+#define HP_WMI_BIOS_GUID		"5FB7F034-2C63-45E9-BE91-3D44E2C707E4"
 
-#define HP_WMI_BIOS_STRING_GUID		"988D08E3-68F4-4c35-AF3E-6A1B8106F83C"
+#define HP_WMI_BIOS_STRING_GUID		"988D08E3-68F4-4C35-AF3E-6A1B8106F83C"
 #define HP_WMI_BIOS_INTEGER_GUID	"8232DE3D-663D-4327-A8F4-E293ADB9BF05"
 #define HP_WMI_BIOS_ENUMERATION_GUID	"2D114B49-2DFB-4130-B8FE-4A3C09E75133"
 #define HP_WMI_BIOS_ORDERED_LIST_GUID	"14EA9746-CE1F-4098-A0E0-7045CB4DA745"
 #define HP_WMI_BIOS_PASSWORD_GUID	"322F2028-0F84-4901-988E-015176049E2D"
-#define HP_WMI_SET_BIOS_SETTING_GUID	"1F4C91EB-DC5C-460b-951D-C7CB9B4B8D5E"
+#define HP_WMI_SET_BIOS_SETTING_GUID	"1F4C91EB-DC5C-460B-951D-C7CB9B4B8D5E"
 
 enum hp_wmi_spm_commandtype {
 	HPWMI_SECUREPLATFORM_GET_STATE  = 0x10,



