Return-Path: <stable+bounces-167047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E45B20CBA
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 16:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29003A95ED
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 14:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D98A2D3A65;
	Mon, 11 Aug 2025 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJirflKW"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D06E19C560;
	Mon, 11 Aug 2025 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754924176; cv=none; b=AUlTyWpTzQqXzorS+OqxHHw1dgAJ6Ta29rewmjQYbzUwmECnrlaN8uWvKRLncqUH5I0DR6n6kzEkx8JdtIfWO49yrfldpx8XuaqjpzfGKEB6anhwmePB7N4j5FEqu/d8VFbCojOWae0xiifyx9dbnkqxlG9fFtcOPu3CNWuvh4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754924176; c=relaxed/simple;
	bh=Sr/JZJ5a5nqZ1qW6UeELtW87nb40WYfkNLJCTM59nLs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GA1AaKRMI+aJXj8JK6MnXL9KR5A3jowJnemPhVX4gVTWwWltSvDb/5D9u2rkiyahUbelo8vrvYsC1pSv9HxXr5XmpmdMvP6aicR+JTghUaHDxtd3V3sPsglOaY0yGSx4cYGmcJ86pOYyCpRymu/1ngJIIwSwJ5uTDXDwDjZdc3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJirflKW; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-33243562752so30717221fa.3;
        Mon, 11 Aug 2025 07:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754924173; x=1755528973; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7MbdwcE6qIc0EwxhkUAtAkkmZpnTQkGEmHg2AGb+L6A=;
        b=lJirflKWTIxK4GPpHCEUNHtJHjsBsk4WG6T3SHNpbrpOuK1/Nn7ginAxCkNVgH8V1z
         AXE104dQccPbX+PDEvJM8YAugbnt0iZ0ZwGgDJmgMcurrjORhp5REwhJGa+rUrQTVOln
         aXcfEllwVT0giNrqu9D1+H3g16VIwS1XIhTo9o5dwhCLyaPDhTMPpE1WuX7f9sD8HFRI
         kw3yPSSn6sOhW+z0QA6xMBbzwbr8Cn66tfFRbIaOYvPVmYV68FGHleIvZjtSvew/+Bx0
         sP5MAbHt0LsZFnvPsyj5/V3bh26N1Qxs6/x7BKWyJE3H15dPFm9z4tAb6aWszcGY59QD
         nKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754924173; x=1755528973;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MbdwcE6qIc0EwxhkUAtAkkmZpnTQkGEmHg2AGb+L6A=;
        b=QybpCq4B0nvYyjqv3vjbbhXeoyjL600R/WwQudcysCOoySd9ZDCn2E4PYV3II2sJ59
         3At1mKVeZJSvebLGRdJKdNlcXvhK4hk/8+TBqmFuRHXtObUAAJ2caYEpuGjnyjauSp6x
         efDnLQFwXtUVVGuross6JhMtIi/9lVJ32/+BMQZURvi+WvA0/eR9x2Dx7ShAMrB+Tero
         clqWA6zPjn44Gz1UWVTF0ji5Shb+DceBUQX1johiWdI/Za3ezEkTLjlPqup5wYFuPeuf
         pA4qKgx6meqPFpT6A4oauYhVG/op2XQe0/TiCB+w5UXReTrido8IpGQkmaimvvX6jCa8
         8bTA==
X-Forwarded-Encrypted: i=1; AJvYcCUUz1OC9xj5lTZ461ANL6P6u5bzy+VXXi2CvUXkeEE7SYjTMQwYoUTMedyetC2ffl8WXn/AlWvz@vger.kernel.org, AJvYcCUt0O8SAC2RS0FifAec5+lC4AscLasfeW1CvkoeDxe/hQJGDM/3IbzbTgULPt9snfl+FIP64ZMF/uYOzpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz9/fb/co7nJ8rOicny3E3E2ZceI3LS4k9Krt+ztTZPfhCNHzF
	1znBMki871fL89v5Rsjgq7txTAXfNlgdbmfsYPrBvVb+OBknUqNdbBr/W+2Oc5tP
