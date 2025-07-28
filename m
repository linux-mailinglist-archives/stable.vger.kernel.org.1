Return-Path: <stable+bounces-164885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96978B1353F
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 08:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF37217674C
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 06:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69DE222577;
	Mon, 28 Jul 2025 06:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NK2ksRuu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D98224225
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 06:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753685975; cv=none; b=pjXjvOnj0mEf1OGfxg+IJAJu7FbR1IadTPlRJz0Ne/2qunQTH2nJaT9UlwZK8IQd1gebvINYpFjyHwvY+FSl3H46M0BIW5nIiH5FMezIDE2BWCLNkeOMGxnXU6tpmK2mwRUrh19DNAt+vJWJSodI/1SUr36Wb9mA3f03d4WOPrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753685975; c=relaxed/simple;
	bh=Zty6rY55l3oXDLSQkstyQEcZV4Od3p3xifkiEtT5NNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQ1+/HaRdBdzFDXxIW7KuMGsFV6LQ53fWAO+Z9RAAewzV29ZMGECBKEqpSkEKJQi1hprVvUpKrGeXFsI92yBKKc2u+rzXGLCjmuduW2NcIbcqr8MaK7NocL4LlAfpew/+2VUdEOOr3n4ZgjRLl8jUgRrzENhRj0rMJ/SXrI8qW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NK2ksRuu; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso42427515e9.3
        for <stable@vger.kernel.org>; Sun, 27 Jul 2025 23:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753685972; x=1754290772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=61Dvs9S3tptU3WeTGwnZUa6lMqYqJ3dceUiHA4Ac0mg=;
        b=NK2ksRuuHcZfbsiH75aXv2QqB4cCIViMLgBdbcGN884Pcm3EhCG5Uk9kEl1jO+KyEE
         NduKVxUQR6CIYnQsC/XPotc/q1vgIBGLdfqt2FGLcic2EqmRwwM8RdmfXb6yUBbaQIUy
         wWVyFSNIsxbijtFe8uHyCRAR4R9WJLUfFDTTTS5yU9DpQDsxl5HeJcmnGnKAGYRrfdwV
         og64sr1qb5G+CqQeAqU9HVQuDCE/og0qjpqoWE0UqB8tDRbYwozLxaP15oMo3vfMTMas
         l6yEReIwaOzeDgoDKLvcAFUVF2poYrLmc7L2bB8bCl1EV9PtaKdptkOh1gZxZt3ZdGIT
         40kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753685972; x=1754290772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61Dvs9S3tptU3WeTGwnZUa6lMqYqJ3dceUiHA4Ac0mg=;
        b=fYI3WHSO72UUoU0BQIxyoR+2KMoIiLUmb9uRFiZcySV6QGmkRjgABLIxR4aFV5MYj0
         SRIhiWtAProqJ8uc17vGtvGp7+4+ojI+6IAmgPScCsv1ozNRhLutOzPgcuji8BGIkL+J
         EFbz4YQ1HlljoHSXeKbg6BgelZhHEb3SlHi33kir14oGk2yrrZFs5eX6KlbK73dAigCu
         eJw8HFleHjaYtr1EyduM66ERc/cHKwgxDnGNUixJlI6U5usRH3HsRlIfs9K2wBO6eeiU
         wYMNUEvQGlDk/dNdu21dAs1xt/CsRyrV9FGURMuWGaVzeFcUO0+8kaTSTNpEZQGUk9jI
         AKUg==
X-Gm-Message-State: AOJu0Yx8AON2IicrzULXMQRhGTVZZLoUFzojsxBLaSFwUo62uhWF98Ai
	/8KKwdLgYcr52LPHtZ3DfWhwOAAYbrz0wOhYef53aa6ifW2DY1Qle2gVT3DefWHMZh/iey0YFzq
	iI7mOUFPV+w==
