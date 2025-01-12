Return-Path: <stable+bounces-108338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC359A0AA3E
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 15:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06BA67A3578
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 14:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FBD1BC073;
	Sun, 12 Jan 2025 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pQwddYrj"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3121BC9F6
	for <stable@vger.kernel.org>; Sun, 12 Jan 2025 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736693690; cv=none; b=Qw3K6+9At2I4PRIOWPlnx/rPLb4xVonFGVVQn0YFaBgkcmV1Rj4VswelM5Mtwvsl4mjmKLQ1fDg85Iy7np0+F1fs/Th8Gom526lz3r4T8/t7zSenxV4b8iYFV2cZp7b1c8ENXwFvcEalN6voiE/iWGwtFU3moRFQPHaPS9gyOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736693690; c=relaxed/simple;
	bh=UO+C5YhTwEykrniNpetkY74ECZHjHAuMJBVyauRfVeo=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=mqJKrdenH8LaKyIX4ZFevaP0REVOX2M2DIKd9r3aFVm5zxGri5Py6smu52taG2LVBB33jDi6N7/sYu8wP1w3QRu8ok87oayz2nkTtcoiO8deJlaCkGubplon3Skc1cDn8Viz9VifdQHT7i0b0/ayY/nm2kD0tETaODS4dBFzSP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pQwddYrj; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-844df397754so111289039f.2
        for <stable@vger.kernel.org>; Sun, 12 Jan 2025 06:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736693687; x=1737298487; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IB+LmuBbLaQLo9sGVY352V62RvJ4P0+11Qr4CbhPIbM=;
        b=pQwddYrjEfHqwOi8FhXs/z6T5UiQQtoo8DjiQvu0jsK1w92s4rPvhNFMuJvTfIs1V/
         0mWRzH02iupTcNN9KUWHJ49pcaGSM/q650ZtfZVHbjWV2Df+SyRNt2OVQvO4wcAxzBmw
         gMADNFjTEjdqBMs7EuVgumrCDiFvLNpZLBSuJT1akADD5/V1wyPv2SNNpaTZxnpl7eSr
         oVssDrqLZI9CbyuHcyuQZpeM2VAa1ecdBqH+1dzHsDVnNLxUoWlw+2KrEWLUThUblYvq
         Aa/JrNHfEOnYyQPDnm8S6+AdPhUAbBiK0pYCe2XfnYW6SZJCzh7czZgA8uYy6GpL7/lW
         ZJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736693687; x=1737298487;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IB+LmuBbLaQLo9sGVY352V62RvJ4P0+11Qr4CbhPIbM=;
        b=tP1la84D3yhl+mEnytyAT0LxqVkvuDIVM4y6N1O/aeFd8nAci33UIadzh/0lvqzxnJ
         erz/DqWX5m0ApfofJZ9TU2KZQLkbQDKIElFyr7e2uD2FA+azFSOm48peVYXVllNL8f+7
         /znrhZsMJea4lKo292iT2fFATOMpHEGhiFaGes6Bv48jKTgIqB6dSiyuXnwjeozDFeZ3
         qpjv85Armf/cMg6ogLzxeKia8DBm5tBz0TtwRsg2R0llARbgBzEm0Vr+t8EkvmAZmK8b
         Ncj22WyTXJV+Lh8e6Z3mHJ28isV5FVB3WG1qsK+Z465otnuYXGz0fVzu9aWfp3pnJeV0
         be/g==
X-Gm-Message-State: AOJu0YyiEFmY1Flvf7wd58n5RgOraMr6j4WKtB0VI+MoOCAeksNMBYbt
	acL9zt5fv/uhKwkFZwtYANp4hpwgKByZ7B3xgokBz+/cfbPnULredClgjpKFAsZkQVOAUmJUUKa
	w
X-Gm-Gg: ASbGncsPo/icJNMKhK0R8QInoMV+43la1Sknnnje0UFxb70OKi/pER1qpjH0W2y9+ut
	xlg3IWRumpNW2O+SLs9YYsO/0C0RvC/ThG+EKQgRn4s78yNoLvKjY5c1rPMFM2uA2VRTtfpyFY+
	r62kXWOs3/BYqK+i1bolKs/MDrlC6dnm7W+xNNWfhDfaaKQa7ezUtQm+j+lBx0UyB5Sd8v9h9lu
	KX7VCvHGkg1x4EJcOjhOrinDrjEQimkMTUVZDpnH5uLTio8+IeIxw==
X-Google-Smtp-Source: AGHT+IHLOPUYDPtRQvQaG/MIlKsnhtWc1MAt5nOCkKsCNRTCvMhcBPn8ddL9tWH0yNAZ4+bFjjMZ7A==
X-Received: by 2002:a05:6e02:3f03:b0:3a8:1195:f216 with SMTP id e9e14a558f8ab-3ce3a944a2fmr126573535ab.10.1736693686675;
        Sun, 12 Jan 2025 06:54:46 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b629093sm2148637173.65.2025.01.12.06.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 06:54:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------m9LA2OrKo7z5Fgyycxb7CvoP"
Message-ID: <aa20e9c1-7fd7-4502-998e-4b1de2af0042@kernel.dk>
Date: Sun, 12 Jan 2025 07:54:45 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/eventfd: ensure
 io_eventfd_signal() defers another" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org, jannh@google.com, lizetao1@huawei.com,
 ptsm@linux.microsoft.com
Cc: stable@vger.kernel.org
References: <2025011245-hardy-tiptop-229e@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025011245-hardy-tiptop-229e@gregkh>

This is a multi-part message in MIME format.
--------------m9LA2OrKo7z5Fgyycxb7CvoP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/25 2:16 AM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x c9a40292a44e78f71258b8522655bffaf5753bdb
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011245-hardy-tiptop-229e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Here's the 6.6 version.

