Return-Path: <stable+bounces-161668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2130DB0210B
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 18:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FE1D7B5E75
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 16:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A32F1EA6F;
	Fri, 11 Jul 2025 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LFlDkTo1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8EF2AE66
	for <stable@vger.kernel.org>; Fri, 11 Jul 2025 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752249713; cv=none; b=QnpbMEn93knsaOxaEXPS3BZh48RtlomJOOk2hrvLbihWr20aTSB1CjS+h4FaT2YiEPOJwU0wHF7uKdW/ueen6Pnt/lkH4jzVu/IkzpI5D8rDRHkWdvUov+WZjawnD4ygVCsEj3e83DYCmnMH6Tl8lUgS7LInIyTGl2kKZVEnEKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752249713; c=relaxed/simple;
	bh=+Ou+0IpA5NqFLd6uuzPDHUs6zJKRI695n/2myCKDpMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVT64Upzij8RJ+e55tT1qJVEFwh9FKVe+KQ7tKz3jcMnm2MbjODyMpMZrywGaGwpAKcLAY24AUl6cT0/hbkcotbd5pnzhUBHjyCpQ3jieLFROW4IVcLZR5f02D2Bhee1wYFkChjw21Dy5RKvNFXSGis7BAkT9gYHPqeBOudkQLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LFlDkTo1; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3ab112dea41so1353139f8f.1
        for <stable@vger.kernel.org>; Fri, 11 Jul 2025 09:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752249710; x=1752854510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SfzvTx6PbZXDwLOdzidNW/W7RYVUXx9hspSggUOo04Q=;
        b=LFlDkTo1HX56SN7meX2Y9ubyM0whFQWNuD8arX2Hg8y2mwfGEXxs4p/EZ2i8DI0dtn
         RyNabw5NPiM5eeus/zfh56WxJEOv3csUfzuDj/RpZ/cn19wb/9kAYr23ZmsrFR/Uc3fK
         tTJ9ogWC/zZjCwEG2ooTcp9JUN2yKvfjlBEziLV0s2C2iTp8f4XydwW2qJwxqNUiF6V0
         KM8I23jf5tQbdh/vm3V3nEtS7snbnDuEPDBEQKqFDk+41mWJy5vzlczB/3fjWLM0+t5W
         KKbPwOIuiDN2BXW5ZHWY01BSt5k6q22++IHmOZYpX0HNzq35K9iwkbv21oqiiSPMjVCP
         B8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752249710; x=1752854510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfzvTx6PbZXDwLOdzidNW/W7RYVUXx9hspSggUOo04Q=;
        b=tw30o2K/CExEv6riBrF2n9GVxuJbTbPz4njYidFgWbrFZL6tavci5tgE/BFr12Iozo
         hUJwHZdq7302dh9qlsgxZ4y/Kxo+WSurcokXS/e7Jf1G7zkTxV7G0IxlM3gUdB5iTRKy
         kZqiMoXOluWNkJ4apIKC8F2x/qBAWpUNBrmLrYxqs8ZBUwYTmSlLDtwIoze6lxVJYe3m
         tbLFyvqNzL25MQHS9QbBgteItp1Fwc9k/bFBHmqZnJeSF2MsIVL6cVCfVGNb72iKUr4Z
         XGfze7r7YiA88HTRzxd9n0AVtFjyY2AO/pOSeRv779dGrTGf8JlVe8hILK4kooBhCXeE
         WPTQ==
X-Gm-Message-State: AOJu0YzEMixRZeMVagJ/2aoSD4SXbO+ikW44xU9QzH1Pv2Xdq3mGDRPd
	M283OCEfd3TpzeeWgfF6S+sA9JFC6ABdnbqz/8IJzVn0wba85rlGIymeGHaEDwYjXVA=
