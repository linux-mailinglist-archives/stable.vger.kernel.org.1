Return-Path: <stable+bounces-54959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0EC913D8E
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 20:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D941C211D0
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 18:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DF6184139;
	Sun, 23 Jun 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BEw5UKbh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dlTSFG/Z"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB36184106;
	Sun, 23 Jun 2024 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719166230; cv=none; b=ANRlgSZ1wigxA/8RynNpwBVyHZEeOOgxlS5Pl2xIkGk+MMRH9YoJR70LI10eGJerKC+vZN8UtYvdCEAo5FP35stQL+P+ETEfQP9dORorAz89YtSDK4rwWhLcl7tSzXfhmRdsvfb34eeqLGp/oz1l89WIPLsclPI5fFcu6BncMKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719166230; c=relaxed/simple;
	bh=WwX9TPSRKyYBlPRCMCpQflwonYvF0f5ZSglVYKYhIEw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VwXNwqIQqQOk9ySQ/okbjua9fvc4p7p5zcERRh3HoQ1HBvDU49xO0Hdst0QNpGTNjjGuBo+Jxz8Aw4zx33pqOlCOfbejm6X+oqyxrSJB2mYgK2Hf75PnpOCO6nal20MEYWNsR9zX/kQANJ1C8MwQbPxIG9fWtz1BaYJg4L9aboU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BEw5UKbh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dlTSFG/Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 18:10:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719166227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+cgei92uAq08pdTY7eAGcOv6ThOTFM0vwvtNUO5lQoI=;
	b=BEw5UKbhzXupS+A/NgJSKNWb5GsLpaLJlWeA298fEyNYUCYbx8kjjjCYXYmnI8hzLjtaFa
	x0Yuv6Yaf6T7UPJ8aGboMMXX0/O9glksEYfPsIwuh34ydMZcw+mCmmaT/6t/x4n6rfzB9Y
	RlvZK7Kh28jcNRuKmna+7k01040OCoCYw7/8sLOz36SfMkskoqTfMnQ7qMQJ3JLnpTRqEe
	D7OaekwSQRedLUHmDyAbKtA6GLdzwgSd584e5NWHYg8SktmxheqBqid3CwoYisxycF7DrQ
	IMrG6pHuk1rhTlymTe6TIDVqSO06gDDnWyz8rb9//2H+vGkWCRj07wQPHa2Bkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719166227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+cgei92uAq08pdTY7eAGcOv6ThOTFM0vwvtNUO5lQoI=;
	b=dlTSFG/ZW15gfYeHjJT/yt2kkrjJT590Y6U0+CmmZSaBidq0XmRhMkW3Q/2pLuj7j2/TrU
	n2vP2/ZtILqJfxCw==
From: "tip-bot2 for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: smp/urgent] cpu: Fix broken cmdline "nosmp" and "maxcpus=0"
Cc: Huacai Chen <chenhuacai@loongson.cn>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240618081336.3996825-1-chenhuacai@loongson.cn>
References: <20240618081336.3996825-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171916622698.10875.11108299425462824566.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the smp/urgent branch of tip:

Commit-ID:     6ef8eb5125722c241fd60d7b0c872d5c2e5dd4ca
Gitweb:        https://git.kernel.org/tip/6ef8eb5125722c241fd60d7b0c872d5c2e5dd4ca
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Tue, 18 Jun 2024 16:13:36 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Jun 2024 20:04:14 +02:00

cpu: Fix broken cmdline "nosmp" and "maxcpus=0"

After the rework of "Parallel CPU bringup", the cmdline "nosmp" and
"maxcpus=0" parameters are not working anymore. These parameters set
setup_max_cpus to zero and that's handed to bringup_nonboot_cpus().

The code there does a decrement before checking for zero, which brings it
into the negative space and brings up all CPUs.

Add a zero check at the beginning of the function to prevent this.

[ tglx: Massaged change log ]

Fixes: 18415f33e2ac4ab382 ("cpu/hotplug: Allow "parallel" bringup up to CPUHP_BP_KICK_AP_STATE")
Fixes: 06c6796e0304234da6 ("cpu/hotplug: Fix off by one in cpuhp_bringup_mask()")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240618081336.3996825-1-chenhuacai@loongson.cn

---
 kernel/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 74cfdb6..3d2bf1d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1859,6 +1859,9 @@ static inline bool cpuhp_bringup_cpus_parallel(unsigned int ncpus) { return fals
 
 void __init bringup_nonboot_cpus(unsigned int max_cpus)
 {
+	if (!max_cpus)
+		return;
+
 	/* Try parallel bringup optimization if enabled */
 	if (cpuhp_bringup_cpus_parallel(max_cpus))
 		return;

