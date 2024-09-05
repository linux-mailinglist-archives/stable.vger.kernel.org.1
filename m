Return-Path: <stable+bounces-73619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5823A96DD3B
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 17:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFE91F2255E
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 15:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46921A2652;
	Thu,  5 Sep 2024 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3c/bQTJ0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HBWAK90u"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18C31A08AB;
	Thu,  5 Sep 2024 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548612; cv=none; b=On0gZUiHxS39Bw10qznDHYBtKvFz6R9xJ5hs86PiDf00oJhPCqwiTuvSP8A0sQjERrPoNbaT6FBFpPKXH9/4i+c2d0dvBlN1JSVfH8k74lRcNTFS5OO83EXYDXB0/aSSS+hoCwIya2qA06bb4MV+vHZXpx/+AoQ7DSLXY9KF2Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548612; c=relaxed/simple;
	bh=tPjV7lbvvVcInSyPS1lzpB3ol7zfA3cyieli8MH7OFE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cY2Ks/+LvSc0mI31UPmAql9k3BLeqN5a1lCKbsG3nKQwH71uBV83X/clBTvSwZbugvjvZZewGOSn0GylIsOmOQpX3hAU4VbTkb2JDsYUUIDsPZRlUq0pZRmSaTwpCof20pUvKtGmvs5257lcbjFD/92SUTByrTgLXpFOFPA6mGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3c/bQTJ0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HBWAK90u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Sep 2024 15:03:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725548609;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1qa/VrX/w5dY9ftTWUinSqACrzuybaSHsCf39+hz7s=;
	b=3c/bQTJ02Q7df3FLVfTlN+x3VGbxnGHrc3Uh1TFnnYIZbm/RTmoe0Siup2hfFwos7YBDeo
	FSh9ECrPKurbdXxrDFJq2G9VHitnHWKPH7IOqulCrctYHVDFUhVOozfhSmcKuyojVZ99kv
	GzoV5SxOyrS4QUq1mCdqgEqT+yMjhD80wfH3PIdHRO7/bRa5UzVz9zoWOlHY/viJXHfP9J
	8bRchpzUoqaCK+Ji7x629xoAQi9Rc6qp1yv4lPWtgLc/SzqBJiixeQIPnbB4xYI/CjGdas
	GTsE6ra8ZwqjOrnHyrYGzMUhEvhGDaEoKEUyYIB8aCUExsZxnnjgKPL/DSSjBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725548609;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1qa/VrX/w5dY9ftTWUinSqACrzuybaSHsCf39+hz7s=;
	b=HBWAK90u6xXU6PV88fDeRU1IhmrRgfC+XeorjNem9bMqpikfAz9CWz4vOC0WRK1npeJF/V
	vwy5TLeLnXdmC7AA==
From: "tip-bot2 for Luo Gengkun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Fix small negative period being ignored
Cc: Luo Gengkun <luogengkun@huaweicloud.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240831074316.2106159-2-luogengkun@huaweicloud.com>
References: <20240831074316.2106159-2-luogengkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172554860849.2215.13532771799874013503.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     62c0b1061593d7012292f781f11145b2d46f43ab
Gitweb:        https://git.kernel.org/tip/62c0b1061593d7012292f781f11145b2d46f43ab
Author:        Luo Gengkun <luogengkun@huaweicloud.com>
AuthorDate:    Sat, 31 Aug 2024 07:43:15 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 05 Sep 2024 16:56:13 +02:00

perf/core: Fix small negative period being ignored

In perf_adjust_period, we will first calculate period, and then use
this period to calculate delta. However, when delta is less than 0,
there will be a deviation compared to when delta is greater than or
equal to 0. For example, when delta is in the range of [-14,-1], the
range of delta = delta + 7 is between [-7,6], so the final value of
delta/8 is 0. Therefore, the impact of -1 and -2 will be ignored.
This is unacceptable when the target period is very short, because
we will lose a lot of samples.

Here are some tests and analyzes:
before:
  # perf record -e cs -F 1000  ./a.out
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.022 MB perf.data (518 samples) ]

  # perf script
  ...
  a.out     396   257.956048:         23 cs:  ffffffff81f4eeec schedul>
  a.out     396   257.957891:         23 cs:  ffffffff81f4eeec schedul>
  a.out     396   257.959730:         23 cs:  ffffffff81f4eeec schedul>
  a.out     396   257.961545:         23 cs:  ffffffff81f4eeec schedul>
  a.out     396   257.963355:         23 cs:  ffffffff81f4eeec schedul>
  a.out     396   257.965163:         23 cs:  ffffffff81f4eeec schedul>
  a.out     396   257.966973:         23 cs:  ffffffff81f4eeec schedul>
  a.out     396   257.968785:         23 cs:  ffffffff81f4eeec schedul>
  a.out     396   257.970593:         23 cs:  ffffffff81f4eeec schedul>
  ...

after:
  # perf record -e cs -F 1000  ./a.out
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.058 MB perf.data (1466 samples) ]

  # perf script
  ...
  a.out     395    59.338813:         11 cs:  ffffffff81f4eeec schedul>
  a.out     395    59.339707:         12 cs:  ffffffff81f4eeec schedul>
  a.out     395    59.340682:         13 cs:  ffffffff81f4eeec schedul>
  a.out     395    59.341751:         13 cs:  ffffffff81f4eeec schedul>
  a.out     395    59.342799:         12 cs:  ffffffff81f4eeec schedul>
  a.out     395    59.343765:         11 cs:  ffffffff81f4eeec schedul>
  a.out     395    59.344651:         11 cs:  ffffffff81f4eeec schedul>
  a.out     395    59.345539:         12 cs:  ffffffff81f4eeec schedul>
  a.out     395    59.346502:         13 cs:  ffffffff81f4eeec schedul>
  ...

test.c

int main() {
        for (int i = 0; i < 20000; i++)
                usleep(10);

        return 0;
}

  # time ./a.out
  real    0m1.583s
  user    0m0.040s
  sys     0m0.298s

The above results were tested on x86-64 qemu with KVM enabled using
test.c as test program. Ideally, we should have around 1500 samples,
but the previous algorithm had only about 500, whereas the modified
algorithm now has about 1400. Further more, the new version shows 1
sample per 0.001s, while the previous one is 1 sample per 0.002s.This
indicates that the new algorithm is more sensitive to small negative
values compared to old algorithm.

Fixes: bd2b5b12849a ("perf_counter: More aggressive frequency adjustment")
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20240831074316.2106159-2-luogengkun@huaweicloud.com
---
 kernel/events/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4acec97..67e115d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4183,7 +4183,11 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
 	period = perf_calculate_period(event, nsec, count);
 
 	delta = (s64)(period - hwc->sample_period);
-	delta = (delta + 7) / 8; /* low pass filter */
+	if (delta >= 0)
+		delta += 7;
+	else
+		delta -= 7;
+	delta /= 8; /* low pass filter */
 
 	sample_period = hwc->sample_period + delta;
 

