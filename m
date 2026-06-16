Return-Path: <stable+bounces-266414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 65pfMD+eMWqioQUAu9opvQ
	(envelope-from <stable+bounces-266414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:04:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EE2694B81
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:04:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=0lum7s7u;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266414-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266414-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2131A31FC496
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D235D47D93F;
	Tue, 16 Jun 2026 18:58:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2AF47CC96;
	Tue, 16 Jun 2026 18:58:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636300; cv=none; b=LZSMv65d+RTBOVU83sX14yXMWJdkAN8L5cDh+gL0y4I3RCwuspYxEscEVFsZVWNbghDicg0iQN5LbPgNw+W8Fm0FGIRA4aWTlsf/fZZPHYXr2eFP4ZihzTBP3CBQ7pwjiSIVEGVFwWHs7f6zlA5zzj1Oz/C6xpo6NyOgtGmu32E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636300; c=relaxed/simple;
	bh=3jr3okUo+L3m9RKE1xvgJGjJheRdwjVDaK0RXtVP4lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHej4USsTZxnWfFe7T89HzhfrgI9xZZPxXqYMwox5waLQW1j3DOCm2BtR6f+I4HU3e8OOWzc5chDGHu6Mjrm0DffS0wuobblMFtklsf+eEBM54XM5ju6zp5RsZ0LQXzFCcDfhzNzFErDAK0SblQ99MdE0iSal9DSymWb6uCwG8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0lum7s7u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486E91F000E9;
	Tue, 16 Jun 2026 18:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781636299;
	bh=3iEZ/EGpUD9cgdr3sYtYNTDXHxDuEyR+tdSNJAMfwJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=0lum7s7uJRJ8uXziyIT0GeyqHmltDEqKiq+DxE7F22lR5HV/tBPld7vs5fYYdGWXN
	 bJu2PxyIokWAzFm7mq8zFsK/+nwBuyY5M500CRlgwAiBM4qb736IPIQWxxU2YT6wqY
	 /mbCG1ftr7Pu863c2P+TPfBu1ZDBIUOBpLebVmB0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.10 187/342] drm/amd/display: Reject gpio_bitshift >= 32 in bios_parser_get_gpio_pin_info()
Date: Tue, 16 Jun 2026 20:28:03 +0530
Message-ID: <20260616145056.894288438@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266414-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:alex.hung@amd.com,m:harry.wentland@amd.com,m:ray.wu@amd.com,m:daniel.wheeler@amd.com,m:alexander.deucher@amd.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35EE2694B81

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -546,8 +546,10 @@ static enum bp_result bios_parser_get_gp
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



