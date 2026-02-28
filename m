Return-Path: <stable+bounces-220473-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNbQOgA5o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220473-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:50:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F6B1C6513
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25C3831CA19A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6752F3C0C07;
	Sat, 28 Feb 2026 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1vNGUpc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286AC3C0BFF;
	Sat, 28 Feb 2026 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300360; cv=none; b=L0Q3Z2urENMoJRPnCVJOlBKTsm1JGgWDZ+pciQHoTE/at17+p1DbomZ3pifZ4hCa37hESMToCBN8+wweYqURkHIZGjfarEnMdEFMIKeiq9DwBX36nrGU2pZIv8hJQOyBAgJlvfhtANzdaWi38VIxR+uimi8nIk0aCt26z8YvOsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300360; c=relaxed/simple;
	bh=FTwb94O2+0BWU/8PxjRoKtacny9TIv5c8a1PPMB4qto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K32CX5q3yEOgqJONElNSGX5wyELjqomN7wiyR6pUJoX2c2JxnkW/ZWok/QAa6Slh9+KeHrTyhCjFpP4Kk/U/VWsLRewPmTM2Z1bOAWQxnrXlttZV2QXVc8XwnnlZ+9CiEqAHh//ceFXomrIaychdosS8O9A3KIrXzipgyryZlUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1vNGUpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F066C19424;
	Sat, 28 Feb 2026 17:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300360;
	bh=FTwb94O2+0BWU/8PxjRoKtacny9TIv5c8a1PPMB4qto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N1vNGUpcSJW6+xh/3R/bPE9wer+EqlmykeiUy1dgk4yJvMlhDUOgIyqa0s2xLKyC3
	 BR3w0N7s61OF0dUSeoq+Ly0BgIg5sbigcVCRFO5sc6PjjFrX+nw09N5V34Gr6ejH68
	 5BqAGy/OyY5bzaaqMIIP+y3ypF2KJWpVccRlZ+P4vASAw4DE9h3gynV1vXCCgCQua1
	 QA9NpP27ygyIGpExKD+jwZVgSbJS8DfKnEbO3pAY30GCdYFkF5HCLr9Qkzo+kVAnMC
	 uJHNxAlfgnOL0xM3FBWbRyB+LyyUARk5otIo60G9a/jvAGN2Jdj6xXwX8VBROVGPjb
	 qa1tf/AI6HPSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 394/844] watchdog: rzv2h_wdt: Discard pm_runtime_put() return value
Date: Sat, 28 Feb 2026 12:25:07 -0500
Message-ID: <20260228173244.1509663-395-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220473-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B2F6B1C6513
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 2dea984a74265a67e3210f818416a83b87f70200 ]

Failing device probe due to pm_runtime_put() returning an error is not
particularly useful.

Returning an error code from pm_runtime_put() merely means that it has
not queued up a work item to check whether or not the device can be
suspended and there are many perfectly valid situations in which that
can happen, like after writing "on" to the devices' runtime PM "control"
attribute in sysfs for one example.  It also happens when the kernel is
configured with CONFIG_PM unset.

Accordingly, update rzt2h_wdt_wdtdcr_init() to simply discard the return
value of pm_runtime_put() and return success to the caller after
invoking that function.

This will facilitate a planned change of the pm_runtime_put() return
type to void in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/rzv2h_wdt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index a694786837e11..f9bb4ef3d327b 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -270,9 +270,7 @@ static int rzt2h_wdt_wdtdcr_init(struct platform_device *pdev,
 
 	rzt2h_wdt_wdtdcr_count_stop(priv);
 
-	ret = pm_runtime_put(&pdev->dev);
-	if (ret < 0)
-		return ret;
+	pm_runtime_put(&pdev->dev);
 
 	return 0;
 }
-- 
2.51.0


