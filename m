Return-Path: <stable+bounces-50233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03368905227
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE781F248EB
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9F516F0FD;
	Wed, 12 Jun 2024 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QE6IVZdS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE97168C3A
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194280; cv=none; b=iBW6VbxgHvpf/CjPQQS0eG/77ddNAScei4lzQozN0Q7eElEGbTjIwzgUgU3nyfkf6U/cLJhL8wcOA+3A83PpRGQ1Jznl75xIVl6b9cfQ8k8/Q6uRwH7o+Zbn6eZtACwOX8mXEDCaHAuE17fKMq2X0lYDkUGOHaXF6PaBYsq4vRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194280; c=relaxed/simple;
	bh=APsZJHsrIeUlirEPGJeadLvAxbDEaVhksQTkCG0MN6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFGQhog5z+IV7MxBk0cloAwCSM5Ae3Jqr0AUXv0thYnQ10hOufTd8+TP4jR+cB2pKDLeqKOzA0rceuHss/a9W7zGmypj6asPmPKblKDUWz6X/kpCcy+wB+z6kQWWr5+38BRGzfVcgyMWub7o8SAU7H5aeZv4fcd3jC2DiHO1hic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QE6IVZdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8869DC3277B;
	Wed, 12 Jun 2024 12:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718194279;
	bh=APsZJHsrIeUlirEPGJeadLvAxbDEaVhksQTkCG0MN6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QE6IVZdSqdJ81TOt6DtULv7WnAB0tst0T+qUQEw0JCQx+jS2gAQnjHIeaZGzNcJNW
	 w6Cl/s9fKPNg5UUneMzPxf1vJVB1rwFBGdKRTMajc3uk+9iBvQemBWUbSg6kiT8f4f
	 S8Yoet/Cj9JQwLLlav1WwLqIyFcSvaKJOMxOQnGw=
Date: Wed, 12 Jun 2024 14:11:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: Are the 'FAILED' notifications always sent?
Message-ID: <2024061229-colony-implicate-c906@gregkh>
References: <bd8c16fd-d640-448b-a75c-09a565fa9c89@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd8c16fd-d640-448b-a75c-09a565fa9c89@kernel.org>

On Mon, May 27, 2024 at 12:55:47PM +0200, Matthieu Baerts wrote:
> Hi Sasha,
> 
> Thank you for the recent backports linked to MPTCP.
> 
> Recently, I noticed that two patches [1] [2] with the same "Fixes" tag
> -- but without "Cc: stable", sorry for that -- have been backported to
> different stable versions. That's good, thank you!
> 
> The first patch made its way to v5.15, while the second one went up to
> v6.8, but not to older stable versions. I understand it didn't go
> further because of other conflicts, and I'm ready to help to fix them.
> 
> I just wanted to know if it is normal I didn't get any 'FAILED'
> notifications like the ones Greg send [3]: I rely on them to know which
> patches have been treated by the Stable team, but had conflicts. Will I
> get these notifications later (no hurry), or should I not rely on them
> to track fixes that could not be backported?

FAILED only happens for patches that explicitly have a "Cc: stable@" tag
in a commit.  If you only have a "Fixes:" tag, that doesn't happen as we
read that as "best effort if the stable team wants to add it".

thanks,

greg k-h

