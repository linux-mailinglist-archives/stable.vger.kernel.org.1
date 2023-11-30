Return-Path: <stable+bounces-3222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4B57FF072
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD571C20B53
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 13:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FF947A46;
	Thu, 30 Nov 2023 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rb87HZUV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9F138FB1
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 13:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EBEC433C8;
	Thu, 30 Nov 2023 13:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701351804;
	bh=JiawPHGAWJawNoP5fcTeTHojAW17GMqb1EO2vrHmZ+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rb87HZUVQk49CBox6fGcVRvkABa/pRkk5/LmZO5jDMqq0USG0kymp1RMjKbfv15Hb
	 HZbgG0sDoS0lgDDf24KHVSvSfMwbmLlG47ujUe5Q3Da8k+Q7hfMXt7zO39XdBw6Lor
	 h3P4/YYhSBld6iYJhB2OFJ9AFbvrHUi7S4yegbA8=
Date: Thu, 30 Nov 2023 13:43:21 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: stable@vger.kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH 5.15.y] proc: sysctl: prevent aliased sysctls from
 getting passed to init
Message-ID: <2023113014-confined-stillness-37e0@gregkh>
References: <2023112228-racoon-mossy-ce5e@gregkh>
 <20231130030534.GA2067@templeofstupid.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130030534.GA2067@templeofstupid.com>

On Wed, Nov 29, 2023 at 07:05:34PM -0800, Krister Johansen wrote:
> commit 8001f49394e353f035306a45bcf504f06fca6355 upstream.
> 
> The code that checks for unknown boot options is unaware of the sysctl
> alias facility, which maps bootparams to sysctl values.  If a user sets
> an old value that has a valid alias, a message about an invalid
> parameter will be printed during boot, and the parameter will get passed
> to init.  Fix by checking for the existence of aliased parameters in the
> unknown boot parameter code.  If an alias exists, don't return an error
> or pass the value to init.
> 
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> Cc: stable@vger.kernel.org
> Fixes: 0a477e1ae21b ("kernel/sysctl: support handling command line aliases")
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> ---
>  fs/proc/proc_sysctl.c  | 7 +++++++
>  include/linux/sysctl.h | 6 ++++++
>  init/main.c            | 4 ++++
>  3 files changed, 17 insertions(+)

Now queued up, thanks.

greg k-h

