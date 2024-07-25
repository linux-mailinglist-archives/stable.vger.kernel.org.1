Return-Path: <stable+bounces-61766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836A893C6D8
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 17:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59031C21E51
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 15:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7481E19D895;
	Thu, 25 Jul 2024 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Aw1yVEd/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A4418028
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922909; cv=none; b=pyr6vinvI7pkmrGw7DNxpNhJ7mxYYZhjD9DRsIE2aeJoOscPNQa0SLDCndvr2sxGDK8u8KTffb/M3H5hwjuh/Bnt/zzIkkV/dofgsPRM+OGQxlIlURQXVI88a47loCTc4IFRne4EZ4vqga7le+dzMD7mv3JOcqavmwGXtHRsysE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922909; c=relaxed/simple;
	bh=LsPqL4zy5kIMEfBnKmaPvJEYRR+Qa9FcTb6inJQF+/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVGGM+2QovVmTvfR0RRnfKWxCE+a6ocAngCdgj9/OElGqWJHajBzG384Mm04Ln75OXWlaKHYiPHoT0lIWBoFKUvs/mXaLWnyEh/kVw91iukQfoqwPJXlxx1kjboZr53JW3Z4hJTBHTBWb24E0Of2aSADZtEgeWVw5MVXVcdMN9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Aw1yVEd/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFD4C116B1;
	Thu, 25 Jul 2024 15:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721922908;
	bh=LsPqL4zy5kIMEfBnKmaPvJEYRR+Qa9FcTb6inJQF+/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aw1yVEd/GccN/vJ8oxuJCuYC2U/QjlmZATy0jmgOY24L+tEgDVGDTSjSuA82hmi38
	 94KTxHT7mC8/DE+3IUcQr93AI/L9jiPOQBwZPp1UdVoq2ZZtrx+86x+hSs9Tpj+hvc
	 OAzOPh/bKMc4eBzv+YBq5zdb9oKKO1+z/WWXGVAQ=
Date: Thu, 25 Jul 2024 17:55:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>
Cc: stable@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
	Jan Kara <jack@suse.cz>,
	syzbot+600a32676df180ebc4af@syzkaller.appspotmail.com
Subject: Re: [PATCH 6.1.y] udf: Convert udf_mkdir() to new directory
 iteration code
Message-ID: <2024072549-difficult-predator-b7cb@gregkh>
References: <20240725135313.155137-1-sergio.collado@gmail.com>
 <2024072521-ducky-record-3b13@gregkh>
 <CAA76j93yfR7Z=g+uEk4OV6N3FqXS5XUXUw9DOKLbJ-yBP1MHVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA76j93yfR7Z=g+uEk4OV6N3FqXS5XUXUw9DOKLbJ-yBP1MHVw@mail.gmail.com>

On Thu, Jul 25, 2024 at 05:45:38PM +0200, Sergio González Collado wrote:
> Hello,
> 
>  Thanks for your feedback. Honestly it was a clean cherry-pick. I'm
> not aware I have changed anything ... but I can be mistaken.
>  I checked with the original commit, and the changes seem the same to
> me, although the changes are not in the same line numbers.
>  Is that change in the line numbers what you mean?

Do a clean cherry-pick and try to build the result, your patch was
different...

thanks,

greg k-h

