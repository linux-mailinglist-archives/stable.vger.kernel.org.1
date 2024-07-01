Return-Path: <stable+bounces-56198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6073F91D758
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 07:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1FD4B208A7
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 05:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F022A8D0;
	Mon,  1 Jul 2024 05:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="okf6C8m2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JPTXfSJH"
X-Original-To: stable@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A1B43ABC;
	Mon,  1 Jul 2024 05:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719811048; cv=none; b=hhWXPqI3l6waCPnthgorZwwSkydhoI/51yFK+R5WAcvRnagtnrpKGNWFZhA6OHVPJtwC050YNtJtmQqPtrlZPUpqAHAVoeVIi8Bx8FNyiHydOmOoxiYWvxJSbPvSdfzNDMwhZ+GlyBjzDGRf0qO4tlZpcXe9sjGiOYdOdEYkyHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719811048; c=relaxed/simple;
	bh=1NCPZuvQK11pWLY83VjIg0A+aLb8avWCrU1p0qACbiQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=JzFoXkh5ajJ08LBhVec4XluDBoctE5l7xKEYkOmwaRKStjKz8TdrmkWnuj9KomveiuhnIlnW7SfzV9416CZSNVLVawG6puvaOI0p2cvDuq+L5b9RU6Hcg54uRDXdYv+Rf8jrJ+mrSSBmrL1jPKL9X3T+LVroV/h0uPyb0GtW3c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=okf6C8m2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JPTXfSJH; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 810BA138021C;
	Mon,  1 Jul 2024 01:17:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 01 Jul 2024 01:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1719811044; x=1719897444; bh=uO1R0mZ5vI
	07kOGzrcM42BVjY+yx0Z5jKChVT17u9q0=; b=okf6C8m2HPPFVmDDl/0YORhXRv
	UFAxS1JCHgjyMKBQMlQ9+fk6b/AKr+B7XxnPIMNEgnRBd3wg5mTQhaRRgnza9edc
	N4anHamcsvcrqJysCW2vlVHT65EIXvKs5OVTOmSK775f5aHXLHHiozMOzrnI1I+6
	zR+QX9oc7ctCToGFOSVic7hfsqnEY3yct+qe4PM21KdJUXfeW9nYcIQ93vBgrjKX
	YBqFqIHFTvXa9oOzjLmq0ZjNRxt/1dIaWuLjfZbx6bGXtXIbxm4xPqkmhuglwthc
	8XZNsQf24FlC9fMpGdwOHtLT4qJIaoGeaGKbyz+2AQAjKd7TdIkhI2ps53yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719811044; x=1719897444; bh=uO1R0mZ5vI07kOGzrcM42BVjY+yx
	0Z5jKChVT17u9q0=; b=JPTXfSJHJ+MPlPv+AnVkJN64nebmJXBb55j9Gg10lxoh
	u/EWAmPQ7sTXj1fty15K7V6bfi8vORaWLuUkHQ7IAmkMnHdkG/zwMZh4FANW7TS2
	JnBth6qjzOUIM2PuIZQz9DwPP0OowxRC1JrFwgZLEmcgG+gab6/Z29SNYo45mcfC
	Qm0rpQIbUdk97CeEBk8T5WfVa0UFutgmhIn4hDZeIpHRYD+dOsJGRJ6AgvwYb3oD
	31kQwt5Ad7hEGUrG2uVZ1dSR7nBNZnsMr214WRjOaSKOZZqQ+Vv2IKC4NDEG4Zu8
	xg6eFZjZZ5//8ik43fNEQ+bkbfGamIDoh0CTM6vbSw==
X-ME-Sender: <xms:5DuCZqPkI8E4OiFNmjln9-m8EYMCd_6IwHl_iWUc-sItmy3v_7SHIA>
    <xme:5DuCZo_n7ONMjki-9RNM32RAOGG3OVyi_ddGJgWFysfKivOXwtxDqxI5yq9GKB8PZ
    jQ2-26g0PWBD7v4ihs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:5DuCZhRqHVVNNyBKsX0olGyvd9-kqb5qAjViHF5Sydr38TkBB95ANQ>
    <xmx:5DuCZquOJxLcsQjJ7tVtiF4-d6oqwARGK4yvYZ-wyLG970f43O4rIg>
    <xmx:5DuCZicl7VDk75mCrld24HDhlv2GoXLEy-IgjXGlGmC6cmcJQZbUWA>
    <xmx:5DuCZu13NBf3WiujbXSTUQvIlqqQj3iMvU6QXl4q7hbCdeVdds27JA>
    <xmx:5DuCZi4OKQJRDchhX5KW8W-2s97WfyovsMFo4hSn8QXZkCQy-Ld9S7YQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 280D1B6008D; Mon,  1 Jul 2024 01:17:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-538-g1508afaa2-fm-20240616.001-g1508afaa
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ebe6268b-3ea9-4490-8b12-09c200bb2e4a@app.fastmail.com>
In-Reply-To: <20240701001033.2919894-1-sashal@kernel.org>
References: <20240701001033.2919894-1-sashal@kernel.org>
Date: Mon, 01 Jul 2024 07:16:26 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Helge Deller" <deller@gmx.de>
Subject: Re: Patch "parisc: use generic sys_fanotify_mark implementation" has been
 added to the 6.1-stable tree
Content-Type: text/plain

On Mon, Jul 1, 2024, at 02:10, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>
>     parisc: use generic sys_fanotify_mark implementation
>
> to the 6.1-stable tree which can be found at:
>     
> http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      parisc-use-generic-sys_fanotify_mark-implementation.patch
> and it can be found in the queue-6.1 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This patch caused a build time regression, the fix is still on
the way into mainline, I plan to send a pull request today:

https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?h=asm-generic

     Arnd

