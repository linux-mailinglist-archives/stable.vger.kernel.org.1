Return-Path: <stable+bounces-143265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F130AAB381D
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 15:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21B7F7A1262
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 13:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C79829293D;
	Mon, 12 May 2025 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uB8llZAx"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D4F28D857
	for <stable@vger.kernel.org>; Mon, 12 May 2025 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055316; cv=none; b=HnzeuJWub/6kWl6PaO6P1KSPBrm+rVQ+Q8ByH74XsJiVxoAhMpxwcBlL4YZQELi09Ctf1UpXL5+84nOqBlVqOzDgukoR9P6WMWxVOO0vOrx23HPcA0zSTlPQAT87k+7AmQKmwYmMLuXxzpHvDUWWQmMDWzUBO3AjQ21zZPUIgOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055316; c=relaxed/simple;
	bh=Gy4EzOOk4aTmIj1ODhW46SlwjI8LKq/r5DVajC+Yr0g=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=oNNCkPmkfqWeKkHwla1S9xjiyejxXCI1SQQ8w7tG+RpZtMuFNAEI+oN4NhLskCeNPqF7eN0l+j+UYqpKhpo0HCnSYEBdVGl2OIK0TBEAsnEguwdTTUQsZWLZkn8Hhp1SSoj35XyCoVFhxsBQZpjNmNrZuFdHEDSvKSJFV4J/t2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uB8llZAx; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-86142446f3fso105933439f.2
        for <stable@vger.kernel.org>; Mon, 12 May 2025 06:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747055311; x=1747660111; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Urw6db/cSHq2BqGAcJmtZT4ZFuRBot5yfx2hgvZZlAE=;
        b=uB8llZAxv/DR1AxrrAEeUA4HChv7LB0cW2M/gNeD2rDIOTrrNH1UkeeDIoHtARirVs
         trcqBYQDXK8f52ttTdx4gqpukvHVTw9gI6h0d+zPHcgIfvByaAHDssJl6jYvZO5IN9CO
         pL3DvSwdBVhTgIYi7Lt5bqjTtW4orlZ9mZCh0homdHSSto5t0SlE2LETMYGsrm5rxT7u
         Lfu0sy5buFwcj/3PsGmXev2zYyaEEE0DRDxhOAmIzasUkeCwDO1mCVRFV4c7OwN6ub2J
         BWkMVu6UsPXjW3y/yZ3P1B8pcW+OrUH/WZv/UUxFUyRFAncmEVktYSEsEiG2jMtysg8u
         rP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747055311; x=1747660111;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Urw6db/cSHq2BqGAcJmtZT4ZFuRBot5yfx2hgvZZlAE=;
        b=d9Db+wBi/APchg/29lljgs/UJqaSs4MiQtyVLeKWiQMMtufmf1EeOa2VJ9X04fifWE
         OEKOBs1sYeCNui3Nlf0li6jBgXvV+BhG8rA50ZkMNDSlF5qcx+oHHRN2A9h0cyzKTpxE
         SVSRg5M9kFp7JTat3GQPNQArWve5Od+THwSSh0I9uEmReIcufnFDrgbmTyzfW07Pr+Ae
         DjVQ0rfpK3rUpXATpK34BSsmPBCmkkk3IHu2gwA9LJKqky8CZqYRSnESUH0/fphb/d4K
         VsZHq3Z7WImNY2qmv1PUGIR56DmSHHgZkbkVPZhAeSy/tT4yU9QOZFEzaUVt1W9WLMFs
         EfBA==
X-Gm-Message-State: AOJu0YxKkGnwwsBdH+dOZKsgWiy98RCPp9R/usI1uiYzlV+ucVIcS1su
	pLLv7poy5I33C5tTWYFyfDRWsc+KH1Mse1nX4NKgcaB6tdxHP5LKUhvzIlPAmOo=
X-Gm-Gg: ASbGncsbmFK42I2eGTCgt+HbxukCOcahV4Nvd1RT3Y/5ARGXdvzkliDSU2/757I5Xj5
	2XoUsir3rVw32D9j12QChIRZnf1j46vSUmjsTSWeMf4eCbFCjU0/XynGJB3S74sTuGEx504eFC2
	zRczY5bNwNZqXXQaO2TID39UsTzSBaD9Qma30NeFf89YIHrFPup0zEQ7f2jFuoAJjnRlYwcK0K3
	6Tnd88sBvpUVjyCwDPxQTYKNjvLYlz3suFQI8AaPxkOV7fwUTdomCyhSrpcRj6UcGPKqIhN5t1H
	6KvFzqARoYyFgz+59uyxlj+uQPUSGemVmyKVwev5GbYGXA4=
X-Google-Smtp-Source: AGHT+IHaCE9ZFSYvA/NWbV2L+6CNdybYafXdjuaL9Yef8v+fXiD8HQesErqf7DNL1UK4QRCUHejo/A==
X-Received: by 2002:a05:6e02:398d:b0:3d5:81aa:4d0a with SMTP id e9e14a558f8ab-3da7e1e743dmr138008785ab.6.1747055311367;
        Mon, 12 May 2025 06:08:31 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3da7e1136bbsm23532475ab.33.2025.05.12.06.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 06:08:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------h50TRrCMMhIjJ58EVUkLW90o"
Message-ID: <1876d7d6-c2e1-4055-9f83-8f63f7f9081d@kernel.dk>
Date: Mon, 12 May 2025 07:08:30 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: ensure deferred completions are
 flushed for" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org, christian.mazakas@gmail.com,
 norman_maurer@apple.com
