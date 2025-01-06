Return-Path: <stable+bounces-106843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE6DA0267D
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 14:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6FB16499A
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 13:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C4E1DE3CB;
	Mon,  6 Jan 2025 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c++d8cPu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEF51DE2A0
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736169893; cv=none; b=a2RFNauaekf6JDx4itozfpTJlnFdI06gbXuSsll7u9nGbZG+rkE8sVwDWqE21sO70efMipo875AadYKJMyesAEUhKtq1PpkNopsVqBIas1bo6C1C+Mj8d8aCjU7fmWvZEB/mzE4c7sIL2FT/qRcR1Os23+7GAuxb/eWGYHjScXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736169893; c=relaxed/simple;
	bh=A6SCwTH0ZBMAjyXZe4Ko+ILCUaVYRr9Sxpbg6XtVUkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huxtAYzUb80Yf+2FEzAiX4v/ZGPdqrDtCyCINt3piNPQTqu4f5z8waEqwfPdYAzm+9UCmOwuLh9F0LHexg9MkcNMc1lTQYg1BFItDHdS6jsQMAJSbXEu+6EGfXgrBsiSl9B/Z+mf2QCI1z6WdjhpX3etGJ8oxnyaUpLOcgCTnrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c++d8cPu; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so16537582a91.3
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 05:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736169890; x=1736774690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vUfLE4D3L43/Hjy6xgTH9enXIQ9LZQ3WuF35y/r7t68=;
        b=c++d8cPuESR6NexYKzQ16ESFV55wFfEmBpIooGun7tyUrQCMiAGkVMbeU8Lzj0IlG8
         leeoed2jdePW71hV0nOKn3we8OhbEdhUiLk/X9tlm50HFkJPyvupjQvz1iKMrowU2jcE
         epu4N2rpS/zzpQVs85ura1qLSiNIsRs+9tBUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736169890; x=1736774690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUfLE4D3L43/Hjy6xgTH9enXIQ9LZQ3WuF35y/r7t68=;
        b=RcdA4M6XS6sGZAy7tZP9oRiLAf5KhcdnijKWhIBTWawGN10Fpoo9dNxvxybSLq4oGZ
         rbVIy/bJuhOYqFSODVK/a5NcRqH7cWd7SX9UBeVC4Pum8RrHV6wIDwgDwFljJ4VhVbms
         9Nq2aqpDh9/wqZO2xO528ZRT+2Os02I1+bt7k12GLvKGw3esm+PTDla2d9h+6coqZKgS
         aysP2Xw6ADr8RX9Kz3QWzSRQvhpIGr4jjH4QHiwFz/9K+A8X2LdKLRN8aHBux9urFsup
         Cbmn/iUR/6IP5fTyHTaicz/9u4sDBWnSWUqJnh864uI30uIoYpJoGnQO/ogMORZCQCS0
         QvvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsO97SEXu/68aHI5Tw8dDe/ZlfkXNIMP58vKNJpdPZILGs5g2TrLvZ6zn555igt5UuzhNx3QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyciR+rQ0oHvIcen5L8FxyH3AkPuhdukD4nmc83liaqT3hf1Wfm
	jK/lKWp0UfCB7IJBznVgn+5UgLr9BILsLqwxQahoiJ9DDb+9QeOMc90DxhUghA==
X-Gm-Gg: ASbGncuuNPtgNHrWgyM6ThTwZzBsLu+Cshfs+p1JkOjvpQcR0DAwbcVBesBRuTuTQqi
	YPZ43SBK8IXr96LoI+dDvD80PpGLchioMBUydTCNAfu/mSQGAj6XFtMAaQ6lOsD4znyENjGa8Si
	bea7jaNlfiwXb2v4683th1bRh9G0U0No06T7Ptgy/IPtr0FnU27m2waHcih+1OFNboCJ2/4yP3Z
	mHl2REj1kfd5DBml4MKUPZF7CAbsyY2YJvOCK9hXwcXEB/yoU+bDgzlI6A8
X-Google-Smtp-Source: AGHT+IHZBSveO4NqFWbE0Vn/nrTYHh/OfJIa6sa9I67SklwWdJzelh6PPGsVsnRTOyb5vgsDPuYezw==
X-Received: by 2002:a17:90b:5183:b0:2ee:5111:a54b with SMTP id 98e67ed59e1d1-2f452eec7dcmr73020037a91.31.1736169890617;
        Mon, 06 Jan 2025 05:24:50 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:c142:c1e8:32c2:942a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4633df7c0sm29908133a91.18.2025.01.06.05.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 05:24:50 -0800 (PST)
Date: Mon, 6 Jan 2025 22:24:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Nathan Hebert <nhebert@google.com>
Subject: Re: [PATCHv3 1/2] media: venus: destroy hfi session after m2m_ctx
 release
Message-ID: <3teih4ch3qze5xdt4at2snv4ln5ebffhdc4f7bclbqxr3dhoiu@kwjnitey74uk>
References: <20241224072444.2044956-1-senozhatsky@chromium.org>
 <20241224072444.2044956-2-senozhatsky@chromium.org>
 <bd751d52-c378-4706-b93d-a063d1b8352d@xs4all.nl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd751d52-c378-4706-b93d-a063d1b8352d@xs4all.nl>

Hi Hans,

On (25/01/06 14:15), Hans Verkuil wrote:
> Hi Sergey,
> 
> On 24/12/2024 08:24, Sergey Senozhatsky wrote:
> > This partially reverts commit that made hfi_session_destroy()
> > the first step of vdec/venc close().  The reason being is a
> > regression report when, supposedly, encode/decoder is closed
> > with still active streaming (no ->stop_streaming() call before
> > close()) and pending pkts, so isr_thread cannot find instance
> > and fails to process those pending pkts.  This was the idea
> > behind the original patch - make it impossible to use instance
> > under destruction, because this is racy, but apparently there
> > are uses cases that depend on that unsafe pattern.  Return to
> > the old (unsafe) behaviour for the time being (until a better
> > fix is found).
> > 
> > Fixes: 45b1a1b348ec1 ("media: venus: sync with threaded IRQ during inst destruction")
> > Cc: stable@vger.kernel.org
> > Reported-by: Nathan Hebert <nhebert@google.com>
> 
> Do you have a link to Nathan's report so I can add a 'Closes' tag
> afterwards?

No public link is available as the report was internal.

