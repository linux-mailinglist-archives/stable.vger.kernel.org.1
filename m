Return-Path: <stable+bounces-174466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 741C0B36347
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0441BC554B
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE882FD1D5;
	Tue, 26 Aug 2025 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JqNEeVW/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF431B87E8;
	Tue, 26 Aug 2025 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214466; cv=none; b=ihNlz+oU4KIozHbCvyOXC0iB/lJjxJJoC9YqzQfWYHgUkcjdJOPlT0P+Q9iRhQX4yWIhH7m3/XrcR2aKoHq8pUu+V47AsDFf8ZoCPZzScpB/1nYHl34mT8u/nOo6otdtT4SUZ9b5bZP+dYSWJAfplrZCwaOiPtV/PXDwV0HXBiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214466; c=relaxed/simple;
	bh=rFb3FH7On7JnbNWuS1YlUgwotbGDRU0PslsD/lnRfGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aONXcKk94M9KJwKw2UjEqbahFtIq6TixGyl2V5YZECJoEgGMBZE8in1iBhyQNrACutevkJ1H9dgfNcYwIftM7ekfIg1RWCCm2a0CPhoiNUJNqGDQAu6AmhuDevVDxzXx6+G9DXiydQEN8QSckHaPuD2zoum2WT0KYoNNxbkmgdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JqNEeVW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53876C4CEF1;
	Tue, 26 Aug 2025 13:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214466;
	bh=rFb3FH7On7JnbNWuS1YlUgwotbGDRU0PslsD/lnRfGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JqNEeVW/TXQUAcibCp2p3SYMyiqROhWEvZT+QB4UcDXl6xq0s6bQ5J0iQ40TyQxeb
	 tdrSQNHGrIm+3lPzKoAaYykvLWIQj0AZmO+0S54CW2uyX2Hh1R14+rWwfYF16X127a
	 bkdzmX/VLqNQBUpCY+4JgluPZquogsNYSO48cm9w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sven Schnelle <svens@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 117/482] s390/time: Use monotonic clock in get_cycles()
Date: Tue, 26 Aug 2025 13:06:10 +0200
Message-ID: <20250826110933.715293152@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Schnelle <svens@linux.ibm.com>

[ Upstream commit 09e7e29d2b49ba84bcefb3dc1657726d2de5bb24 ]

Otherwise the code might not work correctly when the clock
is changed.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/timex.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index ce878e85b6e4..d0255aa5b36e 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -192,13 +192,6 @@ static inline unsigned long get_tod_clock_fast(void)
 	asm volatile("stckf %0" : "=Q" (clk) : : "cc");
 	return clk;
 }
-
-static inline cycles_t get_cycles(void)
-{
-	return (cycles_t) get_tod_clock() >> 2;
-}
-#define get_cycles get_cycles
-
 int get_phys_clock(unsigned long *clock);
 void init_cpu_timer(void);
 
@@ -221,6 +214,12 @@ static inline unsigned long get_tod_clock_monotonic(void)
 	return tod;
 }
 
+static inline cycles_t get_cycles(void)
+{
+	return (cycles_t)get_tod_clock_monotonic() >> 2;
+}
+#define get_cycles get_cycles
+
 /**
  * tod_to_ns - convert a TOD format value to nanoseconds
  * @todval: to be converted TOD format value
-- 
2.39.5




