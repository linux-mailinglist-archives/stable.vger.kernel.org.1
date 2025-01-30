Return-Path: <stable+bounces-111730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D3AA233FA
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 19:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC4F3A69F3
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 18:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450541F0E4F;
	Thu, 30 Jan 2025 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UFhLJrP5"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28F11487E1;
	Thu, 30 Jan 2025 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738262617; cv=none; b=FjJT6qkI9z50FmaM95VgG6vDL/wjad8GS7qwWkSRw5JLDzhYnvcWcNGy/aX5EP31qQTrq0bKLVfFu521EnF3XbDJ/OJduW3BpBZcN1Kgl4yyoWHN1qQfKV3JXYsBLWpCVhscK3tCt8+rwV5i1PoUIVnEbefUtPj+4EsJzSUls5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738262617; c=relaxed/simple;
	bh=aDagd4BAWQY/hP9l+eA734hMfgTakmF87Jm3o4BqsCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KX7HoIWJyzsZDKPV4hRFSssRRzt4vLlLNhK8K4RwoABRdBbKx8/9ZvrcgethuV99cZLg6wIsS4AJ5qek1fngB88k1tZ/hICwlmb6Nr/OBlTJFJC/Up7Jvz/rp3CwmmtC6WppuGyTxYfntE3R8m/D8Q818o2H10OqFWwoevBg0xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UFhLJrP5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.5bhznamrcrmeznzvghz2s0u2eh.xx.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 318BD2109CF9;
	Thu, 30 Jan 2025 10:43:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 318BD2109CF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738262609;
	bh=icDJY8Q348ilzQRtKBEy9Yha219vEzHsJnh9e+6/fwM=;
	h=From:To:Cc:Subject:Date:From;
	b=UFhLJrP5yznKwE9ke0EmRsCvBPk4GeGLxI/+9EishOi3jvI2lI3mxCAo5ZDDVHqT2
	 P+vr4hYVfiV595ZvcmWK5FKwZWSEW0uUo6sIGekzsKgGY/lt22iJ60mtAPBRpwxwRY
	 44NEosvIda6b+PibFHym0sfmLK9P6q/fd9t5q8dw=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Cc: stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] jiffies: Cast to unsigned long for secs_to_jiffies() conversion
Date: Thu, 30 Jan 2025 18:43:17 +0000
Message-ID: <20250130184320.69553-1-eahariha@linux.microsoft.com>
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
CC: stable@vger.kernel.org # 6.12+
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


