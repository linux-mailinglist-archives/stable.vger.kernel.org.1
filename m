Return-Path: <stable+bounces-115131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6103A33F41
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 13:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EFD07A4217
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 12:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E2A20D4F0;
	Thu, 13 Feb 2025 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JbJSfivv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654C41E86E
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450111; cv=none; b=vCJcrqfrbUcLcfNkSPXRSLM6wLTCarTh7IuUhxfC1kMFz5vpArRif1FvjBnG3jr3JOZ9bKbczNhYMXEfMs5y6Pnp8kXoTscrDmu3GO3Ya36CGKIPf/74HsA9oXlaDeEBCAN9+CK5va1dFbZQe1C9AGJ+KJK+VceoLmnz+ieaV+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450111; c=relaxed/simple;
	bh=kAJXpVyl8aKGsiKoKoS8jWL3ClCe8hUrcvaabBOeSFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OB7Kpe3uSG7LjdsxDmJvT4l6DEIfsOOtAsJTiD08cFLxZK1g/J+3Lwx+F28X+MtBaLfmOtiBEjsP6GVYzE0tvQlZ5ZoKrbXxs8iLlDCGigLAjklhcAn6vRdczgxsKIvhaXzXASzYpmgSu4QPkL8ubSGbETyWKrPiCZDUDOVSzH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JbJSfivv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB40C4CED1;
	Thu, 13 Feb 2025 12:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739450109;
	bh=kAJXpVyl8aKGsiKoKoS8jWL3ClCe8hUrcvaabBOeSFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JbJSfivv3oVKN30cqHMBJP9tVbU5Xt1OMU9myBjF6rD3ewhYm9k6gY+bXSlAoluq8
	 Hz/t9ZALLlvZ7d9LknSrmQPlSd2soI3VatP34+TTpE8i5PSDZDWpu3zK+Qay0R6w6G
	 o7P5Eb9YwPK2Im1nVabrh5iHg9uDMYDPmQT2nHTE=
Date: Thu, 13 Feb 2025 13:35:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: brauner@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] fs: fix adding security options to
 statmount.mnt_opt" failed to apply to 6.13-stable tree
Message-ID: <2025021301-captive-flyable-2bd0@gregkh>
References: <2025021142-whoops-explicit-4d75@gregkh>
 <CAOssrKc8gxsOoDUL3DVa6hgOiuZ533aF_TMLkbVe3XfJLRYBow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOssrKc8gxsOoDUL3DVa6hgOiuZ533aF_TMLkbVe3XfJLRYBow@mail.gmail.com>

On Tue, Feb 11, 2025 at 12:32:23PM +0100, Miklos Szeredi wrote:
> On Tue, Feb 11, 2025 at 10:54 AM <gregkh@linuxfoundation.org> wrote:
> >
> >
> > The patch below does not apply to the 6.13-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Please apply the following prerequisite:
> 
> 056d33137bf9 ("fs: prepend statmount.mnt_opts string with
> security_sb_mnt_opts()")

That worked, thanks!

greg k-h

