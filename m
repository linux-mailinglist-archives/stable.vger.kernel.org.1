Return-Path: <stable+bounces-242109-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCh4BuNa82lfzwEAu9opvQ
	(envelope-from <stable+bounces-242109-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:36:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE544A38B7
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58DD730416E7
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62101427A13;
	Thu, 30 Apr 2026 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLfLT3gY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E9E4266B3;
	Thu, 30 Apr 2026 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777555925; cv=none; b=gkMEzD7EqAIMgEMbaNFayOon1ITdccYMWtqaTnQYVc8F8ONCES7gH5XwC9u0CGczJf2t34h9GDgiGMn6c1eHrpDQLd+VOim5P/vYZ+MiUxgnabWrgb5ysf602WiS9j/Pr0hOQPoj1ahAwAm43aRssWVw+0tPAMph86IGmpPj+oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777555925; c=relaxed/simple;
	bh=iN8DKEJJ1MqxD8Atz5WqGwwGI8zukpbk6ZFINC7U+H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbCRzcruTYcGBYmXEKWe01oeDnfElO5H0eR8YjHSzrdkBbniojTU2i0qvG4Xt5u0EHJGE5Ug8jxqeUsnaJuCKSMq77KzusFYlgll32HkIEz7HI99Nnfvz9GdU5GVsApRSn1AJ5kci1Q8sgTJdSTsiclfN063OyuzwQmEYKhsL7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLfLT3gY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90388C2BCB3;
	Thu, 30 Apr 2026 13:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777555924;
	bh=iN8DKEJJ1MqxD8Atz5WqGwwGI8zukpbk6ZFINC7U+H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MLfLT3gYJYUrNlUUkxWDvsFI0GEOKhIELDpU30KfET7gp5dTZ9EY4yyMRczN4jZYE
	 kqXh+s5ibDaz4iOJHmi/9a3t5PdwUCMVIPhSyv19a35G0YWrCuHRJ68M2QfyfU6FzX
	 vbrFtrqv2nfcDGMpLeznkZGIaOVkMBBYgUR8RK+me3NEajH4Fm8l691ni6A/iw9Bzm
	 evViPymfOmZlY003vEz7sliSgQKwulQt5UV8/tFcpCN0UoX+Q7TUlnqDc9ttQ8+a5w
	 33Hchtzclp1IGnms+afkLKQSx0mG3M58jh1HGFCYfgOkMPwwuoI9aqhWUOf6Ic5shv
	 occY/ASH6fFqQ==
Date: Thu, 30 Apr 2026 09:32:03 -0400
From: Sasha Levin <sashal@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: stable@vger.kernel.org, Haoze Xie <royenheart@gmail.com>,
	Robert Garcia <rob_garcia@163.com>, b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Yifan Wu <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
	Ao Zhou <n05ec@lzu.edu.cn>,
	Marek Lindner <mareklindner@neomailbox.ch>,
	Antonio Quartulli <a@unstable.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.15.y] batman-adv: hold claim backbone gateways by
 reference
Message-ID: <afNZ0zVdXkgj5hvA@laps>
References: <20260430071645.3030702-1-rob_garcia@163.com>
 <1857579.VLH7GnMWUR@ripper>
 <3609597.QJadu78ljV@ripper>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3609597.QJadu78ljV@ripper>
X-Rspamd-Queue-Id: 6AE544A38B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242109-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,163.com,lists.open-mesh.org,simonwunderlich.de,lzu.edu.cn,neomailbox.ch,unstable.cc,davemloft.net,kernel.org,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 09:40:34AM +0200, Sven Eckelmann wrote:
>On Thursday, 30 April 2026 09:38:05 CEST Sven Eckelmann wrote:
>> Sasha Levin <sashal@kernel.org> picked it up for 5.15.y (on Sun, 19 Apr 2026
>> 21:13:58 -0400, MsgId 20260419195610.batman-adv-5.15@kernel.org).
>> Yes, it was not yet published or 5.15 - so maybe fell through the cracks.
>
>https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=queue/5.15&id=6fd37208adf6771125b59e1ae0452561024be4e2

Yup, it's still in the queue.

-- 
Thanks,
Sasha

