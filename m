Return-Path: <stable+bounces-180467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB783B82783
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 03:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0343BAA5C
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 01:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382241F875A;
	Thu, 18 Sep 2025 01:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2Oq2G53j"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2881F09BF
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 01:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758157641; cv=none; b=dzs8v8fd9iARQvl94twNT3Dn6u7pODVU/6b0kqPoQ7QJ9dzscalVlbwYQTzse9jHR+jn4XLt4KDLf1YiOP+4V8yTyotQeRmlTUP1N3NLzxt3vDxaHc1AXN6MYG2CZq3s+dLrkMorBdAheGo2ZDRzDCZGV6k68EtnDR/kd7sgbgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758157641; c=relaxed/simple;
	bh=Jyh/T1VQujpBIetRlEwQ9WKQ0pDM9Occu70Vj9kJ3PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaOELGUXAk8GCu2ht+alrL1y3fnYObCLnVeoWLfFCuzqBwkjiXJUyTUpfopu/XQFeZqLR/vd7edW8YHfgxwQeN5KDwlSQIockEa0Dh9r7rbufx4QD+yoHVxn4IqtyTZjmaBa6p0igU5R/HRNN1Ixd9seRj3xE75DpkFEXiX0J9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2Oq2G53j; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77287fb79d3so454213b3a.1
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 18:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1758157638; x=1758762438; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p3n6Uf5fmho3K1YmaoGj4njt8YRbuIHtLi1zAXG6OwM=;
        b=2Oq2G53jiImhW9tX7gMzXIqb746T/KHiolWjo9MhwMcmkOJWUdUilafdNEy5FEC2Lv
         f144ESPYsmq+enFn/UH5FgTuGu7rKoPe1h6aSkIZUCSFMI/VND1Vbfl8fD/EtkmHDEVe
         vIDRcKrjsAQGgp3bkDZTq+IPaJYukxNbTn/DNJGSzARiZOuEHxFxQMHMeBgI14YPmiw3
         qDEF2TuHKMN6Hg96bnmfulLcNDGQfX+7EsaRSzk7PdMQj4g2YMJYM3ZY8TkCOxs3U7MV
         +jMWJusmd/DA6NjdU3oAQYRD1tcb1Y23QVEbCMbDKNAE2aq6yDFdkG7y2/7AI+pWdEr+
         z2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758157638; x=1758762438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3n6Uf5fmho3K1YmaoGj4njt8YRbuIHtLi1zAXG6OwM=;
        b=Vi4gB2pIZR2PgmAWjSGqqmGoF0AcIi1K64gB/lvWPaqyd40rLJhFv4YSI3TevElV5M
         vK5n7iXG1E/yeFeO7EgAsIibugXOHtks0sRGLwnmn8rvOql3623/h/apElJRbY3QEGXf
         gLkNioUq5ZCPac21XCYux4f86m6jMgVYXq54vCvFCjTEkImpQpIFFvJzhic/awKS8YwR
         TElBLVdsNA2cf7YHdvCg/NiNnp+zM+4y0TwN+Kh+rKKOsQqRuNAqtfA+bDrqFge9tMOq
         i2diWVycAifEOKksvkWb9Pyhds1qODvWEG3CGgfTTueTLGuP2n8kKwJZwNsdc3gmE1yC
         p8Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVyGeZiT0QupGR3ri9L/qrcpWKKQoLgn6lSDzCt92oh/+yfdiuDaZ0q7Sg4LhFOq9PrUlkM4WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBBKCVbCZg3qq2I+rRgTIUHaMeWZD/yoOTqz4oZmJl8aQYXgcU
	7PkzZAG3FFxp5+8Xwaa/b/TgNrTa7dM1L5x5lGBF5vbvsAL7c3ia3yG6C7ta3xsuANI=
X-Gm-Gg: ASbGnctNSYvnikhJrUdBWizYmcchjkTQlouJUXk/FTI/yUSaVfO6UPoI8U41xyvS5q4
	+F/yL0uzlaiTPztHTgG+zvMU9/wgBBeC/oN26KrStGL6Idy5ZkNal9A8+ohWXs9/x3trYKufCDE
	6j1lqB07hc0ms0n5WUuHEgg93YoYoe1eH28rX97es7CJmtnG3krjV4is4njQkPdjAc9b1avRuc7
	AK87UBKIrsxAU0XBw+qFE4zkzGkeoLHjoaCQgcr+bwkmw/aK8mcrK0ONeWn2eZ3OwDmzYKf6hNw
	32zGE1sOgt1XzCG8keygwSFa6zF5bDv/FBqUcKQyvRWxQZaXc6Cm+1aA462pG7LvptEI858TJwd
	fgCeqnrFzJVXoljyX5daV++eCIy5yXoUQrgmH0odRQ1zSg9B0KkhUyqwXCF9FyEXRMHnRiWxNI9
	YB0vBb3Q==
