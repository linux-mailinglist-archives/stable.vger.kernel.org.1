Return-Path: <stable+bounces-134248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E89A929F2
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D44A21B64172
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505AA2566DB;
	Thu, 17 Apr 2025 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="F25rqqXa"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A405125525D
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915550; cv=none; b=qIc/EqCQYdf9ccjvV2HL+9CaDKuP2Mz79lNFSNWcq6MEMPRD6ROCmS0eGciGe3GCglxkfmdRzrF6l5F5gjpjgHjqIu4gz+s472Op4vsH6GKgBnAhhP8I0ZlKC2Fmg8Qo1Kpk6LTJAbFdSGEH56hGIiP1ahoDl2nDBvZ7OJVY/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915550; c=relaxed/simple;
	bh=HUJHXW6AycGh2ShvPQuvyO9Si6+2twLX+lvijeyvaCc=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=OwHzlzrJ22TJaEhLy8g9BiBbrOKOvJ0H8Z15J9T+437qF0wpyR9moJbooiWXcfAs1ylkKOzB1R5Fuwnav82cMmBPH8owYcwcRD203pqc2z+8GWEJoVeLFMRAdyuDZmvOHIvRexcvEV4Hj1cbtFNa64dPRfWMWKQEFyYpqsG3fAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=F25rqqXa; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-861b1f04b99so35423739f.0
        for <stable@vger.kernel.org>; Thu, 17 Apr 2025 11:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744915546; x=1745520346; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4Z2nxy25m4oEZrV44AxG67Sv5zFnnbMGXsDaIVA7h8=;
        b=F25rqqXa5XWdJxu7+yXBeCJbD0+DjAmerT8IYi/NZW0OnhV3XH4aWe4tpHNhG9ZgM9
         ugqOs1t6pO4J1I//xKBFyFd0IWMwg0vdb71GoXzY9Yt+v+9ucRweeV0tRgVvJzngju3q
         ok/xdnuYjPPYrMtB+Mqt3mSRm9QEudGdf8VeTVFcYg10H0vvOq8HXZNxiPYnehKCX6Kh
         9JyCvashY0vhDlMygriiLfybEQHyPv3naGTfykjsUbB25LoQ4mN9sZcvoH+5u7BGJ+L3
         YxJPYHINueO+PnC3LXwwYUNO/4OgPrXUoAL6XM1m9hZIGBabV/0+TH33mtZ50OY5hrSw
         rjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744915546; x=1745520346;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p4Z2nxy25m4oEZrV44AxG67Sv5zFnnbMGXsDaIVA7h8=;
        b=gu4bFjfSfkEAydE+4zw2bH2jabhWqfUaexYLAQtrDvE5uube4do/xT0wc2KEvzcFNR
         mL8ZVM7sh3OYgZuPxaEH8LJra7bSpKbUDp2gSRGrCZSRs4r5UARO2b+gQH6CkbATvV6Q
         HwhT7hPVHiYEfJRDsIc6/fEOLCGpBJ/t6WFWAzsAS5n8JET6vsdg3g42UCJNarRtHxNt
         BFev96W//+3T1sIhvoa8xyKeAq9b8Ov+l5Y+FTkpSsM6pGx/QSCkbQPMgtHI+dX+F5+u
         kwNOF5cO+BSJqNpwN7Jxa58zdnmvymA2I//EPXADBKqZZILQkq/ElodL2jahZUENxrhk
         AwXQ==
X-Gm-Message-State: AOJu0YxPin7LAVKkNH0ePKXLchYfkd7n3ZeOIlK0NqtR9W0lJwAzMhHF
	ZAkmwc1CoF/Hw0p9OJECTBWmWyrklG3T5Jp8BSNx7s+QIPwkIem5Grr9iCWnt5DgrXVKDk2gqzz
	e
