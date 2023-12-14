Return-Path: <stable+bounces-6716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 762B28129EF
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 09:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 095ECB20CAF
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 08:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4608C15482;
	Thu, 14 Dec 2023 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hFVJO8cc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFCE15E81
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 08:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E83C433C8;
	Thu, 14 Dec 2023 08:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702541141;
	bh=rxAhYM8vwVOvccy8Vl4CmgUocn1hM/kYn7pn6f2Hymg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hFVJO8ccqIEvUZUYgiiId1zu/lj1Kfve0MJ3TDlGNMx8/WKlkAxFrzjcNOuboC2w2
	 B5RuD7Asp9+qdzb5UmAbr/vTRMhanYmioHM82CdN4ezXd05O4R3M4cHKIIwd+vPqyJ
	 5E89tTyjSL5C+jAWssaHxco0qDilHBzrHSSCUyIA=
Date: Thu, 14 Dec 2023 09:05:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steven French <Steven.French@microsoft.com>,
	"paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for
 CVE-2023-38431
Message-ID: <2023121434-universal-lively-3efa@gregkh>
References: <20231212184745.2245187-1-paul.gortmaker@windriver.com>
 <2023121241-pope-fragility-edad@gregkh>
 <DM4PR21MB34417B034A9637445C598675E48EA@DM4PR21MB3441.namprd21.prod.outlook.com>
 <2023121350-spearmint-manned-b7b1@gregkh>
 <CAKYAXd9H+-zi5QnGQCD5T8nKkK733O6MPUnPn2_d10OW0Pp_Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd9H+-zi5QnGQCD5T8nKkK733O6MPUnPn2_d10OW0Pp_Ww@mail.gmail.com>

On Thu, Dec 14, 2023 at 08:31:44AM +0900, Namjae Jeon wrote:
> 2023-12-13 23:36 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
> > On Tue, Dec 12, 2023 at 08:13:37PM +0000, Steven French wrote:
> >> Out of curiosity, has there been an alternative approach for some
> >> backports, where someone backports most fixes and features (and safe
> >> cleanup) but does not backport any of the changesets which have
> >> dependencies outside the module (e.g. VFS changes, netfs or mm changes
> >> etc.)  to reduce patch dependency risk (ie 70-80% backport instead of
> >> the typical 10-20% that are picked up by stable)?
> >>
> >> For example, we (on the client) ran into issues with 5.15 kernel (for
> >> the client) missing so many important fixes and features (and
> >> sometimes hard to distinguish when a new feature is also a 'fix') that
> >> I did a "full backport" for cifs.ko again a few months ago for 5.15
> >> (leaving out about 10% of the patches, those with dependencies or that
> >> would be risky).
> >
> > We did take a "big backport/sync" for io_uring in 5.15.y a while ago, so
> > there is precident for this.
> >
> > But really, is anyone even using this feature in 5.15.y anyway?  I don't
> > know of any major distro using 5.15.y any more, and Android systems
> > based on 5.15.y don't use this specific filesystem, so what is left?
> > Can we just mark it broken and be done with it?
> As I know, ksmbd is enable in 5.15 kernel of some distros(opensuse,
> ubuntu, etc) except redhat.

But do any of them actually use the 5.15.y kernel tree and take updates
from there?  That's the key thing here.

> And users can use this feature. I will
> make the time for ksmbd backporting job. To facilitate backport, Can I
> submit clean-up patches for ksmbd of 5.15 kernel or only bug fixes are
> allowed?

If a fix relies on an upstream cleanup, that's fine to take.

But first, find out if anyone is actually using this before you take the
time here.

thanks,

greg k-h

