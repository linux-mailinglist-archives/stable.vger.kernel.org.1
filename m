Return-Path: <stable+bounces-144349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CE5AB67EE
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 11:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34FA91646DC
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 09:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFC525D218;
	Wed, 14 May 2025 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FXZy2IXz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7FF25487B
	for <stable@vger.kernel.org>; Wed, 14 May 2025 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747216137; cv=none; b=aBoUyCpw6CtwUaHKDe78Ve2bV0xaR4pH1zWdkrKvLnCqGn1vCQkusSHi5RBRExs/w4vYx2o9HxIc4RpNuKyrprF2ZDzqsxJ/ih6pgM1XLtofaBX6UpahqMynSLfFlGr6hXbd9WCEDe57hafrA6ogklw6B8mX/4rH0HR9jlS6lpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747216137; c=relaxed/simple;
	bh=tJ8eOXVCt93R5a6YvX21e9ao4chQ1VdBrMd78O+pSss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNQifBFA6hBkxmJ3x7RKoqef3wI/iYbSC1e0Ef37qTXHwDmQtKMU+mOPDHDAm0ayKnZ6Ve7foCVKEvJx+jsXsTTfljxZueVpgmkczKGiebbyH+bFsd8LOUVXAKoPRu8vsFHA3X4Y7RnSy6mRSdZlqFYULpfKsiwnrfWsoVsAx9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FXZy2IXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9B2C4CEE9;
	Wed, 14 May 2025 09:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747216137;
	bh=tJ8eOXVCt93R5a6YvX21e9ao4chQ1VdBrMd78O+pSss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FXZy2IXzOuXT3YZ5NJDQ38Xkdg6eZrKLqa3s17OoLFx1+3DqIQZJuqbBP+dsVtRu6
	 Lc8WisWgXXRAFZUscRBVYNXhCRrkVVUL215cyn/6BUCpC99/nPePOXGYhjbemXz4YN
	 lVviXKwQ+9JXMwMmx2NqpUjlcUQuURc0J0r6JnMs=
Date: Wed, 14 May 2025 11:47:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: Re: [PATCH] x86/its: Fix build errors when CONFIG_MODULES=n
Message-ID: <2025051401-absolute-shelving-d657@gregkh>
References: <20250513-its-fixes-6-6-v1-1-2bec01a29b09@linux.intel.com>
 <20250514045557.gonwfisy34jy4rlx@desk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514045557.gonwfisy34jy4rlx@desk>

On Tue, May 13, 2025 at 09:55:57PM -0700, Pawan Gupta wrote:
> On Tue, May 13, 2025 at 09:46:11PM -0700, Pawan Gupta wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > commit 9f35e33144ae5377d6a8de86dd3bd4d995c6ac65 upstream.
> > 
> > Fix several build errors when CONFIG_MODULES=n, including the following:
> > 
> > ../arch/x86/kernel/alternative.c:195:25: error: incomplete definition of type 'struct module'
> >   195 |         for (int i = 0; i < mod->its_num_pages; i++) {
> > 
> > Fixes: 872df34d7c51 ("x86/its: Use dynamic thunks for indirect branches")
> > Cc: stable@vger.kernel.org
> 
> Sorry I forgot to put the kernel version in the subject. The same patch
> applies to other kernel versions as well. I don't really need to send them
> separately I guess, stable bots will likely pick those.
> 

Thanks, now queued up.

greg k-h

