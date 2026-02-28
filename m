Return-Path: <stable+bounces-220088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAobF48no2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:36:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D36ED1C4F35
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E1E130D9D75
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8CB347FCC;
	Sat, 28 Feb 2026 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiEeW1P2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E72E346FAE;
	Sat, 28 Feb 2026 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299982; cv=none; b=N8e4Wh1XJ4YLB9T2bRqJHHiLXUjtuz+QNYPzC4VyJxWmdeBIewK8Wh6/fVBG8QqhH3YgQm5tquCcnk9BhgPxXN3E20vfwbc240AQa4tzikOMwnZyS5Rt9izRjyJUKyvtXzpRZfbKqgC+S44GdVgQSMyGoqN43ctguXoa3k58phI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299982; c=relaxed/simple;
	bh=SFnyf4F+oXbrayj46ArGg9lHqMGNk3XPYVJe7hBn9UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBqMrukLQFsL5ADcqNkqcl3LQkFlpDHZlTJ+nASC//E8Q8Ge6pTeRliWzuWDAUpW044eRSTIXtKUC23iMbiTxHe/YUlxdw6nPtMtjdglpmeb1t/Jro2vfgXX1/Bgg6NCFxRu8SrknIfSP0itAftI2AmpBm+aVtaJztgLWPaWpUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiEeW1P2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA24C19424;
	Sat, 28 Feb 2026 17:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772299981;
	bh=SFnyf4F+oXbrayj46ArGg9lHqMGNk3XPYVJe7hBn9UU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RiEeW1P2NzZ4qkd/mBv4XqFDeMbFVnief/z2Kstn5IhdiT2ZgiJ4j5XivX3FRZzGY
	 WGu0QY8UNyMAYDQ8uOehxIeF8ACjJnHLDEr/4NEsemVNeGnEcMOJWfga5Ub6lLdyZe
	 X1Xp/TUIaurZRoF53uPJJgAPEgniV24Y4HxbGU2DTickZnLN5fY23yVvzjff9sG0d/
	 LX5n3Pakw5p4qZTWWposr2wQ0gb8trNPCbVOzz8j27mqkOBwiIl8xr4Sxus0k9MwNi
	 /AhSR2YILGPHoXCBGDy5S5hOpd2ib6F7d+tCwAsJ0V6vtP03jHQjgIcjxDvFVrJStn
	 /TmJ801/Vyi9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>,
	Shubhi Garg <shgarg@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 010/844] rtc: nvvrs: Add ARCH_TEGRA to the NV VRS RTC driver
Date: Sat, 28 Feb 2026 12:18:43 -0500
Message-ID: <20260228173244.1509663-11-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,bootlin.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220088-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,msgid.link:url,bootlin.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D36ED1C4F35
X-Rspamd-Action: no action

From: Peter Robinson <pbrobinson@gmail.com>

[ Upstream commit f9ecfd9bfedba9fd9d4b015b33b847571f7fdd42 ]

The NV VRS RTC driver currently is only supported on the
Tegra platform so add a dep for ARCH_TEGRA and compile test
so it doesn't show up universally across all arches/platforms.

Fixes: 9d6d6b06933c8 ("rtc: nvvrs: add NVIDIA VRS RTC device driver")
Cc: Shubhi Garg <shgarg@nvidia.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://patch.msgid.link/20251222035651.433603-1-pbrobinson@gmail.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 50dc779f7f983..50ba48609d74e 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -418,6 +418,7 @@ config RTC_DRV_SPACEMIT_P1
 
 config RTC_DRV_NVIDIA_VRS10
 	tristate "NVIDIA VRS10 RTC device"
+	depends on ARCH_TEGRA || COMPILE_TEST
 	help
 	  If you say yes here you will get support for the battery backed RTC device
 	  of NVIDIA VRS (Voltage Regulator Specification). The RTC is connected via
-- 
2.51.0


