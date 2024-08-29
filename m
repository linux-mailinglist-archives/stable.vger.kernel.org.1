Return-Path: <stable+bounces-71510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C686A964986
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 17:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463CC1F21F72
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 15:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260951B29BD;
	Thu, 29 Aug 2024 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrH9KMaJ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128911B1513
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944236; cv=none; b=tVXa4af4aaCghbR4UVXumbGAA9ciEFqY1GgTEYmh7eIx1HUbF7xD53CEXtlRs/FNg5fkExuy7AteV/4BxZ+JQQCoJriNhz3+7u9nGoXrgb8EpZD2SfSkoi6ukslxHsXdR6pNvHGSnm62/+qGgfgvjYEbiQHQOSIGiz66E2VtJ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944236; c=relaxed/simple;
	bh=3wueJtwqZPDY8uUIPY+rtKEAp2/GgrA6iAsAi6G04ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IT+jFBo53YDegDqEzXvLDwDZB4ZNwX74bUCE+Dktc4+w4yFnd4EpR+y/3OExazgDOcv1GFWZc0zfTgjxB553f7djwdtYK97nD4vFZEhFYA2FsZaVXCHrjsKJlbVVuedCKaxrL4+ivhtjtyqLjoMm670nnzFgFIGZeGa2aT9ZGpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YrH9KMaJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724944234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=412DWhH/oriLI6hvWD5rHCU4OUHfqjU0rcZX3wNeFQE=;
	b=YrH9KMaJWVI7uah/CPqAhCRz8QhWtspHaUN4GmjjOCUKJBqfsvF6kZYU/PgVA2COpISh2X
	mhE4bTlhuqCqxYefx46YvrY96r6SpuP6+Aw3/CGFgaQsbbDeYe+dsZ+BXo1eMULzAqO+Pf
	8PLJqWQGVE7dKHWbP7g408NQM59jZk0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-CLY1iY0oNxiGT1syonpCKA-1; Thu, 29 Aug 2024 11:10:32 -0400
X-MC-Unique: CLY1iY0oNxiGT1syonpCKA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5bed91ffb50so576728a12.0
        for <stable@vger.kernel.org>; Thu, 29 Aug 2024 08:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724944231; x=1725549031;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=412DWhH/oriLI6hvWD5rHCU4OUHfqjU0rcZX3wNeFQE=;
        b=bgMENjv+6bjtFXmzhPx49Ebsy9t620CQ+haKCQRAvi7rfvsf1g68GCnQ1ZBpKPrV6b
         ctP0Eayfa2mqF/kLqZMlXHYupp+CFKdUG8GiMJsnBQ1Oyw9grne9n75bfv+JIJbtoBP0
         QTNNrS1zCChD/n8EqCe+0IXZK0YlsUxZkEb5poNsvDnmAgCHVdAv5UmAAH4q+w++OXWE
         DC80UwvdlnEgq78va3SD9/362HRCX62o49/ilOvenibL8FN77nITTcuujQ8qAiggwI2y
         P4RdxPgqYCyaSQ0ORQd6n2tS4Dm3Gmf3fzIckPam8shYDn9hm7b4UlYmAvH7PpyvMPNw
         1C1w==
X-Forwarded-Encrypted: i=1; AJvYcCWUrzdGGwTAsv4G3u7FBe5sUylxgiuol16cGqhr8Jf6wzFO2E9mm1fxnFlhSPrNt/3dmGF8APc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoOPtBVKwKQES7BW/lpyK1mVOsjwCcRENvO735fw+aZx5ddVtP
	nwLAOrKazSLJ6CLOq/Av7xe4pXS4UaFSrbCUfsk92yGtFpCKfwwY0GjVamfPc1ZZ2YJ7jsoK/iG
	DeyP5vmElX6DYrrb/ZDateIZUIJW68fi24cMklAn7/Ta544Ca/FZ/cQ==