X-Gm-Gg: ASbGncui2h6HnImUlEqW+b1+xPPgLnqXNru6glYekufXeMWXoCgotBNJSsA1QgoOb8U
	PuO7NHmAO6q+ALSozY1HfnHkkTbYeiJynPWcRRrUrFPZUmtGkOa5hWBbT2TicRtFLT1GXPhAq3N
	cM23dD1zlxPtdk+fY60uSeH7qSUjumS4A3TFkpWrb38fIxr3axpExd2gcwcLWcoJmEaWdxQfp6w
	3ftkRMxzbrY7Tr+8bn4yh2B7CSQyFBTLEi8RD46asBeu4TZ8xV5CD2LIu7k7gedZn9/gHN+Vd35
	jJv2ywKbubSsIwcenpX3rKh9yeOuCyLCDdGSHNucqmMX9+B8BpjMsBdTIJgsxBrZIUi9kcovZ/A
	VpGZ2FunBLN8Z11FuOcEAEUW5SgDnyrk=
X-Google-Smtp-Source: AGHT+IGVE/TqkveogVzDWlQtprwEsaxc2e/30UrrYvMU03kHlt0fJ8uctIWNIzx+f4bYJUmlkYcLOg==
X-Received: by 2002:a05:6000:18ac:b0:3aa:34f4:d437 with SMTP id ffacd0b85a97d-3b5f35783abmr2762577f8f.37.1752249708422;
        Fri, 11 Jul 2025 09:01:48 -0700 (PDT)
Received: from precision ([2804:7f0:bc00:fc9b:1aa7:f529:d2f7:747d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c301cb550sm8511080a91.41.2025.07.11.09.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:01:47 -0700 (PDT)
Date: Fri, 11 Jul 2025 12:59:55 -0300
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: David Howells <dhowells@redhat.com>
Cc: stable@vger.kernel.org, smfrench@gmail.com, linux-cifs@vger.kernel.org,
	Laura Kerner <laura.kerner@ichaus.de>
Subject: Re: [PATCH 6.6.y] smb: client: support kvec iterators in async read
 path
Message-ID: <aHE0--yUyFJqK6lb@precision>
References: <20250710165040.3525304-1-henrique.carvalho@suse.com>
 <2944136.1752224518@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2944136.1752224518@warthog.procyon.org.uk>

On Fri, Jul 11, 2025 at 10:01:58AM +0100, David Howells wrote:
> Henrique Carvalho <henrique.carvalho@suse.com> wrote:
> 
> > Add cifs_limit_kvec_subset() and select the appropriate limiter in
> > cifs_send_async_read() to handle kvec iterators in async read path,
> > fixing the EIO bug when running executables in cifs shares mounted
> > with nolease.
> > 
> > This patch -- or equivalent patch, does not exist upstream, as the
> > upstream code has suffered considerable API changes. The affected path
> > is currently handled by netfs lib and located under netfs/direct_read.c.
> 
> Are you saying that you do see this upstream too?
> 

No, the patch only targets the 6.6.y stable tree. Since version 6.8,
this path has moved into the netfs layer, so the original bug no longer
exists.

The bug was fixed at least since the commit referred in the commit
message -- 3ee1a1fc3981. In this commit, the call to cifs_user_readv()
is replaced by a call to netfs_unbuffered_read_iter(), inside the
function cifs_strict_readv().

netfs_unbuffered_read_iter() itself was introduced in commit
016dc8516aec8, along with other netfs api changes, present in kernel
versions 6.8+.

Backporting netfs directly would be non-trivial. Instead, I:

- add cifs_limit_kvec_subset(), modeled on the existing
  cifs_limit_bvec_subset()
- choose between the kvec or bvec limiter function early in
  cifs_write_from_iter().

The Fixes tag references d08089f649a0c, which implements
cifs_limit_bvec_subset() and uses it inside cifs_write_from_iter().

> > Reproducer:
> > 
> > $ mount.cifs //server/share /mnt -o nolease
> > $ cat - > /mnt/test.sh <<EOL
> > echo hallo
> > EOL
> > $ chmod +x /mnt/test.sh
> > $ /mnt/test.sh
> > bash: /mnt/test.sh: /bin/bash: Defekter Interpreter: Eingabe-/Ausgabefehler
> > $ rm -f /mnt/test.sh
> 
> Is this what you are expecting to see when it works or when it fails?
> 

This is the reproducer for the observed bug. In english it reads "Bad
interpreter: Input/Output error".

FYI: I tried to follow Option 3 of the stable-kernel rules for submission:
<https://www.kernel.org/doc/html/v6.15/process/stable-kernel-rules.html>
Please let me know if you'd prefer a different approach or any further
changes.


Henrique

