Return-Path: <stable+bounces-25976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F945870B71
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402021F23A92
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 20:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F49487BC;
	Mon,  4 Mar 2024 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="f8XCakn3"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7457B3F3
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583693; cv=none; b=hyGivX0njwWqOetTkA1KuJqs2on83F1+a9QeZqeguAUFF+tqEZXISHg1ClG8ydjUmVHgfxB5r1wDiTdEOho3VylPhNN7nwdtZreNa6JV1a43b6rOCJJOUVYQGNGkHlhMOsPRCVOSM1i20PuW7hE8U5hm6dwAKW88sNO1AV5jMAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583693; c=relaxed/simple;
	bh=ixv/3e099K5oAkmm/TE8nxObti56XmIKB0Vva3OJIcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dmty9vCQjUiUZLPVCRPluV0apyb8j94fX0xViIrs/c/t+mLq81GsMqo5RCoFF4u4rU21sIAzKvs1mzsBckEbmAu1Z9V5luPtHiO4q3KmP6q4e7q6XJuQQW3/8XJ5PYFJ9C845+IkjZehqtkx6gBL2Ne8gOI+pgQkXLH5mhCO/eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=f8XCakn3; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6b5d11385so1255131276.0
        for <stable@vger.kernel.org>; Mon, 04 Mar 2024 12:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709583691; x=1710188491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4ofA+r/J1VWu+/TU1IW0qQNdlLB2vA5UomhfHP0BSE=;
        b=f8XCakn3Rbd8iXmorNbUEmmh28ZhkNXTgGjfdiaFeSiTcfck61Csqt0sGeSUupjK/A
         0z1HJuApFKZNuEhP5cSiMp7PyyzYwUHmTwlz/iy66w7SvuV/uwjUPISW3MI94d39Jpmf
         Xi/91hR988eoGClxi0v15SD/7r/r5koaLms30AFf3GR34zV/vKn14Ts0rQ7j8/8Yk7UU
         kqo9zJJIyG4IRAYuoZSorHd6i/nCJVnzMty8x/GFkemIe6KXvCJ+HmNLfAggPepfgInK
         SpXdehUA25ZQe71WsmHLyfrVEvftvhd30deun2337Tpqur6wwiF38tPsBzI82lU3xxB0
         d2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709583691; x=1710188491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4ofA+r/J1VWu+/TU1IW0qQNdlLB2vA5UomhfHP0BSE=;
        b=De+j6c7dkqHI9QsVwSanYnwgYWqY9f+JP5OIaOkcieAJkHfed9xxoUQA4XPc5r2NiM
         dCTE/rSJUrRFQBi0IVLw45njlLFeGu+OdZPT+MvYx4SF8DFXNKr70Yvg7rSyZZ5QOmlO
         GX9m5wNQofyPNU6inR2l0j/15SnlOyz9cSR07Y9RSH8r0noEX6azWSaKhNgZZrksdko4
         Tdi5wpV4I8CmJkcOmDFKe3H4iMg/zowntYpH6EXvMZx67AvYsdu/2/y0kFAey6b+7aHu
         Is3xSvO20RvbSnYQjXLpHAwT3pWT1/wUkxxBRcDhG4w3tZqJ3hIG/QOPbEMjQakTn5IK
         PlDw==
X-Forwarded-Encrypted: i=1; AJvYcCX2NibxTYiTI9XWVLmvhiBE0A4CW/F8Fq2i/wj7VQOtpwisl/bcJlbjZ7b4QH71GgV9yXKTiorHIjO8lRIPGyKV0BbUenE+
X-Gm-Message-State: AOJu0YyhaLPuFLpnwJnzhWdvPmm/b0Ns9+yNlIFeWFB4M0mVncBQrsbC
	fdi4z/iSR1HO/Sj16ybm9eiqiXOPMHHb65NA/k8xElXCw5NEIX7jZoIsn/8d5f8=
X-Google-Smtp-Source: AGHT+IHwg9aIAW314BBFsP4hayoCOjkU/morxEs5OwYsv0BRjPcUDKtNYzKqFvSVuB7YrmWVtGBEMQ==
X-Received: by 2002:a0d:eb0a:0:b0:609:8d70:d6f1 with SMTP id u10-20020a0deb0a000000b006098d70d6f1mr5817137ywe.2.1709583691063;
        Mon, 04 Mar 2024 12:21:31 -0800 (PST)
Received: from ?IPV6:2600:380:9e7e:686a:98c8:d673:48af:2e19? ([2600:380:9e7e:686a:98c8:d673:48af:2e19])
        by smtp.gmail.com with ESMTPSA id l8-20020a81ad48000000b005ffff40c58csm2808519ywk.125.2024.03.04.12.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 12:21:30 -0800 (PST)
Message-ID: <b36536cd-c62b-4b86-aef7-fddd3eb282a1@kernel.dk>
Date: Mon, 4 Mar 2024 13:21:29 -0700
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
To: Bart Van Assche <bvanassche@acm.org>, Eric Biggers <ebiggers@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
 Sandeep Dhavale <dhavale@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, stable@vger.kernel.org
References: <20240215204739.2677806-1-bvanassche@acm.org>
 <20240215204739.2677806-2-bvanassche@acm.org>
 <20240304191047.GB1195@sol.localdomain>
 <90c96981-cd7a-4a4c-aade-7a5cfc3fd617@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <90c96981-cd7a-4a4c-aade-7a5cfc3fd617@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/24 12:43 PM, Bart Van Assche wrote:
>> I'm also wondering why "ignore" is the right fix.  The USB gadget driver sees
>> that it has asynchronous I/O (kiocb::ki_complete != NULL) and then tries to set
>> a cancellation function.  What is the expected behavior when the I/O is owned by
>> io_uring?  Should it perhaps call into io_uring to set a cancellation function
>> with io_uring?  Or is the concept of cancellation functions indeed specific to
>> legacy AIO, and nothing should be done with io_uring I/O?
> 
> As far as I know no Linux user space interface for submitting I/O
> supports cancellation of read or write requests other than the AIO
> io_cancel() system call.

Not true, see previous reply (on both points in this email). The kernel
in general does not support cancelation of regular file/storage IO that
has submitted. That includes aio. There are many reasons for this.

For anything but that, you can most certainly cancel inflight IO with
io_uring, be it to a socket, pipe, whatever.

The problem here isn't that only aio supports cancelations, it's that
the code to do so is a bad hack.

-- 
Jens Axboe


