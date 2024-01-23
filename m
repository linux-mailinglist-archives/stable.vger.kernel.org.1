Return-Path: <stable+bounces-15565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B814F8396AA
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 18:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3DF1F22D3D
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 17:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A585B811F0;
	Tue, 23 Jan 2024 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1W8urktY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C512811EF;
	Tue, 23 Jan 2024 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031778; cv=none; b=uhxrTH2R7BJq43ZHwwO7fhCpcxZFoNP8BuMaNXgAT+8n3dmL6lJxArQW1lmUCtnRZ1U26BpR4+4R0YIFuimB5M5Ebbp3q41KDerWIIjqJl6Tt69YIK/lhxVBb1oDa1YpzGvrFVct05uySzdM34hDlY2o7vkIX8jZab1J2jUSp6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031778; c=relaxed/simple;
	bh=aDZgODdMnyAohXueDzmxuwQm07rj4V71e8iZM5U8ULo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ew8AHj/dvANVKqv+nVZONBsPXsq5VvLN5o6N17Cu+VEFQ0F7zrQp9eBaCB00vRY1VcNSCW/Jkt5fAm/qKitOaT7e7Rl5oFZ4MWuwmmXDi12i5UD13TAHbjn+EmW9n1j2B6fqjgWHCHhZ1WX4z/+iVP1KdkDSHMZP2QYNctN9F8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1W8urktY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EABC433F1;
	Tue, 23 Jan 2024 17:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706031777;
	bh=aDZgODdMnyAohXueDzmxuwQm07rj4V71e8iZM5U8ULo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1W8urktYRuYY5OBqqKGqdUpVRjX7XJ4LrQabJDDnTWwJM8j8FZtFcjepNy6xPW6n2
	 EAeDo/D7hhq+qWKobU9dINJUMMmPxbwUVgloFWcR+BFgkIfhgtGDIB6Y1SlO6PKZgW
	 aI1H6NLPY1J04DibscMkBETMPevbo1YOZsZBgrEw=
Date: Tue, 23 Jan 2024 09:42:56 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Moulding <dan@danm.net>
Cc: junxiao.bi@oracle.com, logang@deltatee.com, patches@lists.linux.dev,
	song@kernel.org, stable@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH 6.7 438/641] md: bypass block throttle for superblock
 update
Message-ID: <2024012320-coaster-ensnare-237c@gregkh>
References: <20240122235831.717823754@linuxfoundation.org>
 <20240123015634.7761-1-dan@danm.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123015634.7761-1-dan@danm.net>

On Mon, Jan 22, 2024 at 06:56:34PM -0700, Dan Moulding wrote:
> Please see https://lore.kernel.org/all/20240123013514.7366-1-dan@danm.net/
> 
> In particular:
> 
> > Coincidentally, I see it seems this second commit was picked up for
> > inclusion in 6.7.2 just today. I think that needs to NOT be
> > done. Instead the stable series should probably revert 0de40f76d567
> > until the regression is successfully dealt with on master. Probably no
> > further changes related to this patch series should be backported
> > until then.

So, as we are adding this now, it should be ok?

Or is the regression also in Linus's tree and both of these should be
reverted/dropped in order to keep systems ok until the bug is fixed in
Linus's tree?

confused,

greg k-h

