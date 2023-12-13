Return-Path: <stable+bounces-6604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A84998114C3
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 15:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A4A2827D3
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 14:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD6F2EAEE;
	Wed, 13 Dec 2023 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nx0ehPYU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4622E638
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 14:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7B9C433C7;
	Wed, 13 Dec 2023 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702478166;
	bh=Pne6i52ABwz6f3pvs7y3vtxMRHApVnrV9ATt6xs4ZCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nx0ehPYU39r3T7PUrS5YUxMkZNgMINbBP2IfBDo4jSnBJcP5frP3nMU3OYlzI0GUm
	 mmzsKlmHb5FVCb92zS5BAsZt3SvCNgtU3BQm8DLgYEEXF3VVRj8nnYbv7dyQDYFiyr
	 244oyz2auBMw0umF+ddIdSke6Ni9zD7J2EBXfv44=
Date: Wed, 13 Dec 2023 15:36:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Steven French <Steven.French@microsoft.com>
Cc: "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for
 CVE-2023-38431
Message-ID: <2023121350-spearmint-manned-b7b1@gregkh>
References: <20231212184745.2245187-1-paul.gortmaker@windriver.com>
 <2023121241-pope-fragility-edad@gregkh>
 <DM4PR21MB34417B034A9637445C598675E48EA@DM4PR21MB3441.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR21MB34417B034A9637445C598675E48EA@DM4PR21MB3441.namprd21.prod.outlook.com>

On Tue, Dec 12, 2023 at 08:13:37PM +0000, Steven French wrote:
> Out of curiosity, has there been an alternative approach for some
> backports, where someone backports most fixes and features (and safe
> cleanup) but does not backport any of the changesets which have
> dependencies outside the module (e.g. VFS changes, netfs or mm changes
> etc.)  to reduce patch dependency risk (ie 70-80% backport instead of
> the typical 10-20% that are picked up by stable)?
> 
> For example, we (on the client) ran into issues with 5.15 kernel (for
> the client) missing so many important fixes and features (and
> sometimes hard to distinguish when a new feature is also a 'fix') that
> I did a "full backport" for cifs.ko again a few months ago for 5.15
> (leaving out about 10% of the patches, those with dependencies or that
> would be risky).

We did take a "big backport/sync" for io_uring in 5.15.y a while ago, so
there is precident for this.

But really, is anyone even using this feature in 5.15.y anyway?  I don't
know of any major distro using 5.15.y any more, and Android systems
based on 5.15.y don't use this specific filesystem, so what is left?
Can we just mark it broken and be done with it?

thanks,

greg k-h

