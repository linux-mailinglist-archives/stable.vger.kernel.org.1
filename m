Return-Path: <stable+bounces-203644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 290DBCE72D1
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7AD23005FE1
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED1D30FF1D;
	Mon, 29 Dec 2025 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VRxmJsi5"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C713226CE2F
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767021196; cv=none; b=rktivKLntB0sCeSgz404yqYEYzsJKpUNLvhvdzFaFCgej1X2zWFCBzoMj9QeRPd7U+0lRK4eG7BdkHK8azAAlTPN3PyKelDXeR87mvERteby9Qr4/kCSDcBB4nou7jAdOWPdH5npCWfqZh7opILJFzhgxSNcsGB3+qgFHK0GQBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767021196; c=relaxed/simple;
	bh=meEPbY6AbVUTtYPhLlgN6fnQa7RUWGpI1RNv+XbCn8A=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=OFZN3jszbc9tNnQu1GppHFGs8LVleflD0NbDXKh4XkXubJQivt7fwOiTQzXFyc3zHQNv0afJC6mikE7ZaNyEO9F+QxRts2mfrD6xoAHAL5KPd8mY1j43bC6yUDcbXK4nrv/2eQb+uEMDG8b6TKkYRtKbzdmgRiuvNZuteqrnqCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VRxmJsi5; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-65b73eacdfcso1540582eaf.2
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 07:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767021194; x=1767625994; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcIUHz+EQqIB+pq9zwm46vmLpCQX+cmlG8cjS0xSk4c=;
        b=VRxmJsi5bx0jJPQYENG8d/xUf5swlkHZtYpG+rYIVHn2gCdJtmxXDcbjdEosm2fc8d
         qWg5/UCwrQMywuscDMfUZ26YYCVNMx5Hif3Ee8jdO0BNTTMOURS1rm3F8sXZkkr5RaK2
         70cGlCaBXBsPBU1ZaCZu9B4ke1hjGT1ZyPyhCtA4CF7X1RkDSudwtqjNmjMbQVMmnbl4
         ozcBmrXJsnMm0zx0G7isD043m2O1vaC3V2545PVKrKh1ILNCegLyB04bMsP8W/unEQX7
         j0Fyqkk66pkew/oO+XKiGO50BoEMD9F+VmjCpYK8s7aMKMlREkKRIgxxpTcSZs1vueCC
         yTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767021194; x=1767625994;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bcIUHz+EQqIB+pq9zwm46vmLpCQX+cmlG8cjS0xSk4c=;
        b=PLtNbCXy8MQn6T186DScHAvznmjdN700GkIbHKRQwmkvPUBwxS1rFv7wWYVNCZOdbB
         WyEFJhHH6S2tYl0LG3lio1+FF0LG5A84cb4j73ZmruHhwhXrDE/ROt79bYNzeZmfnAFK
         kcco2RlfgIewhAsImdAY99TqC9pR8AEPkAEbp5YnA98KjoAsexAqscEH1++3Iq70OYRg
         ww+/xdbl1J4e9mJOEbAQZCcR34ch7SWNys/lFo9Qle7GpJIpBVpk7OkhRTvBlTrGlWHW
         mUITWEptBZJI/9jgu3z6FRW7ulofHrgiLBAXKRQAddxzkIqw/wW9ZzM8k+VWwx8CnTpz
         nkWw==
X-Gm-Message-State: AOJu0YwsrzeHJzWKbYXzkPbW3NFsG/usy61uJCf+P6aT4CB22k8GawRZ
	Km2W0W+kBvFO/QhIVmNY6+oQA1oDk3hfafsbNq9WKnsblnefHLtxAagNqn/rFIVDvy8=
