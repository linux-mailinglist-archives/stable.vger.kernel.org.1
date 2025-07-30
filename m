Return-Path: <stable+bounces-165184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8DCB15826
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 06:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9BF9188CB48
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 04:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE83A1B413D;
	Wed, 30 Jul 2025 04:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXlvxdgg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED4719597F
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 04:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753850680; cv=none; b=JxZGDhxYDl7nwZGiOan7OwFexKzx8vYOCzpckImu2Aj9PG2kj9QfFxVbe8xfkg2WxJR4Z+5Ct1oIYkDDrDPvIt1tdALzjt9O4jat9kG1gCULSK8iUXgDrfGua5Yi1rXOG5UDdohYRruojxFGvOtSrI9Jj6q+baudL/R6Eh/5uqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753850680; c=relaxed/simple;
	bh=75F/3eV2ETePxbcaL3ardcTIBV+6JF9LFw3emJABTwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2u2kvHhGsPwdH8nLAIw3rI5RIVZDovELxO/hu9o6fDt5hNOL8q7xd3cT2/Fv7CnuVfmce8OfrdZ9T5t02eZ/Tu5ZNvhiKRIMbk0/CWuBgXSQd+FVCxtP7CmJck8MUWP7ay6ZDLu4SC30d3sAHmJ3tYGUHJkwz6h8pfp2e7PPDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXlvxdgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A376EC4CEE7;
	Wed, 30 Jul 2025 04:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753850678;
	bh=75F/3eV2ETePxbcaL3ardcTIBV+6JF9LFw3emJABTwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jXlvxdggbDk06Z0bNTE/6J0PTBhwo3ZL92jUBgcy5TMHy6ozbfOY1gZPRwTgkegf6
	 7lbcmikb11QKC3igOp3HWYJYb5veXltfX7afIzjR036PvtOvr/QI9rJYu2nlDnpanV
	 QKBXaBQ60HMPHJmyht+BncjABQ8w/NkvuMp/f07PN1ZFzpgODKpfgKZouL+y5xx0c8
	 WYpBT318FqWFSfeWs64fHyN3cWZv5Uz05T8GeawOYL6fSgzl/AcYkVPXN3ERLBEylM
	 xp/AQqZrqDU6vRmmCLGR7GskbikqScsbJIp85+s2WJqz6klZaDhEGsMkbFC9t8IvqJ
	 5C2YxeRPZN+/Q==
Date: Wed, 30 Jul 2025 00:44:36 -0400
From: Sasha Levin <sashal@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: stable: queue/* branches no longer updated
Message-ID: <aImjNPvGPMqFu3RD@lappy>
References: <e6ea1805-3e82-476c-86a8-096b80bde74a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e6ea1805-3e82-476c-86a8-096b80bde74a@kernel.org>

On Mon, Jul 28, 2025 at 11:06:17AM +0200, Matthieu Baerts wrote:
>Hi Sasha,
>
>Thank you for maintaining the stable versions with Greg!
>
>If I remember well, you run some scripts on your side to maintain the
>queue/* branches in the linux-stable-rc Git tree [1], is that correct?
>
>These branches have not been updated for a bit more than 3 weeks. Is it
>normal?
>
>Personally, I find them useful. But if it is just me, I can work without
>them.

Nope, it's a bug!

Looks like git was throwing:

fatal: Unable to create '/home/sasha/data/stable-queue-builder/linux-stable/.git/index.lock': File exists.

Another git process seems to be running in this repository, e.g.
an editor opened by 'git commit'. Please make sure all processes
are terminated then try again. If it still fails, a git process
may have crashed in this repository earlier:
remove the file manually to continue.


Which my script was promptly ignoring...

Fixed now, thanks for the heads up!

-- 
Thanks,
Sasha

