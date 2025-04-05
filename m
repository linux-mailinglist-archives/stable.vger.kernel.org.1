Return-Path: <stable+bounces-128373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D8EA7C7F9
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 09:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EEBA189B097
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 07:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6842E1C5F01;
	Sat,  5 Apr 2025 07:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MyzHPah8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2666F111BF
	for <stable@vger.kernel.org>; Sat,  5 Apr 2025 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743838534; cv=none; b=It2zlYIgZkB+X7ckMd1YQvsHBnvrvwF/Zc9MBLp+m+7phdNJ0KjpnGJ6Q55WzwiEMGqyoDJyesxXqs5FD9bJQbntBpE5kWv2gcY5/joA79UgRyLc24cEouvx+pBKCxPTeYx03dHAp7y059a1GS09lXgA8yV+bhX5LdoOTQiePKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743838534; c=relaxed/simple;
	bh=wzrL5Jyk5N5BdACRM6eVrONp64FsU9lkuiQUqscs2SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfasBim1/GCeMX4E4B9PYLIkdYqpabsA/OIetNX0GLNiAt3qv4ML/E3xdxsAU2BDLb+f4qTj8n0QX5hghU5BsKoWZwWtR8RtCYV6Iyp8zRZPXwGH60UzaFvOqj68tuHHA8rw7eQp0HvtWMeJV6F62L/SYhqnXPZ3ELo/+EBq7mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MyzHPah8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F7CC4CEE4;
	Sat,  5 Apr 2025 07:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743838533;
	bh=wzrL5Jyk5N5BdACRM6eVrONp64FsU9lkuiQUqscs2SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MyzHPah8vxb+LjcdGB/d2QoZxMpHFUIXrA8Liy+linrCzHNk6dCdDXmZdVnApG5YP
	 0aCxWE4i3hzFzV+WCmcr+zTnK4mJ2Rrj/GlGqY1i0ljrFGZD9htJwk9lamxCR0XUF5
	 4cWs6owHFEI9+5N+mGeNSQgUO7TTSnE0Aq9Q31cg=
Date: Sat, 5 Apr 2025 08:34:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Justin Tee <justintee8345@gmail.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Bin Lan <bin.lan.cn@windriver.com>, stable@vger.kernel.org,
	bass@buaa.edu.cn, islituo@gmail.com, loberman@redhat.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH 5.10.y] scsi: lpfc: Fix a possible data race in
 lpfc_unregister_fcf_rescan()
Message-ID: <2025040517-ranch-rifling-3e8f@gregkh>
References: <20250403032915.443616-1-bin.lan.cn@windriver.com>
 <20250403032915.443616-2-bin.lan.cn@windriver.com>
 <d808abf5-a999-4821-a24a-388fee184ffc@windriver.com>
 <CAAmqgVM--YEC=hNt5H8DVUwvN9G5p=UX86X-VqKQG2wH9Re7+w@mail.gmail.com>
 <2025040400-retool-spouse-0ecc@gregkh>
 <CABPRKS-WXKmSDyWbEtMHeTbRXctjc5GFwOWJAdzZ+vQHNZBLHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPRKS-WXKmSDyWbEtMHeTbRXctjc5GFwOWJAdzZ+vQHNZBLHw@mail.gmail.com>

On Fri, Apr 04, 2025 at 01:23:49PM -0700, Justin Tee wrote:
> Hi Greg,
> 
> > > This electronic communication and the information and any files transmitted
> > > with it, or attached to it, are confidential and are intended solely for
> > > the use of the individual or entity to whom it is addressed and may contain
> > > information that is confidential, legally privileged, protected by privacy
> > > laws, or otherwise restricted from disclosure to anyone else. If you are
> > > not the intended recipient or the person responsible for delivering the
> > > e-mail to the intended recipient, you are hereby notified that any use,
> > > copying, distributing, dissemination, forwarding, printing, or copying of
> > > this e-mail is strictly prohibited. If you received this e-mail in error,
> > > please return the e-mail to the sender, delete it from your computer, and
> > > destroy any printed copy of it.
> >
> > Now deleted.
> 
> You and everyone on this mailing list are intended recipients, so
> there is no need to delete.

Not true, you said this is "confidential" and according to our legal
advivice, that is not allowed to be on a change for a contribution to
Linux.  Please remove this type of message if you wish to contribute to
open source projects.

thanks,

greg k-h

