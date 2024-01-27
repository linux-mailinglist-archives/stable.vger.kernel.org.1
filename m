Return-Path: <stable+bounces-16067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77CF83EACD
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 05:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE481C231C2
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 04:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B34D11CAD;
	Sat, 27 Jan 2024 04:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="B+7OOKQW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD2E11C80
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 04:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706328094; cv=none; b=qkmrtxd8uJZVC+FjtWQQPJwvMsmjEkEmG0OI9ncDAC4PP1cURrAkaMoXWW4/zhoSUxIOMPP7oCNYvLrzpZJcm3sicihhgxNj8XoVoeQRC/rRxgKvh2l+fl3xshxu4FY2zfJkerJxPjYi9imslDearbzNMTs93PDNUl9BxLR+w9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706328094; c=relaxed/simple;
	bh=MSOfOCDtoVHev4R16/nvMZVnLQ8MtaXoFPLdDNIr9yk=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=tYexNF6H04tR6KrNSNP4TXH8Trn9znMCZCfASV9SLy5E0B8omXhdaGA2mBLlNwzadOn0iY1T1x3Rl93dgnxdMKaJy3WvLQgojQZvbwU7ZWlQg35ko+qJBwP7jaUPsrrTfNBYF6U09xifDqrA07+2bNCfcEsEfekLx9irxfxow2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=B+7OOKQW; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d862e8b163so251290a12.1
        for <stable@vger.kernel.org>; Fri, 26 Jan 2024 20:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706328088; x=1706932888; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ho3cvxJ26eYHb5EXWjmwjDSlfaMuOpb158na95QKvO8=;
        b=B+7OOKQWeCtG1Nn+d5viSqPxesaBvKV5cCQOpdSN5iEOpTeZvlJFfqxrWdfMCfQxkr
         esnaj1OL6BzPdr0SjEASQnis8F8sxTCJvBnXtosuCDSA25zQH5TMZ2izqrR0mZ9O+8Tr
         JtFqnrJANZExUCue/J8ITOApoxVFUhJhYdA7IWGNw0hXhZUjChbKLzkk8oxDsWOMyIc6
         EuH7RRSXPQaKLgQKrG83JO8HH23woV1IN2uARynCqqQuFZLNH9XmcnJIyBmwpnMLlNmP
         KETnUTrKYH0Mmufa82O6XHD3E24cfl/sx2NgZQdcLwEIh79Yf35KjIU9xh5lokCBxVnC
         VFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706328088; x=1706932888;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ho3cvxJ26eYHb5EXWjmwjDSlfaMuOpb158na95QKvO8=;
        b=s+x3JqAGrIEG8iYlGXx918wQ7HsRDr7ewTp0NIOkKDIZWUiU9BpDLw572oZDWswDJC
         0oMS91BJR1HXD10G0xXf+6Rnz5i/bFN6q0mdbln5se11O3zltyvWyV2bK6jQnQe/FGGs
         cUQpE/b1Qo+kIM3OAXVj9kpwIBzjx/qkSA9O/KyOXI0YwvtGfEhPoPou6lkvAieeKcn1
         85QtZktJf9OB3FCTO37kx4xIHflRlPpGbmg3U/E6sIwvMQYpoKjypEjGH9FRSKCHyITm
         yltMhkea+vB2QRg0JDXpYXU4b+0fumKoaXswvJ8eXr/yvupwNZghfroqprwhPh7TPVVX
         9hGA==
X-Gm-Message-State: AOJu0Yw/dm86HC7ASR/qDmeanC5QK/ZGsQlLQPuvjdTq1vkFrJjP47AB
	IeqqKscTfLQ2LucpbtWaclaoW29XLHoTfsf7JmCQydzqVC21Yps+ieUVdt1pFJ4=
X-Google-Smtp-Source: AGHT+IFnrv/HVif4KwMFodOFmkp92B880vTzUm/0RPLBXiE7XSlOvQ8YMICGiJh+ybtWZ/N9oDKRwQ==
X-Received: by 2002:a05:6a00:db:b0:6da:736d:67c8 with SMTP id e27-20020a056a0000db00b006da736d67c8mr1553436pfj.3.1706328088316;
        Fri, 26 Jan 2024 20:01:28 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id r6-20020a056a00216600b006dbd79596f3sm1839543pff.160.2024.01.26.20.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 20:01:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------0ovr0XFVvV6DnP72QJ4yscGS"
Message-ID: <4902c3e8-2376-44c1-9649-244041b8f259@kernel.dk>
Date: Fri, 26 Jan 2024 21:01:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] nbd: always initialize struct msghdr
 completely" failed to apply to 6.1-stable tree
Content-Language: en-US
To: gregkh@linuxfoundation.org, edumazet@google.com, horms@kernel.org,
 josef@toxicpanda.com, syzkaller@googlegroups.com
