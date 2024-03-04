Return-Path: <stable+bounces-25975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC310870B31
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32EBB1C213B1
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 20:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B0E7A14D;
	Mon,  4 Mar 2024 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cla0QPLG"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3172F79DD2
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 20:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709582960; cv=none; b=r7EpMK43kLe7alsQ0z/ImT1COOdGr+K2qi8qD4s7huiebT881D4wSzTq+T9c55iqPOnLtTmp0tO1uO/hw6d7qUuZVekC8F5B9qC2Seg91prnUgAuk68OewgcDBIv2mdNZiRAb5PNrNwhSDF/LlcuwgVEg//vOLgDQzXB6DgasbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709582960; c=relaxed/simple;
	bh=uEKDySeLIrSOOYJsFFw8VQ2ihDn8hx4ZfDRr7IAFZWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DoMSFqU5vnPTrv/+cQFnCUAWO3TgvtRRiNmSWy98FzXLMvdtgb0xCHym7/f8B4VQOK29+5YmKKkOj9y7as44UUaU+nrFwS/2n+emhO85tpVSexaPvAqyDlt6mI9pEPdcNQNdynhJEfhp8RlTwKIboDeoEfDq8Q/y7XjT9fJDtRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cla0QPLG; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5fc05784c60so5296117b3.0
        for <stable@vger.kernel.org>; Mon, 04 Mar 2024 12:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709582957; x=1710187757; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h7X/3WUye+nAnUaTjSE6f5ieUuz/6HclBQ9YlgcmeDA=;
        b=cla0QPLGMp4Ye/O5Ac25x0KLWgjHCM9pi+ehz0iuAJGPyOtyRa6Tg9UGEip1Sc5N/D
         rPY8ckW6WtkB1JsEOMTZklrk7GmhMFAa9q9jAV4U6z7GDT/bf3NQ0/k7AtauM+z4XqLy
         l9tfTwwqb2cRs/9DHrWJKn9mfbIfxkv45EXoInuQw9E34a+qLVtcMCw15wJizNkeO6Ss
         FASmgbPsokys4DyX3sfQQD7Zcbsw9WEcTdgCZBHxP55p66QQH5UbrAt3rVMfjXsqCd1E
         vKZBVvy250TEGV1Zvz8DUNhjl9LgtjC7PbSu8jXhmJxJ4///1JlxIf7fBSBhlHiTG896
         cR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709582957; x=1710187757;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7X/3WUye+nAnUaTjSE6f5ieUuz/6HclBQ9YlgcmeDA=;
        b=G1T6c14qtcVeYQVCJ0UHrto2sQx45WraLAUGZm9b7EWd0joWzVwvgyMDNOll5x8zvG
         dJdAdgeT+WpIAo0NHMGwgAXad2OtJBifFr29CA1kOiDMO1QYQOEEx7Bt0CgmDWpvGTfQ
         JkP7e9UnuW3vpbYUis91snqdYLBSqssMc++CDXCGMWwBai0oYCAIa5nE8f94piAyuT3o
         Z3JXNIMrwNLmDkO4q0S78/PpDig1zYALx3xkxDYgZyAorElfi0g/2pG6COzwajxQuyDq
         pR9t3Mhrss6uFlTIk+7M9YgTsw0SVeaWudWuUPD9ZDPnWErJtN4GDrvjUs0oUdaJDefx
         EXRw==
X-Forwarded-Encrypted: i=1; AJvYcCW7wV4LgsA+nM3JVViLnm74+eVNkSOGfpf8ner3dZNgPcHkZH/BfpqNHXiGE9DBb5YBDyhlqG1FWibwCA6j764aBzf+yiVr
X-Gm-Message-State: AOJu0YyZsICbAOy9JLcvCtZ8DzJlpe9otD48atFQFWgJh7XvAGp//SkN
	RBoHd1Etx7qqwAFiL6wh2j9x0zKbs+5ZTJKMwAazs9TDy+T14N+9t9W5TZI/x4I=
X-Google-Smtp-Source: AGHT+IHKUjnxsb2nK3L9RfXEjNmnSQdcoCVFSgtkVONpyUgd6gGDPDxtJosTROJTeZo/mOGzw/IwcQ==
X-Received: by 2002:a81:d002:0:b0:608:bdee:796e with SMTP id v2-20020a81d002000000b00608bdee796emr6744446ywi.0.1709582956854;
        Mon, 04 Mar 2024 12:09:16 -0800 (PST)
Received: from [172.18.94.26] ([70.158.101.146])
        by smtp.gmail.com with ESMTPSA id j7-20020a819207000000b00607f93f1317sm2804750ywg.33.2024.03.04.12.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 12:09:16 -0800 (PST)
Message-ID: <73d9e8a1-597a-46fc-b81c-0cc745507c53@kernel.dk>
Date: Mon, 4 Mar 2024 13:09:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] fs/aio: Restrict kiocb_set_cancel_fn() to I/O
 submitted via libaio
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>, Bart Van Assche <bvanassche@acm.org>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
 Sandeep Dhavale <dhavale@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, stable@vger.kernel.org
References: <20240215204739.2677806-1-bvanassche@acm.org>
 <20240215204739.2677806-2-bvanassche@acm.org>
 <20240304191047.GB1195@sol.localdomain>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240304191047.GB1195@sol.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/24 12:10 PM, Eric Biggers wrote:
> On Thu, Feb 15, 2024 at 12:47:38PM -0800, Bart Van Assche wrote:
>> void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
>> {
>> 	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
>> 	struct kioctx *ctx = req->ki_ctx;
>> 	unsigned long flags;
>>  
>> +	/*
>> +	 * kiocb didn't come from aio or is neither a read nor a write, hence
>> +	 * ignore it.
>> +	 */
>> +	if (!(iocb->ki_flags & IOCB_AIO_RW))
>> +		return;
>> +
>>  	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
>>  		return;
>>  
> 
> If I understand correctly, this patch is supposed to fix a memory
> safety bug when kiocb_set_cancel_fn() is called on a kiocb that is
> owned by io_uring instead of legacy AIO.  However, the kiocb still
> gets accessed as an aio_kiocb at the very beginning of the function,
> so it's still broken:
>
> 	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
> 	struct kioctx *ctx = req->ki_ctx;
>
Doesn't matter, they are both just pointer math. But it'd look cleaner
if it was below.

> I'm also wondering why "ignore" is the right fix.  The USB gadget
> driver sees that it has asynchronous I/O (kiocb::ki_complete != NULL)
> and then tries to set a cancellation function.  What is the expected
> behavior when the I/O is owned by io_uring?  Should it perhaps call
> into io_uring to set a cancellation function with io_uring?  Or is the
> concept of cancellation functions indeed specific to legacy AIO, and
> nothing should be done with io_uring I/O?

Because the ->ki_cancel() is a hack, as demonstrated by this issue in
teh first place, which is a gross layering violation. io_uring supports
proper cancelations, invoked from userspace. It would never have worked
with this scheme.

-- 
Jens Axboe


