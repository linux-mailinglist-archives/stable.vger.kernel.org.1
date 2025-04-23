Return-Path: <stable+bounces-136454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EF1A9959F
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 18:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45883AAD1D
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22B52820A8;
	Wed, 23 Apr 2025 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umI5REEk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD674281344;
	Wed, 23 Apr 2025 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426432; cv=none; b=LSvzqwfjNvog9278P3Hw3esdxPXS3XLLf6eeAk0iOgvOWdsFr3lQhO0dpuHqfM1UiR0OXPCyYZTPH8z97+mBj3bNJzXlRi9mTUwb8OuTYdpw5Rh4fXlLkztpfpUOFmPQzxW3GKpsUCeQW9zUgnq5mpsGEMTcroJmtwuYcD8oLz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426432; c=relaxed/simple;
	bh=7UVUjAgSUElFHDzSG9AMzlSoSvjL4lpAwsOGeFsGRT0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxoTnm+msW8lZJaZijISjt0JBhmpAOeY3thrlS6gdq9q7pMekDTv3Afz0mXAWwgFSya3mZ9GUbKwVeeTb2XH2g9qwZBjgoyyRUlFT018oKOwCcubEXlAT/jChYPvZbGJ4Da/9gfVXbnNrWupDsOL8EIkOCM+j1AdfWOuUB1JFH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umI5REEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED671C4CEE2;
	Wed, 23 Apr 2025 16:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745426432;
	bh=7UVUjAgSUElFHDzSG9AMzlSoSvjL4lpAwsOGeFsGRT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=umI5REEkuU9aJ4XeTgJYJlzW49lkWibbmQrwvZUUy2RrXiAuxwbSRGUQxf1ktGeYr
	 UwJndjv9qqplSjkKaRy13syUCUl2KD+s9tOkz4ACyqu809RN+7TUMWsE7S0otzS5O/
	 TbhG/7kEWmPZ/jNN68dhybeJRvzSW5KswVv4uEW1RuKbxJqeIoHSrqnPG8qyj0w6Mw
	 ch3WUC53aepeFutddbsP8SUyKzBjiYtm69tzMDoRukT0iYeUgxbnNP/yRi/zrnxt67
	 sDM8DYCyzg54eBzfq0SDggCDsy860QMcydXG2IuO7L+kRKUEE+Gwku0uLKpDsCWnQG
	 gi/bsxw0dhNqQ==
Date: Wed, 23 Apr 2025 09:40:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, Donald Hunter <donald.hunter@gmail.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14 065/241] tools: ynl-gen: individually free previous
 values on double set
Message-ID: <20250423094031.16664cdd@kernel.org>
In-Reply-To: <d478c0b9-2846-496d-b345-429d98f93d38@leemhuis.info>
References: <20250423142620.525425242@linuxfoundation.org>
	<20250423142623.257470479@linuxfoundation.org>
	<d478c0b9-2846-496d-b345-429d98f93d38@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 18:27:46 +0200 Thorsten Leemhuis wrote:
> [note, to avoid confusion: the problem mentioned below is independent of
> an ynl problem I ran into with -next today:
> https://lore.kernel.org/all/59ba7a94-17b9-485f-aa6d-14e4f01a7a39@leemhuis.info/ ]

Thanks for the report, these 4 need to be backported together:

57e7dedf2b8c tools: ynl-gen: make sure we validate subtype of array-nest
ce6cb8113c84 tools: ynl-gen: individually free previous values on double set
dfa464b4a603 tools: ynl-gen: move local vars after the opening bracket
4d07bbf2d456 tools: ynl-gen: don't declare loop iterator in place


