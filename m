Return-Path: <stable+bounces-108336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 137EBA0AA38
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 15:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA84F1886CDA
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 14:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3EC1B86CC;
	Sun, 12 Jan 2025 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="v2/UJzp7"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602871B3948
	for <stable@vger.kernel.org>; Sun, 12 Jan 2025 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736693650; cv=none; b=FiKPNsxc+xvJOmwIE0CBHCMVvyF6nKsz0MjoK18WqM0gJsnHRkQzCaCPKxMrCGxGTubiwtkpgIfxBKDg+A6c5Q2G+BPdNgEny7r8mOjFnkNgcJcJuXkgn93Qq9UWxsnnWjmO226/Xash98Jz5y/L4BJYkfI129+6JHtKlPW73gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736693650; c=relaxed/simple;
	bh=5PGK8vXhWZN4Lj6Nh3VT+k9KkJmIPoLjey0sAmDFxNw=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Vuqdz2cmyhvUSupoGlRY4lozyMVWaGfmMmQQ+MiSwUy+vCfs37kZLwlajQoLAaLeZPKBfystyxltZnf2GTvWhzKTnzwB3kr1g8VW2IxmaAnFineJbhQt1eauPWuEre6fQ2eXdqyrSXUboSl6EWt47XHiHwcBMtzm9t1Azyb2A54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=v2/UJzp7; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a9cdcec53fso25410285ab.1
        for <stable@vger.kernel.org>; Sun, 12 Jan 2025 06:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736693646; x=1737298446; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fntlv8vDgLmjQzrkhLIvY/Un387roSJz1PZ5JEVqHYY=;
        b=v2/UJzp7UF4ol1B5mFP5wE7CnspQFB27pcLX7pOdexsFZBk+tKZuDllmuhN+Sl1pGn
         Ok+JTmPqIZrtUqIOAnm4RYYxyUFgsjryRwW7gY2CishUjcAxmva7aHz75CUcavfiiL6k
         puvvJFAs0TL1Kq3uEMuXOP+C0H1dyzjzsiXKGjiUneXUqlEV1C/rgZEeUg/DnVQbQrCY
         NyZN5nH7jrWAb61tarCyklQum7LK++TtLnkViE/9+ZnXzL6cvWCAzFjWmg0mvQKdTIhz
         Lxd8s6IecOinXsFIwhYziAUChh202WBFU0oQBnMY0QRJsJsmDVmiUYSqdfh2rIj2avP1
         j7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736693646; x=1737298446;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fntlv8vDgLmjQzrkhLIvY/Un387roSJz1PZ5JEVqHYY=;
        b=Rdt8VvjRoQQlye+iYP398TOPSYwMtesuqsqY3GpYMP345IBkVzbT96ISmi9xKrYraK
         92hdvZcY83Brd1U7Q4DnpCG/BlymmC1WUl6wz2LVkme2Xv5QyZxLzPyyCGf1y7FUk2mp
         fW2f7rWeUgzirv27CwVQHZWKMdvmxoN4g2sYgj1BlLtUNPDxnqbr6sYy2mtxovI/zrTz
         +dMRTkwkBoCaVSrvZlUphm8DIxrnHThphM3hn2b7yg7PU4GlnCjRJCVHRDgdrgFbnY2T
         1ND20+gRRB0j1CCb69twsAlC1ilw35FgfC/PhndjyKVLMqAVVXcMCJEGctTCflG1MLeC
         EKUg==
X-Gm-Message-State: AOJu0YxZFzbLhvMDte//pqJHyYbtz485pVhK2YSjW266DPYB1Tsjtimr
	CwS1MlIEL4/1899/sxi284piJzpkvbqSO9NAgs3emq/lSL10NrWzpPPAFmDb5Zk=
