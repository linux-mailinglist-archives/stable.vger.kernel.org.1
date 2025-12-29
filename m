Return-Path: <stable+bounces-203643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F440CE72C8
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01E5130046CF
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E002130FF36;
	Mon, 29 Dec 2025 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="InV3L3Lr"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157971E8826
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767021050; cv=none; b=Abx0P1VPJVk9TiILiiZcNRRPWsABU113JV2vi5G4w9U5DWBpiPHJmkBBHVlLyxoWC7DOVhccxDDpTvTptHERxTtd+8DD8scZcnhhndnecNEJom7EluDVFw6ogQ/OD2oxhIQeXufqheqme+MwsLb/kpsHm7ZTeD0znpDv+fZ/g9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767021050; c=relaxed/simple;
	bh=1KZr8Cl63LRqxmJnoTjYYCZAshqOCqbKv6Ix3y2pXbY=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=GdE6S5j1wa0ySz7oy4N5AvMW0/zYMPXzAj5BLnm7RJq81FUqbh9Fb/NC9Chborlr8Ko2nKLo9TVvVbl92Z7U1egOA/HZOuQ1v7HUasBGJbg+ScmODYO3+LVbbqGpFkXB3DGMJe27/J8juqwXLcdq/eInH8DzYuG9M/HKJzG44Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=InV3L3Lr; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4558f9682efso5921325b6e.3
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 07:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767021045; x=1767625845; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bk+2wt7nQyg3HHubnZcNl8z6s8Vhnwk5CJzFQAXlwIU=;
        b=InV3L3LrWBew8zaExSSnj72QbmbgQuO9aRWkSCRXOJSlIaWPs/aGF2inUujx1cPFuW
         Ee1v0TcgF7cMLUUT5c73+zAVgnHrTZ8NzQEET+B4zmH00PMLZmrIEIUqvmo5LcNtyIeJ
         Ro+Gcgb3WrlF+4Ba/nQZUTGdJFO7cQTAYBJHDi8vLn4TMxsQJBFwh6LsSxjxt+I/nt7V
         MrIg7pQrJYhA4Bdtpaz9HMQSx4y35WowSYmtM9aXcg9ucTn7cdgvePl3VMRaG8IwozkW
         +5rflon0DaLxaGYfIn8kVM0s6iMcrYTe26TUwWgTA+350uAsyfdMN+uSFUbYon0jOL9f
         5Mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767021045; x=1767625845;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bk+2wt7nQyg3HHubnZcNl8z6s8Vhnwk5CJzFQAXlwIU=;
        b=gWQsjAPNRahp+GYG36S/2QRmswrzREBH/b1ZRNzNtcgh3Lp/K32ihWblX/J+oI5oFx
         2ofpBjogr23E3aoFVnwUZfOkhB3B4Dk1KTdc2H+QOUFg8uXLP+XpD18g5EFoOvrLQt+e
         votYPbFmdlg/GxLUOIV46kXZBDH+B6/7ITm3I+GDh1bj1psJsFjSDYxNCLMFO1tZKdiX
         RGv+jObOJgy/qIoBSy6cJmw7htA+qP4T5h2KDiLphAccuaJgx5JBNZCgWYyD3OfasMYZ
         2RJO8i13h0BArUqBk+jDHMYSz4GD2umgrWBTqvo9wGoOQRx+PfRt8+FkJhxgrQV4zjWw
         sbCA==
X-Gm-Message-State: AOJu0Yx+XBOU0jFFBZq1qrOk2O1lMpHcq3n7wcEDDbtfboGCBh8uOCGh
	XsdSHDBDxbqB8ZfDw1Sw/8ASuXyj5Z2RGoVqthUKijSH54s3pq3Q1Hq2G4kGQ5ZT6T4=
X-Gm-Gg: AY/fxX5LFahyILkP/YQ4A9SyyqMZISMirgspP96f7hz6v2Ik6jFQNLzrWFQvNsWDO9q
	v0qsMq+nvsDb1z0GAMczdcclC9PslH31yukKGyEeY97kXPEWH6aa10yuc4PUMUi9274Eou08QR1
	0aIszmzIfm1QJDrqsY//fB5Kx4OieChePS4xztIxbF5upMLfclCLiOW/idFxNY7vE6uC4f7+A/N
	SeDy5J0AfPT3YVxrxX8gVPqPtNqKhlh82LI7/JwGTR2hAdHsEfAOCnFkSrzMIdvhuJKgdsc54D+
	MxTDxWbQ1dGcONIQUHlaqb1CjPuiYu4Je5VRKZAKmD4CC5qtHVO4Apws0/xoB9riYKBMsv7BA70
	m/0ihkVo0I14Y2SzP+ISvh6neTzmuYP/I+GuYJEOCbpMiK8SCr1O4+eq5jcEJa8+hi1fbfSNGrE
	SJe0ZshLJ1
