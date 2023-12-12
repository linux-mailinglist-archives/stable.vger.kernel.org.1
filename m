Return-Path: <stable+bounces-6503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D2980F76D
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 21:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B23DB20E0B
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 20:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6485276B;
	Tue, 12 Dec 2023 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZncvbNx8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3966358C
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 20:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DC2C433C7;
	Tue, 12 Dec 2023 20:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702411481;
	bh=W9wTDyIOJ5Q8acGZqrIiS3PovLd/eJYGI4ioYT2c55Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZncvbNx8TRPl14qPCZAQjWdhI7qJtM3M5uE/+GYO0VTzdPea8LMVgTHp8UxzKSW8l
	 0s3n4n5wmvpzTUbPQgz/gEUhDmdYFnbUzp8U1cmICO8By2spwx/ezUuo/h4f/v2vt2
	 co11cGe/0hEi6KGdQR8mW6XRv4PpJEh2ORk42IKI=
Date: Tue, 12 Dec 2023 21:04:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: paul.gortmaker@windriver.com
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for CVE-2023-38431
Message-ID: <2023121241-pope-fragility-edad@gregkh>
References: <20231212184745.2245187-1-paul.gortmaker@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212184745.2245187-1-paul.gortmaker@windriver.com>

On Tue, Dec 12, 2023 at 01:47:44PM -0500, paul.gortmaker@windriver.com wrote:
> From: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> This is a bit long, but I've never touched this code and all I can do is
> compile test it.  So the below basically represents a capture of my
> thought process in fixing this for the v5.15.y-stable branch.

Nice work, but really, given that there are _SO_ many ksmb patches that
have NOT been backported to 5.15.y, I would strongly recommend that we
just mark the thing as depending on BROKEN there for now as your one
backport here is not going to make a dent in the fixes that need to be
applied there to resolve the known issues that the codebase currently
has resolved in newer kernels.

Do you use this codebase on 5.15.y?  What drove you to want to backport
this, just the presence of a random CVE identifier?  If that's all it
takes to get companies to actually do backports, maybe I should go
allocate more of them :)

thanks,

greg k-h

