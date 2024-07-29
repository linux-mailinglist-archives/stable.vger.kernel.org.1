Return-Path: <stable+bounces-62337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEF993EA44
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 02:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7801C21288
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 00:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32191FB5;
	Mon, 29 Jul 2024 00:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="iGzsKd82";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M6Kqw8qu"
X-Original-To: stable@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D7C1877;
	Mon, 29 Jul 2024 00:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722212854; cv=none; b=CVbDm4ogm88Ruuc4cfsrCrRphoq7L+4rGFN3nrPz/NFrL71Y9pDU552F9fLXCoYQuoBhoK7n4HfGewgcbFCjywKuH6O+402xExleExq8XhzGB/QQlYfI4tFbPMJajCNH6TSRXG6SWrktZp6s0uDiAJIZwyB+vfP/tl/VZT0UcsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722212854; c=relaxed/simple;
	bh=i7oXsCWfcO/9Kin2zf9lN96R2podeKV2ryanNLQwNYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uovbhnFwlyHytt5av9P33ZrkWI89/Gzjm10jszaBCdfs53T5WtNBzsf5jF671HRa4Pj8ONmtzDSOXyG89tibebdwLDcqT/fdWJNjETQGqMPjheyj/zZ8Zk1x1o+fhDsMxvEsQiHBav90I/tCd5LSII5ahUsH/lMdrRhtv5D07eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=iGzsKd82; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M6Kqw8qu; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9F36811400BF;
	Sun, 28 Jul 2024 20:27:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 28 Jul 2024 20:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722212849; x=
	1722299249; bh=k+zl1gJKs4RZGZe7zAg8h9HGt2WHFPnN6AkdANlRvyw=; b=i
	GzsKd82m8jLdFjvZ0PiJe2bqUaCaYdh14RfPPCOQQk85FwwUDP1H0sMICGkIw5mp
	n/rUSqGTvVx1zQfw9mX+AaV4memPKPa0I2Ilu9fnBVOOYjUYOCAdULNGzdkoj0r0
	qKVT9Avh3NI+FCoSo28KLyTzQp4rm/csZltg8J6/XTL9+0VXCfbDrJ0Ka1xZWc8d
	WFWRQOT2IZ2tV63uu1u70u5MqmSSNVg8nRNah8fU7dtP4mV2zxFeZsp8nQlKhyrK
	fWu1LSiVpO3tRrrujtu8IHIUipfa92c2OXmhScNUJX7d72ArJatVMYfaJfoBzbeO
	hWBScxGpjuC9JJKWiqIfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722212849; x=1722299249; bh=k+zl1gJKs4RZGZe7zAg8h9HGt2WH
	FPnN6AkdANlRvyw=; b=M6Kqw8quxJ8fYgquzFOvZE6hNdY+IDdojSQszXZMCT/n
	0f+D3vdfuUFlx3k+BzLzebc7Ne/xw6+UElgUh8h4DJ1DXWInmZtMDkRt1Gt9kwSD
	IKNU3X7fSIdCFELltW0G7NUJjsLXlX+eSPdGKqpaow3QGsMR31VI3O024dz0Pab0
	6mfv8luDj1brlYS0QhE6wdn7IorhIkLZHs3OUFcdUGCYxFOt3ZExpJrAxVC8/FXy
	bAnIV2D66gflLtxZ2iEx7Dn+vZoy9dwUPnsQGrWs5RCMecMIs1OFHww9BqOm1kBs
	0T8nb2CAKVbhtJRAQKTWHMUfoe69xB34yOn4JZxdHw==
X-ME-Sender: <xms:8eGmZvrMTh9Yb5qKTn6_HWaCSS7CHeR0WIFjNghvBNx6cat4F21RAA>
    <xme:8eGmZpr-IyuDjLCJW9s0ydSUIVUXR49WuS2pGE_xtMeyJ5VlekJdi9TeNtdkpZu9Q
    a4XJQrMhNfVm63G2fg>
X-ME-Received: <xmr:8eGmZsMbau5t3h7HHVFXGyGlOnruW3DKDCalGZNTVoJp38h_A4xAi7N9myw8QyYskqWVEBRqtLGkFngxBr2gy4BBlVZfs0MlubQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjedugdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeekueeuvdetheffgeejkeduieeukeejteejfeffhfel
    feeggfduffelheefueevtdenucffohhmrghinhepghhithdqshgtmhdrtghomhdpkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphdpnhgspghrtghpth
    htoheptd
X-ME-Proxy: <xmx:8eGmZi5wxs6sYGBKVzxLUevsrsIs0A6bJWGmZSyozQFEnBMKXFdGFg>
    <xmx:8eGmZu7b8t18ywH8k4zYMlqJ-a9XuW4ugvccBUeupv1ycxS1OR-NQQ>
    <xmx:8eGmZqgUTlb0UuGUr0XwwrsLkOSDnMrJlFan0C_uhtGTBj9BtKaJYw>
    <xmx:8eGmZg5NSxNkdEQz_Dnc9qIGfrFY853WmYEEfULr8ngwWttC3f0QCg>
    <xmx:8eGmZp0viGv67fXBTZdVve-soVOX0Ju1zjDKmYeFlidkO0m06K3REzmy>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Jul 2024 20:27:28 -0400 (EDT)
Date: Mon, 29 Jul 2024 09:27:25 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Edmund Raile <edmund.raile@protonmail.com>
Cc: tiwai@suse.com, linux-sound@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ALSA: firewire-lib: restore process context
 workqueue to prevent deadlock
Message-ID: <20240729002725.GA33722@workstation.local>
References: <20240728122614.329544-1-edmund.raile@protonmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240728122614.329544-1-edmund.raile@protonmail.com>

Hi,

On Sun, Jul 28, 2024 at 12:26:21PM +0000, Edmund Raile wrote:
> This patchset serves to prevent a deadlock between
> process context and softIRQ context:

(snip)

> Edmund Raile (2):
>   ALSA: firewire-lib: restore workqueue for process context
>   ALSA: firewire-lib: prevent deadlock between process and softIRQ
>     context
> 
>  sound/firewire/amdtp-stream.c | 36 ++++++++++++++++++++++-------------
>  sound/firewire/amdtp-stream.h |  1 +
>  2 files changed, 24 insertions(+), 13 deletions(-)

Thank you for your sending the revised patches, it looks better than the
previous one. However, I have an additional request.

In this case, it is enough to execute 'revert' subcommand[1] of git(1),
like:

$ git revert -s b5b519965c4c
$ git revert -s 7ba5ca32fe6e

It is permitted to add postscript to the commit comment generated by the
above command. You see my recent post as an example[2].

Just for safe, it is preferable to execute 'scripts/checkpatch.pl' in
kernel tree to check the patchset generated by send-email subcommand[3].

[1] https://git-scm.com/docs/git-revert
[2] https://lore.kernel.org/lkml/20240725161648.130404-1-o-takashi@sakamocchi.jp/
[3] https://git-scm.com/docs/git-send-email


Thanks

Takashi Sakamoto

