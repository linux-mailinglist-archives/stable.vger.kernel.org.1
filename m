Return-Path: <stable+bounces-176710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11680B3BD12
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 16:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F31F5842CE
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 14:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CD9320380;
	Fri, 29 Aug 2025 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DQGnCx++"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9544F31E10F
	for <stable@vger.kernel.org>; Fri, 29 Aug 2025 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756476163; cv=none; b=G0JRuFFGfrvIKnhLzGG+XenJDFL+scEaCs0ptB3zkYDB2Ij0NFR+aDpBz3iuVrTe6cAI6jPXTvWTXp1pAKGDStzPkuWDlhyCccc7ywDOm6i5T3lmtaNGZrs0eBJaEwqcbLXoeZRTjvPC1sYxpc04R5X0ldNTc9Of28+8NQNv3k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756476163; c=relaxed/simple;
	bh=fWunr7yc2y1RIhgqmDMBK5/Wq/KzzTAEYdrx8u1ef5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5ngy1cBqR/NwwXc25zf7pGx0+jFQt+4MdCSd8bWfru894UZzxrtDDzxbsEm2uBUBAhPcvF3116knGaA3ZBa7+E7hVm80p3AJszrJ7x2SYMYeyTz1ywkyguE42mv7APywOsYkq9mx/HDfkkyY1mZ6Rhhs7FrYTxy+6Oho7QY9pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DQGnCx++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C9DC4CEF6;
	Fri, 29 Aug 2025 14:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756476163;
	bh=fWunr7yc2y1RIhgqmDMBK5/Wq/KzzTAEYdrx8u1ef5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQGnCx+++Nxj8DhLpUf2jBKgRxEPy559Jcgtn5Z6asT4KRsqNAt2isyftmE2qGZ2z
	 hT2pS+a+lKRB2LdUXKADsK/5Nk/1/HyeaoB81Ic6J4MwS0GaT+o+lnk603bu1Qxbcj
	 xSEDURJwcRkQPYKHt5iT68au4HbmMtP9sGMXYaXc=
Date: Fri, 29 Aug 2025 16:02:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
Subject: Re: ACPI: EC: Add device to acpi_ec_no_wakeup[] qurik list
Message-ID: <2025082932-finally-cataract-6bc1@gregkh>
References: <29a71bc0-a615-4bbd-be7a-a343a304e68e@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29a71bc0-a615-4bbd-be7a-a343a304e68e@tuxedocomputers.com>

On Mon, Aug 25, 2025 at 05:47:31PM +0200, Werner Sembach wrote:
> Commit ID: 9cd51eefae3c871440b93c03716c5398f41bdf78
> 
> Why it should be applied: This is a small addition to a quirk list for which
> I forgot to set cc: stable when originally submitted it. Bringing it onto
> stable will result in several downstream distributions automatically
> adopting the patch, helping the affected device.
> 
> What kernel versions I wish it to be applied to: It should apply cleanly to
> 6.1.y and newer longterm releases.
> 
> I hope I correctly followed
> https://docs.kernel.org/process/stable-kernel-rules.html#option-2 to bring
> this into stable.

Now queued up, thanks!

greg k-h

