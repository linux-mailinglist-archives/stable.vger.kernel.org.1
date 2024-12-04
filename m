Return-Path: <stable+bounces-98217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDCB9E31DF
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 04:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2FB22822A3
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 03:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF82137923;
	Wed,  4 Dec 2024 03:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WSpazvX1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FDB126C10
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281838; cv=none; b=EP3Hm0lldXnfSrHFaYVVZT86fZWWU+AnMFtwPYJ7pSLKWIkP/boRpL3KerDbWypBrUY6QmNnAq2m6JCXGHEUOjOYJkxMCRmRgvTBolaAOvmUAEEkHuAueCL2MEWLCHXbEZStPaNhx0dlm3yb5BLjF38ruo5hVvB84lx5dodUrfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281838; c=relaxed/simple;
	bh=5BJcVqk6DTq3D6w4oC0l72ZIPdhLBjr1W7ee3Bk5PEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhhQQXO7sazixMs7lXBxtr5fMVoFHj/y1XA6PDPQbQysuJSZ7mELW9ATagDC0CxYbKnRE4vO6OMBqES6zmnuJ/XAkwn9scIj78H4Mhg6oSEmRQhJB7OTbEmF8TIM+uj4ywU9h7WbjWPm/4OHmCCnO2pNYUZD9UCp8UMd+MO+qm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WSpazvX1; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7fcf59a41ddso374861a12.3
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 19:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733281836; x=1733886636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iNiwGOMCqkTh/NdTdB70sdVoyZNDTHaO6MJHeQ4EdJQ=;
        b=WSpazvX1YPZblxNoiuZe4kZAmbXOIvjrguzvl2WmzAfxiV674N1o25wlMcpgMOEAf5
         JjBPOL9PzJIZaj/R20Hmujg4xj4JC6HV/sQAFtlRtnH0k4I3ozhRMoxihwfPShzdigJN
         P6I4Tlw92kngfaoT57Hu4mvgRYn+VCmsqEmGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733281836; x=1733886636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNiwGOMCqkTh/NdTdB70sdVoyZNDTHaO6MJHeQ4EdJQ=;
        b=c5ef5d548z7SZRTcm6xytDxSFym6P/qTSxqjat2LlPI8/9RiTGP2OEy5WRfiOfWL3g
         Tq59TyZFFTvI2qjcPpuY+UlYYMuW5fjosRuJrRU4v4JMrI83wEq7FEoB+pyIFuVR2coO
         B9wVBexkK4BL9/Vn3tamPNlbUMYX1jBahmWF2QbOCv/9jkHomYmh6B0XnGG4k7XoGZvd
         P6H5/nqjMmHcQ92xUv0pqI4qVlUnqZQGv+cnQZKrerC7329DYEK0J5oNaUDeZfl6uiPY
         eu7VITA8Hh/3Be3KeKViwqYfBSZCgAE0IIGJTndEQ1VIP3DkKUJKk20JZqwdyB/rNTVX
         ccbQ==
X-Gm-Message-State: AOJu0YzUbnqT7Q5m7kQ3QmbQrZ46Y60HSx+3e6yDERnaU0hEVwDGaVlz
	xQ1ffmUXe+lzOxquc13wTGqFs4wxhYgjBW5Ju+YRWlqS8jysrqQjKNEsQ+T2IQ==
X-Gm-Gg: ASbGnctqSdWznJacQ6nIyozoHeA0j3K3sDFt/SiSDV1gXjqrsI4v2U/MaluBP3TjkL0
	AYf8gP2AgKTh2/UAJQzba3g/tVJ8Bgz7Ic6fRYJjQ+t/FNFfoM8ePtORZGSQSeUH12RXA8jY01F
	JyoAV2ErH/GciF3xAGXnDP4j5go0aNZMdF7nKTi80JHE54r05sFrtT1/hkfa25iRqlaUmOBasZr
	O4vSZYNEEnxDYIybPizPrg/+0WG5OKXwySY++KVufufJI0+7Q==
X-Google-Smtp-Source: AGHT+IGOh6c6XB+Mf7vja/zLx4pOyQUTl+vZY1mp61nLNQMy+svMsSvj7/cb2KEHjHiTEcma/HAwBA==
X-Received: by 2002:a05:6a21:78a8:b0:1e0:d632:b9e0 with SMTP id adf61e73a8af0-1e1653b7c5amr7319355637.13.1733281836467;
        Tue, 03 Dec 2024 19:10:36 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:f520:3e:d9a1:1de])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7259056e0d5sm151570b3a.81.2024.12.03.19.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 19:10:36 -0800 (PST)
Date: Wed, 4 Dec 2024 12:10:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Tomasz Figa <tfiga@google.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Bryan ODonoghue <bryan.odonoghue@linaro.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Hans Verkuil <hverkuil@xs4all.nl>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 207/817] media: venus: fix enc/dec destruction order
Message-ID: <20241204031031.GF886051@google.com>
References: <20241203143955.605130076@linuxfoundation.org>
 <20241203144003.826130114@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203144003.826130114@linuxfoundation.org>

On (24/12/03 15:36), Greg Kroah-Hartman wrote:
> 6.11-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> [ Upstream commit 6c9934c5a00ae722a98d1a06ed44b673514407b5 ]
> 
> We destroy mutex-es too early as they are still taken in
> v4l2_fh_exit()->v4l2_event_unsubscribe()->v4l2_ctrl_find().
> 
> We should destroy mutex-es right before kfree().  Also
> do not vdec_ctrl_deinit() before v4l2_fh_exit().

Hi Greg, I just received a regression report which potentially
might have been caused by these venus patches.  Please do not
take

	media: venus: sync with threaded IRQ during inst destruction
	media: venus: fix enc/dec destruction order

to any stable kernels yet.  I need to investigate first.

