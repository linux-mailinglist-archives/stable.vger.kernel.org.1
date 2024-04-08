Return-Path: <stable+bounces-36398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE7989BE1C
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A776C281318
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 11:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183B5657BC;
	Mon,  8 Apr 2024 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wp0cNhtu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFC13FB81
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575649; cv=none; b=Yspy/JU5lVGlocYuL7wKSu25+5oKUUvYYk8j2pHZr6yP+8/xQuqjmIjeRfdCagnvbFsJHJ47CUKpVQbfyRs1MBQdHwS2+parJg/nbaBAkopbBdX9uE9uyto7DoaLcIPWFzQYdK3AEIqDe1w7QLJStO0XoAsxkbxU3hsLLvddfQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575649; c=relaxed/simple;
	bh=RNYbUjbw2dEAyGCIhsnoOVPDK1XN14WH3wMZiu9Ce/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlC1CKJd8t/irTU5Je21/3WZj5vANfAxBlZi9ABRzheT9JqE0CGsPfsAJc1OnxdIZa7ZkSrpqYelWSeG5FPaqkKRUde4EHHKVyz8MlKod+TdIA8PXV9VEsuTBpvGOlsZITtI32fykWsS+QPdBtAkGosalR99aF+gu0ZUdGNU0sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wp0cNhtu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF42CC433C7;
	Mon,  8 Apr 2024 11:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712575649;
	bh=RNYbUjbw2dEAyGCIhsnoOVPDK1XN14WH3wMZiu9Ce/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wp0cNhtuaLpMbUuyXOcbZ/t48M5p8lN7CkWEUwupNZaHvDgtSE4ajesRdjJqiXS9G
	 0yTGn+jfYHT7JYJ4qG7XYLnexC/NUz8e+W/ZOH49np5GYQ5naz8T1ty0YfwD77bgDN
	 1O/mh++WoI5pmQzapdlLg2JPk+Pdt6MPQS0fytjM=
Date: Mon, 8 Apr 2024 13:27:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: stable@vger.kernel.org, xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: [PATCH 6.1.y] mm/secretmem: fix GUP-fast succeeding on secretmem
 folios
Message-ID: <2024040816-hunting-trapezoid-c87e@gregkh>
References: <2024040819-elf-bamboo-00f6@gregkh>
 <20240408103410.81848-1-david@redhat.com>
 <05c72609-06ed-43bd-94a1-e32788cf5654@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05c72609-06ed-43bd-94a1-e32788cf5654@redhat.com>

On Mon, Apr 08, 2024 at 12:39:51PM +0200, David Hildenbrand wrote:
> On 08.04.24 12:34, David Hildenbrand wrote:
> > folio_is_secretmem() currently relies on secretmem folios being LRU
> > folios, to save some cycles.
> > 
> > However, folios might reside in a folio batch without the LRU flag set, or
> > temporarily have their LRU flag cleared.  Consequently, the LRU flag is
> > unreliable for this purpose.
> > 
> > In particular, this is the case when secretmem_fault() allocates a fresh
> > page and calls filemap_add_folio()->folio_add_lru().  The folio might be
> > added to the per-cpu folio batch and won't get the LRU flag set until the
> > batch was drained using e.g., lru_add_drain().
> > 
> > Consequently, folio_is_secretmem() might not detect secretmem folios and
> > GUP-fast can succeed in grabbing a secretmem folio, crashing the kernel
> > when we would later try reading/writing to the folio, because the folio
> > has been unmapped from the directmap.
> > 
> > Fix it by removing that unreliable check.
> > 
> > Link: https://lkml.kernel.org/r/20240326143210.291116-2-david@redhat.com
> > Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > Reported-by: xingwei lee <xrivendell7@gmail.com>
> > Reported-by: yue sun <samsun1006219@gmail.com>
> > Closes: https://lore.kernel.org/lkml/CABOYnLyevJeravW=QrH0JUPYEcDN160aZFb7kwndm-J2rmz0HQ@mail.gmail.com/
> > Debugged-by: Miklos Szeredi <miklos@szeredi.hu>
> > Tested-by: Miklos Szeredi <mszeredi@redhat.com>
> > Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > (cherry picked from commit 65291dcfcf8936e1b23cfd7718fdfde7cfaf7706)
> 
> Forgot to add when cherry-picking
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Now queued up, thanks.

greg k-h

