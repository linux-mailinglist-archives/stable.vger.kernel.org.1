Return-Path: <stable+bounces-210361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B1BD3AC62
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 15:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5B61301E20F
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 14:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AF423ABBD;
	Mon, 19 Jan 2026 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bpFLHMub"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC8C236437
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833297; cv=none; b=d/JeNbVBnxDRDNTUAb9WG/qe7VLknOp0fhH+LU0H8SvXYmr4GmvsK0qvL4OflnHJtaULKC6cVaatuEnRDPknTzfClznraJLExkrKSojF9ayY8CmTaWB5tjBC32Is5RydfrzCzdl4o/vIiw2PN9kQ+R0917diiUd8Tq1m0g6QnY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833297; c=relaxed/simple;
	bh=ErpmyCRDhaNeApX9tefbEgk35lKxS12f4ouCrfojMWM=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=tPh4tvPc+hpONk6qwH39k11KDiJf5hpmbnk4pf/CpMHTXitIq5ARG4+BKMLDU90DzxAC2obI0m9QD1ZOwzrCqwHRx3P9OhpKNF92KtCD1LKGKU1KMTBPzXictmbReuYK7B+dyV326ulQzYFLcvA2QJrYntET1c8q29ELlhx2DhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bpFLHMub; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-404308dd5d6so1825204fac.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 06:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768833293; x=1769438093; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Xy8F08jkkm1eQhNSxAtuzCmDgrshKRVHjJLSMRgIHA=;
        b=bpFLHMubSdkWsNIJze6pQze+cWMFasewyEQ2lOnOaN4V6Byn49pRskL0kZ84y28b6t
         T6PJP0m4ziUk0yPOftoN7P4E01FwQ2ADNauMIQd5wEIQgGpP7czmip6QcIfj/6OXIb1F
         1Yv/Yv4a4Dw2m/co3g1E4iqeTNywA40NcvsMfxT7Fdd2BjuEPqdz5Amb5sQEiyK1a4/w
         3tE432cFFN1lPMZ5H2q6t9m48MA2QfSQKuVvevQVmSYf+qCgwejaRhay5XBZVoVFcAu3
         cAjxLZ24qFF1waH0ktwXEEIbcZDSztiloowmrV0T031qvIXXMSVT2zeoSVz0FPLLZowk
         65CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768833293; x=1769438093;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Xy8F08jkkm1eQhNSxAtuzCmDgrshKRVHjJLSMRgIHA=;
        b=aMJogYh2tqUeIyvAdXsj/2g2wrveolQuxRmnA8cfG0xlKy0Ins/PBfsrjiUNaVCh4q
         CKAtTfFHoGUbomIxxHWQo+yq/C0axnn2o+qxdawngIgUpV4OClXYBqSRx4/yZ3awLk63
         u3pSxTlbFhCT6vUuxbBs//Jo+HmY8AH/N6bgQoo4pN8U76qlQ3QVCinvH+cpV2xXoYvG
         DHvDQvjnRwpTZCv+/7/Q/9tPHITZPfiX9CtFnbQcrjaltkZl64FCt0thVBoH0rR/l+XV
         CC8Q0GkfpZ6dD32rn6xwIlQEQc/mZ2ftWOhKu2bjF1kOIXtx2auPbJc6tBBGSiIAMKK0
         jbmQ==
X-Gm-Message-State: AOJu0Yw5aPKbC8Cy4De++Pb082bz/9QPGTroWpM8aqjVUt+7T5JtjYv/
	4tvsp+N2kQnkCWh4l76iAWu4xEy2isErtoonfDbl2wuMTvNYFybjqgvPUA5InxEGuAU=
X-Gm-Gg: AZuq6aLfTFjTvMCdWM4T1YpmvrMkWnSsThcyfXtfOzjoce9ZaH5R3yYIGNxCS3OMwjR
	c4+DfWTsy2imbBkir5PDiICRbf6W3KiFahmBOCGQ2+cyBA+ZvLmL20PFa1/y/+HW7H1jayMWKuT
	5MGpdN9PujcYEMiKErAroQBL+DvJbie/woshVE27lZwG+Rma8Xl1XPDoPjfFNRWOCn3RNR4ni/i
	A9MxSnrI0B38G60INfwI8ZjUJXqekUNXa6B5EScX4dIjHVRR0bMxYjTqIfVxB2q5OzHcJ/AH9VV
	0R0w5f+/pDfQ7ZsuIouUiDLrXwMdGFEgoQF87b2VQsRqkYVik1dhfnukn0tVJKghjcjMt3/5yGj
	qdI9OtkA80wmeA20jnkMQn6iuAVsEyBhHqcCW6ZFU7NtT/dH/hQ/UudV28zeCevSrWvY6bgjwwB
	nxLP8UwExrtFWFw9HV5NDAlbaR2a0/CxPDjOOsfpD2QBWahleWO7igs5oEddfh4JWvng3hRA==