X-Received: by 2002:a05:6402:3506:b0:5c2:17f7:a3cc with SMTP id 4fb4d7f45d1cf-5c21ed311dfmr3269576a12.7.1724944231557;
        Thu, 29 Aug 2024 08:10:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsjAXjjJGNgtKMvoMzJYd+NwWHB3eXVAslR4/vzHPWb7ReUjNyaxjfmmOTF5ScXOWLN7Kriw==
X-Received: by 2002:a05:6402:3506:b0:5c2:17f7:a3cc with SMTP id 4fb4d7f45d1cf-5c21ed311dfmr3269546a12.7.1724944230707;
        Thu, 29 Aug 2024 08:10:30 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17c:f3dd:4b1c:bb80:a038:2df3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d80fcsm89031566b.181.2024.08.29.08.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 08:10:30 -0700 (PDT)
Date: Thu, 29 Aug 2024 11:10:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v5 6/7] vdpa: solidrun: Fix UB bug with devres
Message-ID: <20240829110902-mutt-send-email-mst@kernel.org>
References: <20240829141844.39064-1-pstanner@redhat.com>
 <20240829141844.39064-7-pstanner@redhat.com>
 <20240829102320-mutt-send-email-mst@kernel.org>
 <CAHp75Ve7O6eAiNx0+v_SNR2vuYgnkeWrPD1Umb1afS3pf7m8MQ@mail.gmail.com>
 <20240829104124-mutt-send-email-mst@kernel.org>
 <2cc5984b65beb6805f8d60ffd9627897b65b7700.camel@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cc5984b65beb6805f8d60ffd9627897b65b7700.camel@redhat.com>

On Thu, Aug 29, 2024 at 04:49:50PM +0200, Philipp Stanner wrote:
> On Thu, 2024-08-29 at 10:41 -0400, Michael S. Tsirkin wrote:
> > On Thu, Aug 29, 2024 at 05:26:39PM +0300, Andy Shevchenko wrote:
> > > On Thu, Aug 29, 2024 at 5:23 PM Michael S. Tsirkin <mst@redhat.com>
> > > wrote:
> > > > 
> > > > On Thu, Aug 29, 2024 at 04:16:25PM +0200, Philipp Stanner wrote:
> > > > > In psnet_open_pf_bar() and snet_open_vf_bar() a string later
> > > > > passed to
> > > > > pcim_iomap_regions() is placed on the stack. Neither
> > > > > pcim_iomap_regions() nor the functions it calls copy that
> > > > > string.
> > > > > 
> > > > > Should the string later ever be used, this, consequently,
> > > > > causes
> > > > > undefined behavior since the stack frame will by then have
> > > > > disappeared.
> > > > > 
> > > > > Fix the bug by allocating the strings on the heap through
> > > > > devm_kasprintf().
> > > > > 
> > > > > Cc: stable@vger.kernel.org    # v6.3
> > > > > Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
> > > > > Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > > > Closes:
> > > > > https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr/
> > > > > Suggested-by: Andy Shevchenko <andy@kernel.org>
> > > > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > > > 
> > > > Post this separately, so I can apply?
> > > 
> > > Don't you use `b4`? With it it as simple as
> > > 
> > >   b4 am -P 6 $MSG_ID_OF_THIS_SERIES
> > > 
> > > -- 
> > > With Best Regards,
> > > Andy Shevchenko
> > 
> > I can do all kind of things, but if it's posted as part of a
> > patchset,
> > it is not clear to me this has been tested outside of the patchset.
> > 
> 
> Separating it from the series would lead to merge conflicts, because
> patch 7 depends on it.
> 
> If you're responsible for vdpa in general I could send patches 6 and 7
> separately to you.
> 
> But number 7 depends on number 1, because pcim_iounmap_region() needs
> to be public. So if patches 1-5 enter through a different tree than
> yours, that could be a problem.
> 
> 
> P.

Defer 1/7 until after the merge window, this is what is normally done.
Adding new warnings is not nice, anyway.

-- 
MST


