Return-Path: <stable+bounces-203645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2D0CE72EF
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBA28300D40C
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC205F4FA;
	Mon, 29 Dec 2025 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KwE48ysZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EAC2C9D
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767021324; cv=none; b=lglF8wmiZ4DVZJLbaFBopimgFZZmc6H4EMx78tFCPFyd3LvyzFkrtHlvL9XR1PAW/qaOUf92rnkCJrmJxOzlA0p1W0PXFbER8uShLWAhmAoTIx9GtOiIuIRc5bB++GIrwa0MFotDNBnDS7gimWUieJnIbqtJweCe212YpFV6GLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767021324; c=relaxed/simple;
	bh=KrfwO+L9tcTCRCpdC6Q4KhEqXxigBJWKQuqdBBT+1y4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=XUKy8m/3ViQn/yUMge5GNW86D63FOtdjch5v7pCvqg7ggpjiTXlFCZ7Hx+EQ0j0clA6x3JaIqNcLTGrTvOTz0G71zfD3YsPYa237BLWqVh9u58DLMZripl6iObvuYICJheGT80THLik0qOpsgPSnbhxJJuCNtCN7YMV89mvzoY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KwE48ysZ; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-45391956bfcso7364640b6e.3
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 07:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767021320; x=1767626120; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpX7Ik7IqTaRmabR36qsaZ5U5ukiJ/yU2K9cO69eieg=;
        b=KwE48ysZHsloYN5D6PQDwvAtiqaJr8av9BPLAJxmGzV8j+nyy6ieHVotjz44hX5QgE
         7hcUkVZNGu+7fxlGZd6dNnugi1zXEEuw/vEj6jOumdGaeRThbS5KJXijz+r/49DVanUR
         WBWhkD3NVibrPJvnTx4BIrrjelPBHps9UkYKnBpY4PA7RSfqHsuTaS21FxBY5EdUv14u
         n5ujZP0A4rWoSeiaM8YiCXKOaVETu+xl+Gopco5FvfZQqLesZux1cuu9J6Gsmmwq8GD/
         BY0iAQcQNeP5YTgnLfDvDXjHMdG8DyxMo1hl2/NXsIMkehFG4EznVZxhyZlhVwRIrv3M
         oT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767021320; x=1767626120;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XpX7Ik7IqTaRmabR36qsaZ5U5ukiJ/yU2K9cO69eieg=;
        b=TZivpMtq3oEV6Q6VQdBIi1QZoAtAjfNl4B7b51AiNHxPyuDWnkQh5O11s9q45uCWBB
         6hFhShnnKcVENmg5ZAdgA49LSQu94R6sQ9ooL+kkVsd6D+wMxmDigmyXqWUjTiRpY+KS
         OCie7IjrRVckNRl8MWSNEJVtTeCGi64y6PaaYBwYb3dt92TeGHlqvY/vwSX9MUGsXn1A
         oGkM8aB/fgNwN5Tr35ySYwu7L+WR38r3Vr8AMh5/T6YiPguQdkQADpTGPu+oXuvgEHXF
         3av+zLNe2uaL74xR8yZ355RNfRME7VnH3vc7xHTlMyvE6ing4J7Bq0vfpCRjwzrK54JE
         CeIw==
X-Gm-Message-State: AOJu0YxCycsRkBMnzIcE1lVre/XskHEY1v5wTR9funrbDbqeTIwo6O5O
	oi+YQdkcnMbtbseuh+w/D2Cp6I6Z57WoPr0tVWriyTyHj66ltGRM5yjE95rZiTE/2E4=
