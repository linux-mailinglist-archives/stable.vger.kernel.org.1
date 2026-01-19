Return-Path: <stable+bounces-210358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D4ED3AB82
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 15:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFAD3300722A
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 14:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B70278753;
	Mon, 19 Jan 2026 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MCQd3MWN"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D7935581C
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832374; cv=none; b=hioBePbmfWzIPYoAVM6nEtxPj1d3UvZiLRfRLAdRROjb7NYMGUVTILJLwAJPvW9Lln4pCGBv359q+F2QKn08fwy04I/3SllvzlXtPLk0fHpZry43gaqSDRHS9QS6UlPGhmmJIFRcExDxMeRnBS/FNl76yzF9MBIZue0BuQtlwx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832374; c=relaxed/simple;
	bh=eiY5zy2ahVwv+O3EN5Zo+g0JqPWfEXLIa1bgVW4kVnk=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=HqSzIpMo5eicjRbFPGczJphrhXHpVHWYDcss5ywFBBUbNtEvhmNR3NLEnX8pQvgYjEbmPnx2JFrFQ/ONstvI87PyZD8OZn+IozUZD96rNJB1qeFIYRUQPW3ziJTKfGfABeZAKvpGeqWNPKYZSXMT9FeiN5w5feSeC7VlnWnKVcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MCQd3MWN; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4044854464fso2154515fac.3
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 06:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768832371; x=1769437171; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXf9vDIRiMVgh0xDImJ8HE0w8I2XZd1i701AFL2L2iM=;
        b=MCQd3MWNu5Mi5L1i2L4fkD6KM/mKNBoZP5L85+tIJ7JlAKac0hZTXMH2ORMvxQhihW
         QLCf32of7efhyN1n/mY8CN/GajpHR3rs+j9/pHba5VYIZO2Yh/fBu2MZkcEK9jAULZHT
         FDbj0VSL7+SSiF5HQBTOrDgU+ubyrWgTG5ErSxuw4ij18zc4X1tpMsx/P0h075nGj8mH
         +8I/EtN5RV2z3e1+zFauvLjQMVtq8/xQiHS/n9VlhY4oY+eDIBZGcBD7CVTbyQMDKYpS
         K7mEUH1fz/EY/v/Vz0i3ftYyDS8ypoF/sOjaZZGq8hOGXOHouAR3+wi5CVvasUCXXHJ3
         52zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832371; x=1769437171;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hXf9vDIRiMVgh0xDImJ8HE0w8I2XZd1i701AFL2L2iM=;
        b=JT1u3hGQDoPkUP7WX4JaUh+sJsp9vJionrGZYN6alrir0bM7VMLvdtLgjTPZslMhQ/
         LpLI4Tcz7lwlqOxNB5n8A5Aa071+YkNHhmThnBm0rx4GL5MkKgLwJgBQz9CiElc1/Sip
         d2iPyq9or1IanQ51cp0oyePwndLVzoFTB7+m7TFeWIBHQy1t5L+JGxeH53x4UZgqkuSm
         KahFaX7jnJ2CJYETIc4zw9MPpU6JPHsAVR4lvdWQDbC1Ry25bsjy1AFszw08gIsN8s/Y
         YnkCwBx1NnoppZwDzUZS2niiA0ntgyv1pc98wZaaZLPE73GSTPF3oPT5LqfS0/ZbCbBV
         SzbA==
X-Gm-Message-State: AOJu0YwFnin2uC/WYhBmp8HhzzLTEq5mC7fatRhYN2BeeEQkUtTWHZsP
	W2vmHDmev89inzW/g5C6+zC5ewEIGiwkSMOaVRT8CJeCy/xqZe8Y5IRRH/Kqseo4rWs=
