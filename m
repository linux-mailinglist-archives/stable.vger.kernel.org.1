Return-Path: <stable+bounces-108576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C5CA1016C
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 08:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24FC3A1C6E
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 07:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D63124633B;
	Tue, 14 Jan 2025 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="IGxhTt6Z"
X-Original-To: stable@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2202500A5
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736840366; cv=none; b=kwGoiatvL8/7O05fGnKEtdwIjvwG3LTwgizcfpDKpRG3qTZ3is5IPMexHrAfHTkd36g+2mG+zitq3lyopgZs1avxEFDob7J7xs+CP7xybzmqLC/gnHaRgJDx0g5EfL3RCeTnHdgRajMZLA4CAbmVfUkw1x8y2uv7VlboZaY01nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736840366; c=relaxed/simple;
	bh=k360k2nENChaTtsCY0XTSnXsQJWoAdUqBiBV+ls1PWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVY6ZAWB8eQgNaDnE1WXrYdqibjdcRuXrtXt3a7WPxpCCj93mdMqhsuOPKiQ3CRZwJ2RFGUEwDEh++ETpjrUONumwyCjsyAFAc5WZu9rMDkuNshhY6/b2m6J+st3B1jkfhDq2GAWVIYzUFFjxZOLN1cpInrZAqIKbiefYnOA0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=IGxhTt6Z; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=IGxhTt6Z;
	dkim-atps=neutral
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id CC0F338C
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 16:39:17 +0900 (JST)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef775ec883so8987900a91.1
        for <stable@vger.kernel.org>; Mon, 13 Jan 2025 23:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1736840357; x=1737445157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNYhzp6T4J8POxGMu2wCD4gj9nKfcrDVmiBH3+FTTC8=;
        b=IGxhTt6Z/k8e1OeGtEYoLsQFfV+/fbjxRsxVS6H+Dd8iAQQiDVaFuHn7hT7JeXCiE9
         0QyNY4acqAauXfYzOHtTtZYPfLRZ71HVy+bivuWwxy7PArIHiF4NaIrRxU3yfpehhXC8
         u4q9H5OZDN/UX9+XAGxnwoFKuIqjvv9CAnBTH/k8L0/9H4eD4M71luTmPW5oe9rftzEZ
         +qxY5zcKwafkh8/+nam5MJUr5duirk+q7JmTXYFf4w7ZpH3Ak/FXqtWBgJ4zPBwFhEuc
         gYEcaKHlrCHRPi3sujdSKDS50HIk9wC9cLt65Jr+0qGpqxmnwiatsSPcdUZwikICOcnC
         552Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736840357; x=1737445157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNYhzp6T4J8POxGMu2wCD4gj9nKfcrDVmiBH3+FTTC8=;
        b=f6AgKwQXJ4j4InwRaQcKZrbZvZXN9joTkCslRyR17wdDsF9Y5Zb2VPFJ2ZLyVY+XDs
         LY4HlCxiXkHQEsd/1LYTh4aeFC42j2ZaQ3xJAsG3B4mhBbZFdYgKiVl0Oh/kF2BwYm8P
         yw1cyPWd3K7uxQ424W1FwSpevi1trPN1F8lnA/uvYqmj/UJh8jFVcNntas2PsE7aCY+A
         fPb8MEFfz/RZbf9K2sCiXgI+udjjxX+ldF5GyeML/83m68LrDe0wpCEswz2A2RBprsPd
         tT6AJ5rPWmzJt4MgYWcFp0MWqvqPrAeg8uYnNrX/J06HcU4hI7Q7ibE2Z+YN+f2oR9hg
         6UgA==
X-Gm-Message-State: AOJu0Yx/0mSocHmoEcxin8KHZGaNBbtOUyhPvCgYazRqx4XLC0bOoFCH
	mGKBI85QVREDyLdeeXMitcOjiavkVTteZ0sRS7tkrzMbHJi2M+4AhPQlR+v6x+/JiRpDYmffLwH
	FEwsxvk8dBBCd0u7lL6WB4sZyF5jQQNcmzaDtLXXWMahAbVhJUpmL5klf2CEMn0g=
X-Gm-Gg: ASbGnctPCv+/3lG5exGT0npMHT43jOwobjKYJPVtyVOCUOyO/zHk91RxV2xKmdBLoGz
	tw45srTh4DYeW+2acqktnrDmdNmWOswUbuUBgka9kT6P6aQ0peMq+bZowEe/0t5SYp1CvkwmWF2
	0kOpgg4eUzDuoihFrCx8DSqjEMx2B5zF1zw4P/2Gjj7zgAZKiP4O8389wA7x7jtGR4tN2R40rO4
	WwKmQPw+V08ZAd5f8ALRUVI8kxUafa0SWF5uMAHhH0Oa0E/VCrIwDmp95ySqsZpK4ELq69G5oGn
	qdMBmetj2q1ORo9mO1UfqzKH676yHCDlg5XhQMlk