X-Gm-Gg: ASbGncu+kTyjjI13B7asz8T/agUjJ1nvoW/6RIORDkMQwRpLCPqGDPExjKWGkcA6Wea
	Ei0y9BrQEOtRLgz2iJ6tkLZt+I5iHWAVVeOyHTmzyGh8aCRgEw8BzlEgqKXcxBHMHu6L+TSRbIX
	QJm2kBv5NgVXkh8nKjrp0KIWBNxEx/50MyJ5BwDq6up600PBnP2dE/dZ4dK85KVy93pjUhlUgIh
	FrM+nLyCvygvlpnaFjgHP0kXFJ6I+/3A5M+B4il251geuoUPiTS/g==
X-Google-Smtp-Source: AGHT+IG6Ub+fhbs7/nohJFqb4AJ9BJs1Dig9W4nhN8k5KT+S9htv00P8o/q5YH9xVg3GLKnlSfGiEw==
X-Received: by 2002:a05:6e02:1885:b0:3a7:e0e6:65a5 with SMTP id e9e14a558f8ab-3ce3a877e2dmr124642015ab.6.1736693646397;
        Sun, 12 Jan 2025 06:54:06 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b613391sm2171547173.47.2025.01.12.06.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 06:54:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------bIxdxfVCrhwUGIPj53cDz4AV"
Message-ID: <27e4ace9-302d-49d8-8419-472af6472c6b@kernel.dk>
Date: Sun, 12 Jan 2025 07:54:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/eventfd: ensure
 io_eventfd_signal() defers another" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, jannh@google.com, lizetao1@huawei.com,
 ptsm@linux.microsoft.com
Cc: stable@vger.kernel.org
References: <2025011244-expedited-clip-fd53@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025011244-expedited-clip-fd53@gregkh>

This is a multi-part message in MIME format.
--------------bIxdxfVCrhwUGIPj53cDz4AV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/25 2:16 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x c9a40292a44e78f71258b8522655bffaf5753bdb
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011244-expedited-clip-fd53@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Here's the 6.12 variant.

-- 
Jens Axboe

--------------bIxdxfVCrhwUGIPj53cDz4AV
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-eventfd-ensure-io_eventfd_signal-defers-ano.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-eventfd-ensure-io_eventfd_signal-defers-ano.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA1YmYxN2ZkNDYxMGRkMDIyNDY1MmU2YWExZDNlYWQwOTM3NzhlZTRkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFdlZCwgOCBKYW4gMjAyNSAxMDoyODowNSAtMDcwMApTdWJqZWN0OiBbUEFUQ0hdIGlv
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
bmcvZXZlbnRmZC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvZXZlbnRmZC5jIGIvaW9fdXJp
bmcvZXZlbnRmZC5jCmluZGV4IGUzN2ZkZGQ1ZDljZS4uZmZjNGJkMTdkMDc4IDEwMDY0NAot
LS0gYS9pb191cmluZy9ldmVudGZkLmMKKysrIGIvaW9fdXJpbmcvZXZlbnRmZC5jCkBAIC0z
OCw3ICszOCw3IEBAIHN0YXRpYyB2b2lkIGlvX2V2ZW50ZmRfZG9fc2lnbmFsKHN0cnVjdCBy
Y3VfaGVhZCAqcmN1KQogCWV2ZW50ZmRfc2lnbmFsX21hc2soZXZfZmQtPmNxX2V2X2ZkLCBF
UE9MTF9VUklOR19XQUtFKTsKIAogCWlmIChyZWZjb3VudF9kZWNfYW5kX3Rlc3QoJmV2X2Zk
LT5yZWZzKSkKLQkJaW9fZXZlbnRmZF9mcmVlKHJjdSk7CisJCWNhbGxfcmN1KCZldl9mZC0+
cmN1LCBpb19ldmVudGZkX2ZyZWUpOwogfQogCiB2b2lkIGlvX2V2ZW50ZmRfc2lnbmFsKHN0
cnVjdCBpb19yaW5nX2N0eCAqY3R4KQotLSAKMi40Ny4xCgo=

--------------bIxdxfVCrhwUGIPj53cDz4AV--

