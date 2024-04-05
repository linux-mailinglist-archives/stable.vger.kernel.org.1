Return-Path: <stable+bounces-36045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B2B899949
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 11:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F51B283BD6
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 09:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E8115FD17;
	Fri,  5 Apr 2024 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p324Z9bA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A9C15F3FB
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308673; cv=none; b=T3wCZwykqGBnGtUtd+2y3Vs4lYSjZxpznj0SrPA/2hKjKDz3dNBdYuiPil9bPJvWBQBxU6hMdEZaaMsR0SHMP5HH9nMdGuyx2SMQSYEpw3KLAGWD/SURcmoAtHw3fD3PzcrU9ZEAPzk2QGtJGg7O5ss5IhUA63VzC0YBR274eY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308673; c=relaxed/simple;
	bh=JtTXA8uMv66ujO9KlaJBksyVPRh8sWz9VkgGElyHN4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/VqkiIOnJan9KC7FbXVsVmbBVrykUsC0CZAraFBAa2mjT43GeR1b2IJ6repwTq7Zeleh5M9Ng9PrOs+aPr+nX4I6TuxkFVx1fJHoIT1APeQFH5CT7qkjWzuPwmgOh6+7a90N5s9lAPjTJjR3boK8GbbVa7ttSk5V7CpnN5d7sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p324Z9bA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BB5C433C7;
	Fri,  5 Apr 2024 09:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712308673;
	bh=JtTXA8uMv66ujO9KlaJBksyVPRh8sWz9VkgGElyHN4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p324Z9bA2KfWrWIItZW5WtaCr+8MMf1kW+YW+t25RyUgTlTaQcAGvJC5tOD9UoWG1
	 QlRU9zJpO5OmhB0Md2GcOgifOj9IiNssig6zGYxuEeAAKrhraJmky4zj2oIX7Ird9y
	 je4Q3yjZcgDAQWXKQ5dVKdEgpWb/N7DNCfW9UzZI=
Date: Fri, 5 Apr 2024 11:17:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: 5.10/15 file registration fixup
Message-ID: <2024040539-research-outdated-fddf@gregkh>
References: <5e662379-5949-4c42-9fd9-43d79812b08a@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e662379-5949-4c42-9fd9-43d79812b08a@kernel.dk>

On Tue, Apr 02, 2024 at 08:51:29AM -0600, Jens Axboe wrote:
> Hi,
> 
> A previous stable backport neglected to handle that we now don't clear
> 'ret' since the SCM registration went away. I checked the other stable
> kernels and it's only affecting 5.10/5.15.
> 
> Can you apply this fixup patch for 5.10-stable and 5.15-stable? I
> provided one for each even though they are identical, but the fixup
> sha is obviously different for them.

Both now queued up, thanks!

greg k-h

