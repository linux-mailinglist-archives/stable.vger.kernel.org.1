Return-Path: <stable+bounces-134141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68027A9296F
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC871B63682
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583B5256C9E;
	Thu, 17 Apr 2025 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2E8kWTSB"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CDD255E34
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915223; cv=none; b=mrj2+YLCXz+1Bfq5x/SLnqPqcs6e4QdWhvSDUFe9smnhIlj1oEI+KTsF+wrkKs0/2mUFJj0Vd+LYFvyjyLdfOCOnmJq3gcoCVnNxYso+uWc+RWS/TctD6dZUvU2/9boBPFJoQhuiLdvO6Du0teF5loUzUGoy7SU4H5dwf89Xz7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915223; c=relaxed/simple;
	bh=Bmgj0mmSE9Sac1GdfRP4qO+e2r1LA5r04XjbwiNKU3Y=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=nAay2aWVOWIfgGCFw+5cT2BaOq506fFZhgnoXn/Qtk7eeWf5wM2A6GNaWKhY2uCDHmcw8Ff6kk7eNN4uAByxZ3sdp6f/VZ8b/iYB/LIk3RJQsslr7YjD6srFBainsUL/+/QYsr3daje+oqzAN9fdH2Q/4fGtY7aKVgypQ/Z425c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2E8kWTSB; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d6d84923c8so3278655ab.0
        for <stable@vger.kernel.org>; Thu, 17 Apr 2025 11:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744915217; x=1745520017; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtvJMSjRUli5q1DbXBzKgiCTIQ8NPsHuNTYxKv2Do7E=;
        b=2E8kWTSBgSuRuEGAhuqeGUS9LIiGpRDe7swqQE03aEhfn3RAxiroro/QhQEVjiau3N
         EHib5mcCwTNqhqleLxSHjntpG1QHA1A/t0srvg6tDkAZ/ARAjxb4G+cBFAof4OQTs12l
         xQhLp8rR8wUtE2pD/+ywqNIaLmb4hlKdapb6NDxclSQ5R+ttBhhmQZ8OhEhyWaNdclhS
         rK1/vPnnrlhkxMt+1mTYI7+RsjL4CQUkmp00wkEZ+VVSNX0hAuLNp2zuSRAttXElzRkq
         /TA5ErQShs13N2KMX19P5ZdfJU2jEW8aKOKfWJSP0WDCva6OdbyJUP/a4NBR9yebp+PG
         QCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744915217; x=1745520017;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xtvJMSjRUli5q1DbXBzKgiCTIQ8NPsHuNTYxKv2Do7E=;
        b=Y0+FJiqNVhrXE6TBR0XxGE0yRae5eYvGOn8FZk4g8MA5UhXmg5Ude3ogmeWkh//1N3
         i20W2HqWFHJt0W7rJmHORoMTy8En2bVuPph5xE5eYZfdiCiQGuCos29zkWPsCwC1bMCS
         FFXlBQ2uNQuFDfzw3d0hkU1yFIPcLUmFPD7kk20Z8VAbjcOzqa/ReZhogaM/CNIzjh8X
         Nalr4lAas/x2NulXMYs+fJguQHNogpFkPcsrKqOxxzDvChl2Lqbuil6zt4NqGCV7xjdw
         LI/GlVLyNcucZBbXhOqqR7iTKhXPshkkohyLjjUkYtCP8kCSl/V0zkhkOUjNrJaIO8EE
         y1GQ==
X-Gm-Message-State: AOJu0YyUP1CeLdrSnz+6egvZBl2YI+LYjDGtRilvCZQwIhpbc7nOsKya
	w2aHW2CjIsxsxbWULDjIy5jM8Epuxq0TGNVR7/udpU1YYReg91cMeA5Akof59II=
X-Gm-Gg: ASbGncuXCJxLW6nP8ABHjrnbk0WKpZXKfUotcMeB2qslkXfzk89fhMBv4MREtAZzW6O
	e2p7MNRdiTBTqLkuCqgi0Uv+9CAPy/fi9cSHznS2FRJx45PL1xQZ055v32KUUpEsaj9gNM8r/qw
	HjW8XWKRoOVPdEPdjDZKmNXnCOUajplc0KP7bAAQdID8JZOirMZD+BPybr4x18eZoxXbIYi1v4p
	VuY4cYp06gLKeJXZDfkMTuSHSVV5hSjTipL3lbeTJPk02/3RZP2cc5TdWVa5eb5D78QPMX631ck
	19MqOWAhRR7fXio9lTrLUou67PeHEhHutrSOUg==
X-Google-Smtp-Source: AGHT+IEnRJ9fOh+DXRoSkCL/djEQw2+tVKZrBA2sPb+dUv4U8bKijGcpiUHJcz2RnhDHaSCs63y/CQ==
X-Received: by 2002:a05:6e02:19c8:b0:3cf:bc71:94f5 with SMTP id e9e14a558f8ab-3d88ee51776mr1831095ab.22.1744915216810;
        Thu, 17 Apr 2025 11:40:16 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a37cbef1sm76101173.12.2025.04.17.11.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 11:40:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------SqkyzHkouK3yG5qMw0lnNrjO"
