Return-Path: <stable+bounces-111781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B547FA23AD7
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 09:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40CEF1889E6B
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 08:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27565146D6A;
	Fri, 31 Jan 2025 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1S440gCn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+ehd+SHv"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E06632;
	Fri, 31 Jan 2025 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738312999; cv=none; b=Ts2FWlYnHRLskfkMB2l6CWuaGElH5tGuoBJXmzgKcrnwWAGsH2rwBaSQ5nP7hWJeoIZn4d27q5rqXHfIwKJiBf3QXRYFZ5/bzURK14jD+EgDoKEEZhgV+b2Tic90PGlJgHH2nt3RjWK4kJf4J9XEyAuZtKsZmC8+W1xYz/vknfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738312999; c=relaxed/simple;
	bh=PHyCaQdJAV7gjkBmpAF+bCcvjIXNcMl++HrfUECgM3A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M9kbu1r232d5i9/mUwthoEW4BlEgQJyVXAwUeC8BYmc/pMrswTwBA6OKdf5JIwUfMXSIqtf71F8C7lMko/EV3wG4VOAacMZyL5dsryHI+TXLE6gJNaegsx1BuziQ7laegD5INDmaEOVG8iL8a6OMZm8DjylCgzj63pvLycemPmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1S440gCn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+ehd+SHv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 Jan 2025 08:43:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738312996;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4j6x8LLvtxLd0fB8/jKqD5ksDv3uRGpB8xaSRDei5SA=;
	b=1S440gCnNPha5lwA5udbAsb6rwzUT0cHFHXeT0gg/VJYWfvZylOy9BC5S9n7AYifX+HWKr
	01fppJwn9Hx2gZ5wcNS8hpuMUQnLUU5db5s6nHJnVIqi+KqG1aYGCDEKZpGh93I/5ZOJnM
	sJnsWbOO9p7qrcDWE0hvriOyBdkA2tFSpPTaU/ORzyGp2yBYxXfv3fhC7S/iV4s1ZrjtZZ
	6H9BQLILuRG+x8LNitfAvbncrz/7EF8e74NDy3bpRsYJTPelQ8eC8py1xM8zYPdNac1ByF
	kG5s05vIZ0Ir5MFZ83w/3okTRP9NeDLqrU32NHV0J5By5vZ8KPjAbc4PoxZx3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738312996;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4j6x8LLvtxLd0fB8/jKqD5ksDv3uRGpB8xaSRDei5SA=;
	b=+ehd+SHveTFMO/X8F+goiApklUlTfS4Ev4FS/cueiMFyyWXZ9b3WuEiZ8JkiLiyz+BOSIn
	c4iNONhEXpGKHfCQ==
From: "tip-bot2 for Easwar Hariharan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] jiffies: Cast to unsigned long in
 secs_to_jiffies() conversion
Cc: kernel test robot <lkp@intel.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250130192701.99626-1-eahariha@linux.microsoft.com>
References: <20250130192701.99626-1-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173831299312.31546.8797889985487965830.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     bb2784d9ab49587ba4fbff37a319fff2924db289
Gitweb:        https://git.kernel.org/tip/bb2784d9ab49587ba4fbff37a319fff2924db289
Author:        Easwar Hariharan <eahariha@linux.microsoft.com>
AuthorDate:    Thu, 30 Jan 2025 19:26:58 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 31 Jan 2025 09:30:49 +01:00

jiffies: Cast to unsigned long in secs_to_jiffies() conversion

While converting users of msecs_to_jiffies(), lkp reported that some range
checks would always be true because of the mismatch between the implied int
value of secs_to_jiffies() vs the unsigned long return value of the
msecs_to_jiffies() calls it was replacing.

Fix this by casting the secs_to_jiffies() input value to unsigned long.

Fixes: b35108a51cf7ba ("jiffies: Define secs_to_jiffies()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250130192701.99626-1-eahariha@linux.microsoft.com
Closes: https://lore.kernel.org/oe-kbuild-all/202501301334.NB6NszQR-lkp@intel.com/
---
 include/linux/jiffies.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index ed945f4..0ea8c98 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -537,7 +537,7 @@ static __always_inline unsigned long msecs_to_jiffies(const unsigned int m)
  *
  * Return: jiffies value
  */
-#define secs_to_jiffies(_secs) ((_secs) * HZ)
+#define secs_to_jiffies(_secs) (unsigned long)((_secs) * HZ)
 
 extern unsigned long __usecs_to_jiffies(const unsigned int u);
 #if !(USEC_PER_SEC % HZ)