X-Received: by 2002:a05:6870:ec92:b0:3fd:a9f3:a66f with SMTP id 586e51a60fabf-4044ce2ddd1mr6444987fac.14.1768833293459;
        Mon, 19 Jan 2026 06:34:53 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bd5d988sm6835475fac.18.2026.01.19.06.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:34:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------amEdN9J1equc9Tkjn01OEta8"
Message-ID: <6a690ac5-1bee-444f-8ff1-4a9d67a0ba8e@kernel.dk>
Date: Mon, 19 Jan 2026 07:34:51 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: move local task_work in exit
 cancel loop" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org, ming.lei@redhat.com
Cc: stable@vger.kernel.org
References: <2026011957-earful-capillary-a00a@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026011957-earful-capillary-a00a@gregkh>

This is a multi-part message in MIME format.
--------------amEdN9J1equc9Tkjn01OEta8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/26 4:47 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x da579f05ef0faada3559e7faddf761c75cdf85e1
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026011957-earful-capillary-a00a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

And here's one for 6.1-stable.

-- 
Jens Axboe

--------------amEdN9J1equc9Tkjn01OEta8
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-move-local-task_work-in-exit-cancel-loop.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-move-local-task_work-in-exit-cancel-loop.patch"
Content-Transfer-Encoding: base64