Message-ID: <43f57b54-7f43-4a1a-ab3d-15bfeefceebb@kernel.dk>
Date: Thu, 17 Apr 2025 12:40:15 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/net: fix accept multishot
 handling" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org, asml.silence@gmail.com
Cc: stable@vger.kernel.org
References: <2025041711-juniper-slapstick-265c@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025041711-juniper-slapstick-265c@gregkh>

This is a multi-part message in MIME format.
--------------SqkyzHkouK3yG5qMw0lnNrjO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 4:46 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

This one applies to both 6.1-stable and 6.6-stable, can you queue
it up for both? Thanks!

-- 
Jens Axboe

--------------SqkyzHkouK3yG5qMw0lnNrjO
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-net-fix-accept-multishot-handling.patch"
Content-Disposition: attachment;
 filename="0001-io_uring-net-fix-accept-multishot-handling.patch"
Content-Transfer-Encoding: base64

RnJvbSA2YTY5ZDE0NDY2MTc4MWExZTYwMjI4ZTI2YmIyNjk4NWNhNjY3MjNhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXZlbCBCZWd1bmtvdiA8YXNtbC5zaWxlbmNlQGdt
YWlsLmNvbT4KRGF0ZTogU3VuLCAyMyBGZWIgMjAyNSAxNzoyMjoyOSArMDAwMApTdWJqZWN0
OiBbUEFUQ0hdIGlvX3VyaW5nL25ldDogZml4IGFjY2VwdCBtdWx0aXNob3QgaGFuZGxpbmcK
CkNvbW1pdCBmNmE4OWJmNTI3OGQ2ZTE1MDE2YTczNmRiNjcwNDM1NjBkMWI1MGQ1IHVwc3Ry
ZWFtLgoKUkVRX0ZfQVBPTExfTVVMVElTSE9UIGRvZXNuJ3QgZ3VhcmFudGVlIGl0J3MgZXhl
Y3V0ZWQgZnJvbSB0aGUgbXVsdGlzaG90CmNvbnRleHQsIHNvIGEgbXVsdGlzaG90IGFjY2Vw
dCBtYXkgZ2V0IGV4ZWN1dGVkIGlubGluZSwgZmFpbAppb19yZXFfcG9zdF9jcWUoKSwgYW5k
IGFzayB0aGUgY29yZSBjb2RlIHRvIGtpbGwgdGhlIHJlcXVlc3Qgd2l0aAotRUNBTkNFTEVE
IGJ5IHJldHVybmluZyBJT1VfU1RPUF9NVUxUSVNIT1QgZXZlbiB3aGVuIGEgc29ja2V0IGhh
cyBiZWVuCmFjY2VwdGVkIGFuZCBpbnN0YWxsZWQuCgpDYzogc3RhYmxlQHZnZXIua2VybmVs
Lm9yZwpGaXhlczogMzkwZWQyOWI1ZTQyNSAoImlvX3VyaW5nOiBhZGQgSU9SSU5HX0FDQ0VQ
VF9NVUxUSVNIT1QgZm9yIGFjY2VwdCIpClNpZ25lZC1vZmYtYnk6IFBhdmVsIEJlZ3Vua292
IDxhc21sLnNpbGVuY2VAZ21haWwuY29tPgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9yLzUxYzZkZWIwMWZlYWE3OGIwODU2NWNhOGYyNDg0M2MwMTdmNWJjODAuMTc0MDMzMTA3
Ni5naXQuYXNtbC5zaWxlbmNlQGdtYWlsLmNvbQpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9l
IDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcvbmV0LmMgfCAyICsrCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvbmV0LmMg
Yi9pb191cmluZy9uZXQuYwppbmRleCBkNTZlOGE0N2U1MGYuLjg5ODk5MGU3MTM2NyAxMDA2
NDQKLS0tIGEvaW9fdXJpbmcvbmV0LmMKKysrIGIvaW9fdXJpbmcvbmV0LmMKQEAgLTEzOTEs
NiArMTM5MSw4IEBAIGludCBpb19hY2NlcHQoc3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2ln
bmVkIGludCBpc3N1ZV9mbGFncykKIAkJZ290byByZXRyeTsKIAogCWlvX3JlcV9zZXRfcmVz
KHJlcSwgcmV0LCAwKTsKKwlpZiAoIShpc3N1ZV9mbGFncyAmIElPX1VSSU5HX0ZfTVVMVElT
SE9UKSkKKwkJcmV0dXJuIElPVV9PSzsKIAlyZXR1cm4gSU9VX1NUT1BfTVVMVElTSE9UOwog
fQogCi0tIAoyLjQ5LjAKCg==

--------------SqkyzHkouK3yG5qMw0lnNrjO--