X-Google-Smtp-Source: AGHT+IHwhwK2ng+S5VshZFxCz5B0dF99iFDo7WDZhijPUJePycuCIuR9tJxMJjZ3UxZWlEqdzsno6w==
X-Received: by 2002:a05:6808:2f15:b0:450:d143:b79f with SMTP id 5614622812f47-457b214d9aamr13427248b6e.66.1767021044937;
        Mon, 29 Dec 2025 07:10:44 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-457b3ba4416sm14358048b6e.1.2025.12.29.07.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 07:10:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------LiiX6dBII8ng6qk4Cf40vm3r"
Message-ID: <91bb9ee4-0ea5-4e15-a2fd-8a4634c4ed34@kernel.dk>
Date: Mon, 29 Dec 2025 08:10:42 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: fix min_wait wakeups for SQPOLL"
 failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, tip@tenbrinkmeijs.com
Cc: stable@vger.kernel.org
References: <2025122915-sensually-wasting-f5f8@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025122915-sensually-wasting-f5f8@gregkh>

This is a multi-part message in MIME format.
--------------LiiX6dBII8ng6qk4Cf40vm3r
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/29/25 4:34 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here's one for 6.12-stable.

-- 
Jens Axboe

--------------LiiX6dBII8ng6qk4Cf40vm3r
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-fix-min_wait-wakeups-for-SQPOLL.patch"
Content-Disposition: attachment;
 filename="0001-io_uring-fix-min_wait-wakeups-for-SQPOLL.patch"
Content-Transfer-Encoding: base64

