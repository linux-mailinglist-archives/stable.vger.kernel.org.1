Return-Path: <stable+bounces-189793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F951C0AA08
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF4E3B06F2
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CA32DF706;
	Sun, 26 Oct 2025 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QfVNJejq"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B66F1547D2
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488863; cv=none; b=H1PZohr2yb0L5o2EKzJ7vbMRHCLc9Sypb+8SvXiY8haliQhNSC6tgXLZk6MakfdlDLlILsl27KP59qnktPmv9ez5CMzEO9yRLy1Ber21aW0ePsQW2TPspixk7Pm5ze8pg1BCK/jBlzlFyuwSPILKAVVVWB9n/Eo5xhYevQzboJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488863; c=relaxed/simple;
	bh=GWaZg6cgnGxm2jWHKUx4itKppyaj/g+NWmZHLumSl4Q=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=ICb2t6oLPq+/l6R04MFku0XpKVWAtQ+iN4w/6+XM9S/S2IZ6di1hWz311Qhg9kXs/saMb9wuuXhWWHL+CdJWSdmGSxDvaGXGFGHsVL5EjrHbO9R0Xlkyir8AtMzlQRrIYREqPSWAfRGrYUQ1q5WQf3wHgXeY5osgGq4Ir0QJyM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QfVNJejq; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-945a6c8721aso12395339f.0
        for <stable@vger.kernel.org>; Sun, 26 Oct 2025 07:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761488859; x=1762093659; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLARJInzXo0NYKYmjvIS0nSWoS/+1xandjkE5RE8+ZI=;
        b=QfVNJejqiHO2XxVAjoCwoFTv0jia7cyF5y8M1QBEMVF0vkpS3RI/Pc5tH6gTSfwSVh
         B++ljzujK/SlBEs5so9bf6UePopiPzn0owbsjoYTSvseExi4QeAeo3vx1cgV4YVf9SYs
         wLiJ6P0yKOgYFM9Uymvoek5FGYhpnbO+YPJYh8bGVIkGYWgs3I9LE5zLhnrHzXIFwX4U
         NRmK5pMsjiQtVv7/7guD52TK5C8V6mYc3S5MMOU87G4aVfO+6ElIDWAl0hQDSexj7hZY
         /6i/RGGq5Q9T1wCwj/AKHFlT+Kxp92Z/nsAvXGQJSfMUDwJDL3ehC6KNrvSfs9m7t35+
         lrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488859; x=1762093659;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tLARJInzXo0NYKYmjvIS0nSWoS/+1xandjkE5RE8+ZI=;
        b=AX0GuZnIIdoHRAhscmY+sOfQI3Bp8jCk6xkbXUTLpVhxZrDL99Th3Q1PU8M1a+MjU0
         3njkayMc5Q5JNFXVfwFUmcAq14tF3EaK6ChbN08FCL5/aWuB1aE8qpptWmllrgeceqJM
         bJyVbiCKE8INlCjNRfdHBpHEf1A9dAnu+yXRzKWBfVebgBB+ImlLFKB7MM229uDXbTCh
         lX8KPv4jGSsDS+lj7L1tNjoIbXle7fBJoLoPHNtDLwFXX8j+RXw8yWOqTk/05ErwxBs6
         Lsg8BWWydAK/rXJes82/z6/V2YY47jlnh+1GrBwn7ZZtDuwAD9M3jZYUlL0CNrdBHEFf
         unxQ==
X-Gm-Message-State: AOJu0YxNcp1fHgOxctXeUUD8ZqzrHGwzcPYgV9GHjRRkS1xvre/nqcDm
	lOGmqX6LJvxHUUvU385Dyr1PmFV9+GJTXvuLDl0m7GQhahAscNf30cBnFyYhvE0htjs=
