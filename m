Return-Path: <stable+bounces-213414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULKwM5Jbg2mYlwMAu9opvQ
	(envelope-from <stable+bounces-213414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:45:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 363D0E7514
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7423C301B716
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C85280A3B;
	Wed,  4 Feb 2026 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CB1+wk2b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6D240758D;
	Wed,  4 Feb 2026 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216257; cv=none; b=ft2LmMontGcIbt0wddJrKljgKPXhD5LZHmbfDff4gwQpP3Uy1XVusUsNxrGuzAQFxBEMfFNZIuA03X2HUDuxy5XyPsXJpPi9/BnVH5nFBMvODBUmn+Z0qaODFxEgV3YAIaG4avFTK4MVkHjcZI+QumXNK1c5uZotZgYSzzuQ9Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216257; c=relaxed/simple;
	bh=S8XrTO6j0KrocNUd036mt6sEeoPwAtmFZR0nOYN9bNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mhi1DqJAGVimFm3j+2F5giVHu/Ijqs2ZcZ8EU4Rn1Y9rhW5JjfITQA1ZF9KLrGZxD7PQpEfWkUbBiu8xfEb7sj8Pi5IVyxQqd+8g/T5lyynzEWo4/pVW0udUQ1tKKBi+OARj6IMgnWrNrfO2EqvvsWC9LiigRgkXZdvy/6vXdwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CB1+wk2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8021C4CEF7;
	Wed,  4 Feb 2026 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216257;
	bh=S8XrTO6j0KrocNUd036mt6sEeoPwAtmFZR0nOYN9bNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CB1+wk2bFugVb3MafZuIV+0+34yRmeuVE19zPt1CRZ4SE8YkKC9uidker4Y97bOUI
	 zS3dPTqPuiZIEThl1KshYupwOLdlyHGzDae29EJqm+mzrcOG62HH+qePfgNKohegoR
	 aviLZ/GVMqNh7lfxXu9JziSvNfH+mCKaz3k2Qc08=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Vasut <marex@nabladev.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 5.10 035/161] drm/panel-simple: fix connector type for DataImage SCF0700C48GGU18 panel
Date: Wed,  4 Feb 2026 15:38:18 +0100
Message-ID: <20260204143853.025128966@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213414-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,nabladev.com:email]
X-Rspamd-Queue-Id: 363D0E7514
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@nabladev.com>

commit 6ab3d4353bf75005eaa375677c9fed31148154d6 upstream.

The connector type for the DataImage SCF0700C48GGU18 panel is missing and
devm_drm_panel_bridge_add() requires connector type to be set. This leads
to a warning and a backtrace in the kernel log and panel does not work:
"
WARNING: CPU: 3 PID: 38 at drivers/gpu/drm/bridge/panel.c:379 devm_drm_of_get_bridge+0xac/0xb8
"
The warning is triggered by a check for valid connector type in
devm_drm_panel_bridge_add(). If there is no valid connector type
set for a panel, the warning is printed and panel is not added.
Fill in the missing connector type to fix the warning and make
the panel operational once again.

Cc: stable@vger.kernel.org
Fixes: 97ceb1fb08b6 ("drm/panel: simple: Add support for DataImage SCF0700C48GGU18")
Signed-off-by: Marek Vasut <marex@nabladev.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patch.msgid.link/20260110152750.73848-1-marex@nabladev.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/panel/panel-simple.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1627,6 +1627,7 @@ static const struct panel_desc dataimage
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
 };
 
 static const struct display_timing dlc_dlc0700yzg_1_timing = {