X-Google-Smtp-Source: AGHT+IGuCJoEhQgAv+Omg49c7c/B2Tcr3E0BGIChrElfWl6Pxd6ZK4K1F7fPmkeQRRASiKleSW/EoQ==
X-Received: by 2002:a05:6a00:2350:b0:776:1834:c8c7 with SMTP id d2e1a72fcca58-77bf9664586mr4517640b3a.26.1758157638566;
        Wed, 17 Sep 2025 18:07:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfec40185sm605187b3a.77.2025.09.17.18.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:07:17 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uz37D-00000003LBO-2MNV;
	Thu, 18 Sep 2025 11:07:15 +1000
Date: Thu, 18 Sep 2025 11:07:15 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, slava.dubeyko@ibm.com,
	xiubli@redhat.com, idryomov@gmail.com, amarkuze@redhat.com,
	ceph-devel@vger.kernel.org, netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls
 asynchronous
Message-ID: <aMtbQzb-aFPtjttc@dread.disaster.area>
References: <20250917124404.2207918-1-max.kellermann@ionos.com>
 <aMs7WYubsgGrcSXB@dread.disaster.area>
 <CAGudoHHb38eeqPdwjBpkweEwsa6_DTvdrXr2jYmcJ7h2EpMyQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHb38eeqPdwjBpkweEwsa6_DTvdrXr2jYmcJ7h2EpMyQg@mail.gmail.com>

On Thu, Sep 18, 2025 at 01:08:29AM +0200, Mateusz Guzik wrote:
> On Thu, Sep 18, 2025 at 12:51 AM Dave Chinner <david@fromorbit.com> wrote:
> > - wait for Josef to finish his inode refcount rework patchset that
> >   gets rid of this whole "writeback doesn't hold an inode reference"
> >   problem that is the root cause of this the deadlock.
> >
> > All that adding a whacky async iput work around does right now is
> > make it harder for Josef to land the patchset that makes this
> > problem go away entirely....
> >
> 
> Per Max this is a problem present on older kernels as well, something
> of this sort is needed to cover it regardless of what happens in
> mainline.
> 
> As for mainline, I don't believe Josef's patchset addresses the problem.
> 
> The newly added refcount now taken by writeback et al only gates the
> inode getting freed, it does not gate almost any of iput/evict
> processing. As in with the patchset writeback does not hold a real
> reference.

Hmmmm. That patchset holds a real active reference when it is on the
LRU list.

I thought the new pinned inode list also did the same, but you are
right in that it only holds an object reference.  i.e. whilst the
inode is pinned, iput_final won't move such inodes to the LRU and so
they don't get a new active reference whilst they are waiting for
writeback/page cache reclaim.

That in itself is probably OK, but it means that writeback really
needs to take an active reference to the inode itself while it is
flushing (i.e. whilst it has I_SYNC is set). This prevents the fs
writeback code from dropping the last active reference and trying to
evict the inode whilst writeback is active on the inode...

Indeed, comments in the patchset imply writeback takes an active
reference and so on completion will put inodes back on the correct
list, but that does not appear to be the behaviour that has been
implemented:

	"When we call inode_add_lru(), if the inode falls into one of these
	categories, we will add it to the cached inode list and hold an
	i_obj_count reference.  If the inode does not fall into one of these
	categories it will be moved to the normal LRU, which is already holds an
	i_obj_count reference.

	The dirty case we will delete it from the LRU if it is on one, and then
	the iput after the writeout will make sure it's placed onto the correct
	list at that point."

It's the "iput after the writeout" that implies writeback should be
holding an active reference, as is done with the LRU a couple of
patches later in the series.

> So ceph can still iput from writeback and find itself waiting in
> inode_wait_for_writeback, unless the filesystem can be converted to
> use the weaker refcounts and iobj_put instead (but that's not
> something I would be betting on).

See above; I think the ref counting needs to be the other way
around: writeback needs to take an active ref to prevent eviction
from a nested iput() call from the filesystem...


-- 
Dave Chinner
david@fromorbit.com

