Return-Path: <stable+bounces-62463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C6B93F2D9
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6671C21D30
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746D7145B0B;
	Mon, 29 Jul 2024 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dI4SIZVA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BYhk/5hd"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3D0144D2B;
	Mon, 29 Jul 2024 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249250; cv=none; b=DySxo+tW48FIrMoHnGglYX8nt4k3K6mHeEDxI/sJ7mCvcYeaybb8qgfC7w5HyLgrNQLQhRD1tC73dILMH0GlJtU6jIXU0MCUSq6/Cfoopi1Fv8v/69AkZtI0szZfzJ4bS4ITYc+ZHvF2JlCj1/oTfaj7sdB1fOu/DQq4kc/cXzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249250; c=relaxed/simple;
	bh=q6UzVgDVK6Xr2Qlw9dVjGM4DU+bElCd1JAAC3gAvF7A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FzKTP6o0t/yRw63LWAoVI0fIdKl9pzAlDv0V+i/lL6+kyi7n7/T/SOyjCf0cPA6lnpZEoX6Ku8hxKkx1z8oGJFY6QBqnlp+rsEiUmYt3x91L2cXEcZiGHvLxHkI1WHjCIX0r4NdBEJb/EM5VE8pbk/yGNINy4vQJcjMPIU/r4rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dI4SIZVA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BYhk/5hd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:34:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722249246;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Io5MX5p9iRtdEbStQ00S3T/l6BZcS4jk1/moOtbAYU=;
	b=dI4SIZVA621EJcF8BeU5EIbcxoAzBfDg6bl3nujgXf6pYJDsC8C3B79FQ1ChhBog9gbmI2
	TpOBy0AEc5sG6pss2N6YVYk7FXQqpupDZIes0Zl7Om3AelYjKKKSeAlDzAGBDjbYCYxXds
	U7XCPtlhlMYs5SnFZ2mdZf94izz8jGCpx8vvGciw4AixfucCelPVSfIMgFa5/68ck/kb+z
	6X+oyUR7Pz+M0Y2GswUfM7hnLBhIgOFHz1XzRMiXt6mOuiX2/1Xt0wnYfKCxSOpg07YE25
	T/LNZxPJo5I+fwAhbkYnxOg0mQ7X30QCT/A2BPyWtCfKEbGDDhCP7UK+f7EUrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722249246;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Io5MX5p9iRtdEbStQ00S3T/l6BZcS4jk1/moOtbAYU=;
	b=BYhk/5hdiVKwz7xpozkzZxyzkuqJwY9o8f7FI9Jm7mmjm4OC7CqoEvVhvvUBFkNRD/WvvG
	uZ+NXYSVBq0DuXCg==
From: "tip-bot2 for Daniel Bristot de Oliveira" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/deadline: Comment sched_dl_entity::dl_server variable
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <147f7aa8cb8fd925f36aa8059af6a35aad08b45a.1716811044.git.bristot@kernel.org>
References:
 <147f7aa8cb8fd925f36aa8059af6a35aad08b45a.1716811044.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224924583.2215.8813533036278787084.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f23c042ce34ba265cf3129d530702b5d218e3f4b
Gitweb:        https://git.kernel.org/tip/f23c042ce34ba265cf3129d530702b5d218e3f4b
Author:        Daniel Bristot de Oliveira <bristot@kernel.org>
AuthorDate:    Mon, 27 May 2024 14:06:47 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:22:35 +02:00

sched/deadline: Comment sched_dl_entity::dl_server variable

Add an explanation for the newly added variable.

Fixes: 63ba8422f876 ("sched/deadline: Introduce deadline servers")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/147f7aa8cb8fd925f36aa8059af6a35aad08b45a.1716811044.git.bristot@kernel.org
---
 include/linux/sched.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8d1503..1c771ea 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -639,6 +639,8 @@ struct sched_dl_entity {
 	 *
 	 * @dl_overrun tells if the task asked to be informed about runtime
 	 * overruns.
+	 *
+	 * @dl_server tells if this is a server entity.
 	 */
 	unsigned int			dl_throttled      : 1;
 	unsigned int			dl_yielded        : 1;