X-Gm-Gg: ASbGncu/ggEVRVU84J9v2QBMoWQJA7NKnd6yM3Q8YPkJx6OqLR5YkRYRms5r5feAPwu
	bhdQjJfPt/S+sSEj4QVKsVOdv7MdVKhEQiCeZSOjrLc+m4U05+KnfhgjE1YssqcbugIBph8uQVA
	zoUMOO5JWE8581I8P04E8IrYo+BhJdt6dn9d9cEL0j/0tqe+ILLy54TRacJ8Vdk8QqZ8M2gFCm6
	8wOEpY0bRMdO1douUEBtJL0l6mtx6nzcq9RNhH9k7tzV8w2YIK1QjtpuTjdTYPglcBQm1oYmMx1
	tk+683hS1Ai5v4+ucaTNio1GFPmmV7MeRsZKbA==
X-Google-Smtp-Source: AGHT+IGNtvoaIZ/OCGzA0l8dOLAa7GJNPquLmxS+Hf0An37oeu7X9lB3y6eyQxaNTbnj+QBbxguYGQ==
X-Received: by 2002:a05:6602:3942:b0:85b:3fda:7dbf with SMTP id ca18e2360f4ac-861c57bcb8emr802674339f.9.1744915546614;
        Thu, 17 Apr 2025 11:45:46 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-861d98dcbd4sm5068039f.31.2025.04.17.11.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 11:45:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------lHhOr8uaKRjqP3TrFzcvZ0F9"
Message-ID: <6bf72a95-ef71-432b-ab81-9ebc0110d493@kernel.dk>
Date: Thu, 17 Apr 2025 12:45:45 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: don't post tag CQEs on
 file/buffer registration" failed to apply to 6.13-stable tree
To: gregkh@linuxfoundation.org, asml.silence@gmail.com
Cc: stable@vger.kernel.org
References: <2025041712-bribe-portly-c54b@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025041712-bribe-portly-c54b@gregkh>

This is a multi-part message in MIME format.
--------------lHhOr8uaKRjqP3TrFzcvZ0F9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 4:47 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.13-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:

This one will apply to both the 6.13 and 6.14 stable branches, can
you pick it up for both? Thanks!

-- 
Jens Axboe

