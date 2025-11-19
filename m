Return-Path: <stable+bounces-195192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 072D1C6FFA3
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 17:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5CC3A34A5A9
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 16:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ED12EB847;
	Wed, 19 Nov 2025 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f5tBSw7z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96C236E563;
	Wed, 19 Nov 2025 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568173; cv=none; b=FgdYpVd/TbZCVmrmI7eQ8r0vghkpA85cirVvmafRZrhvaSMJ1rauWDcH9NGDY9w5RaSo7bHua8w2gwA0qQY/pwoAKRuK60JcdPsZ2NnEaMjMXAa7EafRcrCcdoAblODhYN9nJU4LUMlEXQfDNCGZwDflDATSC6LlIGi7BoNFNPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568173; c=relaxed/simple;
	bh=FFzMom7BsypiO6WAJXDo5CLw9r6cCiHmGONxZukFeVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiqcT3uTJjgcEkcnpx3FhteSBgKqxbM4BDnT43IJ1Go6t8EnnneBgFqmE41Tv5HlrNCQw08+YS226xZHp+5nef5frhAJKx7ISnCbwglLPamGhbUvlzd2djXwj7cBymGZ7UqVmkW9O+C6M1iB+Wpu4SQOXoMClW5obZDanDgIrRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f5tBSw7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CB8C116B1;
	Wed, 19 Nov 2025 16:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763568172;
	bh=FFzMom7BsypiO6WAJXDo5CLw9r6cCiHmGONxZukFeVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5tBSw7zSc8oLVvRFqNW6gJ49iCAgkMwgQSn9wBOIQm8ouy5frc7i8HoGMS2NW9mJ
	 eJ7Ui70VVxCypKXXXDnUsbIaa0RAGBBCo65wD50kopyTmEL5NrBhMV+da7pWwIwZIw
	 Jb1Z4RXCInwdmtw4sUYT01n8lP7aecoY/jcBashc=
Date: Wed, 19 Nov 2025 17:02:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add test_kho to KHO's entry
Message-ID: <2025111944-bullpen-slinging-dcdc@gregkh>
References: <20251118182416.70660-1-pratyush@kernel.org>
 <2025111944-tracing-unwieldy-1769@gregkh>
 <mafs0wm3m2f1h.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0wm3m2f1h.fsf@kernel.org>

On Wed, Nov 19, 2025 at 04:55:06PM +0100, Pratyush Yadav wrote:
> On Wed, Nov 19 2025, Greg KH wrote:
> 
> > On Tue, Nov 18, 2025 at 07:24:15PM +0100, Pratyush Yadav wrote:
> >> Commit b753522bed0b7 ("kho: add test for kexec handover") introduced the
> >> KHO test but missed adding it to KHO's MAINTAINERS entry. Add it so the
> >> KHO maintainers can get patches for its test.
> >> 
> >> Cc: stable@vger.kernel.org
> >
> > Why is this a patch for stable trees?
> 
> If someone finds a problem with this test in a stable kernel, they will
> know who to contact.

Contacting developers/maintainers should always be done on the latest
kernel release, not on older stable kernels as fixes need to ALWAYS be
done on Linus's tree first.

Please don't force us to attempt to keep MAINTAINERS changes in sync in
stable kernel trees, that way lies madness and even more patches that
you would be forcing me to handle :)

thanks,

greg k-h

