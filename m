Return-Path: <stable+bounces-82861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C029994ED5
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051C51F226D0
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DE71DED48;
	Tue,  8 Oct 2024 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ujMbj/7A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BD21DE3C1;
	Tue,  8 Oct 2024 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393673; cv=none; b=HVQXmeEyasPfhA3ZcU1U7UWsPCpWPVAaJyEvoQ+QoAx39A4phcqpWpMr+LD/3y4xVXB7Ffz/bjuCBTHiF81Husv5sqmMdA1U1JL+oP66Hm/ez4ATILc+tWODEcv3AwdXj5gp3qXniHQ1+dhbqE3b9B6aeJh7e/lWmrphlCcDHdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393673; c=relaxed/simple;
	bh=9nOam8FColMiOQ9TZ3uxLlJE3l1KtEG4unDyGV16jVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J64bRwuAiaJWb/UWO32lVNO1D9W/71g0QQ2flpVcw4VcF7l08h05nHCGiPnJ8vk4uQPqWWooJ7jzbwpz5nI9K+ziMb5C3Bs2FUAzHAnAzRyg76DTBLroMBG9Ci9nnrASRsceyGX48S+dzCIIvnf9hGbZNcOypvqWsT5WV9cilz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ujMbj/7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882F0C4CEC7;
	Tue,  8 Oct 2024 13:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728393673;
	bh=9nOam8FColMiOQ9TZ3uxLlJE3l1KtEG4unDyGV16jVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ujMbj/7AxMNzmlqYEMRElgOEFjEtCs+zy9KYHVGMBAExafCfCaiEVNLlc89mlsprR
	 G/7r2aqPW97U1w856Jvig1HEmP6cHb8nHbfy/RkCAsXHvqvD/AVqTqipEWPhs9FqE+
	 esoOmy04NhjNlmeZ92TClqHYFtIy7Tq5XqDoucT4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luo Gengkun <luogengkun@huaweicloud.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 6.6 220/386] perf/core: Fix small negative period being ignored
Date: Tue,  8 Oct 2024 14:07:45 +0200
Message-ID: <20241008115638.064999149@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luo Gengkun <luogengkun@huaweicloud.com>

commit 62c0b1061593d7012292f781f11145b2d46f43ab upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/events/core.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4104,7 +4104,11 @@ static void perf_adjust_period(struct pe
 	period = perf_calculate_period(event, nsec, count);
 
 	delta = (s64)(period - hwc->sample_period);
-	delta = (delta + 7) / 8; /* low pass filter */
+	if (delta >= 0)
+		delta += 7;
+	else
+		delta -= 7;
+	delta /= 8; /* low pass filter */
 
 	sample_period = hwc->sample_period + delta;
 



