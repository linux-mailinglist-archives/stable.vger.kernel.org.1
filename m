Return-Path: <stable+bounces-172887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B76C7B34BA0
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 22:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89130241F5F
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 20:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EA828153A;
	Mon, 25 Aug 2025 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LzkEq1IE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D882367B3
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153238; cv=none; b=hSQ8deGiN1BYWa8uc5DTwgYUqnekXwnmw4D8+y9ly7sgYkrHev+UNHFMotBt1L3q9cEC5PKkMRqnHqtNp9N/kVLNAosRFsNmFieJTktZQE0uIh7eIP3IMLQu0wGYftkXKNv9m7O1zvirWXUuwiR2X8ZoJ775ILxlKjJ+Aa8tJtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153238; c=relaxed/simple;
	bh=1hcpivHsHJK3axl3lAIJMX30sqA6xf0L2OTDBXE7svI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5p+UEBoNchoyDbD7K5oJ2b2GVXNl7PBWsJavGFygy5R7IR4JdDdhqiZIjzoU2Gq9y0AAYSFjcesCMpIxxQi7i3tEuUeXUNzaJBE2xUX+zJnk7nPNQNGpMifrLQDzvAjMsOReOApHGMH+1LJJ5zAds2o5Bh8WG6nbDp5S6sxnIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LzkEq1IE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A17C4CEED;
	Mon, 25 Aug 2025 20:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756153237;
	bh=1hcpivHsHJK3axl3lAIJMX30sqA6xf0L2OTDBXE7svI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LzkEq1IE4FBYaZMRhWUQ3opocGwGUGD5lxOhQ4upEudmILtl5CXR9szJWkF2gucQf
	 QZL8lLT0ivVaqD46SKtE5v0Tmp6N1Inzvdlt2ERVcv3Bbp0BSC8ASLka87TpOMngl5
	 rvIodr60eogQzERFPzS2deNZfjTpkS1Lx9Xzzp/w=
Date: Mon, 25 Aug 2025 22:20:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Subramaniam, Sujana" <sujana.subramaniam@sap.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"akendo@akendo.eu" <akendo@akendo.eu>
Subject: Re: Backport of Patch CVE-2025-21751 to kernel 6.12.43
Message-ID: <2025082546-blaming-platter-fec5@gregkh>
References: <GVXPR02MB8399DEBA4EA261A5F173FE268B3EA@GVXPR02MB8399.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GVXPR02MB8399DEBA4EA261A5F173FE268B3EA@GVXPR02MB8399.eurprd02.prod.outlook.com>

On Mon, Aug 25, 2025 at 01:12:27PM +0000, Subramaniam, Sujana wrote:
> Dear Kernel Developers,
> 
> Hereby we attach patch backported from kernel 6.13 (as proposed by Greg k-h on the full disclosure mailing list) to 6.12 for CVE-2025-21751 vulnerability.
> 
> This patch was tested on metal and virtual machines and rolled out in production.
> 
> I hope patch is sufficient for cherry-pick. Please let us know if something has to be updated/modified.

What is the git id of this in Linus's tree?  And why not use your
correct name in the signed-off-by area and provide the full changelog?

thanks,

greg k-h

