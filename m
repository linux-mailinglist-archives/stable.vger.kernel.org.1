Return-Path: <stable+bounces-208259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8ADD17E21
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 11:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A5A1304B969
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 10:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1216D38A71E;
	Tue, 13 Jan 2026 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o7Zh/2Nj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PIaS+KqD"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767B6366557;
	Tue, 13 Jan 2026 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298817; cv=none; b=Y8nsb0augI0R9l6DBzC73wD1EWKijaREbYL8W9vU4uiP3NccROxL51zaEeyABhR6Q/53kQjQto0V2G0N3bMFyHbiVi8rCjS6NAcSzHQX963BWuwrTY41DLXRn6Z54C6rkBYH+w4X4QYPllJN5X3LjlrXbJN45myfGtk8seP6eoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298817; c=relaxed/simple;
	bh=1oBpTOlf2XVta889sqRveMzTNm8PxjUWg89eIxhYRwQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z4FTaWU4YWZ/9Tg2iFoqOl0VJ+a86nq469wqT0BklUphjGwdpmICAKYzk7D9lpOyvsXwZ+MKjqx8ZFvWG/fEZgROrysdTIk+VGp1yeG7QvmztMZM4xk4uf1XwJ69XiGNh8XQDe9hAQu2w5WwOP0Du9pN7CbIsfXWb/x6NEpL++o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o7Zh/2Nj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PIaS+KqD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:06:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768298815;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDtLATivZOX03yordsEjx3ElIFmeB9jWb+R3evpQR98=;
	b=o7Zh/2Njs7u7tes4tssFQzuwEZ9PWb8tW1G+uI/3FDvVfOPChmNCTK+lBF4reXgpp3iE/x
	9P0fv/h72Mk33qVQd12eTdM3rVo/08g8U5UnqZd1aAyDE3Ik0CZoTjKVarz2735/Gokwgf
	7Y/a/nqwmNrXEDXSHFuz6sWmZkDRfY5q04JdsV5IXb9ecX8YLk727oUjnYTOM8cDBYFjOx
	1lK7pUQG7zR3cgWYgonrkf3rV7txMfrhRueYjH6X+koaZIzuY584FjOpW/MWUGVYxlB0o4
	YU33Yvt1LDMDAa1Mih8837SQe+/iRVDVzvPDHMItGHK/EXY/ueoN/IT/kfjhgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768298815;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDtLATivZOX03yordsEjx3ElIFmeB9jWb+R3evpQR98=;
	b=PIaS+KqDIl7oc3XObgoTKV16mfFqo870AmPyhiF9leUtrFHhQ6dByxvSCDSCGmNItkBsYL
	lXNhPfEQDzXpH6Dg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] hrtimer: Fix softirq base check in update_needs_ipi()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20260107-hrtimer-clock-base-check-v1-1-afb5dbce94a1@linutronix.de>
References:
 <20260107-hrtimer-clock-base-check-v1-1-afb5dbce94a1@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176829881394.510.9659204617448644627.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     05dc4a9fc8b36d4c99d76bbc02aa9ec0132de4c2
Gitweb:        https://git.kernel.org/tip/05dc4a9fc8b36d4c99d76bbc02aa9ec0132=
de4c2
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 07 Jan 2026 11:39:24 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 11:04:41 +01:00

hrtimer: Fix softirq base check in update_needs_ipi()

The 'clockid' field is not the correct way to check for a softirq base.

Fix the check to correctly compare the base type instead of the clockid.

Fixes: 1e7f7fbcd40c ("hrtimer: Avoid more SMP function calls in clock_was_set=
()")
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260107-hrtimer-clock-base-check-v1-1-afb5dbc=
e94a1@linutronix.de
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index bdb30cc..0e4bc1c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -913,7 +913,7 @@ static bool update_needs_ipi(struct hrtimer_cpu_base *cpu=
_base,
 			return true;
=20
 		/* Extra check for softirq clock bases */
-		if (base->clockid < HRTIMER_BASE_MONOTONIC_SOFT)
+		if (base->index < HRTIMER_BASE_MONOTONIC_SOFT)
 			continue;
 		if (cpu_base->softirq_activated)
 			continue;