RnJvbSBkNmMzNTQ5MWNkYzZkZjU2ZmUxYWI3NDljMTcwNDhiMjNmMWNjZjM5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFR1ZSwgOSBEZWMgMjAyNSAxMzoyNToyMyAtMDcwMApTdWJqZWN0OiBbUEFUQ0hdIGlv
X3VyaW5nOiBmaXggbWluX3dhaXQgd2FrZXVwcyBmb3IgU1FQT0xMCgpDb21taXQgZTE1Y2Iy
MjAwYjkzNGU1MDcyNzM1MTBiYTZiYzc0N2Q1Y2RlMjRhMyB1cHN0cmVhbS4KClVzaW5nIG1p
bl93YWl0LCB0d28gdGltZW91dHMgYXJlIGdpdmVuOgoKMSkgVGhlIG1pbl93YWl0IHRpbWVv
dXQsIHdpdGhpbiB3aGljaCB1cCB0byAnd2FpdF9ucicgZXZlbnRzIGFyZQogICB3YWl0ZWQg
Zm9yLgoyKSBUaGUgb3ZlcmFsbCBsb25nIHRpbWVvdXQsIHdoaWNoIGlzIGVudGVyZWQgaWYg
bm8gZXZlbnRzIGFyZSBnZW5lcmF0ZWQKICAgaW4gdGhlIG1pbl93YWl0IHdpbmRvdy4KCklm
IHRoZSBtaW5fd2FpdCBoYXMgZXhwaXJlZCwgYW55IGV2ZW50IGJlaW5nIHBvc3RlZCBtdXN0
IHdha2UgdGhlIHRhc2suCkZvciBTUVBPTEwsIHRoYXQgaXNuJ3QgdGhlIGNhc2UsIGFzIGl0
IHdvbid0IHRyaWdnZXIgdGhlIGlvX2hhc193b3JrKCkKY29uZGl0aW9uLCBhcyBpdCB3aWxs
IGhhdmUgYWxyZWFkeSBwcm9jZXNzZWQgdGhlIHRhc2tfd29yayB0aGF0IGhhcHBlbmVkCndo
ZW4gYW4gZXZlbnQgd2FzIHBvc3RlZC4gVGhpcyBjYXVzZXMgYW55IGV2ZW50IHRvIHRyaWdn
ZXIgcG9zdCB0aGUKbWluX3dhaXQgdG8gbm90IGFsd2F5cyBjYXVzZSB0aGUgd2FpdGluZyBh
cHBsaWNhdGlvbiB0byB3YWtldXAsIGFuZAppbnN0ZWFkIGl0IHdpbGwgd2FpdCB1bnRpbCB0
aGUgb3ZlcmFsbCB0aW1lb3V0IGhhcyBleHBpcmVkLiBUaGlzIGNhbiBiZQpzaG93biBpbiBh
IHRlc3QgY2FzZSB0aGF0IGhhcyBhIDEgc2Vjb25kIG1pbl93YWl0LCB3aXRoIGEgNSBzZWNv
bmQKb3ZlcmFsbCB3YWl0LCBldmVuIGlmIGFuIGV2ZW50IHRyaWdnZXJzIGFmdGVyIDEuNSBz
ZWNvbmRzOgoKYXhib2VAbTJtYXgta3ZtIC9kL2lvdXJpbmctbXJlIChtYXN0ZXIpPiB6aWct
b3V0L2Jpbi9pb3VyaW5nCmluZm86IE1JTl9USU1FT1VUIHN1cHBvcnRlZDogdHJ1ZSwgZmVh
dHVyZXM6IDB4M2ZmZmYKaW5mbzogVGVzdGluZzogbWluX3dhaXQ9MTAwMG1zLCB0aW1lb3V0
PTVzLCB3YWl0X25yPTQKaW5mbzogMSBjcWVzIGluIDUwMDAuMm1zCgp3aGVyZSB0aGUgZXhw
ZWN0ZWQgcmVzdWx0IHNob3VsZCBiZToKCmF4Ym9lQG0ybWF4LWt2bSAvZC9pb3VyaW5nLW1y
ZSAobWFzdGVyKT4gemlnLW91dC9iaW4vaW91cmluZwppbmZvOiBNSU5fVElNRU9VVCBzdXBw
b3J0ZWQ6IHRydWUsIGZlYXR1cmVzOiAweDNmZmZmCmluZm86IFRlc3Rpbmc6IG1pbl93YWl0
PTEwMDBtcywgdGltZW91dD01cywgd2FpdF9ucj00CmluZm86IDEgY3FlcyBpbiAxNTAwLjNt
cwoKV2hlbiB0aGUgbWluX3dhaXQgdGltZW91dCB0cmlnZ2VycywgcmVzZXQgdGhlIG51bWJl
ciBvZiBjb21wbGV0aW9ucwpuZWVkZWQgdG8gd2FrZSB0aGUgdGFzay4gVGhpcyBzaG91bGQg
ZW5zdXJlIHRoYXQgYW55IGZ1dHVyZSBldmVudHMgd2lsbAp3YWtlIHRoZSB0YXNrLCByZWdh
cmRsZXNzIG9mIGhvdyBtYW55IGV2ZW50cyBpdCBvcmlnaW5hbGx5IHdhbnRlZCB0bwp3YWl0
IGZvci4KClJlcG9ydGVkLWJ5OiBUaXAgdGVuIEJyaW5rIDx0aXBAdGVuYnJpbmttZWlqcy5j
b20+CkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCkZpeGVzOiAxMTAwYzRhMjY1NmQgKCJp
b191cmluZzogYWRkIHN1cHBvcnQgZm9yIGJhdGNoIHdhaXQgdGltZW91dCIpCkxpbms6IGh0
dHBzOi8vZ2l0aHViLmNvbS9heGJvZS9saWJ1cmluZy9pc3N1ZXMvMTQ3NwpTaWduZWQtb2Zm
LWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CihjaGVycnkgcGlja2VkIGZyb20g
Y29tbWl0IGUxNWNiMjIwMGI5MzRlNTA3MjczNTEwYmE2YmM3NDdkNWNkZTI0YTMpCi0tLQog
aW9fdXJpbmcvaW9fdXJpbmcuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvaW9fdXJpbmcuYyBiL2lvX3VyaW5nL2lv
X3VyaW5nLmMKaW5kZXggNjg0MzllYjBkYzhmLi5hZGYyYjBhMWJiNTkgMTAwNjQ0Ci0tLSBh
L2lvX3VyaW5nL2lvX3VyaW5nLmMKKysrIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwpAQCAtMjQy
MSw2ICsyNDIxLDkgQEAgc3RhdGljIGVudW0gaHJ0aW1lcl9yZXN0YXJ0IGlvX2NxcmluZ19t
aW5fdGltZXJfd2FrZXVwKHN0cnVjdCBocnRpbWVyICp0aW1lcikKIAkJCWdvdG8gb3V0X3dh
a2U7CiAJfQogCisJLyogYW55IGdlbmVyYXRlZCBDUUUgcG9zdGVkIHBhc3QgdGhpcyB0aW1l
IHNob3VsZCB3YWtlIHVzIHVwICovCisJaW93cS0+Y3FfdGFpbCA9IGlvd3EtPmNxX21pbl90
YWlsOworCiAJaW93cS0+dC5mdW5jdGlvbiA9IGlvX2NxcmluZ190aW1lcl93YWtldXA7CiAJ
aHJ0aW1lcl9zZXRfZXhwaXJlcyh0aW1lciwgaW93cS0+dGltZW91dCk7CiAJcmV0dXJuIEhS
VElNRVJfUkVTVEFSVDsKLS0gCjIuNTEuMAoK

--------------LiiX6dBII8ng6qk4Cf40vm3r--

