Return-Path: <stable+bounces-124137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D94DA5DA65
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 11:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4411189B749
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 10:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3531023C8BD;
	Wed, 12 Mar 2025 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zxq98kiv"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52207237160
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741775125; cv=none; b=MATJZ/QJjWRVPpvAJOMuXQxgQ3JLrraBiw+biIXaBm+sTPPv6oyk1ikXYshlr7FTIxahD7qZ21AbDAx9HudYhH8GHZ+IDYSnJ5xG2E0YPCMkmauEEVyNquSIGFq8Xhx7HVdCN+w/z+Kf1iz3wOgfB9/q/PupO3L8aC9Fw5IfRao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741775125; c=relaxed/simple;
	bh=Unfz1ynURXV9SA2ejF3GQ3Q6+tUVGg7jYvNl4Map2A0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awlmyM8Cey2IXz1pHL7Ac4LNjrs2dJy0EQsdqID+i3QvdRtheggo+xj7qTSzbE3lMeW4WYgLWMCVL0UyfWLfd6f/pOEZHCAO+BPWZU9YFY+oAMQ/rCU5nyXlZ+V939Wvz4e/v/xtJTsPOo0AtIIJmH+4yJXGnZAuLr0H5JZYh8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zxq98kiv; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5499c8fa0f3so3825095e87.2
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 03:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741775121; x=1742379921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LlX1NLJXe80SJDubntfI8UzjC6gvn5HCizGdqCjTtb0=;
        b=Zxq98kiviaGcFWtJrCDhhy8FGR6cqLjRK8976JYcc3M+g2rFz0GGUL89MN0pUVI92A
         kSDGzk8L2FelmFU/pamecVLjfsGmcAsQZs7cfaZ7qVorYJ4jZ++rjoC0scUeZYIWIS/w
         352CUhW7Qw+lG6jJNCKbBNtiThVcs4IBmE5HX9148jIbZqzxv9OxuePLv7trXvYnqRfZ
         C+l2H6tgFirxPcUqArFopjx7MMNcRKTwBEkH83kk3kjuUNhsmahCkE/S5c9ikAeT7efO
         oFkFij0cRoCgjqPeS4XqRX6gbIOE3NafXXA9LYXmvmyitPdxXY2C4aiCT+5P3uVLlzJP
         a3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741775121; x=1742379921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlX1NLJXe80SJDubntfI8UzjC6gvn5HCizGdqCjTtb0=;
        b=gNjXraOFD/SF9S+PAgBMbVh1AHrwXXK6ZFaZIImdd+jw64bzfMQKthsH12xfw6bOn+
         vG9QaARAmZzsCr963PObwxjDqeWZ6ufUrTx9O5GtPN9xYzxF6qaJ2sZtaTCZ6ULLqbZ/
         noeVqc/33BcBWG2vx/6+yiTaaGJbBO/Km3kYhfIxYEnbFwi2AINmDwPPrG/+GsSaBgKD
         lxPX9hVw3VSd2y1ESKVXLFOWVuPYoRrcIecJBjuy/WWD7z5gNHNnhAIjiJyXhTmqHNZ0
         9Fs5BOxueLdX7LrB1LKavRdn/ZTIDf4ddm6H+LCpB/aZjZO9VGsuoFN27ceZ9mbWvo3D
         lyNw==
X-Forwarded-Encrypted: i=1; AJvYcCVRmzMgVNoJuKW2Nd2CMCPAgEgfwINFOEYD5OZ1F0lXbMC4VUzn6qg4ugCXM7EVdiq4/fGLlzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztpjFj59tiVfzdRANe63j2eL4J5T0wvfmODL/pIDu18Pq96M37
	g7eLTtb9j6UmN/vk1bC98HOUfxMWJX/JJWP7egTLPxjnsIaYRIZAZ8M5PQ==
X-Gm-Gg: ASbGnctezN0IDFYseJnG42YZeOvXyf9Hd4XRitjtgXgCnBAjJ5sr6DPlW70U/PRoOhV
	WPwhzylxh3MrIx+xYDR8EAY3kmwUBduEKp479yvzJLn3yB383jN/Qm0NCS8xvlXE79k/wWEBgcy
	daZ6c/kZ65alpvc+0zgkl2jJeaZ1H4mFddcChveTji15zqMNVSly5JCjDzF1PwYznMbUwJfDnqd
	DFsFuN+Q7nR3UKLDJJhGuQH8znC2Yd6DWNEUkZg4ONnzyEG98E+tEbP0OwsuwsrIoPkSRWOjs8X
	AGDgfohLA5TnpP9VMV+uhZfrJ0uOHTdX8IPionQmGTCVO2G9T53z0jdr+3ZnisSb/1tyEzrcz+U
	e/w==
X-Google-Smtp-Source: AGHT+IEf9XregvYnDUx0UtYmF2K5WZwbHVucxvDpJ8M2cxcVwkzVRDh0jjeYSqRiIjFHCeJZAV286g==
X-Received: by 2002:a05:6512:1112:b0:549:4f0e:8e28 with SMTP id 2adb3069b0e04-54990e5d374mr8343973e87.15.1741775121064;
        Wed, 12 Mar 2025 03:25:21 -0700 (PDT)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498fc0ac2asm1909625e87.192.2025.03.12.03.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:25:20 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 12 Mar 2025 11:25:18 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, stable@vger.kernel.org,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Keith Busch <kbusch@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH 6.13.y] mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq
Message-ID: <Z9FhDk-svRFNBFGR@pc636>
References: <20250311165944.151883-1-urezki@gmail.com>
 <96e93e70-0d60-4ec4-a111-9eab58e8b3f9@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96e93e70-0d60-4ec4-a111-9eab58e8b3f9@suse.cz>

On Tue, Mar 11, 2025 at 09:33:38PM +0100, Vlastimil Babka wrote:
> On 3/11/25 17:59, Uladzislau Rezki (Sony) wrote:
> 
> The first line of the changelog needs to say:
> 
> commit dfd3df31c9db752234d7d2e09bef2aeabb643ce4 upstream.
> 
> I think Greg prefers if you resend with that fixed rather than fixing up
> locally.
> If the same backport applies to both 6.12 and 6.13 (it seems to me it does?)
> I guess a single mail with [PATCH 6.12.y 6.13.y] could be enough.
> 
Thank you. I will make one for both kernels.

> > Apart of that, since kvfree_rcu() does reclaim memory it is worth
> > to go with WQ_MEM_RECLAIM type of wq because it is designed for
> > this purpose.
> > 
> > Fixes: 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> > Reported-by: Keith Busch <kbusch@kernel.org>
> > Closes: https://lore.kernel.org/all/Z7iqJtCjHKfo8Kho@kbusch-mbp/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> I don't know if you need to add another
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> opinions on that differ and not sure where stable stands...
> (does "git commit -s" add it or detects your previous one?)
> 
"-s" IMO should add it. But i will check.

Thank you for the comments!

--
Uladzislau Rezki

