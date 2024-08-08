Return-Path: <stable+bounces-65988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF0394B56A
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 05:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFDF41C2105F
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 03:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040824317B;
	Thu,  8 Aug 2024 03:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsEc++iS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16AE26AF7;
	Thu,  8 Aug 2024 03:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723087346; cv=none; b=k9INNwoRRwikPoSom4D1K4vf/+rJcmVpHigKSp75DZMX5LRvoEnuOoOA+3fOmdxerOTmunITdXFjE3tLajQJtoBy1nrEueD13UOq/KQLo13ie1WKbl4ajvWwGcUfBOfM6ccxqlS02LCIGRjF/8fh4zB51pUrBLOEVrWIjpmtvGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723087346; c=relaxed/simple;
	bh=UQttgjTk6MpDHnQe0vVAsTbqSfrXqTtNF0aq3AVcO8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOW3JYFaq4Y6THcuoGgpGRpkcxQC3XmAGBnjRmbvR1Qg7xKY0IlkRrKRhHGEzY4X4KWWxgBd4FVRxFan5uTzAEhZV2U+6HpHpxmEb6fq9KephmY5Tq12A1iRRMReow1uVTiEIDxACSOdjFJu532ydYhl0b3fTphlaP0XLXHRWQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsEc++iS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A4DC32781;
	Thu,  8 Aug 2024 03:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723087346;
	bh=UQttgjTk6MpDHnQe0vVAsTbqSfrXqTtNF0aq3AVcO8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LsEc++iS35P3NdSDtzwhdHIBUGb1WkckuaY7K7XMZFBzKTszmLSqOFPJPcWQUYkWU
	 1fWCnAXPKgo3R7dgBJ0NHGNF/HYbatmcxsYV+a5qSOX7h6yJyAeDu044ATMZoADs48
	 IvmJVuyvA0CqlINtyWZs2qp0TpiG4Arx343hp+1OLT0Bx3eB7nzghwMYXRrJ98uVH3
	 biWHDg9jubfQXaO2iftNL/lI144/QfJbcjXNOAGfW1PrO5PDVtYWnSENs5SsgwsbtO
	 ISHk4D6DbcdMq7TU9oFh1FXUkHFv5GNQIKqN8OQZ41LX3sVxCvOxcIuCN2J0gYlFs9
	 +q0Pco1dVuR2w==
Date: Wed, 7 Aug 2024 20:22:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 netdev@vger.kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>,
 stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Stanislav Fomichev
 <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [PATCH net] eventpoll: Annotate data-race of busy_poll_usecs
Message-ID: <20240807202224.0fe40c4b@kernel.org>
In-Reply-To: <20240806123301.167557-1-jdamato@fastly.com>
References: <20240806123301.167557-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Aug 2024 12:33:01 +0000 Joe Damato wrote:
> From: Martin Karsten <mkarsten@uwaterloo.ca>
> 
> A struct eventpoll's busy_poll_usecs field can be modified via a user
> ioctl at any time. All reads of this field should be annotated with
> READ_ONCE.
> 
> Fixes: 85455c795c07 ("eventpoll: support busy poll per epoll instance")
> Cc: stable@vger.kernel.org
> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Reviewed-by: Joe Damato <jdamato@fastly.com>

Christian took the net-next cleanup, I presume he'll take this too.
-- 
pw-bot: not-applicable

