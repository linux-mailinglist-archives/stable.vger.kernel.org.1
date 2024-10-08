Return-Path: <stable+bounces-82442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB97994CD5
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111602865B0
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A155D1DFD99;
	Tue,  8 Oct 2024 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WmDMzDnf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D55F1DF75D;
	Tue,  8 Oct 2024 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392275; cv=none; b=ZC3/MzYgUa5U33IBDHyi6eI4rZBB5peNI2AJP3tLJ7VSC5ZmOOrhnhu7jF90EW28MvDCikhS2ouOazLRCZfNeOPgrX+CPXxMKfLRGIFYQY8tdpdLg/lyV40naNBUrQVR3aL13psv1TVcL0NdQvra4te4D9orCPc9rXbcReH8QbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392275; c=relaxed/simple;
	bh=U1v8M4SdVie6yimD5cOlc+VQ9JmdMODholHUqC5uSJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjnM95nCjfM34+UGMP2gbFpZlR7geq462QEH2Ut6BFOhzIiBjU9lSg2O5LGdFWk7jFX0VJQgURDkugNI4owAZBAYaZF/Iki4bKwkiWAgXXPgvmE0TijqhLB5TSm047ak63IW5JUjzdA8hWrX5wmN+yOVfT4xU92VoLZMXMYNynA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WmDMzDnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE153C4CEC7;
	Tue,  8 Oct 2024 12:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728392275;
	bh=U1v8M4SdVie6yimD5cOlc+VQ9JmdMODholHUqC5uSJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WmDMzDnfy6tT6zcYy/YEqXOGHQcd+yTCwbR1+aOK2BOura7V5yQeiSWcDoz4CIUQJ
	 2h37Jqfdp56VPb4yI8UGkEwkjS3ZvCSUdhMYgCZzNevw5+vmaq1hrccrLSY9qz+j3r
	 YVaYqDL+xiBPTSH6kqmfVB2DBaZccFNTtdXuNRvg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luo Gengkun <luogengkun@huaweicloud.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 6.11 367/558] perf/core: Fix small negative period being ignored
Date: Tue,  8 Oct 2024 14:06:37 +0200
Message-ID: <20241008115716.738091608@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4097,7 +4097,11 @@ static void perf_adjust_period(struct pe
 	period = perf_calculate_period(event, nsec, count);
 
 	delta = (s64)(period - hwc->sample_period);
-	delta = (delta + 7) / 8; /* low pass filter */
+	if (delta >= 0)
+		delta += 7;
+	else
+		delta -= 7;
+	delta /= 8; /* low pass filter */
 
 	sample_period = hwc->sample_period + delta;
 



