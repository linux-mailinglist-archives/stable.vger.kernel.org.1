Return-Path: <stable+bounces-3233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9AE7FF1F7
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 15:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826241C20C4E
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B839482CB;
	Thu, 30 Nov 2023 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="W+mX8201"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D53B5
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 06:33:33 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-35ccfc5323aso104775ab.1
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 06:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701354812; x=1701959612; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XNoiDddzTjk8fw4pj0V4e1k48Mpdo03JYPxwf0+GWw=;
        b=W+mX8201wyrA1V+5UCd9htP6pxs8Z5aOTIp+HfadYHhmM9nAF1AMTKcXHLoeFiKu2S
         8aLws3TK1yr4D8fTOAAk+rwSvOOFSdv4eiGcyn+ZdKKHVRJgjpdXD0cZdhlZeFUsW85o
         Q0eEspbyd+grptce9DT4+Jk/lWENN5+qCZ+QBaSzKP/k7E0Ly8AjGvDGu9Mf2XZFl+k9
         +NAOFcXf8Tqegjo4Gra49mMGFtAfjPsP91bQURAA3JweWlfGC4WJSvr+0+4pQhDcvuqs
         dhEFhGQYalMzAn0wWkAd898PgHxtaeuQzUbw7yYPZETeYTDaPU4LUh2h7LeXMIvRk1Kx
         Gv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701354812; x=1701959612;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8XNoiDddzTjk8fw4pj0V4e1k48Mpdo03JYPxwf0+GWw=;
        b=Wi96Bz/AFkOAeRd9fg+pWmX/BngGULLovAKz3dR3IOS5jVtGmQDJMe64b97WcD4jRD
         O2zB6kTbk7p1s3KImceqYY2Kn5Fq4+IWnTvQkVzMNXsKSpU7yB7drATuaIDg2Di+Clv2
         YnfCKzXUpaIXBtBcLibJDjwhfXol6nM1oJ+GbO/vDeISRD4OKgfe77RRNZRjUQnYdoh3
         gRRMvSndZKVcXbVKdi1NIHZZSEy/+8xhlOIOMbsTrBt2wzpln+54XAf1fsajVrXdcydy
         fN55gb/fqZ5gJDtNnECB27GVWqcHs8sltp5v02blNq5vqij61DR7OXLhZUi7bHnETtsG
         gLQw==
X-Gm-Message-State: AOJu0YyODTzx4Op0I9PeEyDDt0+l6GnvY58fYPOiUKjBWUDTa3YYVjl5
	v3ACX4XNntD9zRJAU2S7cjWk1w==
X-Google-Smtp-Source: AGHT+IF7LETdTKNUzfwe4hRj5HjsZakct+31kakjoXWMxMTzZX4CPwEZ0+FPpby5a9f+w7WeoqxV7w==
X-Received: by 2002:a05:6e02:1d0c:b0:35c:ac2f:bb38 with SMTP id i12-20020a056e021d0c00b0035cac2fbb38mr2130222ila.2.1701354812518;
        Thu, 30 Nov 2023 06:33:32 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y19-20020a056e02129300b0035cc242a29bsm395254ilq.48.2023.11.30.06.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 06:33:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------ZU3UChRviVipZl7QnTsljt8E"
Message-ID: <1a14f4af-8033-403c-9469-f582daef1457@kernel.dk>
Date: Thu, 30 Nov 2023 07:33:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: fix off-by one bvec index"
 failed to apply to 5.15-stable tree
Content-Language: en-US
To: gregkh@linuxfoundation.org, kbusch@kernel.org
Cc: stable@vger.kernel.org
References: <2023113024-dating-blog-e8e0@gregkh>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023113024-dating-blog-e8e0@gregkh>

This is a multi-part message in MIME format.
--------------ZU3UChRviVipZl7QnTsljt8E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/30/23 7:31 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.

And here's one for both 5.10 and 5.15 stable.

-- 
Jens Axboe


