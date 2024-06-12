Return-Path: <stable+bounces-50301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3F790583B
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 18:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0F01F2162A
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84630180A60;
	Wed, 12 Jun 2024 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mm12.xyz header.i=@mm12.xyz header.b="T1kpbAPA"
X-Original-To: stable@vger.kernel.org
Received: from elcheapo.mm12.xyz (elcheapo.mm12.xyz [148.135.104.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA79182AF;
	Wed, 12 Jun 2024 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.104.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208761; cv=none; b=IpcygFCW9nxV36dxP+bY0xU2juUIaO9Ye3oDrpG9rmO0YXrVtIfKLGzrtswrCVRxb2ySKtV63eh81YvopV8EUPHnk+XKpxRJg3DZDHYke+Z5clEPU0ujQMGgOxzKSIJ1AGOVpBljaQldjfPBW+rWySujmVrxFKdd3+yX/zT02Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208761; c=relaxed/simple;
	bh=Qthq0/xFTBXlCUpZKYSouS6zvAr09ZcXXpeId+yzhRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDok4ZEtLY0BLzWsrgBxSZmEIvg2Wr62uidlG+5Ls2/AXbP13PMV96Oaf6T0iilG+VlF984FZBolzff+3FbmDAyFofYbT14101ow0KiNqZ5FsBqgdOGUue+hfNfAuF8w/HFjbRG18iSLgZyQy6oPsCZ7+MoYxeHmoH2AWXBm7V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mm12.xyz; spf=pass smtp.mailfrom=mm12.xyz; dkim=pass (2048-bit key) header.d=mm12.xyz header.i=@mm12.xyz header.b=T1kpbAPA; arc=none smtp.client-ip=148.135.104.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mm12.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mm12.xyz
Received: from scala.mm12.xyz by elcheapo.mm12.xyz (Postfix) with ESMTPSA id 763D91F436;
	Wed, 12 Jun 2024 12:04:30 -0400 (EDT)
Received: by scala.mm12.xyz (Postfix, from userid 1000)
	id 950A1180477; Wed, 12 Jun 2024 12:04:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mm12.xyz; s=mail;
	t=1718208268; bh=Qthq0/xFTBXlCUpZKYSouS6zvAr09ZcXXpeId+yzhRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1kpbAPArVU6+hTgf0bHPk9FvF8jwVz/k8OA/gwI9W8oQa6+u2QBgKn53s4QFQ4bH
	 0L5slNn8/kTQNfEFkfnYWDOPdstk73f50UF4iz3jN3788FNkRussh6R7jCQy21jHIk
	 L1Zy0myJB7A2kMa4qHs87YXXIkr1m9hWSpm1nTuXSyi2B682XIQ3gv0jUL/uM0gZBH
	 ko4B7/L3y+OHNIiwxrbqmOF8p3sEq3jufZyFCewxgnLkqUybAtw4h24hknYvmvfMyi
	 +1CnMU8npadjinUI1e0ggnWYW2fENw2GWqQaYuJ1eg0xkpdnn/bwFMWlheHff3fHoK
	 nvkkEWHx8XcEA==
Date: Wed, 12 Jun 2024 12:04:28 -0400
From: Matthew Mirvish <matthew@mm12.xyz>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, stable-commits@vger.kernel.org
Subject: Re: Patch "bcache: fix variable length array abuse in btree_iter"
 has been added to the 5.15-stable tree
Message-ID: <20240612160428.GA1953091@mm12.xyz>
References: <2024061210-crib-during-28fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061210-crib-during-28fe@gregkh>

On Wed, Jun 12, 2024 at 05:29:10PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     bcache: fix variable length array abuse in btree_iter
> 
> to the 5.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      bcache-fix-variable-length-array-abuse-in-btree_iter.patch
> and it can be found in the queue-5.15 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 

Hi, I forgot to add a version tag on this -- it should only be in
kernels >= v6.1, so please drop it from v5.10 & v5.15.

Thanks,
Matthew

