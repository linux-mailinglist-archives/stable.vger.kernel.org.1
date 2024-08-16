Return-Path: <stable+bounces-69292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3BF954299
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 09:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E2128F6DF
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 07:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C099C12F38B;
	Fri, 16 Aug 2024 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5AWzoFz"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFDC83CA3;
	Fri, 16 Aug 2024 07:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792805; cv=none; b=ngPpvSuHz3QIG7CN3pScF8I3IZs4kfA2cOepXv5MrF0qjvUJYv3nt1deifDYfZscSfP4zvYdGbNsjLmYATmIfO8eH/XkhBZR2ONmt18tKALFRTkN3mgXijanSadkk9PWGLKuQ+2XhH3f0aucipB+3Hs9fc5w2OqDe0s/3QX2cwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792805; c=relaxed/simple;
	bh=XltBR+DchOvuAWXNxQkJOKqCiETtmFdDHwpmtwucYFI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPIu9jYnRkDCnK/NRERQwJMLFSB/h1nDlWBSFsGtSRI8UNp6fOhXwMEBoomjRmZItZp8PRT3n4CMo/B1AuXarcTEtUGAk9BN+xBKoHY7JzCb78Ch4Et9p7bB9l5eCZIUNAW4T9t+7eTTUO6lNkYKJoxXrk0PJ0BNpH711/L0ILE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5AWzoFz; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-530e062217eso2219874e87.1;
        Fri, 16 Aug 2024 00:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723792801; x=1724397601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BCDYMfGySc443px3vz4IJgiNfp6ypozgyP4rObiGgj0=;
        b=f5AWzoFzV1zkIWBpZnOrvgQwWBIdUwYFZVbdQNn+9ze68KQzQz7ZRvE2up26pWxzdp
         DxXVHhLm+xFJ8m7VQYrmbu9A5Jb4npIb0t0enHPi/6bScNP7sOr8NhK8H4un4tC4tMzD
         plzNZzeZMit8PeGHi8oqfn7xaLEiKWFowe5CGEwengRFZ7g+6HIH5C3l0Ona81WGUelx
         W3CTUXYm8/Snhv8Qxpf2ZV/hpsKl2ezT2qXMEElTZkk2e6ArICBeXlG2MmYr+6+Rz8cQ
         NV1KaGitlt12dBE+NU2fP9I5Iov5UlGwxA6N30p+ksDpmlMmojp41jU+lBp8IAKsVMZv
         YmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723792801; x=1724397601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCDYMfGySc443px3vz4IJgiNfp6ypozgyP4rObiGgj0=;
        b=f3hTztkhNO82jJFLPbncInJ9wiZbn36qAGTggvnArG4srZ/EiQCWnxP6myyPI3evle
         XgZ+2Em3p+oJv3YIqFvM6o/FrpmzmtiSljIaFRLSOG2xJx4VIhX0VrsPGGunw5G9jPk4
         EEi32WFKFHdsBeByt+ESJYEfOEtSZNl2UJlteXSWu2m5VTzVPWvriJtQVKk+NPrJVtuA
         MWsqsi/Py4weuTMQ1mgiAzJ7TDlymOlyKve/JqtOAyV0/hiuEOnV+Gdf5Qz9NauU9v74
         RpvNPyiwH64SEOtjP1jQL9r/9eotdoTz7gTtwqztHL6mpATeq+yqVmvm4fFGvj3MNizm
         XBIg==
X-Forwarded-Encrypted: i=1; AJvYcCUoV32EcXeE1iNRHa0QfPzHyNRnkg09lQlnYk17h7qGZryGMuKv25VuLXVlIJklx8Ae+veNpSMxjf09dyR0cehnWO1GYKnqalAwrC6bJ/p7VCtO5aO0wcgyEW2AkQ7eqlKg0LDk
X-Gm-Message-State: AOJu0YzggaT/0mIewOS96M1OR+yxGtsxuQQV1e4/UPkl4pa9mr57mWpp
	H5J7B6yXvVHzUEO/90cA/Q6Es5Lldm1qKNboqqVV8mT0c6nJySUT
X-Google-Smtp-Source: AGHT+IEMNiMu907jG2oLMbP8LWHs6njbuCrNw+PDgwS8M4Ji8B1T0eTn7Bss8F5WwbXir0Y0aKTrzQ==
X-Received: by 2002:a05:6512:124b:b0:52c:e170:9d38 with SMTP id 2adb3069b0e04-5331c6b027bmr1363916e87.31.1723792800401;
        Fri, 16 Aug 2024 00:20:00 -0700 (PDT)
Received: from pc636 (host-90-233-214-145.mobileonline.telia.com. [90.233.214.145])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5330d3af9b5sm471263e87.14.2024.08.16.00.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 00:19:59 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 16 Aug 2024 09:19:52 +0200
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Michal Hocko <mhocko@suse.com>,
	Barry Song <21cnbao@gmail.com>, Hailong Liu <hailong.liu@oppo.com>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Tangquan Zheng <zhengtangquan@oppo.com>, stable@vger.kernel.org,
	Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <Zr79mKLTtum-rRKF@pc636>
References: <20240808122019.3361-1-hailong.liu@oppo.com>
 <CAGsJ_4z4+CCDoPR7+dPEhemBQN60Cj84rCeqRY7-xvWapY4LGg@mail.gmail.com>
 <ZrXiUvj_ZPTc0yRk@tiehlicka>
 <ZrXkVhEg1B0yF5_Q@pc636>
 <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>

On Thu, Aug 15, 2024 at 10:07:09PM -0700, Andrew Morton wrote:
> On Fri, 9 Aug 2024 11:41:42 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:
> 
> > > > Acked-by: Barry Song <baohua@kernel.org>
> > > > 
> > > > because we already have a fallback here:
> > > > 
> > > > void *__vmalloc_node_range_noprof :
> > > > 
> > > > fail:
> > > >         if (shift > PAGE_SHIFT) {
> > > >                 shift = PAGE_SHIFT;
> > > >                 align = real_align;
> > > >                 size = real_size;
> > > >                 goto again;
> > > >         }
> > > 
> > > This really deserves a comment because this is not really clear at all.
> > > The code is also fragile and it would benefit from some re-org.
> > > 
> > > Thanks for the fix.
> > > 
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > 
> > I agree. This is only clear for people who know the code. A "fallback"
> > to order-0 should be commented.
> 
> It's been a week.  Could someone please propose a fixup patch to add
> this comment?
>
I will send the patch. This is week i have a vacation, thus i am a bit
slow.

--
Uladzislau Rezki