--------------ZU3UChRviVipZl7QnTsljt8E
Content-Type: text/x-patch; charset=UTF-8;
 name="5.15-io_uring-fix-off-by-one-bvec-index.patch"
Content-Disposition: attachment;
 filename="5.15-io_uring-fix-off-by-one-bvec-index.patch"
Content-Transfer-Encoding: base64

RnJvbSA0NTgxZGU2N2IxMzkzNDI2YWMyOWQ4YzZkMTkxMTllMTVmMDhhMzEzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+
CkRhdGU6IE1vbiwgMjAgTm92IDIwMjMgMTQ6MTg6MzEgLTA4MDAKU3ViamVjdDogW1BBVENI
IDIvMl0gaW9fdXJpbmc6IGZpeCBvZmYtYnkgb25lIGJ2ZWMgaW5kZXgKCmNvbW1pdCBkNmZl
ZjM0ZWU0ZDEwMmJlNDQ4MTQ2ZjI0Y2FmOTZkN2I0YTA1NDAxIHVwc3RyZWFtLgoKSWYgdGhl
IG9mZnNldCBlcXVhbHMgdGhlIGJ2X2xlbiBvZiB0aGUgZmlyc3QgcmVnaXN0ZXJlZCBidmVj
LCB0aGVuIHRoZQpyZXF1ZXN0IGRvZXMgbm90IGluY2x1ZGUgYW55IG9mIHRoYXQgZmlyc3Qg
YnZlYy4gU2tpcCBpdCBzbyB0aGF0IGRyaXZlcnMKZG9uJ3QgaGF2ZSB0byBkZWFsIHdpdGgg
YSB6ZXJvIGxlbmd0aCBidmVjLCB3aGljaCB3YXMgb2JzZXJ2ZWQgdG8gYnJlYWsKTlZNZSdz
IFBSUCBsaXN0IGNyZWF0aW9uLgoKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKRml4ZXM6
IGJkMTFiM2EzOTFlMyAoImlvX3VyaW5nOiBkb24ndCB1c2UgaW92X2l0ZXJfYWR2YW5jZSgp
IGZvciBmaXhlZCBidWZmZXJzIikKU2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2ggPGtidXNj
aEBrZXJuZWwub3JnPgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjMxMTIw
MjIxODMxLjI2NDY0NjAtMS1rYnVzY2hAbWV0YS5jb20KU2lnbmVkLW9mZi1ieTogSmVucyBB
eGJvZSA8YXhib2VAa2VybmVsLmRrPgotLS0KIGlvX3VyaW5nL2lvX3VyaW5nLmMgfCAyICst
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9pb191cmluZy9pb191cmluZy5jIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwppbmRl
eCAzZGRiOTU0ODM3NDYuLjM4ZTIwMmI4MTI4NyAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvaW9f
dXJpbmcuYworKysgYi9pb191cmluZy9pb191cmluZy5jCkBAIC0zMTUyLDcgKzMxNTIsNyBA
QCBzdGF0aWMgaW50IF9faW9faW1wb3J0X2ZpeGVkKHN0cnVjdCBpb19raW9jYiAqcmVxLCBp
bnQgcncsIHN0cnVjdCBpb3ZfaXRlciAqaXRlcgogCQkgKi8KIAkJY29uc3Qgc3RydWN0IGJp
b192ZWMgKmJ2ZWMgPSBpbXUtPmJ2ZWM7CiAKLQkJaWYgKG9mZnNldCA8PSBidmVjLT5idl9s
ZW4pIHsKKwkJaWYgKG9mZnNldCA8IGJ2ZWMtPmJ2X2xlbikgewogCQkJaW92X2l0ZXJfYWR2
YW5jZShpdGVyLCBvZmZzZXQpOwogCQl9IGVsc2UgewogCQkJdW5zaWduZWQgbG9uZyBzZWdf
c2tpcDsKLS0gCjIuNDIuMAoK

--------------ZU3UChRviVipZl7QnTsljt8E--

