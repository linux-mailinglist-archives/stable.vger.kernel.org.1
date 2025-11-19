Return-Path: <stable+bounces-195190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E25FAC6FE68
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 17:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 3E7892FC2A
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 16:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B59935B13D;
	Wed, 19 Nov 2025 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHNRg/4V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC088342C8E;
	Wed, 19 Nov 2025 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567710; cv=none; b=c/eX5CiI1xd9rvhntu4nvB/XBT+gtq7rgj/gFDFG0h/gP+QeQAiBWRmK6Vrm6o7GFffyaBfFKyb0daGDwNu0jLqSUxUVqBwC1gcnCbhOxc+mRKqFdrI+euNqq8iSovo0TFVZmOjFoILo+2DBQ/X28rgNSMtE0vYS/i9SuA+o3dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567710; c=relaxed/simple;
	bh=gjDP2XYX+ovocOAAnCbnLjruEh9DhHdieIst67As1IU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mLKG8yO6qeZm21nzbsrL3iKporS8duDY1P5y2v+4EfCApYRvE8qOnpb5m8IooX9jJ/FyZSTCRBGri13VmyTlHj/x2eXCuYvhSS9gFLJRezZDSkOrYfQ6cYDNnoHe4quSH2YSpBsjCZK62TlPACar3fMzsNErXgK0QHHzXi1jQVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHNRg/4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C35C113D0;
	Wed, 19 Nov 2025 15:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763567709;
	bh=gjDP2XYX+ovocOAAnCbnLjruEh9DhHdieIst67As1IU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZHNRg/4V/VlqnzWuKRvqScmKkGA5uOlh8+un22hhoP2BOPO7yDBoSWzRXLxlUCSjN
	 da8rWk89W3/awMVc4m+xhFUOF1XxpM/jCc4vcpHNdv4FVpYx35Ht4KQPQYJpv81vto
	 G0MJwcyuMBFQbX4yrbE4XXw0vBIPCTozn5HrwbIsn0+R3aYugExuJjlavubeRKWSma
	 isEAg9nLiTFySCB5VfdL0bnb77o2vU7Mxkl6M0PGY58R+LTlpsT9olP1QVvEJXGwul
	 Ng5nR0UVCzKTcEzFKSgj4CCPf7W2eGI+qjyyj/hT/cln4EqIXXerX5xYsZPX9N22X9
	 GpNFfEyCnmyPw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Graf <graf@amazon.com>,  Mike
 Rapoport <rppt@kernel.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add test_kho to KHO's entry
In-Reply-To: <2025111944-tracing-unwieldy-1769@gregkh> (Greg KH's message of
	"Wed, 19 Nov 2025 02:36:09 -0500")
References: <20251118182416.70660-1-pratyush@kernel.org>
	<2025111944-tracing-unwieldy-1769@gregkh>
Date: Wed, 19 Nov 2025 16:55:06 +0100
Message-ID: <mafs0wm3m2f1h.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 19 2025, Greg KH wrote:

> On Tue, Nov 18, 2025 at 07:24:15PM +0100, Pratyush Yadav wrote:
>> Commit b753522bed0b7 ("kho: add test for kexec handover") introduced the
>> KHO test but missed adding it to KHO's MAINTAINERS entry. Add it so the
>> KHO maintainers can get patches for its test.
>> 
>> Cc: stable@vger.kernel.org
>
> Why is this a patch for stable trees?

If someone finds a problem with this test in a stable kernel, they will
know who to contact.

-- 
Regards,
Pratyush Yadav

