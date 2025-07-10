Return-Path: <stable+bounces-161613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D77B00AE7
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 19:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6F11889AFA
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 17:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666B91DDC11;
	Thu, 10 Jul 2025 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="JGITLxDl"
X-Original-To: stable@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFAC2F3647;
	Thu, 10 Jul 2025 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752170196; cv=none; b=qZj1fxdjaVPitB38KsUbs7IJ3oO+4euKLtKmrts/rZNVqH/1GKuwYakywL1NHDgUlDcbhLhn6BUw4dierxyB2byMhRqvMFlLC5YQpRdFgSj3CqfKPJnqHeY9sjQNtfJYhWaKAbKbzS6Ri3Sq9ngXC10Uv4x45N49W/J1fUGkj7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752170196; c=relaxed/simple;
	bh=R2uBYRRVEDvnGQyRlNCUOU964/QuqXxp/NqMrC5S4b8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mQSQSz98YwwK3XL9aAoQSYNRk9Q2YJwFsgwOVojynUrdIMj35O4up+Q7WlTuhtdTW04pa1gtkw4yVvUXCUjK9idkR9CXwtX+DY2nFz+uQ6LeyXFQTGTjM9pbgo/xqucgpcKHaIHAyh/slGw/AtY2a6sylpyMH8/S/P126ded6c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=JGITLxDl; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1CD67406FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752170188; bh=StHzJFEIgFoVTiFfu56FB8R7lyhp9GMEl5iQdWvQYb4=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=JGITLxDlEmdqwW+SNQ4aY9pYjrHrd2bBCHKvjYut/F1eKnySWszz4FQDB4EutM8hJ
	 Ok92m8IB4IzW+FpfarkNM35cw68oPIZCvzb2EqbduOVCYIuP3h2Uf4pAIcgmsrQDz4
	 ozYFmo5Yn/lbBpg0vUzbpbff63FTccg2oeC7xRWW+8BT5k9l1c+g2g7/kbT7mEDl21
	 M5ZYYc+KDxkvSupo81GzfeiCgZbgA99bW4oK2xom3SNVkpWOvUmowaTyetPbQJunK6
	 k7W1unAMNQFrM0hxEDilS//BZQYJ0VZxSeHdHC3UMBGJtpOifMPQnd2XkSqI9RmpXR
	 oZA6N70tgMykA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1CD67406FC;
	Thu, 10 Jul 2025 17:56:28 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Pavel Machek <pavel@ucw.cz>, sashal@kernel.org, stable@vger.kernel.org,
 kernel list <linux-kernel@vger.kernel.org>, conduct@kernel.org,
 ebiederm@xmission.com
Subject: Re: Sasha Levin is halucinating, non human entity, has no ethics
 and no memory
In-Reply-To: <aG2B6UDvk2WB7RWx@duo.ucw.cz>
References: <aG2B6UDvk2WB7RWx@duo.ucw.cz>
Date: Thu, 10 Jul 2025 11:56:27 -0600
Message-ID: <87ple8x73o.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
>
> So... I'm afraid subject is pretty accurate. I assume there's actual
> human being called "Sasha Levin" somewhere, but I interact with him
> via email, and while some interactions may be by human, some are
> written by LLM but not clearly marked as such.
>
> And that's not okay -- because LLMs lie, have no ethics, and no
> memory, so there's no point arguing with them. Its just wasting
> everyone's time. People are not very thrilled by 'Markus Elfring' on
> the lists, as he seems to ignore feedback, but at least that's actual
> human, not a damn LLM that interacts as human but then ignores
> everything.

So ... we probably need to have discussions about the role LLMs will
play in kernel development, but this is not the way to do it.  You are
talking about a fellow human, and should treat him with respect.
Please, let's not have this kind of attack here.

jon

