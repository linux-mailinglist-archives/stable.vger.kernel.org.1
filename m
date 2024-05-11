Return-Path: <stable+bounces-43564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 585588C31B1
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 15:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0521F21789
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 13:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FC850A68;
	Sat, 11 May 2024 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFPRzCun"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CFC28F3
	for <stable@vger.kernel.org>; Sat, 11 May 2024 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715435073; cv=none; b=RFPoUThabc1jIDWUWTXqpxDf00p2ajQSgxNgtbczw76uzCZ8wFfkuhgxyiF9NzPRlrku4c9SU2MLTTBcO8dIpnDlE0xL1g1tnMn3eIUGtRtAJp8T4l4LgY8h5P9ngsigzKtFMg5NPn/J95ybBmWYJj/KUwtpIA4an9KIb9AfnO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715435073; c=relaxed/simple;
	bh=ZtuAw+4x9NJkngtoGIy1HE+7VCjdcz63iY8b0cfy5lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScCrZAlCCmOSyP4G5MTC04jX5ovoHZmQOwHZs4szEGG08WFSY6sp9kfH1Ogsk92jxU2Nw84HHu5D4OHBLbcJrPxBQ9i316uujhmLYLEubRbjyUyVjCco+zGob0s+eIXGKy/IcYjhXUSx4xDpN52eYdc/o61VKrVeQk1GxUYHSBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFPRzCun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F184C2BBFC;
	Sat, 11 May 2024 13:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715435072;
	bh=ZtuAw+4x9NJkngtoGIy1HE+7VCjdcz63iY8b0cfy5lA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nFPRzCun+MJtU81hUz3uMXkgpV6Tswo3r8cQrOe41wAEQrNwUY/uIKm+83rGjvfI3
	 mj/XC4twc8pEbgn7fGgszhI7d3efJlS2UXfr3BXLNdfBFoDLW1OUs4h6C8N4FnEBwJ
	 W6wcnzU7gyp62qG9nZZ9OrfdIxXZU2yMhCRWLZwPlJJ1PTu4igMN5tGa4j7OmG8q4A
	 XSPBjpH3WFjFxsFVUly6sK1zGLr2mbZb5fJ1iSQ8GSEhCfqPaBoaKhspVTQZJYIxFv
	 3HoQy0xO0tWbwUYFrzXIersH2xYNH6nVOJLVGF25lPLxIXPedSKo1Z8IoP/hzrSpV4
	 Iz8PQa0kuVI6w==
Date: Sat, 11 May 2024 09:44:31 -0400
From: Sasha Levin <sashal@kernel.org>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.4.y 0/2] net: qede: return value conflict resolution
Message-ID: <Zj92P3ofles3V9yW@sashalap>
References: <20240506212423.1520562-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240506212423.1520562-1-ast@fiberby.net>

On Mon, May 06, 2024 at 09:24:21PM +0000, Asbjørn Sloth Tønnesen wrote:
>Thanks Sasha, for picking these fixes up. I have reviewed all the
>queues and everything looks good.
>
>Just for completeness sake, I have fixed the conflict in v5.4,
>so it can also get the flower patch.

Queued up, thanks!

-- 
Thanks,
Sasha

