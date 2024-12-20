Return-Path: <stable+bounces-105387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7AC9F8B3F
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 05:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 196247A1B9E
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 04:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B157082B;
	Fri, 20 Dec 2024 04:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dxugQtnU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BF03A8CB
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 04:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734669175; cv=none; b=DDutpGpT/aQTnfU6VRmP8MLL/U1OEwlExEBQFIz6VwGiCG6NKDgaKs0Z3l2FJUKVK6r74OHZYhTUu+JocOfxGMv+5zdPKn1DMv9glnsgv9cexuZwAd9Nn8KBOiVNwg8RbhZcDvM2+F76Efeg1kDLFNzMujwIicy2/kUDBqffR4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734669175; c=relaxed/simple;
	bh=OSrK4P8S/D7uJoH0nEX3pAuAWd0uXm4JvxyRw6d9X8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4D9c6F0IOlG3yAhPiZ6Y/iUIDvzeg7S3blrRYbjVlHiPxW5K7hF0v4KbJNxXYsR7T17RCZks9euEpFK5CbOybXfI35rwlT+o1Ast7aNRG7brxW0T+SYufNLyvwsjWDkt80dAXNyln4mA4UjX5/HLZKLcRH7qPFUdO2wON14eRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dxugQtnU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2163bd70069so13914235ad.0
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 20:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734669173; x=1735273973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVqSzgdvMPcdx/FNg6nKx+Oqk/eOtN9slCOURnBKQ6c=;
        b=dxugQtnUiWRpp2K2bxhc2kLnQB46OQwjGYGeWgN8kc2jrSY0ZSg/qL1Yq5XH3SGwdh
         jHWfX7pfcyOzVCeX0MyFKHn3jDnj4NtMW+tRxQra8vxUWsFvHl+SR1t4A5BUkrTf/CXw
         2UzCe7K45TC7WrWFK/STQO7w9/eyIMnCAtnRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734669173; x=1735273973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVqSzgdvMPcdx/FNg6nKx+Oqk/eOtN9slCOURnBKQ6c=;
        b=juFXlNgqcBJAcjJ1PQCgs3gFnW7/edvj0oGYdPPreu2uZJzQG+AiGEqp5iSFEIlvWC
         CdrvR1V/4BTWRi2VerSeLmY+lyLiascDzqF6a2xQ2RrXWqNZuytIpoUNwBFvKEubB+gL
         jGyUUt/bVFtXuo3uDbCCJhrHBIFn3KsMiEbKWzON0qW1gRQ/dxTP40sJqrFI/PGKwNqm
         nrfZSFFv59Tuw0DmZucakXev9pHkyfRoyzaRSF/qSzlNIr/SRkt2eSziIIBrb5Zg2wDg
         8CvqIKiMGC2pXRzH3H5fh7yeMB2fwsjciRWM+/EdEx/RENC45sMw6BS0KsbVUWZu8Q3E
         aXbw==
X-Forwarded-Encrypted: i=1; AJvYcCXSvd0sBnWKLD2FsCa+BZ7qL7UqaB8sR+f7LsCQjpOHwt34iHx8NWCjY6Q51QjU7uQvaejB9M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOFQMMUmYNfVYP7L8SImBZnnLdViD5lutNwJ6n3HZR4Fi6RNw7
	qf0pMkCwdW8xYVjl7VNfuZQpOvXy3k8FLy4f4NuQVBqwFjbfZPhQ41rChDSCVKgpcAMhO2UKqpA
	=
X-Gm-Gg: ASbGncslZu3o8aSZp9IyUYcNybZZmU+lnAzJ4+W28Z6/kLI1OU4r5e2e1DUeNmwDBeo
	7QhLy2pj3ClgMkoxmy/J8E8tVY1dlr4K3mQYs3wuBpG2dBqCi4Dhlnc1V2/Bv7reh1q7HEsyzI2
	40QqFrzlLt86+nqrwUhNoiAS/iZZXZsODHtZ+Nox8Wm4HZLMe4UJapy9ShCUy6qqIM3nhVpng/5
	vCZsOWx+OpM+k94IJloUGAu94KW69VJ+wc7AaVB3Xu2NvQUqmDqHTbCEjyb
X-Google-Smtp-Source: AGHT+IEcslkGB6AJ/jFfNUJKFDnDJ0UoXitm3+XznAk8iVhKCkHnnHczShCxzi/hkt0jWFWF298nFQ==
X-Received: by 2002:a17:902:ccc7:b0:215:94b0:9df4 with SMTP id d9443c01a7336-219e6f283aemr20782245ad.54.1734669173741;
        Thu, 19 Dec 2024 20:32:53 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:8e99:8969:ed54:b6c2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc964b1fsm20366725ad.37.2024.12.19.20.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 20:32:53 -0800 (PST)
Date: Fri, 20 Dec 2024 13:32:48 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv2] media: venc: destroy hfi session after m2m_ctx release
Message-ID: <xkmtptaqzvwe2px7q7ypnkltpx6jnnjeh5mgbirajzbomtsjyz@gefwjgfsjnv7>
References: <20241219033345.559196-1-senozhatsky@chromium.org>
 <20241219053734.588145-1-senozhatsky@chromium.org>
 <yp3nafi4blvtqmr6vqsso2cwrjwb5gdzakzal7ftr2ty66uh46@n42c4q7m6elm>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yp3nafi4blvtqmr6vqsso2cwrjwb5gdzakzal7ftr2ty66uh46@n42c4q7m6elm>

On (24/12/19 15:12), Dmitry Baryshkov wrote:
> On Thu, Dec 19, 2024 at 02:37:08PM +0900, Sergey Senozhatsky wrote:
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
> 
> You are describing a regression. Could you please add corresponding
> Reported-by and Closes tags (for now you can post them in a reply to
> your patch, in future please include them in your commit message).

The regression report is internal, I don't have anything public.
One of the teams found out that some of their tests started to
fail.

> > Fixes: 45b1a1b348ec ("media: venus: sync with threaded IRQ during inst destruction")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> This is v2, but there is no changelog. Please provide one.

The code is obviously the same, I only added Cc: stable and removed
one extra character in commit id "45b1a1b348ec".

