Return-Path: <stable+bounces-105388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA35D9F8C52
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 07:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 887957A11B1
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 06:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF90137932;
	Fri, 20 Dec 2024 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZZ0wlMq"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073653BBC5
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 06:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734674643; cv=none; b=nbkR7skaH8DM/JHZP8yu7qoJ34KiW+o3NI4fNgYxuyQAqnYXGCCTZyIIKC85ECU2OHx2+TZ53cBJX/2LZbUkDbjOn/ixEHTsNpn2gmJyyeepxtwvUrOiyV9YQH4XFZNlJx1DvrdMhjeekLpEnn9pwhZh2eIpYIcOwYKFRxAPauA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734674643; c=relaxed/simple;
	bh=K+63evmhKPcaJDy3TNR5bLmXF6anEPRB9JG+PC+Z9n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdYDiplcbqfcQ85LH9BapU5AJe4O9HHE0vT2lBsyez9FY+QnG1l7YrV3dQNSC/KPcLKtNnm51D2X+NCz15+oMffDHI3Cwol2CGcksj/uafghi45UyILW8XYJqYMjSrqDLXR1Qxz51fBhOYsHIwR7DwYcBGklW8DXc2UZBWdtZWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jZZ0wlMq; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3003943288bso15891251fa.0
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 22:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734674640; x=1735279440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s9bqHJQ5tzHFq8ZTn6AtQRtfBjdvfIRt6uscTcnldow=;
        b=jZZ0wlMqjsFgTlujUQnTuUq+PEroT3uRIWkfszJfMK9tp+NvVAri6ziUz5+XgSfsH8
         BSplNh0fjTqv/8/+27ptPGs0fb7yMYbUVmFPMYnW7uiuTbhcipFbR+RfhljWH6iLin5M
         yxhVAi9JtCcBjE33IUHaOHQ8SuFfX2RnQowbVXTXEaxg9ZELlVWOqHlGTLZMfEYaH6ND
         OK12gGBwIrqirEGyJYsfc7haJXwz9kECV7/2zF9AQYSwjHyLOCtFn8URPUk03R/PKUge
         V53ocilJCXUVdPWtSjubuwTbbA/E0xox17TzdxMTnDGLS+4rLz97sYYqsoKHTefOhLLh
         zkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734674640; x=1735279440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9bqHJQ5tzHFq8ZTn6AtQRtfBjdvfIRt6uscTcnldow=;
        b=kIE9ffu1XOpHmB8pHvZyGEsv0Lg8eY+yxWTTJt85FloG2i9EmUTakzyryAIFzcOrht
         8i/FdlfZDLdTJZD8N1gAurc3dfopxZKaZko+cRFNfBNYBnkGDrqEH7lJ1bL1Vld5I2Zh
         o21se5YZjXQ+jhwVGEsj2aIduWauiVUaf/DYybP05chtHupjNrDFTsnDXV9w3mHbBM96
         KSA3fhzuEFHymcLzaEYgNb5NYLFAfgubjC7MhzpxCesvBOS6OiEoTHw3Ci/vKDtqR9UP
         X/PRqaBugKZ89xH9w823lMNAbic9cChUtAGCtJ9Hr0M9Np4GPuZfYTSg4SGh4f973M+A
         1x7A==
X-Forwarded-Encrypted: i=1; AJvYcCVMDM0ZRRmZKqRD9G8AFHdJPnUTXGTvl9HzbYMSUYWVeTv6NWipqmcVAgFLPSVUS6OaPTxrEeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjTSfQyQLsbgDYbSI9NGH76tOCftxap9vIw766qRZfPrS3Yt6E
	2KVSDM0JatBy0JCosQxRz1pnLC897ZzeDwqlDmACiL8MWHYVltIE3t6EVDXx3bc=
X-Gm-Gg: ASbGncsLxwwplEbcD9Fi2yskrzBUqA4g6UDUWk6I8orRq7ZKb4fsrNELZLlwwjOh7k7
	L+tZnpiczGSW/aNwzjqsrKwYKn5T3TxoKYlUwLQrIrUHG42vjooFs1FNcGWmysz8E0MW62B+cy9
	z6tcv6oQc7VpeXqu0mAhan415RdkhBRF3wqow60IcL0+IfCQC++gtOPzxaHwCz/0rh4QA5SNf5s
	jBJo80u38iwHcrQ7uqOuzuCOXAkT0DeCXDIIOu5SIpy/IGqFwkfdlFq1Wxy65sPssunH0KgZc5X
	chpCJhqO8p53wxzbffmE+2O3Mae7eVDp8IkI
X-Google-Smtp-Source: AGHT+IHKZeImslFcbVUJpHmK8DIG6VFZrKf6PiTgPTPO2VSOU9Xx30flk+6qLwRpIrb79Uec0dN5qA==
X-Received: by 2002:a05:651c:4cb:b0:302:264e:29e4 with SMTP id 38308e7fff4ca-30468630c1amr4194721fa.39.1734674640209;
        Thu, 19 Dec 2024 22:04:00 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6cb7fsm4286001fa.19.2024.12.19.22.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 22:03:58 -0800 (PST)
Date: Fri, 20 Dec 2024 08:03:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv2] media: venc: destroy hfi session after m2m_ctx release
Message-ID: <ga4g3k7j6hx3qs243lcsfyzpuonh3wvxjareaurlg6e246xf7i@xdlg4l42fnuc>
References: <20241219033345.559196-1-senozhatsky@chromium.org>
 <20241219053734.588145-1-senozhatsky@chromium.org>
 <yp3nafi4blvtqmr6vqsso2cwrjwb5gdzakzal7ftr2ty66uh46@n42c4q7m6elm>
 <xkmtptaqzvwe2px7q7ypnkltpx6jnnjeh5mgbirajzbomtsjyz@gefwjgfsjnv7>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xkmtptaqzvwe2px7q7ypnkltpx6jnnjeh5mgbirajzbomtsjyz@gefwjgfsjnv7>

On Fri, Dec 20, 2024 at 01:32:48PM +0900, Sergey Senozhatsky wrote:
> On (24/12/19 15:12), Dmitry Baryshkov wrote:
> > On Thu, Dec 19, 2024 at 02:37:08PM +0900, Sergey Senozhatsky wrote:
> > > This partially reverts commit that made hfi_session_destroy()
> > > the first step of vdec/venc close().  The reason being is a
> > > regression report when, supposedly, encode/decoder is closed
> > > with still active streaming (no ->stop_streaming() call before
> > > close()) and pending pkts, so isr_thread cannot find instance
> > > and fails to process those pending pkts.  This was the idea
> > > behind the original patch - make it impossible to use instance
> > > under destruction, because this is racy, but apparently there
> > > are uses cases that depend on that unsafe pattern.  Return to
> > > the old (unsafe) behaviour for the time being (until a better
> > > fix is found).
> > 
> > You are describing a regression. Could you please add corresponding
> > Reported-by and Closes tags (for now you can post them in a reply to
> > your patch, in future please include them in your commit message).
> 
> The regression report is internal, I don't have anything public.
> One of the teams found out that some of their tests started to
> fail.

Still you probably can have a Repored-by, unless it's anonymous report.

> 
> > > Fixes: 45b1a1b348ec ("media: venus: sync with threaded IRQ during inst destruction")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > 
> > This is v2, but there is no changelog. Please provide one.
> 
> The code is obviously the same, I only added Cc: stable and removed
> one extra character in commit id "45b1a1b348ec".

This is the changelog. It helps reviewers to understand that there were
no code changes between versions.

-- 
With best wishes
Dmitry