X-Received: by 2002:a17:90b:2c84:b0:2ee:8430:b831 with SMTP id 98e67ed59e1d1-2f548f1628fmr36874505a91.2.1736840356842;
        Mon, 13 Jan 2025 23:39:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFucZTLJamv/CQ5nIk/KY9RsHieGOsTWABI4Y2zHT3k7z/UYGhJL1HzEwHdatKUJuyyrTaJ6A==
X-Received: by 2002:a17:90b:2c84:b0:2ee:8430:b831 with SMTP id 98e67ed59e1d1-2f548f1628fmr36874486a91.2.1736840356480;
        Mon, 13 Jan 2025 23:39:16 -0800 (PST)
Received: from localhost (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f559469fa0sm8902619a91.44.2025.01.13.23.39.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jan 2025 23:39:16 -0800 (PST)
Date: Tue, 14 Jan 2025 16:39:04 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Kairui Song <kasong@tencent.com>,
	Desheng Wu <deshengwu@tencent.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 0/3] ZRAM not releasing backing device backport
Message-ID: <Z4YUmMI5e2yPmzHl@atmark-techno.com>
References: <20250110075844.1173719-1-dominique.martinet@atmark-techno.com>
 <2025011201-scorebook-kebab-2288@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025011201-scorebook-kebab-2288@gregkh>

Greg Kroah-Hartman wrote on Sun, Jan 12, 2025 at 11:03:42AM +0100:
> On Fri, Jan 10, 2025 at 04:58:41PM +0900, Dominique Martinet wrote:
> > I've picked the "do not keep dangling zcomp pointer" patch from the
> > linux-rc tree at the time, so kept Sasha's SOB and added mine on top
> > -- please let me know if it wasn't appropriate.
> 
> It's tricky to know, I dropped it and took what was in Linus's tree as
> Sasha didn't actually review this one.

Thanks for saying this; I hadn't actually checked the stable backport
(enough) either so I had another look, and the 6d2453c3dbc5
("drivers/block/zram/zram_drv.c: do not keep dangling zcomp pointer
after zram reset") backport by itself is wrong even if it did
cherry-pick cleanly from master and a quick test appeared to work.
The commit messages says "We do all reset operations under write lock"
but that isn't true without also backporting 6f1637795f28 ("zram: fix
race between zram_reset_device() and disksize_store()"), so with the
current backport we've traded leaking zram->comp behind with a data race
on disksize and comp.

With that extra commit as well, I think we're sane enough, but I'm not
familiar with the zram code so I might have missed another prerequisite.


With that and the previous problems, and given that manipulating
zram devices is a privileged operation (so we're not looking at a must
fix vulnerability), I'm actually rather inclined to just drop all the
zram patches and not backport these to 5.15/5.10 unless someone actually
reports problems around zram reset (or perhaps keep 5.15 but skip 5.10
as you see fit)

(
  I'm not opposed to Kairui or someone else actually do these backport,
  but I'm not confident it's worth the effort and think we're trading a
  known problem (current behaviour) with potential unknown ones if
  we're just cherry-picking an arbitrary subset of patches.
  If someone wants to take over, the commits I had identified (from
  Sasha's initial backport and this mail) for 5.10 were as follow:
3b4f85d02a4b ("loop: let set_capacity_revalidate_and_notify update the bdev size")
5dd55749b79c ("nvme: let set_capacity_revalidate_and_notify update the bdev size")
b200e38c493b ("sd: update the bdev size in sd_revalidate_disk")
449f4ec9892e ("block: remove the update_bdev parameter to set_capacity_revalidate_and_notify")
6e017a3931d7 ("zram: use set_capacity_and_notify")
6f1637795f28 ("zram: fix race between zram_reset_device() and disksize_store()")
6d2453c3dbc5 ("drivers/block/zram/zram_drv.c: do not keep dangling zcomp pointer after zram reset")
677294e4da96 ("zram: check comp is non-NULL before calling comp_destroy")
74363ec674cb ("zram: fix uninitialized ZRAM not releasing backing device")
)


Thank you Greg for the follow-ups, and thank you Kairui for the
suggestions during my earlier bug report.
-- 
Dominique