Cc: stable@vger.kernel.org
References: <2025051212-safeness-barista-b429@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025051212-safeness-barista-b429@gregkh>

This is a multi-part message in MIME format.
--------------h50TRrCMMhIjJ58EVUkLW90o
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/25 4:01 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here's a tested 6.6-stable backport.

-- 
Jens Axboe

--------------h50TRrCMMhIjJ58EVUkLW90o
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-ensure-deferred-completions-are-posted-for-.patch"
Content-Disposition: attachment;
 filename*0="0002-io_uring-ensure-deferred-completions-are-posted-for-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBmZDlmNDZjZmU0NmNmYzQ5YTBkMDU1NWU1Y2ZlNjBkNDBlYzAwMzU5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFdlZCwgNyBNYXkgMjAyNSAwODowNzowOSAtMDYwMApTdWJqZWN0OiBbUEFUQ0ggMi8y
XSBpb191cmluZzogZW5zdXJlIGRlZmVycmVkIGNvbXBsZXRpb25zIGFyZSBwb3N0ZWQgZm9y
CiBtdWx0aXNob3QKCkNvbW1pdCA2ODdiMmJhZTBlZmZmOWIyNWUwNzE3MzdkNmFmNTAwNGU2
ZTM1YWY1IHVwc3RyZWFtLgoKTXVsdGlzaG90IG5vcm1hbGx5IHVzZXMgaW9fcmVxX3Bvc3Rf
Y3FlKCkgdG8gcG9zdCBjb21wbGV0aW9ucywgYnV0IHdoZW4Kc3RvcHBpbmcgaXQsIGl0IG1h
eSBmaW5pc2ggdXAgd2l0aCBhIGRlZmVycmVkIGNvbXBsZXRpb24uIFRoaXMgaXMgZmluZSwK
ZXhjZXB0IGlmIGFub3RoZXIgbXVsdGlzaG90IGV2ZW50IHRyaWdnZXJzIGJlZm9yZSB0aGUg
ZGVmZXJyZWQgY29tcGxldGlvbnMKZ2V0IGZsdXNoZWQuIElmIHRoaXMgb2NjdXJzLCB0aGVu
IENRRXMgbWF5IGdldCByZW9yZGVyZWQgaW4gdGhlIENRIHJpbmcsCmFuZCBjYXVzZSBjb25m
dXNpb24gb24gdGhlIGFwcGxpY2F0aW9uIHNpZGUuCgpXaGVuIG11bHRpc2hvdCBwb3N0aW5n
IHZpYSBpb19yZXFfcG9zdF9jcWUoKSwgZmx1c2ggYW55IHBlbmRpbmcgZGVmZXJyZWQKY29t
cGxldGlvbnMgZmlyc3QsIGlmIGFueS4KCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMg
Ni4xKwpSZXBvcnRlZC1ieTogTm9ybWFuIE1hdXJlciA8bm9ybWFuX21hdXJlckBhcHBsZS5j
b20+ClJlcG9ydGVkLWJ5OiBDaHJpc3RpYW4gTWF6YWthcyA8Y2hyaXN0aWFuLm1hemFrYXNA
Z21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+
Ci0tLQogaW9fdXJpbmcvaW9fdXJpbmcuYyB8IDggKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pb191cmluZy9pb191cmluZy5jIGIv
aW9fdXJpbmcvaW9fdXJpbmcuYwppbmRleCA0ZjRhYzQwZmM2MDUuLmRiNTkyZmE1NDliNyAx
MDA2NDQKLS0tIGEvaW9fdXJpbmcvaW9fdXJpbmcuYworKysgYi9pb191cmluZy9pb191cmlu
Zy5jCkBAIC05MTksNiArOTE5LDE0IEBAIHN0YXRpYyBib29sIF9faW9fcG9zdF9hdXhfY3Fl
KHN0cnVjdCBpb19yaW5nX2N0eCAqY3R4LCB1NjQgdXNlcl9kYXRhLCBzMzIgcmVzLCB1CiB7
CiAJYm9vbCBmaWxsZWQ7CiAKKwkvKgorCSAqIElmIG11bHRpc2hvdCBoYXMgYWxyZWFkeSBw
b3N0ZWQgZGVmZXJyZWQgY29tcGxldGlvbnMsIGVuc3VyZSB0aGF0CisJICogdGhvc2UgYXJl
IGZsdXNoZWQgZmlyc3QgYmVmb3JlIHBvc3RpbmcgdGhpcyBvbmUuIElmIG5vdCwgQ1FFcwor
CSAqIGNvdWxkIGdldCByZW9yZGVyZWQuCisJICovCisJaWYgKCF3cV9saXN0X2VtcHR5KCZj
dHgtPnN1Ym1pdF9zdGF0ZS5jb21wbF9yZXFzKSkKKwkJX19pb19zdWJtaXRfZmx1c2hfY29t
cGxldGlvbnMoY3R4KTsKKwogCWlvX2NxX2xvY2soY3R4KTsKIAlmaWxsZWQgPSBpb19maWxs
X2NxZV9hdXgoY3R4LCB1c2VyX2RhdGEsIHJlcywgY2ZsYWdzKTsKIAlpZiAoIWZpbGxlZCAm
JiBhbGxvd19vdmVyZmxvdykKLS0gCjIuNDkuMAoK

--------------h50TRrCMMhIjJ58EVUkLW90o--

