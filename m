Return-Path: <stable+bounces-65299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6775945F90
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 16:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C87B1F219B8
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 14:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D736E21019D;
	Fri,  2 Aug 2024 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ImUm53r8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lKljglRj"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DFD1171C;
	Fri,  2 Aug 2024 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722609801; cv=none; b=FyP1POU0e8ZicqBYKWDPTM1rF/GgYO68AcCpHggim4qBZDPfR6mVHJDxkqnarmkZDzvHsstHLO8v0Whl7W3ps/9uz0dKxN/McoFWffGMs9GpHkfvC1EY2Ce4Sgh+2sq4Pjqlb2jLcioCxIWCOuHsD39FdQlMSygHxCk+YFO6z2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722609801; c=relaxed/simple;
	bh=NU3wYy8k5zdf/9XOOg0SD16HymdvaMCyJVKYJpshXx4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=dwL204ZAGRaFwbmeO87iGQgeceX+0xcnTzqO7x5gkTs74bG9YjaFsZL3oecljeoVzxgSFfsDiwENqNRXsSV/0l0cUVP4tRtRuLSuhwREx3dHwmzhk0l5mjV3UwY4+f9bf3tsK0MG4PTI2fPUkrT1N14wCTGDhW9IqJC5wzEtUvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ImUm53r8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lKljglRj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 14:43:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722609798;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=08Xy70LRyIdQG3tcn9StZykLFGQJFxclC0TUOOF1MYk=;
	b=ImUm53r8hk6DkslxA55mdKzq9oUwF/6yYCX6bFxVc1CWovGA7ajCMlTi0hpC9UgDcMzcSh
	+7ogu73BRNRooScXFrNMRlfkDJogffrbW6gf5yL0WPUwDTTMtFAvhIj6HsGJAqnVkab57e
	arQVefM4ZwPj/PB0ygzI+qrqbtUG3hUSaprjaRZXMsUHpMlPNontQwLWkIzbg9io4AwWEE
	eRExbbDxFKHmcNVQ1fvlkTaR7dWmZHLdEsyRYiGZIylFZYRClrNKq964K85x2lpTSxIkzd
	NwumrZN2qtyRPbD917L+mpipa2F9bhLjUQKSMUM97Hf6A9WWfyfpnw2tgQ2leQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722609798;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=08Xy70LRyIdQG3tcn9StZykLFGQJFxclC0TUOOF1MYk=;
	b=lKljglRjDKoPlQzPcgYizb6aQ2MRBYk1bEoJcL32f5IPhIktx8kyKlVkRQ8DzL3UpDUBrU
	tSQdRVAv2TNDcFCw==
From: "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource: Fix brown-bag boolean thinko in
 cs_watchdog_read()
Cc: Borislav Petkov <bp@alien8.de>, "Paul E. McKenney" <paulmck@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172260979799.2215.16859702418802740077.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     305c821c3006c1f201eb85bcfb44a35930f54a71
Gitweb:        https://git.kernel.org/tip/305c821c3006c1f201eb85bcfb44a35930f54a71
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 01 Aug 2024 17:16:36 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 16:34:26 +02:00

clocksource: Fix brown-bag boolean thinko in cs_watchdog_read()

The current "nretries > 1 || nretries >= max_retries" check in
cs_watchdog_read() will always evaluate to true, and thus pr_warn(), if
nretries is greater than 1.

The intent is instead to never warn on the first try, but otherwise warn if
the successful retry was the last retry.

Therefore, change that "||" to "&&".

Fixes: db3a34e17433 ("clocksource: Retry clock read if long delays detected")
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index d25ba49..d0538a7 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -246,7 +246,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow, 
 
 		wd_delay = cycles_to_nsec_safe(watchdog, *wdnow, wd_end);
 		if (wd_delay <= WATCHDOG_MAX_SKEW) {
-			if (nretries > 1 || nretries >= max_retries) {
+			if (nretries > 1 && nretries >= max_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
 					smp_processor_id(), watchdog->name, nretries);
 			}

