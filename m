Return-Path: <stable+bounces-259015-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAn4GqguG2oLAAkAu9opvQ
	(envelope-from <stable+bounces-259015-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:38:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6522561228A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5158F3008479
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EA339478D;
	Sat, 30 May 2026 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bI1TRVyZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8423331200;
	Sat, 30 May 2026 18:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780166304; cv=none; b=OzVXegkE9ij8RlikPqecZM8ecnBDPfDl18XhW+cezaU75aPljSXHI/HGuYQNSKKGi2ITVbi911zritsVy/TwC3+xJopOnoZVTy4KOxKA2skoSBJl6kVmUV8BtHAMJ32y4/MRkKmjCpbE3a92LazlHUfTkrVNeOAzFvJlY/HjhQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780166304; c=relaxed/simple;
	bh=3vhalJVmp96w92gYl6TCsWtg2/CLnYYxkhI0x8/lrRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3owCGc1Uz1i8ivQGtikelQmvhkUDTt5nv7sD7MHj95/CgJKsLGWbeSEYYPb1RIA4iG/WwKTWtFHtTXRetogHtnqD/XQtj8gk0uNbDOw4vQCFVHzXGzcv9Aw919pSnOzDfEqRcYjrD0oQFBNLmD77+z77X1gswEzeef8P0Ndq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bI1TRVyZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295931F00893;
	Sat, 30 May 2026 18:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780166303;
	bh=ZU6jshQKcydDhh71pZNGj/FWWP5hfM8oS4n1xw0h4Xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bI1TRVyZwkHzDAGlJNw4n9ig0k4KDY9EmJyyPsV0UimPZ2bGCI6Yb5mJ4Yh7uERQ4
	 5PWIdF74Klq/MteyC5eat9XriyIma1qjaCW3Y6aMPoIAdTRw5ptNxJlNOab2AuFF5K
	 J6LQZjQLpCrSU/Ed6RIRdF1XrttGrDXk2L1fNhvI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Ian Ray <ian.ray@gehealthcare.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 334/589] drm/panel: simple: Correct G190EAN01 prepare timing
Date: Sat, 30 May 2026 18:03:35 +0200
Message-ID: <20260530160233.683175183@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259015-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linaro.org:email,collabora.com:email,msgid.link:url,gehealthcare.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6522561228A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Reichel <sebastian.reichel@collabora.com>

[ Upstream commit f1080f82570b797598c1ba7e9c800ae9e94aafc6 ]

The prepare timing specified by the G190EAN01 datasheet should be
between 30 and 50 ms. Considering it might take some time for the
LVDS encoder to enable the signal, we should only wait the min.
required time in the panel driver and not the max. allowed time.

Fixes: 2f7b832fc992 ("drm/panel: simple: Add support for AUO G190EAN01 panel")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patch.msgid.link/20260217142528.68613-1-ian.ray@gehealthcare.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index d4bd72347245a..a59adc08267f5 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1140,7 +1140,7 @@ static const struct panel_desc auo_g190ean01 = {
 		.height = 301,
 	},
 	.delay = {
-		.prepare = 50,
+		.prepare = 30,
 		.enable = 200,
 		.disable = 110,
 		.unprepare = 1000,
-- 
2.53.0




