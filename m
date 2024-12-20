Return-Path: <stable+bounces-105391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 892DF9F8CB3
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 07:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832CB1898010
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 06:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1933019D084;
	Fri, 20 Dec 2024 06:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GJYQDfLX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D893199E8D
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 06:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734675749; cv=none; b=gr93dvZf6wcS2fRFKKaXEuRW1T9SHn8YM8u60+vI7mOLOis0mImX6YFAp0NIUuPbap3juqIDlD0h8ISWOv35ZlD/WwPhNn1XLaIUxmiqbLrOTjQDB0Oe77kXA98XSh0Mn/pXgmbGO5Gv5muGONzXJ++KYL1eeI+Gu90SOVl9/uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734675749; c=relaxed/simple;
	bh=yTxtHlpZhJaWLrNGQktrEe47fUy0ci77cALAMbauTGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYjS/mzRvganWnJ9xcogAUxLvgN8bUCYg6LJQF/B9IytJFMioawT9mqEXI7Bpvnd1vnC7j2BBOdVfeUQH84rD8qd8zac2KTF/0ljIHPKFmWdzU4OJMGC9iTz8I8pQvvdQLktIi7/gDZtJjuhjIljDe62gHhIMn+/xOgInsM/+ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GJYQDfLX; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725ecc42d43so1303706b3a.3
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 22:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734675748; x=1735280548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hENRJeDL2zrkFH/JRQSrNdsVu5tnCmHT7uSM0w/i5Kc=;
        b=GJYQDfLXfDqwTYjAV0XaGCgvIqBwhp0H1Z/gfuppK7LLCA9MI1FzPdzkR62WNlauLb
         9QdSGJ6rSOJ17jR4Ml2xJWKIZSdqFR5d9bnnxQJ89MfxPLXr1YRn/dWWK16XYSlzM9CI
         7pfz1ZA5Ok+IRYXk8j7irPI076eAOhyM+Q+nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734675748; x=1735280548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hENRJeDL2zrkFH/JRQSrNdsVu5tnCmHT7uSM0w/i5Kc=;
        b=BujsmNNQ1BsOZ1e3A8bLCTuUXrtzKquDlogtWh2bFZFHJA/NEtYOnKvyI7rfOneDIi
         NRzP63iHijGNRFf9ssH1rrGk0++YhjDLNta2ppil7YpaguHswbGd/tc6PmsFGiDf5tVe
         t/8g6a/maXpzeEWFn1jvklWv1RkUKMH8J5I6JohLc+g1sGkZhPFDWTGJU5oKVWFV5UXd
         CEwdEUqnnN4PPYMaUnQUuX6hJjyllJS/RSPOgGbgqAKp8nq4HdqJd5rYbbgfmpN2Emra
         9YMEKSAoKcdcbyhrp4u2CIr+bbsKlpszPgsVxc3e1y2MGxKgPRB9wx1Gq4wJwtCEyEPh
         p1FA==
X-Forwarded-Encrypted: i=1; AJvYcCXNd9+EXdB60XmpF1LySPQKSiKFumL8yovjIpNE65qrvWemG7e0ZN+EodafSdNIDxq0AfOjpGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu9VoDPXR3okG2x0zhRlBpmXGa2qeGC09hkSe9V9fNJqOaOTMp
	LbzrvQw9PTvLKvt18hkC89beW9esiPFHfPXbPcIQPNZbfp2MuhUAH072zW2VDQ==
X-Gm-Gg: ASbGnctkbY7uuUNRQdkxWmBTKZtXCd2DYDuLnCnNvGpPad1tLShuYe7Xn8Y7hGCl79v
	YN4MbIE69dd1xKFwTzrzMr1Z+WPMBr+tayp+l/8RVQBmGQTACYSpT9IN04tuWfqviQNMDftNuYR
	VItss4tR8icAMqjymS+IjQ6+EEZ5A9snT0wUBmijf1NetbaELPwuhnIyHGrgSWeGHSBlrQS4AFN
	1pFXI3ed8KsWeTGnf/pTmCQ7rZNk9xaq36TTV8yHLSNwaxy0BzFfw6FAIxp
X-Google-Smtp-Source: AGHT+IE9RQtbpm0MmqI0gbDVgr7DDJO6/SI2ZeXyHFwwSh9QSDTdaNOMl2YtA5pMMEZot8nSPSy9Nw==
X-Received: by 2002:a05:6a20:1596:b0:1db:e0d7:675c with SMTP id adf61e73a8af0-1e5e045a0b9mr3334587637.13.1734675747746;
        Thu, 19 Dec 2024 22:22:27 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:8e99:8969:ed54:b6c2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad836d0fsm2358036b3a.73.2024.12.19.22.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 22:22:27 -0800 (PST)
Date: Fri, 20 Dec 2024 15:22:22 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv2] media: venc: destroy hfi session after m2m_ctx release
Message-ID: <36jk74quu6pg6q6fw3u6k62uzupcjtiwrvbnn2gpwp4iolxeao@lykirrx4j7mn>
References: <20241219033345.559196-1-senozhatsky@chromium.org>
 <20241219053734.588145-1-senozhatsky@chromium.org>
 <yp3nafi4blvtqmr6vqsso2cwrjwb5gdzakzal7ftr2ty66uh46@n42c4q7m6elm>
 <xkmtptaqzvwe2px7q7ypnkltpx6jnnjeh5mgbirajzbomtsjyz@gefwjgfsjnv7>
 <ga4g3k7j6hx3qs243lcsfyzpuonh3wvxjareaurlg6e246xf7i@xdlg4l42fnuc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ga4g3k7j6hx3qs243lcsfyzpuonh3wvxjareaurlg6e246xf7i@xdlg4l42fnuc>

On (24/12/20 08:03), Dmitry Baryshkov wrote:
> On Fri, Dec 20, 2024 at 01:32:48PM +0900, Sergey Senozhatsky wrote:
> > On (24/12/19 15:12), Dmitry Baryshkov wrote:
> > > On Thu, Dec 19, 2024 at 02:37:08PM +0900, Sergey Senozhatsky wrote:
> > > > This partially reverts commit that made hfi_session_destroy()
> > > > the first step of vdec/venc close().  The reason being is a
> > > > regression report when, supposedly, encode/decoder is closed
> > > > with still active streaming (no ->stop_streaming() call before
> > > > close()) and pending pkts, so isr_thread cannot find instance
> > > > and fails to process those pending pkts.  This was the idea
> > > > behind the original patch - make it impossible to use instance
> > > > under destruction, because this is racy, but apparently there
> > > > are uses cases that depend on that unsafe pattern.  Return to
> > > > the old (unsafe) behaviour for the time being (until a better
> > > > fix is found).
> > > 
> > > You are describing a regression. Could you please add corresponding
> > > Reported-by and Closes tags (for now you can post them in a reply to
> > > your patch, in future please include them in your commit message).
> > 
> > The regression report is internal, I don't have anything public.
> > One of the teams found out that some of their tests started to
> > fail.
> 
> Still you probably can have a Repored-by, unless it's anonymous report.

Sure.

> > > > Fixes: 45b1a1b348ec ("media: venus: sync with threaded IRQ during inst destruction")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > 
> > > This is v2, but there is no changelog. Please provide one.
> > 
> > The code is obviously the same, I only added Cc: stable and removed
> > one extra character in commit id "45b1a1b348ec".
> 
> This is the changelog. It helps reviewers to understand that there were
> no code changes between versions.

Sure.

