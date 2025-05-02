Return-Path: <stable+bounces-139431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC5DAA69EE
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 06:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7641BC2773
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 04:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096071A4F3C;
	Fri,  2 May 2025 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nzHF4wfW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3191A239D
	for <stable@vger.kernel.org>; Fri,  2 May 2025 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746161674; cv=none; b=s2MmLJsY3bngQ8j3JxGLJpwWDOZOKlr57Oxtz4tY+m2vGf0+n2CLCOpeunwNPqWmxe6ZKP8+eaQ89razJL89JSYV9/v0pbd/89ImycZyPJ6CfOJ5sru6VHlK1oXZfi47SfA2yOVNWRgBJzEGH4tcKouMPec0kXCLPEh6UzdtIiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746161674; c=relaxed/simple;
	bh=U8MCDGLeLIWXPklvwj16NOg6iZMVTcu6zSXsprGLL4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khGJRwK3xxY2kZPTQ28Pc6iDiDCEvzjnzWsL/X8uOsDbMGyYZma3ShzVNQrOrdyJpSsRBJsLAQ64wS4uFNtV+G+l/kFjQlw/RqfJPbqJDwPxEed8BuHKaikO7HlX0hA926Zcr/ljea4RbrTNKyCUpQP6gZTc9tXWhd9mZeNQXLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nzHF4wfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CBEC4CEE4;
	Fri,  2 May 2025 04:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746161673;
	bh=U8MCDGLeLIWXPklvwj16NOg6iZMVTcu6zSXsprGLL4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nzHF4wfWCe8P51N8diVvhxnaw1KFtvgVZHoF7CUFNYq1FJjesxbkvJbStrgEtL/ly
	 k4itbFGSnMQKG/jEucfNiQWyZljqBFSwlC5xkIcgqX23F4M7glOmaFgE0sZ/2w0w8C
	 obp6Xlbi36J7AWJhwfTY5JJ+qgwhRJs/4vKaq8Yw=
Date: Fri, 2 May 2025 06:54:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: stable@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: Please backport 980a573621ea to 6.12, 6.14
Message-ID: <2025050202-diving-palatable-b44c@gregkh>
References: <CAAH4kHb8OUZKh6Dbkt4BEN6w927NjKrj60CSjjg_ayqq0nDdhA@mail.gmail.com>
 <2025050151-recharger-cavity-b628@gregkh>
 <CAAH4kHY7sccAgtoouC4wFEbp4beKJ-pMD2SxW_jVrVpg5FexVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAH4kHY7sccAgtoouC4wFEbp4beKJ-pMD2SxW_jVrVpg5FexVw@mail.gmail.com>

On Thu, May 01, 2025 at 01:06:34PM -0700, Dionna Amalie Glaze wrote:
> On Thu, May 1, 2025 at 11:04 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, May 01, 2025 at 09:48:59AM -0700, Dionna Amalie Glaze wrote:
> > > 980a573621ea ("tpm: Make chip->{status,cancel,req_canceled} opt")
> > >
> > > This is a dependent commit for the series of patches to add the AMD
> > > SEV-SNP SVSM vTPM device driver. Kernel 6.11 added SVSM support, but
> > > not support for the critical component for boot integrity that follows
> > > the SEV-SNP threat model. That series
> > > https://lore.kernel.org/all/20250410135118.133240-1-sgarzare@redhat.com/
> > > is applied at tip but is not yet in the mainline.
> >
> > How does this fix a bug in these stable branches now?
> 
> I find that the inability to use the main purpose of SVSM support for
> trusted boot integrity is a security bug according to the SEV-SNP
> threat model.

That is a new feature, sorry.  Just use new kernel versions if you wish
to have this.

greg k-h

