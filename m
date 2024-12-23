Return-Path: <stable+bounces-106014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEB19FB520
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 21:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9AC0164A3F
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 20:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774021BE871;
	Mon, 23 Dec 2024 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iuHjCBim"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8FE38F82
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 20:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734985248; cv=none; b=swIKvu6gKrb7BSNDWjvw0OtL/bXKIz70pCGENEFfT2TJjUT+TwuFbPDtrd5rhSgHY5hd8s92067WoTWzEjBVMY/IX/dC+CURaob4JGl4GALJgBZTc3BGmbdTQEZ7nqPQreEGbed52liFc2ICl+WX+RbU/9MgZpjgh1S26B0LQVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734985248; c=relaxed/simple;
	bh=f2z2BR8g6lK9CjbxurMGbf93qB3sfrD8plI6DvyUGwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XC0TLkyO3Ffx2aYxtC76QEmjffRuRFbwDJXPsqt+0OR7G/HMaLiRpuQ/UJfvWu1y5J8OJgEesNUAafamrDZ8iAge5hAx1mL5G302Ztk8DwnDuAarB/leiQ1IZ4R/DMCnlyfQsCxWNQZiqYzcyXZ8KC6YkkoY1HceilS1Ct+MCk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iuHjCBim; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Mkxv5xrUzEiKwh12aWokIMRnBqYKg+GZne1fzgylWCk=; b=iuHjCBim1vFCoUtx+wJ+cCfdb1
	ZcAXXY1+MCM7MM1o7G7oXDusGyCq62+cntWllMZMYezOorxc0qibwntQV/NxpChQdYyD8V5QekqcB
	uNHAChvx0S1FI0+neE1FfC1YtjQlkqswCemS3LXV1HzJ+Cg/qJEKOL4REU61cC4SCiUO/AjQWLYDU
	oDiRFRuAtkAp3yrHERnekWj/nUrO8ABE16Zpmpm8es/tneUHLl/KI/8dW+nFh6UpyaRv2I7ufva1z
	qfk7IbANvB7eHfKKsZkxUvgP+VuCfeakta0j4SkUad9YHV9HagfdrI3t6ioOP0Nx3/NUN+fxfBM83
	G7zrCjIg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tPoux-0000000Gpix-2Zzj;
	Mon, 23 Dec 2024 20:20:43 +0000
Date: Mon, 23 Dec 2024 20:20:43 +0000
From: Matthew Wilcox <willy@infradead.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, balbirs@nvidia.com, hannes@cmpxchg.org,
	hch@lst.de, mhocko@suse.com, muchun.song@linux.dev,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	stable@vger.kernel.org, urezki@gmail.com
Subject: Re: FAILED: patch "[PATCH] vmalloc: fix accounting with i915" failed
 to apply to 5.10-stable tree
Message-ID: <Z2nGG8WpNJB__fhR@casper.infradead.org>
References: <2024122301-uncommon-enquirer-5f71@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024122301-uncommon-enquirer-5f71@gregkh>

On Mon, Dec 23, 2024 at 11:18:01AM +0100, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

The 5.15 patch also applies to the 5.10-stable tree.  Thanks,

