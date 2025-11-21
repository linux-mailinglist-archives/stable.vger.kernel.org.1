Return-Path: <stable+bounces-195486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F93CC78477
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 11:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 65D772D1E9
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 10:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7512341677;
	Fri, 21 Nov 2025 09:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dli2UErX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96567339B47
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 09:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763718941; cv=none; b=QEWpwvn3em3qs9ytbDWDPTUaBJ5mGvMiHPn/ee8u31KizXhJpdvEYH6aNXkqi1P6zrNc9N+4BCcaIL8j+GnPPjjYy1t8koEmn96Gl7Wwz8jUxXzbHjWK72qUvOfLmSxXIhIDLrM2FzQKlSP3rkUOWRhmnl+/zG8EPK+KuUp0V2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763718941; c=relaxed/simple;
	bh=cjlWdPb4XQFe4LnG0fVPNFmwLbkFdp/EUOgmbEldvs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHI9g+aofK36Cksr7GrnMqotU8t4IGaG8XdZUaMtPX7bTKY5HZLMg3U0sfaFNQyRpgbKAL3SCl2y/w0p8f7gXODTCDO5FTpHxo2V4WRHgZHocgxAu59gzEnh+Ejwx5Zu1KOrl3JIId/iDJ5oRax3orW12ndxOv/n3qzig+57ckQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dli2UErX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14006C4CEF1;
	Fri, 21 Nov 2025 09:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763718941;
	bh=cjlWdPb4XQFe4LnG0fVPNFmwLbkFdp/EUOgmbEldvs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dli2UErX3lkuaF8rwTraoPOgxMa75bL1RbZr0o4Kv/n/pvhZC+DgxM8/L4FdcH3Wi
	 07JCfiuCZeyyyejC/1y11MNCkBcuKawN3KLfACkgmvkAQSDSnsggykB08WzXQ4hZfW
	 EgeBjMHf65sUbOScXPz/5KzhNoFdkTyRo/gOefgQ=
Date: Fri, 21 Nov 2025 10:55:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y 0/5] LBR virtualization fixes
Message-ID: <2025112118-everyone-perish-5a7a@gregkh>
References: <2025112046-confider-smelting-6296@gregkh>
 <20251120233936.2407119-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120233936.2407119-1-yosry.ahmed@linux.dev>

On Thu, Nov 20, 2025 at 11:39:31PM +0000, Yosry Ahmed wrote:
> This is a backport of LBR virtualization fixes that recently landed in
> Linus's tree to 6.12.y.
> 
> Patch 1 is not a backport, it's introducing a helper that exists in
> Linus's tree to make the following backports more straightforward to
> apply.

Why not include the actual commit that adds that helper?

> Patch 2 should already be in queue-6.12, but it's included here as the
> remaining patches depend on it.

So this series will not apply?

confused,

greg k-h

