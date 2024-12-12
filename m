Return-Path: <stable+bounces-100856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1576B9EE175
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 09:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5CE165A58
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 08:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA6420B80A;
	Thu, 12 Dec 2024 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DkD5YEth"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA420ADFC
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733992686; cv=none; b=keIpMTDE319Y1MZbTq7EIkquAeLkTOhvjzFo6Ek/4lkgtYBc1BaGIMPTjzrCd7NJvz9bPj2VC7ckB6+JcRAnteG8fIV7Alf0GlXNrSIlsx+NKhinT8eTqvAtoz7VfjpxvAWDnFK6ZovMeHe9FL64SxkkGQE39gfHmvfGuCspSpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733992686; c=relaxed/simple;
	bh=Pc8lPokc8o8F+06n6dTCvZX364RbRMqitr7rw547I2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmFBDbHYxAMNHYB/qjrgTjr7NzhYO1yfybVP8inp7iobLSqilGvErfvzoPZbCDX6xIakcoxtNa1a5jF5pJrtH/SAS/O0esW9yXXK7jI9o+tmnLLMlJzsnbS00ujaP8zic3SaGXNtIXyeKiuA6SMMINMRRXXfvAW59pjDG8gd5O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DkD5YEth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78F3C4CECE;
	Thu, 12 Dec 2024 08:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733992685;
	bh=Pc8lPokc8o8F+06n6dTCvZX364RbRMqitr7rw547I2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DkD5YEth1K2/996ehYXdrCd0iS0mOEZH51SGgSZNblVNzGTbQOqZyXk1OE3LBWeKw
	 r424edD0j65T1SCcupJ/C9cEGSvdCqQ5jDj7LZqCJGAdj4kj/fN5E1cKt4wDrPGicp
	 RVQfDdGec5LNKIxngk+PZZ/sQGJISbFvqiZ/NjJc=
Date: Thu, 12 Dec 2024 09:38:02 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: Stable inclusion
Message-ID: <2024121256-theft-ninetieth-9d4e@gregkh>
References: <57b048be-31d4-4380-8296-56afc886299a@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57b048be-31d4-4380-8296-56afc886299a@kernel.dk>

On Tue, Dec 10, 2024 at 04:30:05PM -0700, Jens Axboe wrote:
> Hi,
> 
> Can you add the below to 6.1-stable? Thanks!
> 

Now queued up, thanks.

greg k-h

