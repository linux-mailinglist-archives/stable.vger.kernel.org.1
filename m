Return-Path: <stable+bounces-46178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CDB8CEFDC
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 17:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43E41C20A2F
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC33B44C6F;
	Sat, 25 May 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RKglvwqi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C73B29CE5
	for <stable@vger.kernel.org>; Sat, 25 May 2024 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716651650; cv=none; b=hjMgGToeZYTnumAPuZcFBie5XcvQjKIMbs6dGyGBnZCadOL8AdrWXlUzMX4ILwLR3LLmwGZE9PKSP8dQia2IXYSTeXyB6h9WqRfrXHw43+91OfeZkFyJMvea2M2C9DqMybfCoXHJNj0HT3UjQI49sUag6rxDEbmStcJt+oOrzI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716651650; c=relaxed/simple;
	bh=P5idHcgipaeUyJfZt9viGz7WXpWEXij7tvpjiQ2CD0E=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=UwFTmPB70nexQV4lIZE6W+thJSK6oHcT9tym9ZmQToI6aWaIGZt1gDWXrkie7SqcUH17lv3cvLYrlIdlrX7rIm4DiQevvIWtN1VFHJCaQ83AsSqJ0csW7GXLd5kA6wvstAlOmDcxh4+6qEzNnl9D7lNWgQAr0mRFFLy5sObnr2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RKglvwqi; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2bded7f6296so352458a91.1
        for <stable@vger.kernel.org>; Sat, 25 May 2024 08:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716651648; x=1717256448; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F23t8C5hRQ79KqwqvI9mbREGYaE+piZUitH89nLoPb4=;
        b=RKglvwqiJ36omK4MaQcjF4QPDX8dpfSfxHqb+ddShkjH3XbXTFvcFNoBwqVvxjXtDb
         h6dGo+azpbBunmLSWW3H3pWbGAIZ2lbpbxeDXb+/d3YNyVUH+L3MFSjPjXZt1aqCb2nX
         pk8dS1xXWj++dRtH5UD4kiYZ22ANvv/2NkI10ijb3sXJ8JYMELGWrO4Q649yGz2yIZB1
         E75s1zVwSkjaBudhUy0rOYGkR8IzmFNTzrSEVb0nPXB2+nJZ4ZTEpH5NbZldlB7XyT3Y
         6FAQR6u3jz4O+LnvqPPXgR2/S6cWSsTF7SId4xU21GV9lMRlrD30WS3KwPMc8YvuPXjs
         2NLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716651648; x=1717256448;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F23t8C5hRQ79KqwqvI9mbREGYaE+piZUitH89nLoPb4=;
        b=BN1se+7dVYJ1NJHzqNMbhQEaBcSe9MpZ8uIhE7psw/8l34a6LLWRTxnq5DUOBz8YP2
         TvC+P/KyFJqu7V4xxh3wiMMiTR5wFlcVeDIfA7RFMSF+8W5SUAqS2/nmG2R1nnJ2zxIr
         7xjYS//OKLTit7l9KNPUtkkkxt3L02divR0IizBn5+/oCuCkM/Nxc/vVABZjoG5Ad/fe
         64a8LocTN9G9zKns3OXnobl+7ulVnIQEAcsPzNnxY75RP1q952jMvAvgU3RIbNOavOB3
         G5llhjzSJeaLL6CAsyp8Gt823OFevmLFLFnvUdtM/3WiqysIWAMM5XDRdHcPKrSCGhRp
         C/KQ==
X-Gm-Message-State: AOJu0YzeQbHcEisRI4nM72Y5yo5Sn+KbXvVSHV/EG8GPmUOWcxiHqrZa
	ManzlYR/x4/JEUFLeBzv6w6yndYerPdhb3MFo+lyMxtr1yhPKS8gIXTR5JyfAjg=
X-Google-Smtp-Source: AGHT+IHTPjhMnbq6kQXdvRn0RgBDLN7nIQp6DucMDum+TH7zfmn3wUD3zJ5XLNAvssziU2Hs7gqsaw==
X-Received: by 2002:a17:90b:3d10:b0:2bd:feb6:b09b with SMTP id 98e67ed59e1d1-2bf5e161326mr4962088a91.1.1716651647769;
        Sat, 25 May 2024 08:40:47 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdd9ed26f4sm4994511a91.4.2024.05.25.08.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 08:40:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------6BXZ3I6zAyDwkc79bngWdZLL"
Message-ID: <52c45ad5-51f1-4fb7-8df4-b083bb303146@kernel.dk>
Date: Sat, 25 May 2024 09:40:45 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: fail NOP if non-zero op flags is
 passed in" failed to apply to 5.4-stable tree