X-Gm-Gg: ASbGnctra2wakIExM6JzPGi5L3bAOQINIOMg+6deIUzuywh3xK8pML3Jd/b7ZJt1ciL
	rgFPs/cdyKVpCjumueKFGAVbSN6WSLhcu1ta4TIm3QyvG+s+kXUElFx83SAeNsRFI2vUIV9q4Yx
	Sm3Ig+BdwP/G1LcgUGLflrNxoyune+063zcov+Ol80y5QG2CUl3IqV60MCqiuqyMY60mtt1UZMs
	4hTTmrHVP6H0L+KCdzwPw6gb8I/KZ6enbIWaYXij4JntYUkhMG6dDA7EpKa3J0pj7vgFbWeToAf
	wVWNDyNKCeKb/svmaK8twgk3lGJm/fiXnPhmBFvmVYI+P0wk58zByi0rkbPxo1xzaR5ctz9Pe+M
	Uth31AgeiPrX/g62EtUBorbmK4p9OkmPKxoQYLjEiZb4Ni4esgpk9T7Utswe/9xUwcDLh7HmOpE
	+kVpRCo4wd
X-Google-Smtp-Source: AGHT+IHNvd5DOgZl46jJGIgc1cujbkMuWwaGUbBCWftB1UaWz7CdB/NQ93DriQ9mTocWcPzp8zSwwQ==
X-Received: by 2002:a05:6e02:1fca:b0:430:ab63:69d6 with SMTP id e9e14a558f8ab-430c527dc00mr422161755ab.21.1761488859580;
        Sun, 26 Oct 2025 07:27:39 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea995d412sm1986569173.46.2025.10.26.07.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 07:27:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------Rciy02gCSVs2RZ8Kl0Wkj5Xq"
Message-ID: <f0056b81-512f-447c-9ac1-e41f66d5ee07@kernel.dk>
Date: Sun, 26 Oct 2025 08:27:37 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/sqpoll: switch away from
 getrusage() for CPU" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, krisman@suse.de
Cc: stable@vger.kernel.org
References: <2025102606-showplace-direness-c7b3@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025102606-showplace-direness-c7b3@gregkh>

This is a multi-part message in MIME format.
--------------Rciy02gCSVs2RZ8Kl0Wkj5Xq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/26/25 8:22 AM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x 8ac9b0d33e5c0a995338ee5f25fe1b6ff7d97f65
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102606-showplace-direness-c7b3@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Here's one for 6.12-stable, just needed some trivial fixups.

-- 
Jens Axboe