X-Gm-Gg: AY/fxX4PH6vYreJhor0uHFg8jgoZYmWYZWUf1CiCM7QNVo8Vpn7y9kzhXv7zZ34snIZ
	OIvubUPLYTRay8uHfn7ctsYbrnQwIA6Yn/Oz84Lz8jAx8wxWlzra1Y9lIp0KL3TLPRHXfIXVfXp
	LXjXERP06W7v2V43qXsQAuIZcqXfck7W/x7jW8Gv+mmZVhdjmPAIaL44213WjpIzva+L7MrhaXX
	eVU4gB8ulnX7u1JrH8yXwD4L69wUgODdr3LZvFszm71o4KyQ4NJPZNJPcJPXzWHaxQjzA+BhPO4
	3ldrRprIGTtET89RJKblJPZ7OA65A4pVpE67Nh2VVYpPTIAqRBkZamfcnXoFA33Y6s3hk6wbDR3
	2Uns+4PavF/S/+9mpffT8sj2Wf/I/JOFe8ULzekZIvT52T1BF5fllZyRbH3kwN5ZGeImXLvwyBo
	4DkbcUpRB8
X-Google-Smtp-Source: AGHT+IHwL4BC9lNgmtmK/BPb4DoUiqq2PVywroV8pNKwGvFhTuoYH+u/pQniLkgWnr5YZZKPAFZIjg==
X-Received: by 2002:a05:6808:4fe4:b0:450:50d:c6c2 with SMTP id 5614622812f47-457b21f524amr12840695b6e.33.1767021319854;
        Mon, 29 Dec 2025 07:15:19 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4598c356623sm9343949b6e.2.2025.12.29.07.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 07:15:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------JlgNmYI4kV0cLIGU1lgLCjy8"
Message-ID: <4c57e1d1-d78b-472c-a833-5793bd395afb@kernel.dk>
Date: Mon, 29 Dec 2025 08:15:18 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: fix filename leak in
 __io_openat_prep()" failed to apply to 5.15-stable tree
To: gregkh@linuxfoundation.org, activprithvi@gmail.com
Cc: stable@vger.kernel.org
References: <2025122931-palm-unfixed-3968@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025122931-palm-unfixed-3968@gregkh>

This is a multi-part message in MIME format.
--------------JlgNmYI4kV0cLIGU1lgLCjy8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/29/25 4:34 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here's one for 5.15-stable AND 5.10-stable. Please apply to both, as they
share the same base.

-- 
Jens Axboe

--------------JlgNmYI4kV0cLIGU1lgLCjy8
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-fix-filename-leak-in-__io_openat_prep.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-fix-filename-leak-in-__io_openat_prep.patch"
Content-Transfer-Encoding: base64