Cc: stable@vger.kernel.org
References: <2024012655-dwelled-unlinked-8b2c@gregkh>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024012655-dwelled-unlinked-8b2c@gregkh>

This is a multi-part message in MIME format.
--------------0ovr0XFVvV6DnP72QJ4yscGS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/26/24 3:14 PM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x 78fbb92af27d0982634116c7a31065f24d092826
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012655-dwelled-unlinked-8b2c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Here's the patch for 6.1-stable.

-- 
Jens Axboe


--------------0ovr0XFVvV6DnP72QJ4yscGS
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-nbd-always-initialize-struct-msghdr-completely.patch"
Content-Disposition: attachment;
 filename*0="0001-nbd-always-initialize-struct-msghdr-completely.patch"
Content-Transfer-Encoding: base64

RnJvbSA1M2E1YTA1MTk1NTE2Mjc0ZTM3ZWJlZmEwMjNiY2FlZjAwM2ExZGE0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5j
b20+CkRhdGU6IEZyaSwgMjYgSmFuIDIwMjQgMjA6NTk6MDggLTA3MDAKU3ViamVjdDogW1BB
VENIXSBuYmQ6IGFsd2F5cyBpbml0aWFsaXplIHN0cnVjdCBtc2doZHIgY29tcGxldGVseQoK
Y29tbWl0IDc4ZmJiOTJhZjI3ZDA5ODI2MzQxMTZjN2EzMTA2NWYyNGQwOTI4MjYgdXBzdHJl
YW0uCgpzeXpib3QgY29tcGxhaW5zIHRoYXQgbXNnLT5tc2dfZ2V0X2lucSB2YWx1ZSBjYW4g
YmUgdW5pbml0aWFsaXplZCBbMV0KCnN0cnVjdCBtc2doZHIgZ290IG1hbnkgbmV3IGZpZWxk
cyByZWNlbnRseSwgd2Ugc2hvdWxkIGFsd2F5cyBtYWtlCnN1cmUgdGhlaXIgdmFsdWVzIGlz
IHplcm8gYnkgZGVmYXVsdC4KClsxXQogQlVHOiBLTVNBTjogdW5pbml0LXZhbHVlIGluIHRj
cF9yZWN2bXNnKzB4Njg2LzB4YWMwIG5ldC9pcHY0L3RjcC5jOjI1NzEKICB0Y3BfcmVjdm1z
ZysweDY4Ni8weGFjMCBuZXQvaXB2NC90Y3AuYzoyNTcxCiAgaW5ldF9yZWN2bXNnKzB4MTMx
LzB4NTgwIG5ldC9pcHY0L2FmX2luZXQuYzo4NzkKICBzb2NrX3JlY3Ztc2dfbm9zZWMgbmV0
L3NvY2tldC5jOjEwNDQgW2lubGluZV0KICBzb2NrX3JlY3Ztc2crMHgxMmIvMHgxZTAgbmV0
L3NvY2tldC5jOjEwNjYKICBfX3NvY2tfeG1pdCsweDIzNi8weDVjMCBkcml2ZXJzL2Jsb2Nr
L25iZC5jOjUzOAogIG5iZF9yZWFkX3JlcGx5IGRyaXZlcnMvYmxvY2svbmJkLmM6NzMyIFtp
bmxpbmVdCiAgcmVjdl93b3JrKzB4MjYyLzB4MzEwMCBkcml2ZXJzL2Jsb2NrL25iZC5jOjg2
MwogIHByb2Nlc3Nfb25lX3dvcmsga2VybmVsL3dvcmtxdWV1ZS5jOjI2MjcgW2lubGluZV0K
ICBwcm9jZXNzX3NjaGVkdWxlZF93b3JrcysweDEwNGUvMHgxZTcwIGtlcm5lbC93b3JrcXVl
dWUuYzoyNzAwCiAgd29ya2VyX3RocmVhZCsweGY0NS8weDE0OTAga2VybmVsL3dvcmtxdWV1
ZS5jOjI3ODEKICBrdGhyZWFkKzB4M2VkLzB4NTQwIGtlcm5lbC9rdGhyZWFkLmM6Mzg4CiAg
cmV0X2Zyb21fZm9yaysweDY2LzB4ODAgYXJjaC94ODYva2VybmVsL3Byb2Nlc3MuYzoxNDcK
ICByZXRfZnJvbV9mb3JrX2FzbSsweDExLzB4MjAgYXJjaC94ODYvZW50cnkvZW50cnlfNjQu
UzoyNDIKCkxvY2FsIHZhcmlhYmxlIG1zZyBjcmVhdGVkIGF0OgogIF9fc29ja194bWl0KzB4
NGMvMHg1YzAgZHJpdmVycy9ibG9jay9uYmQuYzo1MTMKICBuYmRfcmVhZF9yZXBseSBkcml2
ZXJzL2Jsb2NrL25iZC5jOjczMiBbaW5saW5lXQogIHJlY3Zfd29yaysweDI2Mi8weDMxMDAg
ZHJpdmVycy9ibG9jay9uYmQuYzo4NjMKCkNQVTogMSBQSUQ6IDc0NjUgQ29tbToga3dvcmtl
ci91NToxIE5vdCB0YWludGVkIDYuNy4wLXJjNy1zeXprYWxsZXItMDAwNDEtZ2YwMTZmNzU0
N2FlZSAjMApIYXJkd2FyZSBuYW1lOiBHb29nbGUgR29vZ2xlIENvbXB1dGUgRW5naW5lL0dv
b2dsZSBDb21wdXRlIEVuZ2luZSwgQklPUyBHb29nbGUgMTEvMTcvMjAyMwpXb3JrcXVldWU6
IG5iZDUtcmVjdiByZWN2X3dvcmsKCkZpeGVzOiBmOTRmZDI1Y2IwYWEgKCJ0Y3A6IHBhc3Mg
YmFjayBkYXRhIGxlZnQgaW4gc29ja2V0IGFmdGVyIHJlY2VpdmUiKQpSZXBvcnRlZC1ieTog
c3l6Ym90IDxzeXprYWxsZXJAZ29vZ2xlZ3JvdXBzLmNvbT4KU2lnbmVkLW9mZi1ieTogRXJp
YyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPgpDYzogc3RhYmxlQHZnZXIua2VybmVs
Lm9yZwpDYzogSm9zZWYgQmFjaWsgPGpvc2VmQHRveGljcGFuZGEuY29tPgpDYzogSmVucyBB
eGJvZSA8YXhib2VAa2VybmVsLmRrPgpDYzogbGludXgtYmxvY2tAdmdlci5rZXJuZWwub3Jn
CkNjOiBuYmRAb3RoZXIuZGViaWFuLm9yZwpSZXZpZXdlZC1ieTogU2ltb24gSG9ybWFuIDxo
b3Jtc0BrZXJuZWwub3JnPgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQw
MTEyMTMyNjU3LjY0NzExMi0xLWVkdW1hemV0QGdvb2dsZS5jb20KU2lnbmVkLW9mZi1ieTog
SmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPgotLS0KIGRyaXZlcnMvYmxvY2svbmJkLmMg
fCA2ICstLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA1IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svbmJkLmMgYi9kcml2ZXJzL2Jsb2Nr
L25iZC5jCmluZGV4IDgwMzdhYWVmZWIyZS4uOWE1MzE2NWRlNGNlIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2Jsb2NrL25iZC5jCisrKyBiL2RyaXZlcnMvYmxvY2svbmJkLmMKQEAgLTQ5NCw3
ICs0OTQsNyBAQCBzdGF0aWMgaW50IF9fc29ja194bWl0KHN0cnVjdCBuYmRfZGV2aWNlICpu
YmQsIHN0cnVjdCBzb2NrZXQgKnNvY2ssIGludCBzZW5kLAogCQkgICAgICAgc3RydWN0IGlv
dl9pdGVyICppdGVyLCBpbnQgbXNnX2ZsYWdzLCBpbnQgKnNlbnQpCiB7CiAJaW50IHJlc3Vs
dDsKLQlzdHJ1Y3QgbXNnaGRyIG1zZzsKKwlzdHJ1Y3QgbXNnaGRyIG1zZyA9IHsgfTsKIAl1
bnNpZ25lZCBpbnQgbm9yZWNsYWltX2ZsYWc7CiAKIAlpZiAodW5saWtlbHkoIXNvY2spKSB7
CkBAIC01MDksMTAgKzUwOSw2IEBAIHN0YXRpYyBpbnQgX19zb2NrX3htaXQoc3RydWN0IG5i
ZF9kZXZpY2UgKm5iZCwgc3RydWN0IHNvY2tldCAqc29jaywgaW50IHNlbmQsCiAJbm9yZWNs
YWltX2ZsYWcgPSBtZW1hbGxvY19ub3JlY2xhaW1fc2F2ZSgpOwogCWRvIHsKIAkJc29jay0+
c2stPnNrX2FsbG9jYXRpb24gPSBHRlBfTk9JTyB8IF9fR0ZQX01FTUFMTE9DOwotCQltc2cu
bXNnX25hbWUgPSBOVUxMOwotCQltc2cubXNnX25hbWVsZW4gPSAwOwotCQltc2cubXNnX2Nv
bnRyb2wgPSBOVUxMOwotCQltc2cubXNnX2NvbnRyb2xsZW4gPSAwOwogCQltc2cubXNnX2Zs
YWdzID0gbXNnX2ZsYWdzIHwgTVNHX05PU0lHTkFMOwogCiAJCWlmIChzZW5kKQotLSAKMi40
My4wCgo=

--------------0ovr0XFVvV6DnP72QJ4yscGS--

