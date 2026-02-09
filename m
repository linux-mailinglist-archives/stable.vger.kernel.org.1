Return-Path: <stable+bounces-215356-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN/qObz3iWl7FAAAu9opvQ
	(envelope-from <stable+bounces-215356-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:05:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0931117E3
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6752230B35D8
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD0E2DB7B4;
	Mon,  9 Feb 2026 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MLTNaGlS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4429285073;
	Mon,  9 Feb 2026 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648527; cv=none; b=uzCswzIAVGRMYB4yf5weoPMJuP8WRDn1+HQwdq3a3pjPv+TEOZ1uNbZGgTMtmjX+efzMqvckCf7MB03zQ1Iy7ibx2Q8xG9hHqmdrnYnXOPTIuvToCLxr1qBjpZctyB282jC0dd0lYgNh6GJceO9LUcSjWcQuRsr4d77xl30CZ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648527; c=relaxed/simple;
	bh=YXjBNje42pH691iNPNuHQEPrRgnVLpsoJTlbrVIaTwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XX8Vh59Wf6B+uihJ/35uvvT90zgOamxKP/M4rQ9utFq2Nkczag6OVy/I3dcqoLDrb64a2VW27Is1RD6eKbc80fuVYLQ/yniTWnNJuTPeA7rnmh4I6Hdl+9Di3DYtwIc29w1X28sz1KHc37dL5cf6m7nHds7W/53sSg7tOZAHF0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MLTNaGlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CA5C116C6;
	Mon,  9 Feb 2026 14:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648527;
	bh=YXjBNje42pH691iNPNuHQEPrRgnVLpsoJTlbrVIaTwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MLTNaGlSDci01FxQ2vzG74+H9ZrGLE/s6ikkfHwFt+iyzCuzg4uJYeQPuJ+tkrX2O
	 0hYZ2fMQwm2pZAl+TiY/5BKGexNi0AsVLUQhmFHbfCtp+j2yT37do7JphMU9jhSO5J
	 ZTGm4UNgJNNQJDU7AdEqWZCGWQSnakDE7ev8lyUs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 57/86] platform/x86: intel_telemetry: Fix PSS event register mask
Date: Mon,  9 Feb 2026 15:24:20 +0100
Message-ID: <20260209142306.831616812@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142304.770150175@linuxfoundation.org>
References: <20260209142304.770150175@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215356-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B0931117E3
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

[ Upstream commit 39e9c376ac42705af4ed4ae39eec028e8bced9b4 ]

The PSS telemetry info parsing incorrectly applies
TELEM_INFO_SRAMEVTS_MASK when extracting event register
count from firmware response. This reads bits 15-8 instead
of the correct bits 7-0, causing misdetection of hardware
capabilities.

The IOSS path correctly uses TELEM_INFO_NENABLES_MASK for
register count. Apply the same mask to PSS parsing for
consistency.

Fixes: 9d16b482b059 ("platform:x86: Add Intel telemetry platform driver")
Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Link: https://patch.msgid.link/20251224061144.3925519-1-kaushlendra.kumar@intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/telemetry/pltdrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/telemetry/pltdrv.c b/drivers/platform/x86/intel/telemetry/pltdrv.c
index 06311d0e94518..a574615c6faa6 100644
--- a/drivers/platform/x86/intel/telemetry/pltdrv.c
+++ b/drivers/platform/x86/intel/telemetry/pltdrv.c
@@ -610,7 +610,7 @@ static int telemetry_setup(struct platform_device *pdev)
 	/* Get telemetry Info */
 	events = (read_buf & TELEM_INFO_SRAMEVTS_MASK) >>
 		  TELEM_INFO_SRAMEVTS_SHIFT;
-	event_regs = read_buf & TELEM_INFO_SRAMEVTS_MASK;
+	event_regs = read_buf & TELEM_INFO_NENABLES_MASK;
 	if ((events < TELEM_MAX_EVENTS_SRAM) ||
 	    (event_regs < TELEM_MAX_EVENTS_SRAM)) {
 		dev_err(&pdev->dev, "PSS:Insufficient Space for SRAM Trace\n");
-- 
2.51.0