RnJvbSA5ZWE2YjljYjUyODVhMTI0NTg0NWRlZGRlMDU2MzgwMDVhYmEwMzdiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQcml0aHZpIFRhbWJld2FnaCA8YWN0aXZwcml0aHZp
QGdtYWlsLmNvbT4KRGF0ZTogVGh1LCAyNSBEZWMgMjAyNSAxMjo1ODoyOSArMDUzMApTdWJq
ZWN0OiBbUEFUQ0hdIGlvX3VyaW5nOiBmaXggZmlsZW5hbWUgbGVhayBpbiBfX2lvX29wZW5h
dF9wcmVwKCkKCiBfX2lvX29wZW5hdF9wcmVwKCkgYWxsb2NhdGVzIGEgc3RydWN0IGZpbGVu
YW1lIHVzaW5nIGdldG5hbWUoKS4gSG93ZXZlciwKZm9yIHRoZSBjb25kaXRpb24gb2YgdGhl
IGZpbGUgYmVpbmcgaW5zdGFsbGVkIGluIHRoZSBmaXhlZCBmaWxlIHRhYmxlIGFzCndlbGwg
YXMgaGF2aW5nIE9fQ0xPRVhFQyBmbGFnIHNldCwgdGhlIGZ1bmN0aW9uIHJldHVybnMgZWFy
bHkuIEF0IHRoYXQKcG9pbnQsIHRoZSByZXF1ZXN0IGRvZXNuJ3QgaGF2ZSBSRVFfRl9ORUVE
X0NMRUFOVVAgZmxhZyBzZXQuIER1ZSB0byB0aGlzLAp0aGUgbWVtb3J5IGZvciB0aGUgbmV3
bHkgYWxsb2NhdGVkIHN0cnVjdCBmaWxlbmFtZSBpcyBub3QgY2xlYW5lZCB1cCwKY2F1c2lu
ZyBhIG1lbW9yeSBsZWFrLgoKRml4IHRoaXMgYnkgc2V0dGluZyB0aGUgUkVRX0ZfTkVFRF9D
TEVBTlVQIGZvciB0aGUgcmVxdWVzdCBqdXN0IGFmdGVyIHRoZQpzdWNjZXNzZnVsIGdldG5h
bWUoKSBjYWxsLCBzbyB0aGF0IHdoZW4gdGhlIHJlcXVlc3QgaXMgdG9ybiBkb3duLCB0aGUK
ZmlsZW5hbWUgd2lsbCBiZSBjbGVhbmVkIHVwLCBhbG9uZyB3aXRoIG90aGVyIHJlc291cmNl
cyBuZWVkaW5nIGNsZWFudXAuCgpSZXBvcnRlZC1ieTogc3l6Ym90KzAwZTYxYzQzZWI1ZTQ3
NDA0MzhmQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KQ2xvc2VzOiBodHRwczovL3N5emth
bGxlci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9MDBlNjFjNDNlYjVlNDc0MDQzOGYKVGVzdGVk
LWJ5OiBzeXpib3QrMDBlNjFjNDNlYjVlNDc0MDQzOGZAc3l6a2FsbGVyLmFwcHNwb3RtYWls
LmNvbQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBQcml0aHZp
IFRhbWJld2FnaCA8YWN0aXZwcml0aHZpQGdtYWlsLmNvbT4KRml4ZXM6IGI5NDQ1NTk4ZDhj
NiAoImlvX3VyaW5nOiBvcGVuYXQgZGlyZWN0bHkgaW50byBmaXhlZCBmZCB0YWJsZSIpClNp
Z25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191cmlu
Zy9pb191cmluZy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvaW9fdXJpbmcuYyBiL2lvX3Vy
aW5nL2lvX3VyaW5nLmMKaW5kZXggNDNkZDU0YzU3NmQ2Li5lNTg4OWVjMDI3M2YgMTAwNjQ0
Ci0tLSBhL2lvX3VyaW5nL2lvX3VyaW5nLmMKKysrIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwpA
QCAtNDMyNiwxMyArNDMyNiwxMyBAQCBzdGF0aWMgaW50IF9faW9fb3BlbmF0X3ByZXAoc3Ry
dWN0IGlvX2tpb2NiICpyZXEsIGNvbnN0IHN0cnVjdCBpb191cmluZ19zcWUgKnNxZQogCQly
ZXEtPm9wZW4uZmlsZW5hbWUgPSBOVUxMOwogCQlyZXR1cm4gcmV0OwogCX0KKwlyZXEtPmZs
YWdzIHw9IFJFUV9GX05FRURfQ0xFQU5VUDsKIAogCXJlcS0+b3Blbi5maWxlX3Nsb3QgPSBS
RUFEX09OQ0Uoc3FlLT5maWxlX2luZGV4KTsKIAlpZiAocmVxLT5vcGVuLmZpbGVfc2xvdCAm
JiAocmVxLT5vcGVuLmhvdy5mbGFncyAmIE9fQ0xPRVhFQykpCiAJCXJldHVybiAtRUlOVkFM
OwogCiAJcmVxLT5vcGVuLm5vZmlsZSA9IHJsaW1pdChSTElNSVRfTk9GSUxFKTsKLQlyZXEt
PmZsYWdzIHw9IFJFUV9GX05FRURfQ0xFQU5VUDsKIAlyZXR1cm4gMDsKIH0KIAotLSAKMi41
MS4wCgo=

--------------JlgNmYI4kV0cLIGU1lgLCjy8--