X-Gm-Gg: ASbGncuZReHze04RudhyCG0R9fdgUAptLkm2eSBrOpgYe1FmWkyf3RGDkdkVSwkYRgv
	yGSQn2kQwJujESYg4oxICNfQVzpUleMzaewgF6qN3/27vbW0LHUJujHK4W25+Ksie3cn+rlhd9p
	lNsKcwQxX7jTFr5DPk4WPt7XuUI+2f7P3jQRbwmHlDVwhZpfNU9K5pP7YngHd0nstSahwyfJm4y
	CzkGvgcLm+g/6ET18X90fQfMzBdBUJ1gXfd8AvU0RFcW1sY4WeVOKTpHaVVL4ROEYtIklYA0Qj3
	nHpE5TMSG9XL1t9e8CDb4A45akHekIAfFKJpY5NbuTJMOYks9F9VBTqW5fkIn0D5J5NHsAlJYMJ
	MfVSwRdDY412Gh1T4Kwdjr2erddhNOyo3YWOe+lJTK7ULXw5A
X-Google-Smtp-Source: AGHT+IECRd+TsNuZkkszRtfXc4DmfLDF4C9c7qEETgQXVkuYLjO3th9nJYo4vmRB71ZqZIPs4nJuvg==
X-Received: by 2002:adf:a345:0:b0:3b7:76e8:ba1e with SMTP id ffacd0b85a97d-3b776e8be25mr5417180f8f.11.1753685971558;
        Sun, 27 Jul 2025 23:59:31 -0700 (PDT)
Received: from u94a (61-227-70-84.dynamic-ip.hinet.net. [61.227.70.84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f04abcsm7778931f8f.48.2025.07.27.23.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 23:59:31 -0700 (PDT)
Date: Mon, 28 Jul 2025 14:59:24 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH stable 6.12 1/1] selftests/bpf: Add tests with stack ptr
 register in conditional jmp
Message-ID: <csl7sw37yy5hnqcu6rks7udhuarxrlrjdmdbt5qp6g3wmcel4k@aux63y4e7dhd>
References: <20250721084531.58557-1-shung-hsi.yu@suse.com>
 <2025072251-sympathy-fender-c2b8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025072251-sympathy-fender-c2b8@gregkh>

On Tue, Jul 22, 2025 at 11:28:16AM +0200, Greg KH wrote:
> On Mon, Jul 21, 2025 at 04:45:29PM +0800, Shung-Hsi Yu wrote:
> > From: Yonghong Song <yonghong.song@linux.dev>
> > 
> > Commit 5ffb537e416ee22dbfb3d552102e50da33fec7f6 upstream.
> > 
> > Add two tests:
> >   - one test has 'rX <op> r10' where rX is not r10, and
> >   - another test has 'rX <op> rY' where rX and rY are not r10
> >     but there is an early insn 'rX = r10'.
> > 
> > Without previous verifier change, both tests will fail.
> > 
> > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > Link: https://lore.kernel.org/bpf/20250524041340.4046304-1-yonghong.song@linux.dev
> > [ shung-hsi.yu: contains additional hunks for kernel/bpf/verifier.c that
> >   should be part of the previous patch in the series, commit
> >   e2d2115e56c4 "bpf: Do not include stack ptr register in precision
> >   backtracking bookkeeping", which was incorporated since v6.12.37. ]
> > Link: https://lore.kernel.org/all/9b41f9f5-396f-47e0-9a12-46c52087df6c@linux.dev/
> > Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > ---
> >  kernel/bpf/verifier.c                         |  7 ++-
> >  .../selftests/bpf/progs/verifier_precision.c  | 53 +++++++++++++++++++
> >  2 files changed, 58 insertions(+), 2 deletions(-)
> 
> We can not take a patch only for older stable kernels and not newer
> ones.

Oops, forgot about 6.15, sorry.

> Please resubmit this as a backport for all affected kernel trees.

Will do.

Shung-Hsi

> thanks,
> 
> greg k-h

