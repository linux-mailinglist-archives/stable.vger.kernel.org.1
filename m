Return-Path: <stable+bounces-111736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD51DA234AA
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 20:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD49188876F
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 19:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62131F03F9;
	Thu, 30 Jan 2025 19:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="od/VtkOQ"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0741946C8;
	Thu, 30 Jan 2025 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738265226; cv=none; b=jUcRNeb/ZmzAjt657E45HxpF/3NrWAqU+ZG7k8Mp6Pzs1S8ci7NUmb3PBDr3xa6+BdkKjSk9GuKI6VQAlPMyAwxXgu0hHyqq5xkNHfAjjKbFIjCJdsWZq17Qu+mZc+47tmHXjicX1MLpfb6hEaajOv152jZxWNRdUxGmQzNe1qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738265226; c=relaxed/simple;
	bh=HphWgGYol3yK/0d3uuUuI/pzYpPkdRYoaqWMg365tx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cumserAJGkoVzpJiWvEqNq77QSIxsYPmMYdvmIAthKo3d8hYSv91Xs4Fua7aDJrISjX8VGGDengKWYDEW8WKjd/X8IGY7F9hDH3sKfn5Tecuzsi0NnXxWJNG3/PM38vf1FJlXyIbNWW33aTmqeAWL1rOYBQbL1E/UJcloArT2B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=od/VtkOQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.5bhznamrcrmeznzvghz2s0u2eh.xx.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id C806B2109CFC;
	Thu, 30 Jan 2025 11:27:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C806B2109CFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738265224;
	bh=9rMV5BwrVZrfwGEnLcs+V/L2+KRPdN0vhANGt+Y9ls0=;
	h=From:To:Cc:Subject:Date:From;
	b=od/VtkOQrbFMZbiXIjc5A16/OvzNNvNWzk2lTHx5ZYjca/DgU8J1EOt45BbwKJRJU
	 ojSJIh1d98SX7rf2sM3rMsPSv5tmNps+OSHWyOJaEFg81BvaiEfwK9yJ6K/udCjnoJ
	 ami6TgdGAZjJXjcPqOlo/K2GnzlYxaCXsVGVWTwY=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Cc: stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] jiffies: Cast to unsigned long for secs_to_jiffies() conversion
Date: Thu, 30 Jan 2025 19:26:58 +0000
Message-ID: <20250130192701.99626-1-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While converting users of msecs_to_jiffies(), lkp reported that some
range checks would always be true because of the mismatch between the
implied int value of secs_to_jiffies() vs the unsigned long
return value of the msecs_to_jiffies() calls it was replacing. Fix this
by casting secs_to_jiffies() values as unsigned long.

Fixes: b35108a51cf7ba ("jiffies: Define secs_to_jiffies()")
CC: stable@vger.kernel.org # 6.13+
CC: Andrew Morton <akpm@linux-foundation.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501301334.NB6NszQR-lkp@intel.com/
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 include/linux/jiffies.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index ed945f42e064..0ea8c9887429 100644
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
-- 
2.43.0


