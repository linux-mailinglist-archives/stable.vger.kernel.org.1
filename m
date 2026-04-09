Return-Path: <stable+bounces-235375-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Pp2LJSH12mwPAgAu9opvQ
	(envelope-from <stable+bounces-235375-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 13:03:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D7B3C97AA
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 13:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2988330097E2
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFF13BF696;
	Thu,  9 Apr 2026 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="mESvNSEe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TrdsIibh"
X-Original-To: stable@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0F53BF676;
	Thu,  9 Apr 2026 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775732551; cv=none; b=IjyAr4kN7Ve18p6NepGxuyV4UYk+zYvltgxzoLVZ2r4sjQ/V6+QqaZGhvGkUEvWUTjIwFnELLhcaXSghTQOa5pH/zuukJb4YYXL5wLWNHoSkQBqrtEBNGUuMewC3jpMGbBpe6wSYJW62vPchOkrhUbiwybqXFJcioyJPMILiNlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775732551; c=relaxed/simple;
	bh=iX7/g7kG2GIgH13KIIvNMSxX5esKQkJI1KeQ+z9SNug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQQ+Pr4aIGBqkqUjGz+78QKor5+v/iWoA1c1PxryBUOTMybo6oEyPrcOwrrhsQ6RGbmsGIEb4/cwcBLg/fHm316LtjhG6t1q2Lv6KvCfawFgeaOURWWpgmTxsGcBPPQesvM1jQ7PR3QauQmmxfua316LLgehtapeKTLM/QBWcq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=mESvNSEe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TrdsIibh; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D01301D001B9;
	Thu,  9 Apr 2026 07:02:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 09 Apr 2026 07:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1775732547;
	 x=1775818947; bh=lO6+NpO+dZ6bvnKitXIQQe7ubM4Dfl6IPksxjM2XXtg=; b=
	mESvNSEeIduwM+sMGu/HPA/eviSn23TMJLIfsWQ1plxxEqqwnaKk5ep/cGTjC7Nf
	wPYA2FKjjN4H+0Pua//enThMKNz/BFy0gmJJhk4M4nrs7lPAkItJyFpsacoxArab
	KF7fj+T3Jf8o19/6hAxm5OkihXflos4TupUKNKFGDYjRCCtUVri8DJ/K4Sqf6TwI
	SAo16MW9dFIfVd76UwfQYzTCitxWj+U+TsbjbO9eHfD7MwLy5HzpgnzgfIzXpimw
	GMLirSweV+cZ6D6HVqWcEUtfatEiuz7+bkSf9EIupmv8AVx8feqPMOSLL0K4Y/AY
	kwsvzuG8Y5/mA6obNb00nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775732547; x=
	1775818947; bh=lO6+NpO+dZ6bvnKitXIQQe7ubM4Dfl6IPksxjM2XXtg=; b=T
	rdsIibhla0tvNGeE9MfwoKcLdqatYJtpRxZhtllCQeMqwLL8ERfDSRBMizp8RfH2
	gD975HK6Z+RFebFwIW1FV1JnzKjUw9AtYclLvPYMBzm4hVAUja2thvv4NzYXSYS+
	Jpil7d/meoSVzK4v1H28o+hQE1XPGsdb8niN9E5zIOq2NaNyCIfE7PSTlYo1rxes
	tY6rQ6Y2R0Qo6Yd1hz30pWqVcDFlcBFDYvDfgefT3d13vJkvDon2M9UfYPC6rjfy
	aGoUnrYVpT4paWNQ4zHHNEQ60tFNh6T7lPLe1FZEN9F6DneDpCFAI+CntX5vuXHw
	Jm4rjpkoAFeNKcb0D7zbg==
X-ME-Sender: <xms:Q4fXaT_GGmmC_Qeq5ncZ7NYZWab1Ii-of06dRVED8KfzWT3l3dACXw>
    <xme:Q4fXaQZxRsFgCFnxdiohxpH0vAnopqX6GY8actyclZofXq6Miuz3T_rP3kU6fStwG
    dyVUi4Jz0hYbgML62Ogp9e976xFXcw02oyeKWCG0prPWXcpp2Z2>
X-ME-Received: <xmr:Q4fXafNXxkHJe-dZ4iJjbZZb3z_hJebSLquS-tttV9b4ySxSKrSWVc9u1NvopnluNcIds5-u6sbL_IXpRe1PePd22y0QLbG5arn-DWlkSE5N6TaUoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvieefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhephefhjeeujeelhedtheetfedvgfdtleffuedujefhheegudefvdfhheeuvedu
    ueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsghstghhuhgsvghrthesuggunhdrtghomhdprhgtph
    htthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhhorghnnhgv
    lhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhiseguughnrdgt
    ohhmpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohephhgsihhrthhhvghlmhgvrhesuggunhdrtghomh
X-ME-Proxy: <xmx:Q4fXaUAkyVRWIfWYiuYLMtpzshA3rBdhzQ9uDGqivJssmXbqWVtPFw>
    <xmx:Q4fXaeJKEC-bVo-9H7Z7YgJJZ7B1_t-PGPxY3wn-bzdG5MokRzmE4w>
    <xmx:Q4fXaVPp9z8q0lqFmGeaSeg4Stm9h56kNXubXY5xm_gRnrcoN0oLWA>
    <xmx:Q4fXaU6oP54s2dzsBpq0oZLr8bz2wXC_lo-xxKB_8Qf7B9pRsuwRag>
    <xmx:Q4fXae-xuqeHQsBspbbY9_hemRellvhq-z1lIMv5zxbK6KUIhK_tegCU>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 07:02:26 -0400 (EDT)
Message-ID: <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com>
Date: Thu, 9 Apr 2026 13:02:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fuse: Fix possible memleak at startup with immediate
 teardown
To: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
 Jian Huang Li <ali@ddn.com>, stable@vger.kernel.org,
 Horst Birthelmer <hbirthelmer@ddn.com>
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,ddn.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235375-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20D7B3C97AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 10/21/25 23:33, Bernd Schubert wrote:
> Do not merge yet, the current series has not been tested yet.

I'm glad that that I was hesitating to apply it, the DDN branch had it
for ages and this patch actually introduced a possible fc->num_waiting
issue, because fc->uring->queue_refs might go down to 0 though
fuse_uring_cancel() and then fuse_uring_abort() would never stop and
flush the queues without another addition.

Thanks,
Bernd

> The race is only easily reproducible with additional patches that
> pin pages during FUSE_IO_URING_CMD_REGISTER - slows it down and then
> xfstest's generic/001 triggers it reliably. However, I need to update
> these pin patches for linux master.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
> Bernd Schubert (1):
>       fuse: Move ring queues_refs decrement
> 
> Jian Huang Li (1):
>       fs/fuse: fix potential memory leak from fuse_uring_cancel
> 
>  fs/fuse/dev_uring.c | 33 ++++++++++++++-------------------
>  1 file changed, 14 insertions(+), 19 deletions(-)
> ---
> base-commit: 6548d364a3e850326831799d7e3ea2d7bb97ba08
> change-id: 20251021-io-uring-fixes-cancel-mem-leak-820642677c37
> 
> Best regards,


