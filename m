Return-Path: <stable+bounces-65302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D65D29461D8
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 18:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13DC31C21121
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 16:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D375127447;
	Fri,  2 Aug 2024 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DLzGpwzS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V84ErmWD"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3865616BE02;
	Fri,  2 Aug 2024 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722616454; cv=none; b=lycNAc0jpe1CfpKNJHyCb3glSVoZSy6jWkEgE0Rj365ob4D8AyL87tODXPYADicSql+bgevmly1WMVQQUbVvFyQ2tHN/eoiGufS9YotB6DIpOYd21LY3JC0h5Co4XfzaLa4yeGDluDLxL5ht/OEzl82FYPGeRHowpjvcRxEN3xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722616454; c=relaxed/simple;
	bh=9bLn5yGmawFBvnqXge0/NJUOwJecjejLfHHLAoUB0yc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=azkpCr/2Ep5ANUskb8Vv8H8NAbgOlMV20tXM7DDImMt7ZhgUGMZMDhgCqnOjy/yEg5BfCvhig9T6PDO+Q7tKpPl0gdthB4UWaTfvG09b48AS7dSTREzDSMBUcVZHFdihFgH60N2UCBqKhirFVuxCPJ2GTDAWyGwiR+oSEespReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DLzGpwzS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V84ErmWD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 16:34:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722616451;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b7ARxUaiYZidzCL18/Yr8/6nTCZfAm5uA8+opUKz0uw=;
	b=DLzGpwzS3zW2pv44H8TOORgOmrT/jHLS647k1ibEQD5eQFNS8VU3yPzUrid/ahfTBJwXBy
	tEvegao8Ymg/hiExcAav7KKkZUOEfuCle4wBlIhJJ6FbHXZIvTvZvzhUbUk5b3/VVJdBtT
	/25xdl9TVOiWo/5NVqg6v13BuyJ0hB5BHxUDab5fHzqZLRXg/KtSsLz3ahD+v7Fuhu6V7p
	Sv1N/cDnagiRsMvcugjabj4KwvTbyOctMmMIw2wez5PxvjBcyb9kuFFmxwY6PPZFARRmVj
	ubbfj2vxvgjmaUDtD23gqLHyxK/0ngDzqNC7RQyCeOmATWdBqxpydlgNG5wd7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722616451;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b7ARxUaiYZidzCL18/Yr8/6nTCZfAm5uA8+opUKz0uw=;
	b=V84ErmWDAhyPhg/bLKMHdpShj9Nqv8Oelgud+Ec8dY9FELwJVxxSh9nn/Y23TvrrxMryfF
	Vtt4y3gS/VJl4JBw==
From: "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource: Fix brown-bag boolean thinko in
 cs_watchdog_read()
Cc: Borislav Petkov <bp@alien8.de>, "Paul E. McKenney" <paulmck@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802154618.4149953-2-paulmck@kernel.org>
References: <20240802154618.4149953-2-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172261645098.2215.1439295710951106215.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     f2655ac2c06a15558e51ed6529de280e1553c86e
Gitweb:        https://git.kernel.org/tip/f2655ac2c06a15558e51ed6529de280e1553c86e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 02 Aug 2024 08:46:15 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 18:29:28 +02:00

clocksource: Fix brown-bag boolean thinko in cs_watchdog_read()

The current "nretries > 1 || nretries >= max_retries" check in
cs_watchdog_read() will always evaluate to true, and thus pr_warn(), if
nretries is greater than 1.  The intent is instead to never warn on the
first try, but otherwise warn if the successful retry was the last retry.

Therefore, change that "||" to "&&".

Fixes: db3a34e17433 ("clocksource: Retry clock read if long delays detected")
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240802154618.4149953-2-paulmck@kernel.org

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

