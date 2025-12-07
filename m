Return-Path: <stable+bounces-200281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE3CCAAFDA
	for <lists+stable@lfdr.de>; Sun, 07 Dec 2025 01:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3968F3050BA1
	for <lists+stable@lfdr.de>; Sun,  7 Dec 2025 00:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BE61E6DC5;
	Sun,  7 Dec 2025 00:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsWwljNE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A10B1D130E;
	Sun,  7 Dec 2025 00:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765067890; cv=none; b=hVpKXDSNwh9MDt25Nn6bxvCuzJubHZ7xovtKvLJNCS4he2QJjQ1Zpk9ssesY+j8C9ONosCozTcBoQlpUekLIpoVe+ahp7uXEK3gCjCHVdFo/60vcaDu2FPTgXgpubRMgVy5gQCJJTZYnBQGhZPnh48AQRQ1hUB02Nplck0tJXR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765067890; c=relaxed/simple;
	bh=4EJiNyGFqVH5oLncqbZ8VBOaG3Diod3tSHEX/MG0qkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j34UcCiuSRoUFVG0+Ue4vz8aYaRhgPdqrn4qLlDIZPcEJ861Bq+yLrZ3lRrp1gIyWTXYrO5WQSV6AsQQ9Iy7g3xhO0SEIstWiO4fNQhhRR4sFLvgf4K8jIcTVhZ7msLzcMWMWt4svfKeBceV2Py8nIlt3CilxKsFC8uRZZzHH2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsWwljNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCA0C4CEF5;
	Sun,  7 Dec 2025 00:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765067890;
	bh=4EJiNyGFqVH5oLncqbZ8VBOaG3Diod3tSHEX/MG0qkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UsWwljNE18Ld6ibmtEYy9JNbpyqbSZ7ywr/T3jdwmiKSl9vVNOAGhWxcYxqt52V5j
	 pqOQ274V7tdHSbOT5NEBjtc8ksgqYRpd4XOs2OO0cvoG42OHM3DN3hWy9GoS/0T04m
	 umAPXJjztrxx7nI4t2xajQx3rMtZ5lKX/SriVHO35m1K+zuEm5OdmZ3kC7zXVoCJE9
	 fYZ9//t6MwwVzhvWz4ACgbqf14pAufqtF+4e8cxIw4OeMOprebCYKHAt/riEBZ8Pub
	 JqGg7DPat4gi9c1asAvvezk/ApX4OsMra/GQiVqruZ0UHhZ/BrIQEQ2bxR/3sbr0QF
	 idivJ39S8wrvg==
Date: Sat, 6 Dec 2025 19:38:08 -0500
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	netdev@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: Please apply 5b1e38c0792cc7a44997328de37d393f81b2501a to 5.15
Message-ID: <aTTMcMFeq4Bt8wKk@laps>
References: <20251204002517.GC468348@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251204002517.GC468348@ax162>

On Wed, Dec 03, 2025 at 05:25:17PM -0700, Nathan Chancellor wrote:
>Hi stable folks,
>
>Please apply commit 5b1e38c0792c ("dpaa2-mac: bail if the dpmacs fwnode
>is not found") to 5.15, where it addresses an instance of
>-Wsometimes-uninitialized with clang-21 and newer, introduced by commit
>3264f599c1a8 ("net: dpaa2-mac: Add ACPI support for DPAA2 MAC driver")
>in 5.14.
>
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c:54:13: error: variable 'parent' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>     54 |         } else if (is_acpi_node(fwnode)) {
>        |                    ^~~~~~~~~~~~~~~~~~~~
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c:58:29: note: uninitialized use occurs here
>     58 |         fwnode_for_each_child_node(parent, child) {
>        |                                    ^~~~~~
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c:54:9: note: remove the 'if' if its condition is always true
>     54 |         } else if (is_acpi_node(fwnode)) {
>        |                ^~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c:43:39: note: initialize the variable 'parent' to silence this warning
>     43 |         struct fwnode_handle *fwnode, *parent, *child  = NULL;
>        |                                              ^
>        |                                               = NULL
>
>It applies and builds cleanly for me. If there are any issues, please
>let me know.

Queued up, thanks.

-- 
Thanks,
Sasha

