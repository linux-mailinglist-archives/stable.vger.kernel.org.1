Return-Path: <stable+bounces-50225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FAC90515D
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 13:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7995E1C212A3
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 11:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326F016F0D6;
	Wed, 12 Jun 2024 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xuuf40in"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8505B16C878;
	Wed, 12 Jun 2024 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718191653; cv=none; b=rSo6sEyiVpdZslbcJy56epd1UoHQKq5LjLl5h0VCtmlaFhQGzH0cGmbG5lmzJlKie2qptWA22y8BQdBWY147oNdiFeocZHXHIC8FAClrjRlbD+VmmmYQGJsqHZSHVjcKdo53PNpmQeZMn2KOm/0gd+4I1DRtW6L1HHB1PerYt9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718191653; c=relaxed/simple;
	bh=2WXhunE0FX83qRs/SGKpCCNORSUg99lCzf12ZKZzJD0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4QaU2UiJ7y378RBD6j+dybEefBI0wwq+UTYhC3oJVmiAO5UhA3HuGy2lAwq1cQjkbdon+WOZ55rll8BcR+UobpGyQyAvJVCn9XQeg65Yj4YCHkJ/z2+3NVPjsJNRgINQdnvaCIjlEd0bcOSONuxrnAEqxEv+vB9lXHefrOyYtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xuuf40in; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52bc274f438so2948449e87.0;
        Wed, 12 Jun 2024 04:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718191650; x=1718796450; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2WXhunE0FX83qRs/SGKpCCNORSUg99lCzf12ZKZzJD0=;
        b=Xuuf40inTwVHXOw5MahtPUReIoIQTy3lP8yvO3OmiJ0BYsXNOaqKmxlCi7kvqkJO5s
         Z6YQdR3xFX3SnpJwmFZsonPOYmfyYe/dUFfbzxRKkmF0UjZeiW8vEWZc2VYp5ELynUdK
         spueHseTiA1KKDEiarFBNg7zPoFnrWg5jOfLNm5Ev34nK4xfUzCXEuwQKiHlJ3B/Bo7Z
         SX2ryhE5P0VKa/gphGqsA1bsmlavW/dr/EuO6iLcheVl18KYTzXwzKgIgZy8LLpWJI6/
         CoqjCmVwwAUa0gMr/pI313K5EfCxBKzgX5Gwr09wpaTMOD1r6L2kd9Bc7bLY0FkX9d47
         43xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718191650; x=1718796450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WXhunE0FX83qRs/SGKpCCNORSUg99lCzf12ZKZzJD0=;
        b=b7+39zBQFHJuiFJwk6kgekGPSolACjm+TEUqQpOy44bBqLzPxpsjt6JgFb2Hf9uxxH
         ItBev+FIqqJ3PEcxnoSfIQsyhrBECnagNr/mZNWemI5+fQyqRXZ5lRa+pOeEBWRfQ026
         sZ4yURFRlnSxLoI45X2jYZmRNPQuWuo2u8BPWtUYU3b4qOdc/rywT2ZU4PiNYqPyt9Ia
         y1TNJtySY5kQa3kexrNDFLBYiLhK/TKXkZ5x6MXPn2/+bZffa9HHQ7jfYakz7Nwul7Dg
         pow+uh5stmZGAkxGfiph3x66+U1UDXhqJ7QDi0DK0DgqPa6eGHX+9+GhnEcNbQosP71G
         rLmw==
X-Forwarded-Encrypted: i=1; AJvYcCWqQeS4c7e1loxOTvA0xT0VCGAZys8sztE4eiPdOcvkSyE20dZl5/mmC924CZPJJNwY6eZYZYJf62GqdpVYrFntSCi1yn8e4T8vCFyvzyqIfO86ck02J0qPrCWvvB8hQ/K9CnOJ
X-Gm-Message-State: AOJu0Yzg/MGXLTaqqVuubWYsytkvwCiwA8hhhVCp6EhO6lMTpnjSZTZc
	obp7X7CDniVq7bR0Nf95FXM8w6hXkS8iuOaymYhlZGzhe6gEw+AO
X-Google-Smtp-Source: AGHT+IFL/+dHqux09NxFiimG8+4GZxdGxQxBDWDe+F9a1kTeGHUaRxVMPVGtrmjMLX8TEzoMX7Y22g==
X-Received: by 2002:a05:6512:3e05:b0:52c:836c:9ce8 with SMTP id 2adb3069b0e04-52c9a3b9624mr1506594e87.4.1718191649607;
        Wed, 12 Jun 2024 04:27:29 -0700 (PDT)
Received: from pc636 (host-90-233-193-23.mobileonline.telia.com. [90.233.193.23])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c879187f0sm1489134e87.272.2024.06.12.04.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 04:27:28 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 12 Jun 2024 13:27:26 +0200
To: Zhaoyang Huang <huangzhaoyang@gmail.com>, Baoquan He <bhe@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	hailong liu <hailong.liu@oppo.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	steve.kang@unisoc.com
Subject: Re: [Resend PATCHv4 1/1] mm: fix incorrect vbq reference in
 purge_fragmented_block
Message-ID: <ZmmGHhUDk5PqSHPB@pc636>
References: <20240607023116.1720640-1-zhaoyang.huang@unisoc.com>
 <CAGWkznEODMbDngM3toQFo-bgkezEpmXf_qE=SpuYcqsjEJk1DQ@mail.gmail.com>
 <CAGWkznE-HcYBia2HDcHt6trM9oeJ2x6KdyFzR3Jd_-L5HyPxSA@mail.gmail.com>
 <ZmiUgPDjzI32Cqr9@pc636>
 <CAGWkznGnaV8Tz0XrgaVWEVG0ug7dp3w23ygKKmq8SPu_AMBhoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWkznGnaV8Tz0XrgaVWEVG0ug7dp3w23ygKKmq8SPu_AMBhoA@mail.gmail.com>

On Wed, Jun 12, 2024 at 10:00:14AM +0800, Zhaoyang Huang wrote:
> On Wed, Jun 12, 2024 at 2:16 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > >
> > > Sorry to bother you again. Are there any other comments or new patch
> > > on this which block some test cases of ANDROID that only accept ACKed
> > > one on its tree.
> > >
> > I have just returned from vacation. Give me some time to review your
> > patch. Meanwhile, do you have a reproducer? So i would like to see how
> > i can trigger an issue that is in question.
> This bug arises from an system wide android test which has been
> reported by many vendors. Keep mount/unmount an erofs partition is
> supposed to be a simple reproducer. IMO, the logic defect is obvious
> enough to be found by code review.
>
Baoquan, any objection about this v4?

Your proposal about inserting a new vmap-block based on it belongs
to, i.e. not per-this-cpu, should fix an issue. The problem is that
such way does __not__ pre-load a current CPU what is not good.

--
Uladzislau Rezki

