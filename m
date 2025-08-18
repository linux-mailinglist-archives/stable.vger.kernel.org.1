Return-Path: <stable+bounces-171624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4766B2AD9A
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 18:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 434DB7AC7B2
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FBF33A038;
	Mon, 18 Aug 2025 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gwZXd/gX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210B33375C5
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532729; cv=none; b=dbj5VZQVGyoXPsrZ1ITPQlgwJHxWDOIjcmME7Ctg5RkK0v1JOGgr7KnSiY3feQmwsxVzCliEzBpzicE/KVQsCALbJYLIn1MuJst+mSKD1ZihIAE9TdQJVfsQCzLBP7M4DQAu1cUm73/U74zBGWmc50QWoo9CWAYBfuzld6dnR4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532729; c=relaxed/simple;
	bh=Eyk/8KcuB2Eqn02m/EzbFHs8Iv80eOgBTxEoyfSTwOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soYhMlRPXCvL75rUndr9Hx3nKR8bmKEh496RQD61oW1ziSf4CeHWXodZt3D65R+CBELy5sZgffiNmuTpocks1wb4+QmV43h//YKS2VgXvFINhzwUtNgJALAzyoIJdjUd16/eWkD4tnFHwezz9HppxgVjcRLQWV8jbBjjvPnmf9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gwZXd/gX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11343C4CEEB;
	Mon, 18 Aug 2025 15:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755532728;
	bh=Eyk/8KcuB2Eqn02m/EzbFHs8Iv80eOgBTxEoyfSTwOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gwZXd/gXbkSnjMMAV5HKt7j0oH3pyYfw7ec74oy20C1nGs6Rddm1MUmqMJGgN7m/G
	 AT7D8g9sf4U8RYyNJm+ExF9Mov6h02zqZ5uWAa4XGetQnSf9NXa2yd812j9iEYNIF5
	 jpxiBqmgZRy5u8hxAuDqIuuk/YkiFQColRIjO4OU=
Date: Mon, 18 Aug 2025 17:58:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: vbabka@suse.cz, harry.yoo@oracle.com, roman.gushchin@linux.dev,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm, slab: restore NUMA policy support for
 large kmalloc" failed to apply to 6.1-stable tree
Message-ID: <2025081809-taekwondo-blimp-2d91@gregkh>
References: <2025081818-skilled-timid-4660@gregkh>
 <f423079b-6994-a2aa-8bcf-248f39e739b7@gentwo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f423079b-6994-a2aa-8bcf-248f39e739b7@gentwo.org>

On Mon, Aug 18, 2025 at 08:07:30AM -0700, Christoph Lameter (Ampere) wrote:
> The breakage was introduced in 6.1 So maybe the fix is not needed?

If it is broken in 6.1, then yes, it needs to be fixed in 6.1.y :)

thanks,

greg k-h

