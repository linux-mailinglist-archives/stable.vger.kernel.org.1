Return-Path: <stable+bounces-158798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADD8AEBD7F
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 18:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA2A3AD897
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 16:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69362EA730;
	Fri, 27 Jun 2025 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vgb+4uvk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FC52EA496
	for <stable@vger.kernel.org>; Fri, 27 Jun 2025 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751042007; cv=none; b=F6kEjWtGqvueHCMRPrX6nmA+btx5VCcLVQbPCYarC6gzru3IAhANsuUt1HvjZR/+bSp/u5y6KZqm0QUum8bikRvYJQI/1ACILqRyRoro31GrnSLrcuOX/Q3ikK9DFIikoHzDk40nBK7XOUZLrci7/R6mrd/mrotmSzqsPwkUSXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751042007; c=relaxed/simple;
	bh=uqS6lXyRm2rw7QE9EAxJNG2Wt0wSjDLKMZf6XFvPE8o=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Eg1Z0L325fVutDwKikoP9ULLKw4EROKcyRhOxaBfnSH+6gQf9LNUUGQe5mSZx3ev8p8JRZAiVyzpAtfbx5u2+aju72B7VVapuAQIdhEhK004wkQTLpHnDldvFr7KYAkX87iyomINxxTJB/71ffEBgyagHLNrEs/YoWMaye4zXx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vgb+4uvk; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-748e378ba4fso3417472b3a.1
        for <stable@vger.kernel.org>; Fri, 27 Jun 2025 09:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751042004; x=1751646804; darn=vger.kernel.org;
        h=in-reply-to:content-language:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4nGtntNWiIPwUj1ee1XnNi/5sRluRtItIk84qqS3V8=;
        b=vgb+4uvkklPD7hiL5mR666VWG+UTFmaoe96+TDPJ2ZNly5mBPTngRrlXqKQnsF8RHY
         m54nCngvl7wxrhv+MldNUzGtxA05qJCxqNuqSSqLyICp56Zxtes073CmrhzL7RuNdIvp
         ousrKgBz/t4Lj674xLUUSGE0CAKM3cCXYbvDR1O/2KiIskIfCcRUKt5TNBJXdwoXwu07
         4yjjHzvyPvNt8k4KNX05wSC4k3SOcb/IH5qrsdCTFBVOif7JS9ZsNRuQdgwG5emoAF0a
         Sz0dX4jI9zCbTjc6IzU7lZqkxbZVqJudGms931n9W2kX8GPIWKhgijP2I4wW2N4tpnmD
         Gj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751042004; x=1751646804;
        h=in-reply-to:content-language:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q4nGtntNWiIPwUj1ee1XnNi/5sRluRtItIk84qqS3V8=;
        b=NoItA3WschLIQR/bZK6xieRHlMTETj4FsX20PI/Vg8LrocFi4IALaZ+/g3coK5w7ez
         Yibav0bExZ3gSrIYvepvveHzBnQdedmTb68zZsY4SeRsSO5eHu11PGOaKr/YcP7VqQgO
         PvShJDuNtyFUskBeHhhlR6VPwnmqX0xYaAd1uwK1x9BZUVxZmz2BfQTfm19vgiUBhH6B
         TXbqivi0SJOOf29ApHe2WLYXOvbjzeywsb7Zss6iKcyEOYxlAvce8DRomTmBRtNBHV09
         O1K8d9vSHBl/6i5OfwMDSv2Xt8rdjEjQBWYg+90VgGYiuI6uP+MQgi6FoL7clu//k31d
         V78Q==
X-Gm-Message-State: AOJu0YxIzCxf3eVt/HEmqQpWF1UI9xKkdLiTqrpwjHB9nP/MCVCfUVke
	xm1D2NVhC3im2VPH0PqvhZipTe2aCdxcBWPW5AR7sSk/+VewfrlbSZDJW+s0H+21u+e9KHYbqyz
	5iMRw
