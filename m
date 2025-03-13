Return-Path: <stable+bounces-124333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F77A5FAEE
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 17:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53559188B90D
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 16:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87255260366;
	Thu, 13 Mar 2025 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MzuhRNuP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F4926980A
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881693; cv=none; b=fA/2IZbfLOSxflQwZFRIaKy+vwNAHqFsFkEl3PrEQBw4pOJWM+utAu6+qg28hto4YZYBIBPJk8XLjeN4AocUZj3vaVOM5FZe5eib8aBa4x5ZfHwICFDsakjqLs5QEfIrR6Ax28CdbOy9e9ZIuZnXdEqt5OYN1dkO7gDFse1hkYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881693; c=relaxed/simple;
	bh=L5P3hFLI5K7ekSRd/ERL3CdOeuImNGaiSpTkHDgueXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSBRXVkPvZ+QGlFdNs52u527fv/3grMJzOA3R1EHAJg16k2R6cUZn+pRQJpBtcOoebzI45Nd3oeBpbcVs8q5JHFiFf+Gq7rbEKJGhblCM9tLLaVtaWS+yUfTww4tH59OggTHF+2OCCFNgO3kRGHcvCZHxoTxPDIGTXbKgRKKPqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MzuhRNuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188EAC4CEDD;
	Thu, 13 Mar 2025 16:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741881691;
	bh=L5P3hFLI5K7ekSRd/ERL3CdOeuImNGaiSpTkHDgueXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MzuhRNuPwHpE2zLAFgeg72hbN0CAcURYA2yKmorSfGiEpLANx0AJ4b/K2hBOpUYj9
	 omtb5kWBS0+vqD8NvBotdrIpGP7XouUh1aUTzyWEE0fQXbO77PrjL+nfJNO+FtPRZm
	 35CyXcVlA+CKRMZ087r6OB1cZLLWQ5uKm2jQCUvY=
Date: Thu, 13 Mar 2025 17:01:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: 21cnbao@gmail.com, Liam.Howlett@oracle.com, aarcange@redhat.com,
	akpm@linux-foundation.org, david@redhat.com, hughd@google.com,
	jannh@google.com, kaleshsingh@google.com, lokeshgidra@google.com,
	lorenzo.stoakes@oracle.com, peterx@redhat.com,
	stable@vger.kernel.org, v-songbaohua@oppo.com, willy@infradead.org
Subject: Re: FAILED: patch "[PATCH] userfaultfd: fix PTE unmapping
 stack-allocated PTE copies" failed to apply to 6.13-stable tree
Message-ID: <2025031321-irritate-repulsion-f936@gregkh>
References: <2025030947-disloyal-bust-0d23@gregkh>
 <CAJuCfpETm8PL8O91jEhkAHc8hkpJhCyEXiZbCvnPz_GMAZ5ptA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpETm8PL8O91jEhkAHc8hkpJhCyEXiZbCvnPz_GMAZ5ptA@mail.gmail.com>

On Mon, Mar 10, 2025 at 11:50:37AM -0700, Suren Baghdasaryan wrote:
> On Sun, Mar 9, 2025 at 11:15 AM <gregkh@linuxfoundation.org> wrote:
> >
> >
> > The patch below does not apply to the 6.13-stable tree.
> 
> Hi Greg,
> I just posted linux-6.13.y backport [1] for an earlier patch and with
> that and with 37b338eed10581784e854d4262da05c8d960c748 which you
> already backported into linux-6.13.y this patch should merge cleanly.
> Could you please try cherry-picking it again after merging [1] into
> linux-6.13.y?
> Thanks,
> Suren.
> 
> [1] https://lore.kernel.org/all/20250310184033.1205075-1-surenb@google.com/

Yes, that worked, thanks!

greg k-h