X-Gm-Gg: AY/fxX40ZHzg+OZGcYzkDkMEYx/eAwBi0Rb3vrt7SJ2YXDrSIbiO78zZ+Uqj/Bi87lO
	vBWQtfnfPeG+nXqxQZ67rc7ALCLZ4et6pU+ueUoKEPda6IFoT+7Ws/zwFDEe3oqah8N88wArRbt
	4phxLK+QCXpwjo7BpYt/Y07TIEDLneSc7xUR1WZG/MPSOBjMXd+9zV8a+Cggv3MF0XErXYg6eva
	6TL6vrug/ZW7UwUBlpVfO62mzoHiQl9b+pW9RWVUD8qtVTtT/egzEhDwVwixJ+Gh/YKotQcus5H
	BHTtfm8QM5UP3P7QQdJpCyJAALJAxQ2/v/8IS/3RPL4wgk8HIrkA0ObXOn0v1ZYHwY62yRllHJ9
	Joq+ONyp+YUiDOhDGu0QjMicRBz2bnMdrKjJS/j+oPXweDM85PJBBkx8CEGRPCfNQ0yPDcNmJtC
	40o/q9qIaqdlLDodWukoY=
X-Google-Smtp-Source: AGHT+IEdNLFyOFwbPfHsVTiIS4F58F6s0fKwuzbbamsVxk7Uogo+YRzF5r95LlPy/KfF9/i03Gu7fg==
X-Received: by 2002:a05:6820:a1cd:b0:659:9a49:8e3e with SMTP id 006d021491bc7-65d0e965111mr10498027eaf.14.1767021193690;
        Mon, 29 Dec 2025 07:13:13 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65d0f3fb710sm18278751eaf.2.2025.12.29.07.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 07:13:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------g0Q2vXEEABjgNjJ33cfXS330"
Message-ID: <90c17bf7-e5f9-4fbc-9c85-02f00fc9ba46@kernel.dk>
Date: Mon, 29 Dec 2025 08:13:11 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: fix filename leak in
 __io_openat_prep()" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org, activprithvi@gmail.com
Cc: stable@vger.kernel.org
References: <2025122931-primer-motivate-1780@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025122931-primer-motivate-1780@gregkh>

This is a multi-part message in MIME format.
--------------g0Q2vXEEABjgNjJ33cfXS330
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/29/25 4:34 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here's one for 6.1-stable.

-- 
Jens Axboe

--------------g0Q2vXEEABjgNjJ33cfXS330
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-fix-filename-leak-in-__io_openat_prep.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-fix-filename-leak-in-__io_openat_prep.patch"
Content-Transfer-Encoding: base64