--------------Rciy02gCSVs2RZ8Kl0Wkj5Xq
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-sqpoll-switch-away-from-getrusage-for-CPU-a.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-sqpoll-switch-away-from-getrusage-for-CPU-a.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBiOWM3ZGEyM2JhMDdjNjc4MWUxM2Y5NzM5OGIyOTc5ZDJlYTYyMzBmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFR1ZSwgMjEgT2N0IDIwMjUgMDc6MTY6MDggLTA2MDAKU3ViamVjdDogW1BBVENIIDEv
Ml0gaW9fdXJpbmcvc3Fwb2xsOiBzd2l0Y2ggYXdheSBmcm9tIGdldHJ1c2FnZSgpIGZvciBD
UFUKIGFjY291bnRpbmcKCkNvbW1pdCA4YWM5YjBkMzNlNWMwYTk5NTMzOGVlNWYyNWZlMWI2
ZmY3ZDk3ZjY1IHVwc3RyZWFtLgoKZ2V0cnVzYWdlKCkgZG9lcyBhIGxvdCBtb3JlIHRoYW4g
d2hhdCB0aGUgU1FQT0xMIGFjY291bnRpbmcgbmVlZHMsIHRoZQpsYXR0ZXIgb25seSBjYXJl
cyBhYm91dCAoYW5kIHVzZXMpIHRoZSBzdGltZS4gUmF0aGVyIHRoYW4gZG8gYSBmdWxsClJV
U0FHRV9TRUxGIHN1bW1hdGlvbiwganVzdCBxdWVyeSB0aGUgdXNlZCBzdGltZSBpbnN0ZWFk
LgoKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKRml4ZXM6IDNmY2I5ZDE3MjA2ZSAoImlv
X3VyaW5nL3NxcG9sbDogc3RhdGlzdGljcyBvZiB0aGUgdHJ1ZSB1dGlsaXphdGlvbiBvZiBz
cSB0aHJlYWRzIikKUmV2aWV3ZWQtYnk6IEdhYnJpZWwgS3Jpc21hbiBCZXJ0YXppIDxrcmlz
bWFuQHN1c2UuZGU+ClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5k
az4KLS0tCiBpb191cmluZy9mZGluZm8uYyB8ICA4ICsrKystLS0tCiBpb191cmluZy9zcXBv
bGwuYyB8IDMyICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCiBpb191cmluZy9z
cXBvbGwuaCB8ICAxICsKIDMgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMTgg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvZmRpbmZvLmMgYi9pb191cmlu
Zy9mZGluZm8uYwppbmRleCBjNmM2MjRlYjk4NjYuLjVjMGEwMmJmZWI1NSAxMDA2NDQKLS0t
IGEvaW9fdXJpbmcvZmRpbmZvLmMKKysrIGIvaW9fdXJpbmcvZmRpbmZvLmMKQEAgLTU1LDcg
KzU1LDYgQEAgX19jb2xkIHZvaWQgaW9fdXJpbmdfc2hvd19mZGluZm8oc3RydWN0IHNlcV9m
aWxlICptLCBzdHJ1Y3QgZmlsZSAqZmlsZSkKIAlzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCA9
IGZpbGUtPnByaXZhdGVfZGF0YTsKIAlzdHJ1Y3QgaW9fb3ZlcmZsb3dfY3FlICpvY3FlOwog
CXN0cnVjdCBpb19yaW5ncyAqciA9IGN0eC0+cmluZ3M7Ci0Jc3RydWN0IHJ1c2FnZSBzcV91
c2FnZTsKIAl1bnNpZ25lZCBpbnQgc3FfbWFzayA9IGN0eC0+c3FfZW50cmllcyAtIDEsIGNx
X21hc2sgPSBjdHgtPmNxX2VudHJpZXMgLSAxOwogCXVuc2lnbmVkIGludCBzcV9oZWFkID0g
UkVBRF9PTkNFKHItPnNxLmhlYWQpOwogCXVuc2lnbmVkIGludCBzcV90YWlsID0gUkVBRF9P
TkNFKHItPnNxLnRhaWwpOwpAQCAtMTU1LDE0ICsxNTQsMTUgQEAgX19jb2xkIHZvaWQgaW9f
dXJpbmdfc2hvd19mZGluZm8oc3RydWN0IHNlcV9maWxlICptLCBzdHJ1Y3QgZmlsZSAqZmls
ZSkKIAkJICogdGhyZWFkIHRlcm1pbmF0aW9uLgogCQkgKi8KIAkJaWYgKHRzaykgeworCQkJ
dTY0IHVzZWM7CisKIAkJCWdldF90YXNrX3N0cnVjdCh0c2spOwogCQkJcmN1X3JlYWRfdW5s
b2NrKCk7Ci0JCQlnZXRydXNhZ2UodHNrLCBSVVNBR0VfU0VMRiwgJnNxX3VzYWdlKTsKKwkJ
CXVzZWMgPSBpb19zcV9jcHVfdXNlYyh0c2spOwogCQkJcHV0X3Rhc2tfc3RydWN0KHRzayk7
CiAJCQlzcV9waWQgPSBzcS0+dGFza19waWQ7CiAJCQlzcV9jcHUgPSBzcS0+c3FfY3B1Owot
CQkJc3FfdG90YWxfdGltZSA9IChzcV91c2FnZS5ydV9zdGltZS50dl9zZWMgKiAxMDAwMDAw
Ci0JCQkJCSArIHNxX3VzYWdlLnJ1X3N0aW1lLnR2X3VzZWMpOworCQkJc3FfdG90YWxfdGlt
ZSA9IHVzZWM7CiAJCQlzcV93b3JrX3RpbWUgPSBzcS0+d29ya190aW1lOwogCQl9IGVsc2Ug
ewogCQkJcmN1X3JlYWRfdW5sb2NrKCk7CmRpZmYgLS1naXQgYS9pb191cmluZy9zcXBvbGwu
YyBiL2lvX3VyaW5nL3NxcG9sbC5jCmluZGV4IDJmYWEzMDU4YjJkMC4uYWYyMzNiMmZhYjEw
IDEwMDY0NAotLS0gYS9pb191cmluZy9zcXBvbGwuYworKysgYi9pb191cmluZy9zcXBvbGwu
YwpAQCAtMTEsNiArMTEsNyBAQAogI2luY2x1ZGUgPGxpbnV4L2F1ZGl0Lmg+CiAjaW5jbHVk
ZSA8bGludXgvc2VjdXJpdHkuaD4KICNpbmNsdWRlIDxsaW51eC9jcHVzZXQuaD4KKyNpbmNs
dWRlIDxsaW51eC9zY2hlZC9jcHV0aW1lLmg+CiAjaW5jbHVkZSA8bGludXgvaW9fdXJpbmcu
aD4KIAogI2luY2x1ZGUgPHVhcGkvbGludXgvaW9fdXJpbmcuaD4KQEAgLTE3NSw2ICsxNzYs
MjAgQEAgc3RhdGljIGlubGluZSBib29sIGlvX3NxZF9ldmVudHNfcGVuZGluZyhzdHJ1Y3Qg
aW9fc3FfZGF0YSAqc3FkKQogCXJldHVybiBSRUFEX09OQ0Uoc3FkLT5zdGF0ZSk7CiB9CiAK
K3U2NCBpb19zcV9jcHVfdXNlYyhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzaykKK3sKKwl1NjQg
dXRpbWUsIHN0aW1lOworCisJdGFza19jcHV0aW1lX2FkanVzdGVkKHRzaywgJnV0aW1lLCAm
c3RpbWUpOworCWRvX2RpdihzdGltZSwgMTAwMCk7CisJcmV0dXJuIHN0aW1lOworfQorCitz
dGF0aWMgdm9pZCBpb19zcV91cGRhdGVfd29ya3RpbWUoc3RydWN0IGlvX3NxX2RhdGEgKnNx
ZCwgdTY0IHVzZWMpCit7CisJc3FkLT53b3JrX3RpbWUgKz0gaW9fc3FfY3B1X3VzZWMoY3Vy
cmVudCkgLSB1c2VjOworfQorCiBzdGF0aWMgaW50IF9faW9fc3FfdGhyZWFkKHN0cnVjdCBp
b19yaW5nX2N0eCAqY3R4LCBib29sIGNhcF9lbnRyaWVzKQogewogCXVuc2lnbmVkIGludCB0
b19zdWJtaXQ7CkBAIC0yNjEsMjYgKzI3NiwxNSBAQCBzdGF0aWMgYm9vbCBpb19zcV90d19w
ZW5kaW5nKHN0cnVjdCBsbGlzdF9ub2RlICpyZXRyeV9saXN0KQogCXJldHVybiByZXRyeV9s
aXN0IHx8ICFsbGlzdF9lbXB0eSgmdGN0eC0+dGFza19saXN0KTsKIH0KIAotc3RhdGljIHZv
aWQgaW9fc3FfdXBkYXRlX3dvcmt0aW1lKHN0cnVjdCBpb19zcV9kYXRhICpzcWQsIHN0cnVj
dCBydXNhZ2UgKnN0YXJ0KQotewotCXN0cnVjdCBydXNhZ2UgZW5kOwotCi0JZ2V0cnVzYWdl
KGN1cnJlbnQsIFJVU0FHRV9TRUxGLCAmZW5kKTsKLQllbmQucnVfc3RpbWUudHZfc2VjIC09
IHN0YXJ0LT5ydV9zdGltZS50dl9zZWM7Ci0JZW5kLnJ1X3N0aW1lLnR2X3VzZWMgLT0gc3Rh
cnQtPnJ1X3N0aW1lLnR2X3VzZWM7Ci0KLQlzcWQtPndvcmtfdGltZSArPSBlbmQucnVfc3Rp
bWUudHZfdXNlYyArIGVuZC5ydV9zdGltZS50dl9zZWMgKiAxMDAwMDAwOwotfQotCiBzdGF0
aWMgaW50IGlvX3NxX3RocmVhZCh2b2lkICpkYXRhKQogewogCXN0cnVjdCBsbGlzdF9ub2Rl
ICpyZXRyeV9saXN0ID0gTlVMTDsKIAlzdHJ1Y3QgaW9fc3FfZGF0YSAqc3FkID0gZGF0YTsK
IAlzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eDsKLQlzdHJ1Y3QgcnVzYWdlIHN0YXJ0OwogCXVu
c2lnbmVkIGxvbmcgdGltZW91dCA9IDA7CiAJY2hhciBidWZbVEFTS19DT01NX0xFTl07CiAJ
REVGSU5FX1dBSVQod2FpdCk7CisJdTY0IHN0YXJ0OwogCiAJLyogb2ZmbG9hZCBjb250ZXh0
IGNyZWF0aW9uIGZhaWxlZCwganVzdCBleGl0ICovCiAJaWYgKCFjdXJyZW50LT5pb191cmlu
ZykgewpAQCAtMzIzLDcgKzMyNyw3IEBAIHN0YXRpYyBpbnQgaW9fc3FfdGhyZWFkKHZvaWQg
KmRhdGEpCiAJCX0KIAogCQljYXBfZW50cmllcyA9ICFsaXN0X2lzX3Npbmd1bGFyKCZzcWQt
PmN0eF9saXN0KTsKLQkJZ2V0cnVzYWdlKGN1cnJlbnQsIFJVU0FHRV9TRUxGLCAmc3RhcnQp
OworCQlzdGFydCA9IGlvX3NxX2NwdV91c2VjKGN1cnJlbnQpOwogCQlsaXN0X2Zvcl9lYWNo
X2VudHJ5KGN0eCwgJnNxZC0+Y3R4X2xpc3QsIHNxZF9saXN0KSB7CiAJCQlpbnQgcmV0ID0g
X19pb19zcV90aHJlYWQoY3R4LCBjYXBfZW50cmllcyk7CiAKQEAgLTMzOSw3ICszNDMsNyBA
QCBzdGF0aWMgaW50IGlvX3NxX3RocmVhZCh2b2lkICpkYXRhKQogCiAJCWlmIChzcXRfc3Bp
biB8fCAhdGltZV9hZnRlcihqaWZmaWVzLCB0aW1lb3V0KSkgewogCQkJaWYgKHNxdF9zcGlu
KSB7Ci0JCQkJaW9fc3FfdXBkYXRlX3dvcmt0aW1lKHNxZCwgJnN0YXJ0KTsKKwkJCQlpb19z
cV91cGRhdGVfd29ya3RpbWUoc3FkLCBzdGFydCk7CiAJCQkJdGltZW91dCA9IGppZmZpZXMg
KyBzcWQtPnNxX3RocmVhZF9pZGxlOwogCQkJfQogCQkJaWYgKHVubGlrZWx5KG5lZWRfcmVz
Y2hlZCgpKSkgewpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvc3Fwb2xsLmggYi9pb191cmluZy9z
cXBvbGwuaAppbmRleCBiODNkY2RlYzk3NjUuLmZkMmY2ZjI5YjUxNiAxMDA2NDQKLS0tIGEv
aW9fdXJpbmcvc3Fwb2xsLmgKKysrIGIvaW9fdXJpbmcvc3Fwb2xsLmgKQEAgLTI5LDYgKzI5
LDcgQEAgdm9pZCBpb19zcV90aHJlYWRfdW5wYXJrKHN0cnVjdCBpb19zcV9kYXRhICpzcWQp
Owogdm9pZCBpb19wdXRfc3FfZGF0YShzdHJ1Y3QgaW9fc3FfZGF0YSAqc3FkKTsKIHZvaWQg
aW9fc3Fwb2xsX3dhaXRfc3Eoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgpOwogaW50IGlvX3Nx
cG9sbF93cV9jcHVfYWZmaW5pdHkoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgsIGNwdW1hc2tf
dmFyX3QgbWFzayk7Cit1NjQgaW9fc3FfY3B1X3VzZWMoc3RydWN0IHRhc2tfc3RydWN0ICp0
c2spOwogCiBzdGF0aWMgaW5saW5lIHN0cnVjdCB0YXNrX3N0cnVjdCAqc3Fwb2xsX3Rhc2tf
bG9ja2VkKHN0cnVjdCBpb19zcV9kYXRhICpzcWQpCiB7Ci0tIAoyLjUxLjAKCg==

--------------Rciy02gCSVs2RZ8Kl0Wkj5Xq--

