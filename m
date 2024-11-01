Return-Path: <stable+bounces-89545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0566A9B9B59
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 00:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AEC728126B
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 23:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3F11CFEB6;
	Fri,  1 Nov 2024 23:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6bqOt+p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7DD1C9EC0
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 23:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730505414; cv=none; b=HY+LjwN5yxWaDk/UFfFTp2BuWkxdVdM6fHZ1AjhWP1WHeRPrlkQvEDj979hMA1gGZ9LJmFnHc4BWS9tOfDiIvDtCmrkI3egTe3oRJ/G3DTf7QeABKDhSEgEabiYWHc1UYtmPgxy9pR0MBUeB0opULCQgAsyVZx1v90aVE0jeuyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730505414; c=relaxed/simple;
	bh=965Uqc03qJjmC1AwbA6zm6solCk89cn8fKpMrSPrgB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdY2SZYWCQgYZ4DJos1OGSO8OWUoeUJhNXR3xd40QOP9X7l6NRysqpLQ3tVOYr/oOz/tLm2JMMlDvLMTsAYEjFfaxe1bJmURHxK4jq+HsHtf7oVrLJshoPqvgPy1VxeoUZ6E0FdiIXXdQ24W3NgJY1qX7U2hjto+5Bmd9viK8aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6bqOt+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82B2C4CECE;
	Fri,  1 Nov 2024 23:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730505413;
	bh=965Uqc03qJjmC1AwbA6zm6solCk89cn8fKpMrSPrgB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6bqOt+pQKiVP4EqftFCyKwSa2+Bvjf6HTuFOr6xcmsuMttUzGgYtfOP1tGGPpLXV
	 hEkU1RalMMXnmEXiW3Ucob+qLQl+ffp4OQRrgpuYKDaYmh10U9QAw0CAgprMPWGlX0
	 ggEEpcC4spkRzfE5oDVgNfFF59ad9Fa1TWS/lOguD0mthaKxU24Ump8F7VBR69x6F1
	 xGBxYVWZn/fyD4Q0nM7XV8nJcn1KSHLYou3fIY3R3Sa2zjVXsfCqJ46Rb4V119grEv
	 nzDT2XiY1T+uRu0LdwLO0eM7sFmKrqGY0Q/HjCTXtWwf/aP2v22J5uwYO1AsIBml4R
	 ePI8EeXTSqyjg==
Received: by pali.im (Postfix)
	id D5A9671F; Sat,  2 Nov 2024 00:56:45 +0100 (CET)
Date: Sat, 2 Nov 2024 00:56:45 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Steve French <stfrench@microsoft.com>,
	Paulo Alcantara <pc@manguebit.com>, stable@vger.kernel.org
Subject: Re: Backport smb client char/block fixes
Message-ID: <20241101235645.yqwqqipzhzoyprch@pali>
References: <20241028094339.zrywdlzguj6udyg7@pali>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241028094339.zrywdlzguj6udyg7@pali>
User-Agent: NeoMutt/20180716

Hello Greg and Sasha, do you have any opinion about this?

On Monday 28 October 2024 10:43:39 Pali Rohár wrote:
> Hello,
> 
> I would like to propose backporting these two commits into stable:
> * 663f295e3559 ("smb: client: fix parsing of device numbers")
> * a9de67336a4a ("smb: client: set correct device number on nfs reparse points")
> 
> Linux SMB client without these two recent fixes swaps device major and
> minor numbers, which makes basically char/block device nodes unusable.
> 
> Commit 663f295e3559 ("smb: client: fix parsing of device numbers")
> should have had following Fixes line:
> Fixes: 45e724022e27 ("smb: client: set correct file type from NFS reparse points")
> 
> And commit a9de67336a4a ("smb: client: set correct device number on nfs
> reparse points") should have contained line:
> Fixes: 102466f303ff ("smb: client: allow creating special files via reparse points")
> 
> Pali

