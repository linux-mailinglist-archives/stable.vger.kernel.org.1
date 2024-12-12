Return-Path: <stable+bounces-100855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F419C9EE170
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 09:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC31165A4E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 08:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0F120B21D;
	Thu, 12 Dec 2024 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LNhwZGMG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51E259496
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733992649; cv=none; b=nFEtFOf59nqYS1GGqpXoygJHV+tCBADBBh3pSjjxbRRPAlsIXqFMpVuVq6pScXLP+WxQxJDgMYp5IdKd8G8Snnb/XK7xoJQvCT/OPcA1vrl7dKnPF8p0V09f8ireFAvMjhDEBzNDfWlV3mQkhpvaEvsWX54jLP2k5+42+fGfnKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733992649; c=relaxed/simple;
	bh=++pp15EJ+yIgUPJs/JFmpZFsZ33cBz6PSdmWIz94MkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XU6wkDWu/PSyVkD7tEyYFUU3If0idGXSJDrYDaddrZgqDCbOPjuw+7xftFw09s/HYaAk8BbvqrbtQFSIK3UJ3Ip4K+cpOsXZLOfeRq9zv+43Bp5bTxQhqBNGwKUCgvIDoN7ZMyaPYkRaiUdW0GsLqpvPOjWKAkCL853AzAIZbfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LNhwZGMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF224C4CECE;
	Thu, 12 Dec 2024 08:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733992649;
	bh=++pp15EJ+yIgUPJs/JFmpZFsZ33cBz6PSdmWIz94MkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LNhwZGMG+LKpy9DJmr8sJVZv3S6n1WjBPENpAwUV3NKhGGQtY8coJW565Ctwe9A6p
	 /KY5CHCkzii2wm9KxYQBpIWuz3gjIUNE2e0dKlaVO8FBaigTmTi2wrtkUKrzu6PVlf
	 DzntF7+EjT8JWX/OdItHGVXHuEnp/jcOAcedVWRs=
Date: Thu, 12 Dec 2024 09:37:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Gohil <hgohil@mvista.com>
Cc: stable@vger.kernel.org
Subject: Re: request to backport this patch to v6.6 stable tree
Message-ID: <2024121203-blinking-unblock-b85a@gregkh>
References: <CAH+zgeEVr3g23gtcbHtQnUpC5R2uDZ3T56wzx3g9cNnvOZ-+HA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH+zgeEVr3g23gtcbHtQnUpC5R2uDZ3T56wzx3g9cNnvOZ-+HA@mail.gmail.com>

On Wed, Dec 11, 2024 at 11:16:32AM +0530, Hardik Gohil wrote:
> ethtool: fail closed if we can't get max channel used in indirection tables
> 
> [ Upstream commit 2899d58462ba868287d6ff3acad3675e7adf934f ]
> 

It does not apply cleanly at all, so obviously you didn't even test that
this worked :(

{sigh}

