Return-Path: <stable+bounces-137007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B478AA049D
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 09:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659CC3BCC15
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 07:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029A8277805;
	Tue, 29 Apr 2025 07:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1xXHRTYN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37B926F47F
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 07:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745912064; cv=none; b=rarGWbN9OLkLr/1l5lQN6lUisDBHCrxuC64zK/sr7xcMqJnDMjOWRkr7D85PLs3qyMsVFCQrIS600F/MnPJfnSP/4kZKd/8SjtaxHoaOw6QowIkfhiz4a0gNZtdPWAeBv0pzRtU5Jx8+ndCgukx4ZKSwZxzX1TiLvnhUSMt3wgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745912064; c=relaxed/simple;
	bh=4i5tCPY4FYt03qxp6JjEZgBLX4nD/mTSE2gCzbSwRl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPBB1gn5RdpCuXyFkqMKIirAsxvyd5yoSTrSDuqY5Ck1cNMN7W8X+5NmgoZ5mH9v5Bwj31T/qAwO6xkpkAfjJ0jYBgDIFO155K5859QjEHno9uW27nBHPmAxRPZlm+iEKO2bMe9GK4ultNoKknf2FI917WP/CJS6NzkA0CEdxek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1xXHRTYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3369C4CEE3;
	Tue, 29 Apr 2025 07:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745912064;
	bh=4i5tCPY4FYt03qxp6JjEZgBLX4nD/mTSE2gCzbSwRl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1xXHRTYN9HtYcwfmRt5XZTsK/dlJ9aAd+8/9qyr8NP/ffdP04RBDRPib7edt8RrL4
	 bHqU5azeIBimeymwjRiBkljgWWuaExeUWlGanMYxgFDkG95cpIOw/b7Cx8rXd0dlXd
	 B03nCVyAH6b1D/LYbUxKsNuMZO8Vq5JEcTNhDMzM=
Date: Tue, 29 Apr 2025 09:34:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH 6.12.y 2/5] net: dsa: mv88e6xxx: fix atu_move_port_mask
 for 6341 family
Message-ID: <2025042936-quit-scoff-4ca7@gregkh>
References: <20250428075813.530-1-kabel@kernel.org>
 <20250428075813.530-2-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250428075813.530-2-kabel@kernel.org>

On Mon, Apr 28, 2025 at 09:58:10AM +0200, Marek Behún wrote:
> [ Upstream commit 4ae01ec007716986e1a20f1285eb013cbf188830 ]
> 
> The atu_move_port_mask for 6341 family (Topaz) is 0xf, not 0x1f. The
> PortVec field is 8 bits wide, not 11 as in 6390 family. Fix this.
> 
> Fixes: e606ca36bbf2 ("net: dsa: mv88e6xxx: rework ATU Remove")
> Signed-off-by: Marek Behún <kabel@kernel.org>

Sorry, but you seem to have lost all of the original signed-off-by and
other metadata on this commit (and all the other backports).

Can you resend them with that information added back please?  Then we'll
be glad to queue these up.

thanks,

greg k-h