X-Gm-Gg: AY/fxX5/Yt8X8S6eTgN6x9rNOMDjLeRCSOL8DyGMM5aXNlBDfnPAmp9oAAKB37G8pjH
	xv2pb4sT0Xgf/b4yn2MzzXNlYJ+qbSVcMGS8hbdrlVmRN3bGwlG9z/+8P2FwftqYT9nGJHYfjNM
	8yJGoG5a4uC2F6sQ7ZCIygcGu4Bq/t5PhCeO8Y2oxc2YLh+i1rK6RCwSByiPsU3SdN92jQn8ID4
	Mrr6XILydCFKOWDTOJ+dOPg52zPJvUaXpQ2t8YRsrvx/hQPa97eZ2qS7MHzFg+RkfF83pJkM/lM
	YTbaaqmpBDu2ib6gesyPcCnxENwGyR3ivDyud/Tj13l5W65Y7G+GUsIXfWeDDteVtSN5S0JQQUI
	936WPJ3SmNntcTwuT/at6gPuxzpBUjsEl6MwwIDmFESNhTx76qE0er/wUDSw2c2TWW51s7XXlYz
	N9/jC5xmoP8yt2Lhuwu7m+YHqP4H8SkAaImYS9hJTaG7D1fgu/kfQ9ZZOxIg0NZaX0mWnEow==
X-Received: by 2002:a05:6820:16a1:b0:659:9a49:8f4d with SMTP id 006d021491bc7-6611795b68emr4982718eaf.18.1768832366178;
        Mon, 19 Jan 2026 06:19:26 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-661187cffbfsm4634836eaf.17.2026.01.19.06.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:19:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------l0tVUhkSNb0YdLF1Z95xr3yC"
Message-ID: <1807a9e4-8eec-4eed-9fcd-88b0408c152e@kernel.dk>
Date: Mon, 19 Jan 2026 07:19:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: move local task_work in exit
 cancel loop" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org, ming.lei@redhat.com
Cc: stable@vger.kernel.org
References: <2026011956-unclog-language-54ed@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026011956-unclog-language-54ed@gregkh>

This is a multi-part message in MIME format.
--------------l0tVUhkSNb0YdLF1Z95xr3yC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/26 4:47 AM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x da579f05ef0faada3559e7faddf761c75cdf85e1
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026011956-unclog-language-54ed@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

6.12 variant also applies to 6.6, attached again here for 6.6-stable.

-- 
Jens Axboe

--------------l0tVUhkSNb0YdLF1Z95xr3yC
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-move-local-task_work-in-exit-cancel-loop.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-move-local-task_work-in-exit-cancel-loop.patch"
Content-Transfer-Encoding: base64

RnJvbSBkZGRlMWU4OTU1YzRkNzU3NGFmN2Y3OGZmYTY0Njk1NDgyZGUzZmM4IE1vbiBTZXAg
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
bmcuYyBiL2lvX3VyaW5nL2lvX3VyaW5nLmMKaW5kZXggYWRmMmIwYTFiYjU5Li45OWIwYjFi
YTBmZTIgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL2lvX3VyaW5nLmMKKysrIGIvaW9fdXJpbmcv
aW9fdXJpbmcuYwpAQCAtMjkwNCwxMSArMjkwNCwxMSBAQCBzdGF0aWMgX19jb2xkIHZvaWQg
aW9fcmluZ19leGl0X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCQkJbXV0ZXhf
dW5sb2NrKCZjdHgtPnVyaW5nX2xvY2spOwogCQl9CiAKLQkJaWYgKGN0eC0+ZmxhZ3MgJiBJ
T1JJTkdfU0VUVVBfREVGRVJfVEFTS1JVTikKLQkJCWlvX21vdmVfdGFza193b3JrX2Zyb21f
bG9jYWwoY3R4KTsKLQotCQl3aGlsZSAoaW9fdXJpbmdfdHJ5X2NhbmNlbF9yZXF1ZXN0cyhj
dHgsIE5VTEwsIHRydWUpKQorCQlkbyB7CisJCQlpZiAoY3R4LT5mbGFncyAmIElPUklOR19T
RVRVUF9ERUZFUl9UQVNLUlVOKQorCQkJCWlvX21vdmVfdGFza193b3JrX2Zyb21fbG9jYWwo
Y3R4KTsKIAkJCWNvbmRfcmVzY2hlZCgpOworCQl9IHdoaWxlIChpb191cmluZ190cnlfY2Fu
Y2VsX3JlcXVlc3RzKGN0eCwgTlVMTCwgdHJ1ZSkpOwogCiAJCWlmIChjdHgtPnNxX2RhdGEp
IHsKIAkJCXN0cnVjdCBpb19zcV9kYXRhICpzcWQgPSBjdHgtPnNxX2RhdGE7Ci0tIAoyLjUx
LjAKCg==

--------------l0tVUhkSNb0YdLF1Z95xr3yC--

