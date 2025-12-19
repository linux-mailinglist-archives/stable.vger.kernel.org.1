Return-Path: <stable+bounces-203054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD59CCF1AD
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 10:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70038300F713
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 09:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D352D94A9;
	Fri, 19 Dec 2025 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="P1wqUzP4"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F6B18FDAF;
	Fri, 19 Dec 2025 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766135977; cv=none; b=KM8q1TTwzR4dh7QJVoJVSFGjKF0t5A/4Ze8U+SdSc93SGdHEbolu8IF7OLkNioqDvlW390R8Qf4QhzYZRVTUZSB+WivhtVOr4MrfGf0Iccl131X32RoSHpqOxB6XkDI/2BsFwoFkV8nbVpah+9YngzuLAeEUSQPBgnotdTxiJVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766135977; c=relaxed/simple;
	bh=3T4DXwGEK6fFM+rljpyoBPlKKuNj3NbNxx5d/1pDU0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TNo40BJIlYmsSDL93AmRpfzvrbGtGyf76KwKKXBAe3aIhzjUvEu4IQsldcT8M+x5lCbl6PrHg94SyIP/TykkSROvOrZh59Q2zOzs+446/aCA0096vtCgFAyK3QjjU3CY3QH5GozWLNYBW3FWBKhn5iXORwD2iUbaqBTUmiEcR58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=P1wqUzP4; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=k9sDDaYd6VKZiJGJbBvPsTD3iEK8JKrLPJyOnc5OhUs=; t=1766135975;
	x=1766567975; b=P1wqUzP4Ste7rRAofhrbntNWVJeozv81xr9VuMr6OOR3oJDUl7C0fKvTmqFl7
	xC5aM/a2GhsLyxMpehn3g34xf5zG1bEFK2ScEBofrcw+qNwp2nFdY6hXjJEotE8w5d7XX2adpTpwr
	zZTpMap59qxG9R0l3flE5AK+bfGmKadsMpxtZqlBR+WZjSqrrsFFLwEZ1mhQCKjLK6gL6p58OLN0l
	SZWgnjFX/io79Li9BsEAT6/Jup41Kyu9JPHk/ROxut0zVSqfWC1N/6s3mgl5EmDWCkiSZmHGOR3lH
	eT+dqFDdS5B/rPZBGQombbN2lcm6McvNmzb8tKMIrC/d3SDkXg==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1vWWdo-003nRO-2n;
	Fri, 19 Dec 2025 10:19:16 +0100
Message-ID: <d4b4a22e-c0cb-4e1f-8125-11e7a4f44562@leemhuis.info>
Date: Fri, 19 Dec 2025 10:19:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression 5.10.y] Libvirt can no longer delete macvtap devices
 after backport of a6cec0bcd342 ("net: rtnetlink: add bulk delete support
 flag") to 5.10.y series (Debian 11)
To: Roland Schwarzkopf <rschwarzkopf@mathematik.uni-marburg.de>,
 Nikolay Aleksandrov <razor@blackwall.org>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>,
 debian-kernel@lists.debian.org, Ben Hutchings <benh@debian.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, regressions@lists.linux.dev
References: <0b06eb09-b1a9-41f9-8655-67397be72b22@mathematik.uni-marburg.de>
 <aUMEVm1vb7bdhlcK@eldamar.lan>
 <e8bcfe99-5522-4430-9826-ed013f529403@mathematik.uni-marburg.de>
 <176608738558.457059.16166844651150713799@eldamar.lan>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <176608738558.457059.16166844651150713799@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1766135975;fd08c14d;
X-HE-SMSGID: 1vWWdo-003nRO-2n

On 12/18/25 20:50, Salvatore Bonaccorso wrote:
> 
> Is there soemthing missing?
> 
> Roland I think it would be helpful if you can test as well more recent
> stable series versions to confirm if the issue is present there as
> well or not, which might indicate a 5.10.y specific backporting
> problem.

FWIW, it (as usual) would be very important to know if this happens with
mainline as well, as that determines if it's a general problem or a
backporting problem -- and the outcome, strictly speaking, determines if
the developers of the change in question or the stable team are
responsible. If we are lucky that distinction does not matter, but if we
are unlucky neither camp might look into this as of now. I wrote more
about this at length here:
https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-kernel-bug-reports-are-ignored/

But yes, given that 5.10.y is quite old, it might be easier to test more
recent stable series first. But if they show the same problem, please
test mainline -- and ideally try if reverting is able to resolve the
problem.

Ciao, Thorsten


