Return-Path: <stable+bounces-26890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F02872BE5
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 01:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E051C253E0
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 00:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901171FA4;
	Wed,  6 Mar 2024 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="KupWpdJK"
X-Original-To: stable@vger.kernel.org
Received: from insect.birch.relay.mailchannels.net (insect.birch.relay.mailchannels.net [23.83.209.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E266FD0
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 00:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709686191; cv=pass; b=Sy6px8gsLZzJLh4vuxHdSNQwJ/38K6RaTHuqfA+hHpr7qs2o7TLeXfGn8N5djn/3MmrOp/WcmREgEIYA1wZJ+wbP/t8jBQGnE4cItyBmdA0MxiVssK/7xyz38Eh2F3SHfaLaiBG8Ew+BZOFMeRhg+CQYEym++OLiDgfQVoOsfyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709686191; c=relaxed/simple;
	bh=d+5Zd4khyhEDwJqmZ6kkCg4maPTRHHQ6hfUNFL/fafY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cI1xQO+MmBqBuQh+XCDbQQgsZFjc38GPDfG0dy6xRNceezvdgk8EnkRKVLsiFA8YesyC0eE+f+uk5EBw9uFc0k3AZqbjiUYd3iI1ZH8ppoiQIHZQq/IB26D88Ay4yt+lbiZ05TdTP7Mv3TYxVrW1nSfUF06IrvFWVTTq7O5MVNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=KupWpdJK; arc=pass smtp.client-ip=23.83.209.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8F06C7A1840
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 00:49:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 362127A11C1
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 00:49:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1709686183; a=rsa-sha256;
	cv=none;
	b=qYwirUCQDwhTRT24ncd+685Qo1SMeif9OOZTe8Kv25UxV0tWQsfjWLFvq/L9o7z0FBmZdy
	NN+hHXIYlmdI97z91r2OyTMV6NwQgME+NI5NWVhigyWX6YBAqTJ5/GENrqky1OyHEHK6rJ
	jQkk7KV8j2BaFvAxzN7uV1q+039B2GJHrk7ak1ICHLf+EOu1vBKjMY4peXie3WLkQg3cIt
	D/Taf3QBviemk8/URyCt3wcJOBpS3zPnabyMgMgopM8Zar0d6MSQBG3ejdqpoVqfKM0H7F
	5y6EeGrzTOfMamMyBCyd52KRr4f17+E0P3JU8htd8Ae8uv5snKivR/B2wRcaBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1709686183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=DNLKvccLFdiUKHv2i3lmJ34W+CDmNNDBX/usWGypHyw=;
	b=0nXwR901hCYqBbGNGzhyCXQgDGviCFepve84/terqnKSlCeYy2sKTJlB9AOnzv11yVNBNK
	9+RVeyBi/rBoAkhYcSMLhQn4d8jt6pgrH94E8SmfmyyCKWB70XY4cGR7c+3IR9zQCjqQGD
	TZdM4k7QJOw9ojFENh6Q8eRbg1YWki/4mRLgq+ddfG73bmt5D7gACT98lKOCG1eJBzQaeT
	wN5IB21IjjidyVEL/vafvuRpwtaPe5JZaMhNqF0iyBJBzrbOPr7UpCA4r7Z9DKzqZn2LoQ
	gIlMVOl2FbXdvVY+UNXEvdBzvv7LAF4S/0UaNd3QhH8PRZ5NFZWJ6Ov1VRflIg==
ARC-Authentication-Results: i=1;
	rspamd-55b4bfd7cb-m2nj9;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Occur-Glossy: 698b9353339c95f7_1709686183444_2506996998
X-MC-Loop-Signature: 1709686183444:234661904
X-MC-Ingress-Time: 1709686183444
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.52.242 (trex/6.9.2);
	Wed, 06 Mar 2024 00:49:43 +0000
Received: from kmjvbox.templeofstupid.com (c-73-222-159-162.hsd1.ca.comcast.net [73.222.159.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4TqDNQ72sMzFf
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 16:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1709686183;
	bh=DNLKvccLFdiUKHv2i3lmJ34W+CDmNNDBX/usWGypHyw=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=KupWpdJKMKNqq4ZM0GGCfLFa2tI4fp5I/QkLxtkIAHekPCxg5xZz38EQpe8siheyd
	 ns/4TuQYU+qyN2id+rZkvzfhCnR3ipJ/Fy+Uw9UEjAQgphtZAdRw/gunKHuDBi72PV
	 XbQKQVyrZM6QslHj5xqAGiR+JEHyrUZ5lkRYp+r1S1k99MvM30t4lfFnorJcU5CD73
	 e5EZB7K/uWJYbwgXA6f5vCwOsAdz1WOOBat/XoJfKd8OYNFyP0SpswORcBLNqtspto
	 L0KNkundKivT2DWttpfdve3cg9iqC2e2KNtIT2Wt1WtcHLoYRPf2acF2j/AJZ0qUUP
	 1EZFIFhkaptvQ==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0082
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Tue, 05 Mar 2024 16:49:34 -0800
Date: Tue, 5 Mar 2024 16:49:34 -0800
From: Krister Johansen <kjlx@templeofstupid.com>
To: stable@vger.kernel.org
Cc: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	David Matlack <dmatlack@google.com>, kvm@vger.kernel.org
Subject: [PATCH 5.15.y v2 0/2] fix softlockups in stage2_apply_range()
Message-ID: <cover.1709685364.git.kjlx@templeofstupid.com>
References: <cover.1709665227.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709665227.git.kjlx@templeofstupid.com>

Hi Stable Team,
In 5.15, unmapping large kvm vms on arm64 can generate softlockups.  My team has
been hitting this when tearing down VMs > 100Gb in size.

Oliver fixed this with the attached patches.  They've been in mainline since
6.1.

I tested on 5.15.150 with these patches applied. When they're present,
both the dirty_log_perf_test detailed in the second patch, and
kvm_page_table_test no longer generate softlockups when unmapping VMs
with large memory configurations.

Would you please consider these patches for inclusion in an upcoming 5.15
release?

Change in v2:  I ran format-patch without the --from option which incorrectly
generated the first series without leaving Oliver in place as the author.  The
v2 should retain the correct authorship.  Apologies for the mistake.

-K

Oliver Upton (2):
  KVM: arm64: Work out supported block level at compile time
  KVM: arm64: Limit stage2_apply_range() batch size to largest block

 arch/arm64/include/asm/kvm_pgtable.h    | 18 +++++++++++++-----
 arch/arm64/include/asm/stage2_pgtable.h | 20 --------------------
 arch/arm64/kvm/mmu.c                    |  9 ++++++++-
 3 files changed, 21 insertions(+), 26 deletions(-)

-- 
2.25.1


