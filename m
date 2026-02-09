Return-Path: <stable+bounces-215467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI2BI135iWkiFQAAu9opvQ
	(envelope-from <stable+bounces-215467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:12:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E35B111B6F
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D29B30C422B
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0060237BE7F;
	Mon,  9 Feb 2026 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PmxJBZJX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A5E37756D;
	Mon,  9 Feb 2026 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648890; cv=none; b=mQTDA6eY2qrDm2oP/0JinzV415alEdsY/1qc5RZaC2MVm/9GxHLtDBzyA7KwY5ANcdhVf9HXRLdW0NQnOCNqzARDEvk0ZjkYZjYrhEx5nBCFn6rjoQ6/Psgz+H7PwSwPuqodpsZr1d+eV8aN8ebgA1JS3KbnNQFADad1Uvw5xHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648890; c=relaxed/simple;
	bh=x4nQlHAqAkpK0kJCXboaufGZygkeikmn8QltLbpmYMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eM8h3HFbZCHnBH+JRh2JsJMHeJVjP+BT7mdhprYuO43r3c3tMQCKbBTOk314hzPhaFLA+U0l4pcix+gjpadhcF8ljMeipCitHxLX5v2uvZPKMEjJaXaNcjtxE6Bpt3tkXEhFWr4QFafGVhuYwAtPb7fuT3t3pxQ6Q9vRCcDkbpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PmxJBZJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1012C116C6;
	Mon,  9 Feb 2026 14:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648890;
	bh=x4nQlHAqAkpK0kJCXboaufGZygkeikmn8QltLbpmYMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmxJBZJXfuQUW6NnomUnjGISCSdy3LpvMeOLf9tRzZ4IrCOtnxyuxWxu4aGRacpWS
	 /C0jShr4NgSyYznrtfh3n2dox7tcOjFd0YxUj38vtvFGr7q+Z5rJi/8sKrDxKhqVjw
	 ivaxmq1X0p/mRMxdUNfbL5ZmXSzzevuVNmN4PODM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 45/75] platform/x86: intel_telemetry: Fix PSS event register mask
Date: Mon,  9 Feb 2026 15:24:42 +0100
Message-ID: <20260209142303.467596069@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142301.830618238@linuxfoundation.org>
References: <20260209142301.830618238@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-215467-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 0E35B111B6F
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 405dea87de6bf..dd1ee2730b6a6 100644
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




