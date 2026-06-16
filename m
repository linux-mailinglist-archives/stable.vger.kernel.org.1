Return-Path: <stable+bounces-264425-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y9u+AEp6MWp2kQUAu9opvQ
	(envelope-from <stable+bounces-264425-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:31:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC438692286
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:31:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="HCmeEn/3";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264425-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264425-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8E9330E3432
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906F24611C1;
	Tue, 16 Jun 2026 16:03:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51714451052;
	Tue, 16 Jun 2026 16:03:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625815; cv=none; b=N028G9ZMJSQTKDG7yHaT+804AGF4+kLI5gCbqquQrjz/U7/Ml0zncXgjGJdIz0aAAmWq5JRbsR0V3WP8q7BsYutpSzHps/AI0fEswe8axBKZMhP9x+cKbn/9cIvlMMvhh3KKMkL3U5U6ctd2PW9Kxokn6r5NSzmYFQpcM/LdVRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625815; c=relaxed/simple;
	bh=EbT7g4OLMbFiPJ3ptyJJ3okUxociPFgqeZfk+gNl9CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJ5vYAN565M0CJqsUGLFP3Kybcf8LuM/HBqyxRCc8rcGJHE6O3kHQljzx6y8QnEIhvJ6MXv2Qs8xaIFFaJqnm+MaMdTF4mE/G3IpcpDbHaiUflpcnJoOYwl8rVu4IpVWXC+do2504dOb0/C82YsWYcR9xxjI1oLXVHmgiKoXKZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HCmeEn/3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0951F000E9;
	Tue, 16 Jun 2026 16:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625814;
	bh=Dcwl5Ec2WDq8dQgsHiT2CFc+wAcKH8BSy1/HXNRgx6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HCmeEn/3oVkgN4rjdLCFED+AVFfWTOVbPWziOhGv6ZEs/4+2RcxEPFSWrLuMDPdrp
	 dZHi4FkKDOIn7UkGSCeONoZmNrIBVl61q80c4QrimSF4hwJIarL4+aG64aQv6zlXFO
	 gAccNkmGWFkBuv9Ipo5YVx08o8QKYm6rj/8WcjMs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.18 182/325] drm/amd/display: Reject gpio_bitshift >= 32 in bios_parser_get_gpio_pin_info()
Date: Tue, 16 Jun 2026 20:29:38 +0530
Message-ID: <20260616145106.949701205@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264425-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:alex.hung@amd.com,m:harry.wentland@amd.com,m:ray.wu@amd.com,m:daniel.wheeler@amd.com,m:alexander.deucher@amd.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC438692286

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harry Wentland <harry.wentland@amd.com>

commit 49c3da65961fe9857c831d47fa1989084e87514a upstream.

[Why & How]
gpio_bitshift is a uint8_t read directly from the VBIOS GPIO pin table.
If the value is >= 32, the expression "1 << gpio_bitshift" triggers
undefined behaviour in C (shift count exceeds type width). On x86 the
shift is silently masked to 5 bits, producing an incorrect GPIO mask
that may cause wrong MMIO register bits to be toggled.

Validate gpio_bitshift before use and return BP_RESULT_BADBIOSTABLE for
out-of-range values.

Fixes: ae79c310b1a6 ("drm/amd/display: Add DCE12 bios parser support")
Assisted-by: Copilot:claude-opus-4.6
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit eadf438ab8d370b9d19acee9359918c85afeb80d)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -700,8 +700,10 @@ static enum bp_result bios_parser_get_gp
 		info->offset_en = info->offset + 1;
 		info->offset_mask = info->offset - 1;
 
-		info->mask = (uint32_t) (1 <<
-			header->gpio_pin[i].gpio_bitshift);
+		if (header->gpio_pin[i].gpio_bitshift >= 32)
+			return BP_RESULT_BADBIOSTABLE;
+
+		info->mask = 1u << header->gpio_pin[i].gpio_bitshift;
 		info->mask_y = info->mask + 2;
 		info->mask_en = info->mask + 1;
 		info->mask_mask = info->mask - 1;