RnJvbSBiZTBkZDE2MjhlNDk2MDhlNTJhZGFlYzZhOTRjNDk1NjcwMmVlZGQ0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNaW5nIExlaSA8bWluZy5sZWlAcmVkaGF0LmNvbT4K
RGF0ZTogV2VkLCAxNCBKYW4gMjAyNiAxNjo1NDowNSArMDgwMApTdWJqZWN0OiBbUEFUQ0hd
IGlvX3VyaW5nOiBtb3ZlIGxvY2FsIHRhc2tfd29yayBpbiBleGl0IGNhbmNlbCBsb29wCgpD
b21taXQgZGE1NzlmMDVlZjBmYWFkYTM1NTllN2ZhZGRmNzYxYzc1Y2RmODVlMSB1cHN0cmVh
bS4KCldpdGggSU9SSU5HX1NFVFVQX0RFRkVSX1RBU0tSVU4sIHRhc2sgd29yayBpcyBxdWV1
ZWQgdG8gY3R4LT53b3JrX2xsaXN0Cihsb2NhbCB3b3JrKSByYXRoZXIgdGhhbiB0aGUgZmFs
bGJhY2sgbGlzdC4gRHVyaW5nIGlvX3JpbmdfZXhpdF93b3JrKCksCmlvX21vdmVfdGFza193
b3JrX2Zyb21fbG9jYWwoKSB3YXMgY2FsbGVkIG9uY2UgYmVmb3JlIHRoZSBjYW5jZWwgbG9v
cCwKbW92aW5nIHdvcmsgZnJvbSB3b3JrX2xsaXN0IHRvIGZhbGxiYWNrX2xsaXN0LgoKSG93
ZXZlciwgdGFzayB3b3JrIGNhbiBiZSBhZGRlZCB0byB3b3JrX2xsaXN0IGR1cmluZyB0aGUg
Y2FuY2VsIGxvb3AKaXRzZWxmLiBUaGVyZSBhcmUgdHdvIGNhc2VzOgoKMSkgaW9fa2lsbF90
aW1lb3V0cygpIGlzIGNhbGxlZCBmcm9tIGlvX3VyaW5nX3RyeV9jYW5jZWxfcmVxdWVzdHMo
KSB0bwpjYW5jZWwgcGVuZGluZyB0aW1lb3V0cywgYW5kIGl0IGFkZHMgdGFzayB3b3JrIHZp
YSBpb19yZXFfcXVldWVfdHdfY29tcGxldGUoKQpmb3IgZWFjaCBjYW5jZWxsZWQgdGltZW91
dDoKCjIpIFVSSU5HX0NNRCByZXF1ZXN0cyBsaWtlIHVibGsgY2FuIGJlIGNvbXBsZXRlZCB2
aWEKaW9fdXJpbmdfY21kX2NvbXBsZXRlX2luX3Rhc2soKSBmcm9tIHVibGtfcXVldWVfcnEo
KSBkdXJpbmcgY2FuY2VsaW5nLApnaXZlbiB1YmxrIHJlcXVlc3QgcXVldWUgaXMgb25seSBx
dWllc2NlZCB3aGVuIGNhbmNlbGluZyB0aGUgMXN0IHVyaW5nX2NtZC4KClNpbmNlIGlvX2Fs
bG93ZWRfZGVmZXJfdHdfcnVuKCkgcmV0dXJucyBmYWxzZSBpbiBpb19yaW5nX2V4aXRfd29y
aygpCihrd29ya2VyICE9IHN1Ym1pdHRlcl90YXNrKSwgaW9fcnVuX2xvY2FsX3dvcmsoKSBp
cyBuZXZlciBpbnZva2VkLAphbmQgdGhlIHdvcmtfbGxpc3QgZW50cmllcyBhcmUgbmV2ZXIg
cHJvY2Vzc2VkLiBUaGlzIGNhdXNlcwppb191cmluZ190cnlfY2FuY2VsX3JlcXVlc3RzKCkg
dG8gbG9vcCBpbmRlZmluaXRlbHksIHJlc3VsdGluZyBpbgoxMDAlIENQVSB1c2FnZSBpbiBr
d29ya2VyIHRocmVhZHMuCgpGaXggdGhpcyBieSBtb3ZpbmcgaW9fbW92ZV90YXNrX3dvcmtf
ZnJvbV9sb2NhbCgpIGluc2lkZSB0aGUgY2FuY2VsCmxvb3AsIGVuc3VyaW5nIGFueSB3b3Jr
IG9uIHdvcmtfbGxpc3QgaXMgbW92ZWQgdG8gZmFsbGJhY2sgYmVmb3JlCmVhY2ggY2FuY2Vs
IGF0dGVtcHQuCgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpGaXhlczogYzBlMGQ2YmEy
NWYxICgiaW9fdXJpbmc6IGFkZCBJT1JJTkdfU0VUVVBfREVGRVJfVEFTS1JVTiIpClNpZ25l
ZC1vZmYtYnk6IE1pbmcgTGVpIDxtaW5nLmxlaUByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5
OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CihjaGVycnkgcGlja2VkIGZyb20gY29t
bWl0IGRhNTc5ZjA1ZWYwZmFhZGEzNTU5ZTdmYWRkZjc2MWM3NWNkZjg1ZTEpCi0tLQogaW9f
dXJpbmcvaW9fdXJpbmcuYyB8IDggKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvaW9fdXJp
bmcuYyBiL2lvX3VyaW5nL2lvX3VyaW5nLmMKaW5kZXggMmFhZTBkZTYxNjljLi5kMGQ5ZmY2
Yjg3YTAgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL2lvX3VyaW5nLmMKKysrIGIvaW9fdXJpbmcv
aW9fdXJpbmcuYwpAQCAtMjg2NywxMSArMjg2NywxMSBAQCBzdGF0aWMgX19jb2xkIHZvaWQg
aW9fcmluZ19leGl0X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCSAqIGFzIG5v
Ym9keSBlbHNlIHdpbGwgYmUgbG9va2luZyBmb3IgdGhlbS4KIAkgKi8KIAlkbyB7Ci0JCWlm
IChjdHgtPmZsYWdzICYgSU9SSU5HX1NFVFVQX0RFRkVSX1RBU0tSVU4pCi0JCQlpb19tb3Zl
X3Rhc2tfd29ya19mcm9tX2xvY2FsKGN0eCk7Ci0KLQkJd2hpbGUgKGlvX3VyaW5nX3RyeV9j
YW5jZWxfcmVxdWVzdHMoY3R4LCBOVUxMLCB0cnVlKSkKKwkJZG8geworCQkJaWYgKGN0eC0+
ZmxhZ3MgJiBJT1JJTkdfU0VUVVBfREVGRVJfVEFTS1JVTikKKwkJCQlpb19tb3ZlX3Rhc2tf
d29ya19mcm9tX2xvY2FsKGN0eCk7CiAJCQljb25kX3Jlc2NoZWQoKTsKKwkJfSB3aGlsZSAo
aW9fdXJpbmdfdHJ5X2NhbmNlbF9yZXF1ZXN0cyhjdHgsIE5VTEwsIHRydWUpKTsKIAogCQlp
ZiAoY3R4LT5zcV9kYXRhKSB7CiAJCQlzdHJ1Y3QgaW9fc3FfZGF0YSAqc3FkID0gY3R4LT5z
cV9kYXRhOwotLSAKMi41MS4wCgo=

--------------amEdN9J1equc9Tkjn01OEta8--

