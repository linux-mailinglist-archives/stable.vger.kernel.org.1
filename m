Return-Path: <stable+bounces-212601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oO4FNOM0eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:10:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03380A531F
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A5DC3163D2C
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EC42DB791;
	Wed, 28 Jan 2026 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sOCsA3YE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFC681AA8;
	Wed, 28 Jan 2026 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616066; cv=none; b=IEY2TJyTBibsNUZOprHqPYLuvD8p0zuAquetkpu5snXtMydLRKWEc7oqjU/G1PdAUNdbyidRGnmi0M6Fl+gRPpKd+4rIQXsrf2KnZysfTkgOL4kjhft1/tnHENFisqdr6s/G+GbBq6fX3JhE/7JQFwkcqIlMHMg9p0IPg2OEjME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616066; c=relaxed/simple;
	bh=pkfYbo+8F4YdO+Z8QTLCJsmmo1psVobCwHtzcR21qD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGhqth0eUBkk38aQaEKOUWn+sCa1WzvxXQ4A2h79USjwkNRlq/aYubXv0sDdleX2c8EekXgHVKUNHxCPHvux0ALp1QqDxtLZinV6++oS4gbtO9SnO7ka0hBzRvHGmykhxlYZ2Kac3gJiYumIw/45zJ20kCxHnTa6ZV5+HS/oAdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sOCsA3YE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB67C4CEF1;
	Wed, 28 Jan 2026 16:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769616065;
	bh=pkfYbo+8F4YdO+Z8QTLCJsmmo1psVobCwHtzcR21qD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sOCsA3YEcoyurERxX30PDJKcLiGcaJpz4iNGqJbV15ymR7CBrxKqIB2OAvJ9gYzRZ
	 +lwJWqngtFScG65PF9VwcBsO/+MCdlCQw2JLGD3B2PSEP7jZZEP0Eb0ndvHQXZ2v+0
	 qhibL3VKUaD7yYlTrFX5PW8n5PBAv5aQx9CnfLVE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.18 196/227] platform/x86: hp-bioscfg: Fix automatic module loading
Date: Wed, 28 Jan 2026 16:24:01 +0100
Message-ID: <20260128145351.497409547@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212601-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,intel.com:email,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03380A531F
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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