X-Gm-Gg: ASbGncsKJNxzcYEKdvSPXgpX7knsXIpLGxya2NpL+PEC/dpFmvLXE5bCNVqSwmKFqKl
	vVhNyhXtDFTBW1zuMblQvnil7/WbhRZkBbqXUN5+55gubdbiOPMl0FSD9p77tQJu8gaSICSIlvu
	dJX1K4r4gmGXhpHd+EFaXJwLLdEJji020i2qLVfaLyGR6Tn9Wq7J8hIiWsIpTLcMFrwEMPMa9Jd
	q7VoKNeulURJZ8PO4eWnUEwdEE0sDg1u9sJhzSQbTIvaeLeejsP2NFAQO9idqIep3Ko1VAmZII9
	z26DeyMY2IZtCAQUpOJtlpe12AuV+Xbc6YQ2GXnmCzUyBlVsUvadfioLeA==
X-Google-Smtp-Source: AGHT+IFY1YoKsFYrPpqoihSWdsKOSdiYGWIli99QOAjPncnrrhz8DWKEZ/tZCG7ahtBVnxu9KVGsrA==
X-Received: by 2002:a17:902:e84a:b0:235:866:9fac with SMTP id d9443c01a7336-23ac3bffa3emr63126585ad.2.1751042003645;
        Fri, 27 Jun 2025 09:33:23 -0700 (PDT)
Received: from [172.20.0.228] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c8649sm20087595ad.236.2025.06.27.09.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 09:33:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------K5AiNv8YcmSDRNtRrqv0UpE4"
Message-ID: <9f95ec1e-88fe-4760-9ecd-31c01c722516@kernel.dk>
Date: Fri, 27 Jun 2025 10:33:22 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] nvme: always punt polled uring_cmd end_io
 work to task_work" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
References: <2025062012-skydiver-undergrad-6e0f@gregkh>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <2025062012-skydiver-undergrad-6e0f@gregkh>

This is a multi-part message in MIME format.
--------------K5AiNv8YcmSDRNtRrqv0UpE4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/25 9:10 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 9ce6c9875f3e995be5fd720b65835291f8a609b1
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062012-skydiver-undergrad-6e0f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Here's one for 6.6-stable.

-- 
Jens Axboe
--------------K5AiNv8YcmSDRNtRrqv0UpE4
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-nvme-always-punt-polled-uring_cmd-end_io-work-to-tas.patch"
Content-Disposition: attachment;
 filename*0="0001-nvme-always-punt-polled-uring_cmd-end_io-work-to-tas.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAxMWYzMjg3MmFlYjU4MWQ5YTIwMDdmNzRhMGYwYzFhNTM0ZTRlMzYxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IEZyaSwgMTMgSnVuIDIwMjUgMTM6Mzc6NDEgLTA2MDAKU3ViamVjdDogW1BBVENIXSBu
