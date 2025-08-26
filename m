Return-Path: <stable+bounces-175143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F85B36737
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0BC463EC6
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC74350835;
	Tue, 26 Aug 2025 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q2suxF2k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778DB34F49D;
	Tue, 26 Aug 2025 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216255; cv=none; b=n9f/068OSvvDnmYXK6LzIRvBBN5BTzI3p621L7Hc3aDqzBSnpF068XORPcixvboNF2+W4bWNwI42Y+E6WFGkThhQVJNP6xgdsxqdiLuDABewmou+MyaHb7uYm7i3iJQ+lQZrppISHEGzxpRs5i9Us5nIBJnPgVl0YqA19Ltoi4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216255; c=relaxed/simple;
	bh=QRN9JVLng10BfUXHvP/Kpfis2PVqKBzmYN7v6p9rytI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCL+2u6gZYpUxh234Z9OFgoUb3T6KE8fyzmGNLWcHNzDv4PCFPW5mF4NQQHDjjj8j7My9eHZDdrLMZIEW3UBaoA0pkOAMtnO/6J4IhiP4xoLGjAFCYEdD/pFjxGlNYpUxPHFV5cVUy7CV6ULeFsQmi3YFXX2Rl/AemV4O8EEdSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q2suxF2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052A3C4CEF1;
	Tue, 26 Aug 2025 13:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216255;
	bh=QRN9JVLng10BfUXHvP/Kpfis2PVqKBzmYN7v6p9rytI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2suxF2kWbSCL3/GA4aBaQeaT2AjntNlUnteiKcNkqtg9rTZOfgbegW3BByxdudff
	 txu+I2feWsEdGxIQoe8dQjB9OhjxrFt7ntaKIih8xo3SD1XULuc87vQBlPZe9E77IZ
	 mYzy+FFFnG217yZ+Hp4xfX7LVj9e9w2TubORvGf0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sven Schnelle <svens@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 340/644] s390/time: Use monotonic clock in get_cycles()
Date: Tue, 26 Aug 2025 13:07:11 +0200
Message-ID: <20250826110954.814315982@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index bc50ee0e91ff..a046a4d13816 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -196,13 +196,6 @@ static inline unsigned long get_tod_clock_fast(void)
 	return get_tod_clock();
 #endif
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
 
@@ -225,6 +218,12 @@ static inline unsigned long get_tod_clock_monotonic(void)
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