-- 
Jens Axboe

--------------m9LA2OrKo7z5Fgyycxb7CvoP
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-eventfd-ensure-io_eventfd_signal-defers-ano.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-eventfd-ensure-io_eventfd_signal-defers-ano.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA5ODE1ODZkZDdiODVmYzQyNGQ1OWJlODQxNDI1NWFkNDYyNTE5NThjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFdlZCwgOCBKYW4gMjAyNSAxMToxNjoxMyAtMDcwMApTdWJqZWN0OiBbUEFUQ0hdIGlv
X3VyaW5nL2V2ZW50ZmQ6IGVuc3VyZSBpb19ldmVudGZkX3NpZ25hbCgpIGRlZmVycyBhbm90
aGVyCiBSQ1UgcGVyaW9kCgpDb21taXQgYzlhNDAyOTJhNDRlNzhmNzEyNThiODUyMjY1NWJm
ZmFmNTc1M2JkYiB1cHN0cmVhbS4KCmlvX2V2ZW50ZmRfZG9fc2lnbmFsKCkgaXMgaW52b2tl
ZCBmcm9tIGFuIFJDVSBjYWxsYmFjaywgYnV0IHdoZW4KZHJvcHBpbmcgdGhlIHJlZmVyZW5j
ZSB0byB0aGUgaW9fZXZfZmQsIGl0IGNhbGxzIGlvX2V2ZW50ZmRfZnJlZSgpCmRpcmVjdGx5
IGlmIHRoZSByZWZjb3VudCBkcm9wcyB0byB6ZXJvLiBUaGlzIGlzbid0IGNvcnJlY3QsIGFz
IGFueQpwb3RlbnRpYWwgZnJlZWluZyBvZiB0aGUgaW9fZXZfZmQgc2hvdWxkIGJlIGRlZmVy
cmVkIGFub3RoZXIgUkNVIGdyYWNlCnBlcmlvZC4KCkp1c3QgY2FsbCBpb19ldmVudGZkX3B1
dCgpIHJhdGhlciB0aGFuIG9wZW4tY29kZSB0aGUgZGVjLWFuZC10ZXN0IGFuZApmcmVlLCB3
aGljaCB3aWxsIGNvcnJlY3RseSBkZWZlciBpdCBhbm90aGVyIFJDVSBncmFjZSBwZXJpb2Qu
CgpGaXhlczogMjFhMDkxYjk3MGNkICgiaW9fdXJpbmc6IHNpZ25hbCByZWdpc3RlcmVkIGV2
ZW50ZmQgdG8gcHJvY2VzcyBkZWZlcnJlZCB0YXNrIHdvcmsiKQpSZXBvcnRlZC1ieTogSmFu
biBIb3JuIDxqYW5uaEBnb29nbGUuY29tPgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpT
aWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJp
bmcvaW9fdXJpbmcuYyB8IDEzICsrKysrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvaW9f
dXJpbmcuYyBiL2lvX3VyaW5nL2lvX3VyaW5nLmMKaW5kZXggMDEyMmYyMjBlZjBkLi5jNzE5
OGZiY2Y3MzQgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL2lvX3VyaW5nLmMKKysrIGIvaW9fdXJp
bmcvaW9fdXJpbmcuYwpAQCAtNTM3LDYgKzUzNywxMyBAQCBzdGF0aWMgX19jb2xkIHZvaWQg
aW9fcXVldWVfZGVmZXJyZWQoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgpCiAJfQogfQogCitz
dGF0aWMgdm9pZCBpb19ldmVudGZkX2ZyZWUoc3RydWN0IHJjdV9oZWFkICpyY3UpCit7CisJ
c3RydWN0IGlvX2V2X2ZkICpldl9mZCA9IGNvbnRhaW5lcl9vZihyY3UsIHN0cnVjdCBpb19l
dl9mZCwgcmN1KTsKKworCWV2ZW50ZmRfY3R4X3B1dChldl9mZC0+Y3FfZXZfZmQpOworCWtm
cmVlKGV2X2ZkKTsKK30KIAogc3RhdGljIHZvaWQgaW9fZXZlbnRmZF9vcHMoc3RydWN0IHJj
dV9oZWFkICpyY3UpCiB7CkBAIC01NTAsMTAgKzU1Nyw4IEBAIHN0YXRpYyB2b2lkIGlvX2V2
ZW50ZmRfb3BzKHN0cnVjdCByY3VfaGVhZCAqcmN1KQogCSAqIG9yZGVyaW5nIGluIGEgcmFj
ZSBidXQgaWYgcmVmZXJlbmNlcyBhcmUgMCB3ZSBrbm93IHdlIGhhdmUgdG8gZnJlZQogCSAq
IGl0IHJlZ2FyZGxlc3MuCiAJICovCi0JaWYgKGF0b21pY19kZWNfYW5kX3Rlc3QoJmV2X2Zk
LT5yZWZzKSkgewotCQlldmVudGZkX2N0eF9wdXQoZXZfZmQtPmNxX2V2X2ZkKTsKLQkJa2Zy
ZWUoZXZfZmQpOwotCX0KKwlpZiAoYXRvbWljX2RlY19hbmRfdGVzdCgmZXZfZmQtPnJlZnMp
KQorCQljYWxsX3JjdSgmZXZfZmQtPnJjdSwgaW9fZXZlbnRmZF9mcmVlKTsKIH0KIAogc3Rh
dGljIHZvaWQgaW9fZXZlbnRmZF9zaWduYWwoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgpCi0t
IAoyLjQ3LjEKCg==

--------------m9LA2OrKo7z5Fgyycxb7CvoP--

