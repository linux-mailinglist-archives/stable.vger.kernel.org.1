Return-Path: <stable+bounces-185627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E36BD8B4C
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 12:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05043ADE79
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 10:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D092E719C;
	Tue, 14 Oct 2025 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="KhRbTcCK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680532D193C
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436917; cv=none; b=B79NynQm4fhmHpk2AfRT4ZIs0Qxafvk7xXv55fFfdTouP5F6rBYDtDpSLPvxYvr2HiVyJwMEopiMldmjKcM8Xyo1jhtcxoTpLdW6Eq9yYjJiVlwSoiVaWp3PvvuIe8FgFYA9qEku681/nQnZFRPusORNCVuKe2+CTbiKIosT6vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436917; c=relaxed/simple;
	bh=14Etygw7WtPpgXOE948mx5h6cWwRuoAVhGXgkcIcs1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/LsaJsE3TaCaG17IdA/frnUYbbH06uazA1k/ZqpcBhx8lBAzzB29dEimRydDkuO6WBppDwv7kvkZIm9AvXqyraWTj7E9D7ekv5rOJ8QicbtLQ3NLbGzRG3pYLDFBqJmGv60yikBAhtyhUPGvaWNuYqldrRqTrbhh2JpzCr+Du0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=KhRbTcCK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e4f2696bdso51955815e9.0
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 03:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1760436914; x=1761041714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MrIIKq5VDN62JRdWP+77b/CdflRUKD6ACbZlPSNFmBY=;
        b=KhRbTcCKOwt1nRUPjHPgrgjWoNjUxrnLiaeRJZm0ZuV2a73OSOejhjfLNKD1uMtxUW
         DI+iVNXi/aWLlebDO1GPgAD8SfnTa/iwi7kvoRbZWMcvmXeyKoys/8g89iQekP8SZ91s
         95BV40bcxCDhToufb2Rbqlw8rZi7gvvzcYHvazHVr9wed7LSZs1DpJQSPDAmqtkxjjAN
         uvUx5vbf95EssSr6zUgWUMXOi8am9PgXRQO/JKimbZvVu/f6dP+k/zbl3aHUzJ6SmAKp
         2uFz3EzDE2pb9jx4UMarKi56ty8nlFneab4oQUNJlD9zj3Y9M1KM9Nakaoj0zNPJLhaz
         QSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436914; x=1761041714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrIIKq5VDN62JRdWP+77b/CdflRUKD6ACbZlPSNFmBY=;
        b=A4OSjPb3P1Vxg8cgChALnR7S23GOIz00iOXeSM4CPPhnH9cM2Ax0w+SYIMQUAtbYRD
         b5Rf0q10dwtwta2EnIL+PGcUFyIDCulv2uZ0W/8i8OvJAXkV/wgnfeSZpIXagGPjW1+f
         Ib2f5yGq2t1d7MW4N6ANaMWjJ5SI6opfxSVnC9XLypc4ZXLXXTqzlKPPRc6hrmZakQ6b
         /tK/YR8JfBMhLe/tyaQJbLjtrQmWwfWBahJFxb4IzlWqbULy3OhC0FKyoBMMB8chRCZ8
         cp+oYyhlxvNxWFBx+ePXNAuCM7qbaCy0L6DFoKl4+9W9joGCGALjsnf4Ng60PrEi+Jv8
         K4Ww==
X-Forwarded-Encrypted: i=1; AJvYcCULySs7cSIX3mFmpPuOLzrw80fczz46GxROGKryHe5oTFOk6wzj671OYoJ88LP7cW7ZLjWQI8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuOmz/BDtxsfN5CcMpF28mEfxuLhD4MjmEwzfaJK/uq8OZI8TZ
	30PjEFuHifASCNzM/QCeZbiXLQdNy8qAUtphS+3MW6knhEYLmUbWJiE6y3j43LsYS8s=
X-Gm-Gg: ASbGnctbEdDDC8HUU6dreAOJELSgSG9QP01tA01vMpXGd7/HnbmaqiyfYHyndaWS6p0
	Aa1JZ95Iiqy8HHmKUVZgP4r6ktZhmM/XE0g5n0hhjAyECLZtnzXBuaDaSysa5U3lww+W6QMeP7z
	Eet/jJCzFcRv56gYhoKOUIE9oO+kHXJB2MA3Hcwnid94igA8AhDt04RtuIDbDrTE1onbY+2v6ue
	AGN1KuWoB+3S+b4zOPqCsgsPwKOjt873RrfKF1lIhd5prbHKSa4KmcL7LOvCSmITNlFhQo3g6Ix
	ZJezEbur9PzvaepTjSrKbpcImOpkgJsO1/5ZeqCWeFqG7VH//8WOP1jSJ+xrFAHSbQor7VXb379
	MXivCke/Zy/kweEGavT21P4Tzcg==
X-Google-Smtp-Source: AGHT+IELPWvY5XW8S/2q2NqbM1z7T3e4Zv2tUvs3NJqtyA6KBFgk27XBQjSIlKd9c18cAaAbYkez7A==
X-Received: by 2002:a05:600c:548d:b0:46e:49fd:5e30 with SMTP id 5b1f17b1804b1-46fa9a8f4e3mr177906435e9.6.1760436913213;
        Tue, 14 Oct 2025 03:15:13 -0700 (PDT)
Received: from localhost ([2a09:bac1:2880:f0::3df:19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3cc939sm152574265e9.1.2025.10.14.03.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:15:12 -0700 (PDT)
Date: Tue, 14 Oct 2025 11:15:11 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Chris Arges <carges@cloudflare.com>, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "sched/core: Tweak wait_task_inactive() to force
 dequeue sched_delayed tasks"
Message-ID: <20251014101511.uzeemvmm334mfopy@matt-Precision-5490>
References: <20250925133310.1843863-1-matt@readmodwrite.com>
 <CANDhNCr+Q=mitFLQ0Xr8ZkZrJPVtgtu8BFaUSAVTZcAFf+VgsA@mail.gmail.com>
 <105ae6f1-f629-4fe7-9644-4242c3bed035@amd.com>
 <CAENh_SRj9pMyMLZAM0WVr3tuD5ogMQySzkPoiHu4SRoGFkmnZw@mail.gmail.com>
 <0fc0943c-8ec1-47dd-9b3a-82c68c6bde34@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fc0943c-8ec1-47dd-9b3a-82c68c6bde34@amd.com>

On Mon, Sep 29, 2025 at 09:23:06AM +0530, K Prateek Nayak wrote:
> 
> Thank you for testing the diff. I see Ingo has already posted the
> scheduler pull for v6.18 which indirectly solves this by removing those
> early returns.
> 
> Once that lands, I'll attach a formal commit log and send out a patch
> targeting the stable kernels >= 6.12.

Hey Prateek, I see the merge window is closed. Do you have plans to
submit a patch for stable now?

