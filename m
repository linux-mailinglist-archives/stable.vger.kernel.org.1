Return-Path: <stable+bounces-201122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 428A8CC0786
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 02:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 401F53010CD9
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 01:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B08F270545;
	Tue, 16 Dec 2025 01:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gl7nPRlX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8761E570D
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765849076; cv=none; b=rJbE2E6h3vvaknEcvcz6fzdcXoL/cyKOuw7ZkvvgRJCgnFdT8B0MzJuUpXgNUngy9613csHwQglJgxmkMhN6jC2gqpSQn2rtuKD2e8JZB/9yezdTqafyEOaDYHU75nYKe6EQcSX/q/EPwntW1/kL0krdKRXk9iEVVM8iM2Xue1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765849076; c=relaxed/simple;
	bh=jneufzrQq9U/X2h2rmo/2QoND+mJCZiav6Js47r/6OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6OS4j7idDD8dUBDlmCiP7rRq7DsF6D3wYB9sEsby7XpNbrIOh8Ieoekgoq19cdiPMVPthg7hfUdsRAnfBXn64FrOnRaFZxfDHGsNPcLmRrNp3yGSLxSSY/yt4AQLAGdh4GbKelpBJAoWFexaVLUoHcufdMRfel1iAtLWKyTUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gl7nPRlX; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so4277582b3a.2
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 17:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765849075; x=1766453875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f0FDBivIYW8TFHL3VKiPkgeHToq4CwEnpvCaDs7HwAE=;
        b=Gl7nPRlX5FRSyqolHTAUG6fRj3GnsUuARuEenBxn9CLzFjxiLIpqAbWFPN/KjbMTk0
         efuQlkePS9LcFV6ak/CSYmj2OMW10Fr2HxOIAxgKV2Dxpq6Bjk7fIFNksEyfkcbrpwIY
         Bma6FGXgh/BMmDwapkX0MPOL0uc3n4cDoFsZ9orJeWRBpxyg2HzaKD6EvuQ4+6u17hf5
         oHbYIxB3sClAyXML2zSE8ajHc6vBIjq8B80/A3EHE0ZuN17nWjYGFnzmLvlyWPcTIfW3
         87OzPMwkhBcZfW+/qxnOAgRazpsNenTBym9MRLpzgPKH+iERxDFlm/JvkDJb8UR/tUGr
         Sleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765849075; x=1766453875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0FDBivIYW8TFHL3VKiPkgeHToq4CwEnpvCaDs7HwAE=;
        b=ZdRNbzpiiwVTJ2BlKFiGg/jEpgajpRFB5yt81Kf/ysA0kaJZZq0dojJbBWqZ4+/b0P
         QpGaAgJwcnEMapKVJsPhUEbLr46YaGXwyfkc45ZvY3StYanYNv6qJEFt3dihwZhv45jg
         ynaN1TKKxOZEEqAQvPl/HeKRqAPX918cOtg1ilYyStoyw6pcKfJJK6/v/3188BmsebJV
         qt57170/SoaCl08NGyj0vglvPGuTwS60QJUjGgu9z/2nkUm0hEWHunFglhcF+1ukJD7V
         BzQnVhK2ldmI99XxX7Va/I9xf+OjYxI2otSgU8WtK9ocg7s1SGh7bmhCB3edNzyp7BJE
         c9eA==
X-Forwarded-Encrypted: i=1; AJvYcCVbVKCDXsKSF2QepT+EXX4hxMcsun7QqiGFmyN7IVT4c5Vw6lLlzG5OYx3WZtPI23fRjM8QJj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr/SXV6MtTm0d1vvT+gtoCwK0I09E+eebAyucvKNeT0+yIZbKH
	rEmzQyNVnyIrIzbG0+V/eXUPqtq3k+RVdDuuWD/iw82fNe4oNdCw1VlM
X-Gm-Gg: AY/fxX6Rbr37ZFnn4UoZHyuOxdP1ePIQoqF+qScu6y6CdGDTX59CegBjBXioeuOAAKu
	p8sXn5iWWJyHOBczfmrZLEeCw1uho1xAs29gNjeHgsLD4FjokOu1lXm2GlFETx8tcql9FAiV47s
	1E4XnWbss6GJtllIVUTCvudWP35qapDbOhkKZCARe/FjtW+2r1Kh3Znl4HCjKJW7JtO0OGLAx2w
	Mndf0aCMYBoVeIQP9hc8pPARq9i+4tXcUA1VQtIwpD9IpaxFxNhilUaFsIaHPfgQ10uIg/Vo2lP
	4PY1mrqXzT/UwmY86dMyKWROjyx2Z4Sr1FC4PxOf3XMV36D7eUIBd8t6uZuXCmoSa0nAQ035yoo
	n39TH7A9k8/2a4WG8ZlBfjfMPvA7crA+e73Q9UESa3Mw1YvR1/xuJdwipjVfopA0xPP40A/UnFi
	JIoak=
X-Google-Smtp-Source: AGHT+IGt3M1e5nD6KT/Tr73XIoi0zHyij2fPN6XhQLefORTEEkXDCvzAbax3QerzbjuxYRohNPHGbw==
X-Received: by 2002:a05:6a20:394b:b0:366:14ac:e200 with SMTP id adf61e73a8af0-369b708cd8dmr12251610637.62.1765849074655;
        Mon, 15 Dec 2025 17:37:54 -0800 (PST)
Received: from localhost ([2a12:a304:100::105b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c26515d4bsm13325458a12.9.2025.12.15.17.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 17:37:54 -0800 (PST)
Date: Tue, 16 Dec 2025 09:37:51 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+4d3cc33ef7a77041efa6@syzkaller.appspotmail.com,
	syzbot+fdba5cca73fee92c69d6@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/readahead: read min folio constraints under
 invalidate lock
Message-ID: <aUC32PJZWFayGO-X@ndev>
References: <20251215141936.1045907-1-wangjinchao600@gmail.com>
 <aUAZn1ituYtbCEdd@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUAZn1ituYtbCEdd@casper.infradead.org>

On Mon, Dec 15, 2025 at 02:22:23PM +0000, Matthew Wilcox wrote:
> On Mon, Dec 15, 2025 at 10:19:00PM +0800, Jinchao Wang wrote:
> > page_cache_ra_order() and page_cache_ra_unbounded() read mapping minimum folio
> > constraints before taking the invalidate lock, allowing concurrent changes to
> > violate page cache invariants.
> > 
> > Move the lookups under filemap_invalidate_lock_shared() to ensure readahead
> > allocations respect the mapping constraints.
> 
> Why are the mapping folio size constraints being changed?  They're
> supposed to be set at inode instantiation and then never changed.

They can change after instantiation for block devices. In the syzbot repro:
  blkdev_ioctl() -> blkdev_bszset() -> set_blocksize() ->
  mapping_set_folio_min_order()