RnJvbSBiMTRmYWQ1NTUzMDJhMjEwNDk0OGZlYWZmNzA1MDNiNjRjODBhYzAxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQcml0aHZpIFRhbWJld2FnaCA8YWN0aXZwcml0aHZp
QGdtYWlsLmNvbT4KRGF0ZTogVGh1LCAyNSBEZWMgMjAyNSAxMjo1ODoyOSArMDUzMApTdWJq
ZWN0OiBbUEFUQ0hdIGlvX3VyaW5nOiBmaXggZmlsZW5hbWUgbGVhayBpbiBfX2lvX29wZW5h
dF9wcmVwKCkKCkNvbW1pdCBiMTRmYWQ1NTUzMDJhMjEwNDk0OGZlYWZmNzA1MDNiNjRjODBh
YzAxIHVwc3RyZWFtLgoKIF9faW9fb3BlbmF0X3ByZXAoKSBhbGxvY2F0ZXMgYSBzdHJ1Y3Qg
ZmlsZW5hbWUgdXNpbmcgZ2V0bmFtZSgpLiBIb3dldmVyLApmb3IgdGhlIGNvbmRpdGlvbiBv
ZiB0aGUgZmlsZSBiZWluZyBpbnN0YWxsZWQgaW4gdGhlIGZpeGVkIGZpbGUgdGFibGUgYXMK
d2VsbCBhcyBoYXZpbmcgT19DTE9FWEVDIGZsYWcgc2V0LCB0aGUgZnVuY3Rpb24gcmV0dXJu
cyBlYXJseS4gQXQgdGhhdApwb2ludCwgdGhlIHJlcXVlc3QgZG9lc24ndCBoYXZlIFJFUV9G
X05FRURfQ0xFQU5VUCBmbGFnIHNldC4gRHVlIHRvIHRoaXMsCnRoZSBtZW1vcnkgZm9yIHRo
ZSBuZXdseSBhbGxvY2F0ZWQgc3RydWN0IGZpbGVuYW1lIGlzIG5vdCBjbGVhbmVkIHVwLApj
YXVzaW5nIGEgbWVtb3J5IGxlYWsuCgpGaXggdGhpcyBieSBzZXR0aW5nIHRoZSBSRVFfRl9O
RUVEX0NMRUFOVVAgZm9yIHRoZSByZXF1ZXN0IGp1c3QgYWZ0ZXIgdGhlCnN1Y2Nlc3NmdWwg
Z2V0bmFtZSgpIGNhbGwsIHNvIHRoYXQgd2hlbiB0aGUgcmVxdWVzdCBpcyB0b3JuIGRvd24s
IHRoZQpmaWxlbmFtZSB3aWxsIGJlIGNsZWFuZWQgdXAsIGFsb25nIHdpdGggb3RoZXIgcmVz
b3VyY2VzIG5lZWRpbmcgY2xlYW51cC4KClJlcG9ydGVkLWJ5OiBzeXpib3QrMDBlNjFjNDNl
YjVlNDc0MDQzOGZAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQpDbG9zZXM6IGh0dHBzOi8v
c3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD0wMGU2MWM0M2ViNWU0NzQwNDM4ZgpU
ZXN0ZWQtYnk6IHN5emJvdCswMGU2MWM0M2ViNWU0NzQwNDM4ZkBzeXprYWxsZXIuYXBwc3Bv
dG1haWwuY29tCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IFBy
aXRodmkgVGFtYmV3YWdoIDxhY3RpdnByaXRodmlAZ21haWwuY29tPgpGaXhlczogYjk0NDU1
OThkOGM2ICgiaW9fdXJpbmc6IG9wZW5hdCBkaXJlY3RseSBpbnRvIGZpeGVkIGZkIHRhYmxl
IikKU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPgotLS0KIGlv
X3VyaW5nL29wZW5jbG9zZS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvb3BlbmNsb3NlLmMg
Yi9pb191cmluZy9vcGVuY2xvc2UuYwppbmRleCAwMDg5OTBlNTgxODAuLmVkODM1NDUxNWEz
MSAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvb3BlbmNsb3NlLmMKKysrIGIvaW9fdXJpbmcvb3Bl
bmNsb3NlLmMKQEAgLTU0LDEzICs1NCwxMyBAQCBzdGF0aWMgaW50IF9faW9fb3BlbmF0X3By
ZXAoc3RydWN0IGlvX2tpb2NiICpyZXEsIGNvbnN0IHN0cnVjdCBpb191cmluZ19zcWUgKnNx
ZQogCQlvcGVuLT5maWxlbmFtZSA9IE5VTEw7CiAJCXJldHVybiByZXQ7CiAJfQorCXJlcS0+
ZmxhZ3MgfD0gUkVRX0ZfTkVFRF9DTEVBTlVQOwogCiAJb3Blbi0+ZmlsZV9zbG90ID0gUkVB
RF9PTkNFKHNxZS0+ZmlsZV9pbmRleCk7CiAJaWYgKG9wZW4tPmZpbGVfc2xvdCAmJiAob3Bl
bi0+aG93LmZsYWdzICYgT19DTE9FWEVDKSkKIAkJcmV0dXJuIC1FSU5WQUw7CiAKIAlvcGVu
LT5ub2ZpbGUgPSBybGltaXQoUkxJTUlUX05PRklMRSk7Ci0JcmVxLT5mbGFncyB8PSBSRVFf
Rl9ORUVEX0NMRUFOVVA7CiAJcmV0dXJuIDA7CiB9CiAK

--------------g0Q2vXEEABjgNjJ33cfXS330--