To: gregkh@linuxfoundation.org, ming.lei@redhat.com
Cc: stable@vger.kernel.org
References: <2024052549-gyration-replica-129f@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024052549-gyration-replica-129f@gregkh>

This is a multi-part message in MIME format.
--------------6BXZ3I6zAyDwkc79bngWdZLL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/25/24 9:05 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.4-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
> git checkout FETCH_HEAD
> git cherry-pick -x 3d8f874bd620ce03f75a5512847586828ab86544
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024052549-gyration-replica-129f@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Here's one for 5.4 stable, thanks.

-- 
Jens Axboe


--------------6BXZ3I6zAyDwkc79bngWdZLL
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-fail-NOP-if-non-zero-op-flags-is-passed-in.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-fail-NOP-if-non-zero-op-flags-is-passed-in.pat";
 filename*1="ch"
Content-Transfer-Encoding: base64

RnJvbSA0ZTgxOWZjMzI1OTgyZTMzMGUzNmVhYWEyMjg5NmIyZThkNzc4YmEwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNaW5nIExlaSA8bWluZy5sZWlAcmVkaGF0LmNvbT4K
RGF0ZTogRnJpLCAxMCBNYXkgMjAyNCAxMTo1MDoyNyArMDgwMApTdWJqZWN0OiBbUEFUQ0hd
IGlvX3VyaW5nOiBmYWlsIE5PUCBpZiBub24temVybyBvcCBmbGFncyBpcyBwYXNzZWQgaW4K
CkNvbW1pdCAzZDhmODc0YmQ2MjBjZTAzZjc1YTU1MTI4NDc1ODY4MjhhYjg2NTQ0IHVwc3Ry
ZWFtLgoKVGhlIE5PUCBvcCBmbGFncyBzaG91bGQgaGF2ZSBiZWVuIGNoZWNrZWQgZnJvbSBi
ZWdpbm5pbmcgbGlrZSBhbnkgb3RoZXIKb3Bjb2RlLCBvdGhlcndpc2UgTk9QIG1heSBub3Qg
YmUgZXh0ZW5kZWQgd2l0aCB0aGUgb3AgZmxhZ3MuCgpHaXZlbiBib3RoIGxpYnVyaW5nIGFu
ZCBSdXN0IGlvLXVyaW5nIGNyYXRlIGFsd2F5cyB6ZXJvcyBTUUUgb3AgZmxhZ3MsIGp1c3QK
aWdub3JlIHVzZXJzIHdoaWNoIHBsYXkgcmF3IE5PUCB1cmluZyBpbnRlcmZhY2Ugd2l0aG91
dCB6ZXJvaW5nIFNRRSwgYmVjYXVzZQpOT1AgaXMganVzdCBmb3IgdGVzdCBwdXJwb3NlLiBU
aGVuIHdlIGNhbiBzYXZlIG9uZSBOT1AyIG9wY29kZS4KClN1Z2dlc3RlZC1ieTogSmVucyBB
eGJvZSA8YXhib2VAa2VybmVsLmRrPgpGaXhlczogMmIxODhjYzFiYjg1ICgiQWRkIGlvX3Vy
aW5nIElPIGludGVyZmFjZSIpCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClNpZ25lZC1v
ZmYtYnk6IE1pbmcgTGVpIDxtaW5nLmxlaUByZWRoYXQuY29tPgpMaW5rOiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9yLzIwMjQwNTEwMDM1MDMxLjc4ODc0LTItbWluZy5sZWlAcmVkaGF0
LmNvbQpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQog
ZnMvaW9fdXJpbmcuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9mcy9pb191cmluZy5jIGIvZnMvaW9fdXJpbmcuYwppbmRleCAyYzc5
M2U0Y2NmMDkuLjRjZmRkZDcxMjQ1MiAxMDA2NDQKLS0tIGEvZnMvaW9fdXJpbmcuYworKysg
Yi9mcy9pb191cmluZy5jCkBAIC0yMTEyLDYgKzIxMTIsOCBAQCBzdGF0aWMgaW50IF9faW9f
c3VibWl0X3NxZShzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwgc3RydWN0IGlvX2tpb2NiICpy
ZXEsCiAKIAlzd2l0Y2ggKHJlcS0+c3VibWl0Lm9wY29kZSkgewogCWNhc2UgSU9SSU5HX09Q
X05PUDoKKwkJaWYgKFJFQURfT05DRShzLT5zcWUtPnJ3X2ZsYWdzKSkKKwkJCXJldHVybiAt
RUlOVkFMOwogCQlyZXQgPSBpb19ub3AocmVxLCByZXEtPnVzZXJfZGF0YSk7CiAJCWJyZWFr
OwogCWNhc2UgSU9SSU5HX09QX1JFQURWOgotLSAKMi40My4wCgo=

--------------6BXZ3I6zAyDwkc79bngWdZLL--

