Return-Path: <stable+bounces-6603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 640978114B3
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 15:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811E328280C
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 14:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9422E3FD;
	Wed, 13 Dec 2023 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lVwpk+9R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE4163C2
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 14:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA70C433C7;
	Wed, 13 Dec 2023 14:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702478076;
	bh=vHOm7JL/I9P+W4e+R3B8sE5/YtDRdgWrEVkHonMsDEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lVwpk+9R0dfVVT+Zv23YTpmZkQ5rwTkr72jRIApxtueSmfkOLJXuk32fJduqdgz+k
	 EKPSZ8Du6tm2gdNnUWgnZ1tGA+VEiK1T6MPT8Pbieo/PWTiVIAzFhnfJ8ljjpvtclC
	 muQNs9+gfZyo+yusvmi8ZxNlR/n0XTELK8XgoscM=
Date: Wed, 13 Dec 2023 15:34:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for CVE-2023-38431
Message-ID: <2023121344-scorebook-doily-5050@gregkh>
References: <20231212184745.2245187-1-paul.gortmaker@windriver.com>
 <2023121241-pope-fragility-edad@gregkh>
 <ZXjGg3SKPHFsTxkb@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXjGg3SKPHFsTxkb@windriver.com>

On Tue, Dec 12, 2023 at 03:45:55PM -0500, Paul Gortmaker wrote:
> [Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for CVE-2023-38431] On 12/12/2023 (Tue 21:04) Greg KH wrote:
> 
> > On Tue, Dec 12, 2023 at 01:47:44PM -0500, paul.gortmaker@windriver.com wrote:
> > > From: Paul Gortmaker <paul.gortmaker@windriver.com>
> > > 
> > > This is a bit long, but I've never touched this code and all I can do is
> > > compile test it.  So the below basically represents a capture of my
> > > thought process in fixing this for the v5.15.y-stable branch.
> > 
> > Nice work, but really, given that there are _SO_ many ksmb patches that
> > have NOT been backported to 5.15.y, I would strongly recommend that we
> > just mark the thing as depending on BROKEN there for now as your one
> 
> I'd be 100% fine with that.  Can't speak for anyone else though.
> 
> > backport here is not going to make a dent in the fixes that need to be
> > applied there to resolve the known issues that the codebase currently
> > has resolved in newer kernels.
> > 
> > Do you use this codebase on 5.15.y?  What drove you to want to backport
> 
> I don't use it, and I don't know of anyone who does.

Then why are you all backporting stuff for it?

If no one steps up, I'll just mark the thing as broken, it is _so_ far
behind in patches that it's just sad.

thanks,

greg k-h

