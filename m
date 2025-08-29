Return-Path: <stable+bounces-176714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F6DB3BDCD
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 16:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6F31CC3740
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 14:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AD3320CB7;
	Fri, 29 Aug 2025 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQP95uGp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2922B320CA3;
	Fri, 29 Aug 2025 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477799; cv=none; b=QK7vB/8H4wXKSvbW9COolW6gbPBXVSUUCtp3/nCordQQ2pAFqwgUm1lCwJw1lgaT9/OJnfnywivvPLPuCLp4F1EMIjMGpKDRfnMc9ZRQ0s27NIMN6W5S7PlsWCPUxI2ok/z0XjtyMjXwAInTwDwsZ1pA5b0Xn6J7G+pH1xv+JkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477799; c=relaxed/simple;
	bh=Yns9bavo72CG4gNmrewLrs/gA3MVFABLZslxaAFREJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oymVvaeUb926X0iGhDttH+AmHe4Uc1kKlx7rtS1s79TI6cszzw8Hn4S32QP0teIJgJzavBbm7wMiwcajfLZQC9c5fQQQtnYFp/FuynX6HvMpqKxVUJ5YZ6So5vqOgfD027XSTN7ZWdDHLRWUpjLZavI4Ieg6oIjIenOkH21Qlqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQP95uGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7CFC4CEF0;
	Fri, 29 Aug 2025 14:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756477798;
	bh=Yns9bavo72CG4gNmrewLrs/gA3MVFABLZslxaAFREJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQP95uGpYWjOh0/WvGngenn519PhBUV2JOOu7M/vPRfYt/jFyLuONC3cJk2dxWtXi
	 ZcM2TerOGx3V6Az0+uTaZ3ezgTQIJVBq5WWNvKL9ukiu8Hgj4oPOXpiWdx8HjnhP6U
	 huDGcJKaGEMRpoXBEQhlt6QOxgZ2VGexAhMmOm+X8/4PlRqmpJio0IatvIT9jmjlbT
	 oS/v3gVau/6/z6IvdaRM21bnQQkIoxhDJMUb9TvBchmpG56npOcTrwERoB7ejm21th
	 3GIRUoSC+wrnAozzV3/DpKtjBGymoH7zoiIf5sYSEQBnc450c5FxpYKZonEKfa+7JV
	 me13JUApqexUg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1us06u-0000000008d-0bA7;
	Fri, 29 Aug 2025 16:29:48 +0200
Date: Fri, 29 Aug 2025 16:29:48 +0200
From: Johan Hovold <johan@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jan Palus <jpalus@fastmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: quirk: fix write to string constant
Message-ID: <aLG5XFHXKgcBida8@hovoldconsulting.com>
References: <20250829132152.28218-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829132152.28218-1-johan@kernel.org>

On Fri, Aug 29, 2025 at 03:21:52PM +0200, Johan Hovold wrote:
> The quirk version range is typically a string constant and must not be
> modified (e.g. as it may be stored in read-only memory):
> 
> 	Unable to handle kernel write to read-only memory at virtual
> 	address ffffc036d998a947
> 
> Fix the range parsing so that it operates on a copy of the version range
> string, and mark all the quirk strings as const to reduce the risk of
> introducing similar future issues.

With Jan's permission, let's add:

Reported-by: Jan Palus <jpalus@fastmail.com>

> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220437
> Fixes: 487c407d57d6 ("firmware: arm_scmi: Add common framework to handle firmware quirks")
> Cc: stable@vger.kernel.org	# 6.16
> Cc: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Johan