dm1lOiBhbHdheXMgcHVudCBwb2xsZWQgdXJpbmdfY21kIGVuZF9pbyB3b3JrIHRvIHRhc2tf
d29yawoKQ29tbWl0IDljZTZjOTg3NWYzZTk5NWJlNWZkNzIwYjY1ODM1MjkxZjhhNjA5YjEg
dXBzdHJlYW0uCgpDdXJyZW50bHkgTlZNZSB1cmluZ19jbWQgY29tcGxldGlvbnMgd2lsbCBj
b21wbGV0ZSBsb2NhbGx5LCBpZiB0aGV5IGFyZQpwb2xsZWQuIFRoaXMgaXMgZG9uZSBiZWNh
dXNlIHRob3NlIGNvbXBsZXRpb25zIGFyZSBhbHdheXMgaW52b2tlZCBmcm9tCnRhc2sgY29u
dGV4dC4gQW5kIHdoaWxlIHRoYXQgaXMgdHJ1ZSwgdGhlcmUncyBubyBndWFyYW50ZWUgdGhh
dCBpdCdzCmludm9rZWQgdW5kZXIgdGhlIHJpZ2h0IHJpbmcgY29udGV4dCwgb3IgZXZlbiB0
YXNrLiBJZiBzb21lb25lIGRvZXMKTlZNZSBwYXNzdGhyb3VnaCB2aWEgbXVsdGlwbGUgdGhy
ZWFkcyBhbmQgd2l0aCBhIGxpbWl0ZWQgbnVtYmVyIG9mCnBvbGwgcXVldWVzLCB0aGVuIHJp
bmdBIG1heSBmaW5kIGNvbXBsZXRpb25zIGZyb20gcmluZ0IuIEZvciB0aGF0IGNhc2UsCmNv
bXBsZXRpbmcgdGhlIHJlcXVlc3QgbWF5IG5vdCBiZSBzb3VuZC4KCkFsd2F5cyBqdXN0IHB1
bnQgdGhlIHBhc3N0aHJvdWdoIGNvbXBsZXRpb25zIHZpYSB0YXNrX3dvcmssIHdoaWNoIHdp
bGwKcmVkaXJlY3QgdGhlIGNvbXBsZXRpb24sIGlmIG5lZWRlZC4KCkNjOiBzdGFibGVAdmdl
ci5rZXJuZWwub3JnCkZpeGVzOiA1ODUwNzliNmU0MjUgKCJudm1lOiB3aXJlIHVwIGFzeW5j
IHBvbGxpbmcgZm9yIGlvIHBhc3N0aHJvdWdoIGNvbW1hbmRzIikKU2lnbmVkLW9mZi1ieTog
SmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPgotLS0KIGRyaXZlcnMvbnZtZS9ob3N0L2lv
Y3RsLmMgfCAxNiArKysrKysrLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspLCA5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0
L2lvY3RsLmMgYi9kcml2ZXJzL252bWUvaG9zdC9pb2N0bC5jCmluZGV4IDRjZTMxZjlmMDY5
NC4uNWNmMDUwZTU2MmI3IDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9pb2N0bC5j
CisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2lvY3RsLmMKQEAgLTUyNiwxNiArNTI2LDE0IEBA
IHN0YXRpYyBlbnVtIHJxX2VuZF9pb19yZXQgbnZtZV91cmluZ19jbWRfZW5kX2lvKHN0cnVj
dCByZXF1ZXN0ICpyZXEsCiAJcGR1LT51LnJlc3VsdCA9IGxlNjRfdG9fY3B1KG52bWVfcmVx
KHJlcSktPnJlc3VsdC51NjQpOwogCiAJLyoKLQkgKiBGb3IgaW9wb2xsLCBjb21wbGV0ZSBp
dCBkaXJlY3RseS4KLQkgKiBPdGhlcndpc2UsIG1vdmUgdGhlIGNvbXBsZXRpb24gdG8gdGFz
ayB3b3JrLgorCSAqIElPUE9MTCBjb3VsZCBwb3RlbnRpYWxseSBjb21wbGV0ZSB0aGlzIHJl
cXVlc3QgZGlyZWN0bHksIGJ1dAorCSAqIGlmIG11bHRpcGxlIHJpbmdzIGFyZSBwb2xsaW5n
IG9uIHRoZSBzYW1lIHF1ZXVlLCB0aGVuIGl0J3MgcG9zc2libGUKKwkgKiBmb3Igb25lIHJp
bmcgdG8gZmluZCBjb21wbGV0aW9ucyBmb3IgYW5vdGhlciByaW5nLiBQdW50aW5nIHRoZQor
CSAqIGNvbXBsZXRpb24gdmlhIHRhc2tfd29yayB3aWxsIGFsd2F5cyBkaXJlY3QgaXQgdG8g
dGhlIHJpZ2h0CisJICogbG9jYXRpb24sIHJhdGhlciB0aGFuIHBvdGVudGlhbGx5IGNvbXBs
ZXRlIHJlcXVlc3RzIGZvciByaW5nQQorCSAqIHVuZGVyIGlvcG9sbCBpbnZvY2F0aW9ucyBm
cm9tIHJpbmdCLgogCSAqLwotCWlmIChibGtfcnFfaXNfcG9sbChyZXEpKSB7Ci0JCVdSSVRF
X09OQ0UoaW91Y21kLT5jb29raWUsIE5VTEwpOwotCQludm1lX3VyaW5nX3Rhc2tfY2IoaW91
Y21kLCBJT19VUklOR19GX1VOTE9DS0VEKTsKLQl9IGVsc2UgewotCQlpb191cmluZ19jbWRf
ZG9faW5fdGFza19sYXp5KGlvdWNtZCwgbnZtZV91cmluZ190YXNrX2NiKTsKLQl9Ci0KKwlp
b191cmluZ19jbWRfZG9faW5fdGFza19sYXp5KGlvdWNtZCwgbnZtZV91cmluZ190YXNrX2Ni
KTsKIAlyZXR1cm4gUlFfRU5EX0lPX0ZSRUU7CiB9CiAKLS0gCjIuNTAuMAoK

--------------K5AiNv8YcmSDRNtRrqv0UpE4--