X-Gm-Gg: ASbGncuWRsQOz6Rr0fdgNWNDiddVPdsqVBzWhPZukDcKDFemZ2ofxy7khdkylXY7/8/
	o1APJwrJGdkprXLa5Fe8jWJUdfLRls6Bh21q2hL0SXnbgfh3L2TRyf8bOVKZcU7S+GyCxHZeyLm
	p8PqWL9aevsLFcB8dN7b/57PW9CWgs8qCIqQo/tn+evYAfn3jRslfd8BQHY2h5ogpPOwDe/2cUx
	4IsGi4y8iEfA3zgZjs6VVgdwmLY5MkkJywAj5/1uh8jgik1EvJQjIZ+k3C7Fvx9PaK8ye1d1ElR
	WEtFEuUaSEcJWeTksFidEfcmrBJ/x9kgmxeGf7blUQb6gJWlYsjgSgOh+DHVK8Zxhl6XrD3QeZB
	ok0oxrWlI4XVoCAuo7oQUcyoeNVQLaNcEzgjWksvq/racm/2J+Q==
X-Google-Smtp-Source: AGHT+IGRHHXrSOrCUMkrwKfldelClnCJtFN21p0fHiQD2i+xxAbPXfghsGQVTTI8je1KDeQL54bQWQ==
X-Received: by 2002:a2e:8a90:0:b0:32b:881e:9723 with SMTP id 38308e7fff4ca-333a2265b8emr22577041fa.30.1754924172216;
        Mon, 11 Aug 2025 07:56:12 -0700 (PDT)
Received: from pc636 (host-95-203-26-173.mobileonline.telia.com. [95.203.26.173])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238272a7csm41552511fa.15.2025.08.11.07.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:56:11 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 11 Aug 2025 16:56:09 +0200
To: Dave Hansen <dave.hansen@intel.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Ethan Zhao <etzhao1900@gmail.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	iommu@lists.linux.dev, security@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Message-ID: <aJoEiajJwlWuXyax@pc636>
References: <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <4ce79c80-1fc8-4684-920a-c8d82c4c3dc8@intel.com>
 <b6defa2a-164e-4c2f-ac55-fef5b4a9ba0f@linux.intel.com>
 <2611981e-3678-4619-b2ab-d9daace5a68a@gmail.com>
 <aJm0znaAqBRWqOCT@pc636>
 <83c47939-7366-4b97-9368-02d432ddc24a@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83c47939-7366-4b97-9368-02d432ddc24a@intel.com>

On Mon, Aug 11, 2025 at 06:55:52AM -0700, Dave Hansen wrote:
> On 8/11/25 02:15, Uladzislau Rezki wrote:
> >> kernel_pte_work.list is global shared var, it would make the producer
> >> pte_free_kernel() and the consumer kernel_pte_work_func() to operate in
> >> serialized timing. In a large system, I don't think you design this
> >> deliberately 🙂
> >>
> > Sorry for jumping.
> > 
> > Agree, unless it is never considered as a hot path or something that can
> > be really contented. It looks like you can use just a per-cpu llist to drain
> > thinks.
> 
> Remember, the code that has to run just before all this sent an IPI to
> every single CPU on the system to have them do a (on x86 at least)
> pretty expensive TLB flush.
> 
> If this is a hot path, we have bigger problems on our hands: the full
> TLB flush on every CPU.
> 
> So, sure, there are a million ways to make this deferred freeing more
> scalable. But the code that's here is dirt simple and self contained. If
> someone has some ideas for something that's simpler and more scalable,
> then I'm totally open to it.
> 
You could also have a look toward removing the &kernel_pte_work.lock.
Replace it by llist_add() on adding side and llist_for_each_safe(n, t, llist_del_all(&list))
on removing side. So you do not need guard(spinlock) stuff. 

If i do not miss anything.

>
> But this is _not_ the place to add complexity to get scalability.
>
OK.

--
Uladzislau Rezki