--------------lHhOr8uaKRjqP3TrFzcvZ0F9
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-don-t-post-tag-CQEs-on-file-buffer-registra.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-don-t-post-tag-CQEs-on-file-buffer-registra.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBkZDQ4ZGE2ZGUyMDNkNjdhM2Y5ZGIyYzZiNWVjNWRhYzA3MDJhZTI1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXZlbCBCZWd1bmtvdiA8YXNtbC5zaWxlbmNlQGdt
YWlsLmNvbT4KRGF0ZTogRnJpLCA0IEFwciAyMDI1IDE1OjQ2OjM0ICswMTAwClN1YmplY3Q6
IFtQQVRDSF0gaW9fdXJpbmc6IGRvbid0IHBvc3QgdGFnIENRRXMgb24gZmlsZS9idWZmZXIg
cmVnaXN0cmF0aW9uCiBmYWlsdXJlCgpDb21taXQgYWI2MDA1ZjM5MTJmZmYwNzMzMDI5N2Fi
YTA4OTIyZDI0NTZkY2VkZSB1cHN0cmVhbS4KCkJ1ZmZlciAvIGZpbGUgdGFibGUgcmVnaXN0
cmF0aW9uIGlzIGFsbCBvciBub3RoaW5nLCBpZiBpdCBmYWlscyBhbGwKcmVzb3VyY2VzIHdl
IG1pZ2h0IGhhdmUgcGFydGlhbGx5IHJlZ2lzdGVyZWQgYXJlIGRyb3BwZWQgYW5kIHRoZSB0
YWJsZQppcyBraWxsZWQuIElmIHRoYXQgaGFwcGVucywgaXQgZG9lc24ndCBtYWtlIHNlbnNl
IHRvIHBvc3QgYW55IHJzcmMgdGFnCkNRRXMuIFRoYXQgd291bGQgYmUgY29uZnVzaW5nIHRv
IHRoZSBhcHBsaWNhdGlvbiwgd2hpY2ggc2hvdWxkIG5vdCBuZWVkCnRvIGhhbmRsZSB0aGF0
IGNhc2UuCgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBQYXZl
bCBCZWd1bmtvdiA8YXNtbC5zaWxlbmNlQGdtYWlsLmNvbT4KRml4ZXM6IDcwMjlhY2Q4YTk1
MDMgKCJpb191cmluZy9yc3JjOiBnZXQgcmlkIG9mIHBlci1yaW5nIGlvX3JzcmNfbm9kZSBs
aXN0IikKTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci9jNTE0NDQ2YThkY2IwMTk3
Y2RkZDVkNGJhOGY2NTExZGEwODFjZjFmLjE3NDM3Nzc5NTcuZ2l0LmFzbWwuc2lsZW5jZUBn
bWFpbC5jb20KU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPgot
LS0KIGlvX3VyaW5nL3JzcmMuYyB8IDE3ICsrKysrKysrKysrKysrKystCiAxIGZpbGUgY2hh
bmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2lv
X3VyaW5nL3JzcmMuYyBiL2lvX3VyaW5nL3JzcmMuYwppbmRleCBjYzU4ZGVmZDg4ZDQuLmQ4
ZGE1YWQxZDM2YiAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvcnNyYy5jCisrKyBiL2lvX3VyaW5n
L3JzcmMuYwpAQCAtMTMwLDYgKzEzMCwxOCBAQCBzdHJ1Y3QgaW9fcnNyY19ub2RlICppb19y
c3JjX25vZGVfYWxsb2Moc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgsIGludCB0eXBlKQogCXJl
dHVybiBub2RlOwogfQogCitzdGF0aWMgdm9pZCBpb19jbGVhcl90YWJsZV90YWdzKHN0cnVj
dCBpb19yc3JjX2RhdGEgKmRhdGEpCit7CisJaW50IGk7CisKKwlmb3IgKGkgPSAwOyBpIDwg
ZGF0YS0+bnI7IGkrKykgeworCQlzdHJ1Y3QgaW9fcnNyY19ub2RlICpub2RlID0gZGF0YS0+
bm9kZXNbaV07CisKKwkJaWYgKG5vZGUpCisJCQlub2RlLT50YWcgPSAwOworCX0KK30KKwog
X19jb2xkIHZvaWQgaW9fcnNyY19kYXRhX2ZyZWUoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgs
IHN0cnVjdCBpb19yc3JjX2RhdGEgKmRhdGEpCiB7CiAJaWYgKCFkYXRhLT5ucikKQEAgLTU0
MSw2ICs1NTMsNyBAQCBpbnQgaW9fc3FlX2ZpbGVzX3JlZ2lzdGVyKHN0cnVjdCBpb19yaW5n
X2N0eCAqY3R4LCB2b2lkIF9fdXNlciAqYXJnLAogCWlvX2ZpbGVfdGFibGVfc2V0X2FsbG9j
X3JhbmdlKGN0eCwgMCwgY3R4LT5maWxlX3RhYmxlLmRhdGEubnIpOwogCXJldHVybiAwOwog
ZmFpbDoKKwlpb19jbGVhcl90YWJsZV90YWdzKCZjdHgtPmZpbGVfdGFibGUuZGF0YSk7CiAJ
aW9fc3FlX2ZpbGVzX3VucmVnaXN0ZXIoY3R4KTsKIAlyZXR1cm4gcmV0OwogfQpAQCAtODU4
LDggKzg3MSwxMCBAQCBpbnQgaW9fc3FlX2J1ZmZlcnNfcmVnaXN0ZXIoc3RydWN0IGlvX3Jp
bmdfY3R4ICpjdHgsIHZvaWQgX191c2VyICphcmcsCiAJfQogCiAJY3R4LT5idWZfdGFibGUg
PSBkYXRhOwotCWlmIChyZXQpCisJaWYgKHJldCkgeworCQlpb19jbGVhcl90YWJsZV90YWdz
KCZjdHgtPmJ1Zl90YWJsZSk7CiAJCWlvX3NxZV9idWZmZXJzX3VucmVnaXN0ZXIoY3R4KTsK
Kwl9CiAJcmV0dXJuIHJldDsKIH0KIAotLSAKMi40OS4wCgo=

--------------lHhOr8uaKRjqP3TrFzcvZ0F9--

