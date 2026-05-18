Return-Path: <stable+bounces-249242-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JtjM0jfCmqR8wQAu9opvQ
	(envelope-from <stable+bounces-249242-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:43:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F36569F35
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4082D3059FF6
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4D23E7155;
	Mon, 18 May 2026 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="EXDwKVG5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qzttd3E3"
X-Original-To: stable@vger.kernel.org
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3863E7179;
	Mon, 18 May 2026 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096972; cv=none; b=nNw0tUJgA3Dd4J9+2Egk7728eMci0GMFFTpbOgyVuMIw/g+pvh5in9HHbAhPxl3tTV6m8EOar9JWTheLBp9wWH9OmaEuuMdpH2Rk+wf2Sh8DEIMk6v2ZhYz05IWYdi34v4YJxqthNdfc1aRihS7+S7Aqy2spwqW85tpNpw3dGm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096972; c=relaxed/simple;
	bh=9f59zeiLZgadl3kKXePTlE/z4EO79MiiStdZcxlY7A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAJHmlP8wKd8gtgGnaxtFR5Mp+v4Z8nXZARTaRIYme9xk6/OdefZtMof7pM5h5bjys9AvzieEAJtc2pYMoNmba1rMGbH0w52z13cZYI6mh/NnOSDMQUqM9lctJzMlq4RALlrafFQzohay97+4+wKO1t2k2C+Zl7rg1gtvUOE13A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=EXDwKVG5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qzttd3E3; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 5C6921380493;
	Mon, 18 May 2026 05:36:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 18 May 2026 05:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779096969;
	 x=1779104169; bh=19w0nMnNE9J8yixcestTCQ227en8+KUKILsHHgeFJYQ=; b=
	EXDwKVG5CLp9uIlpOhT3ylfesZfyzXpa69XZPG+5SkJqBJS0R2S3ThV9nwmnn9TA
	yBua87LtMY1EmaTVtLhNX3EBgnY5Gm0O5wvypTtMDUJrhTf+UP0kDbC8m4dvV1/3
	n3u/NVnnJJjAYOhEAW4QxdgPO1PdbdY78e+HriRxW4J2mzVDpAtSon3VLcykhWwt
	aptexbSwdEFQa/a74xqM07GiR0Akh9jlXzxXc6dQb8y0hqEb68EbRTfOnQs1NyQd
	HJ2Hjr5c5JokNRIcG1Qd+9pQrZzynxK0vb3f4ydYitTv6KKapBCsTLnRyevmTYPa
	5zctu42AZJLUWmZTsPwakQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779096969; x=
	1779104169; bh=19w0nMnNE9J8yixcestTCQ227en8+KUKILsHHgeFJYQ=; b=Q
	zttd3E30ERjO8ZZLOp+QkUcCsi8wBQ/FAiE3GuG8iofnzfbxgSyz3w3JKrej2pC0
	0naGJFx33ekROrh+2V5YGgMRxmdCrz8uvFjndPYCDyIi37Qdov7Slgf3kJ7vlA6S
	ns6/BynHq86U79ZWhp/nu0CI3UUGlcaQ2Q1kRzETQmKWEhl1+7U3VdhbV9FwEh+I
	MfezOkmp3j5AkrGNqKhWX2NacRJfhIu9P1i5FFqrS5T7Klglq7FO88OyuJCpvIWI
	hG+j5DjlzNQOIW0Zcc0xTq0VlXFaeXj5BzfQQ3aAyWzT6m4QeoCP3d5jDEwaQJD+
	iIrWU4IlslUHU0BrrfemA==
X-ME-Sender: <xms:iN0Kauzuvm1090nizHzRV8-niUV7JaZPXojq8a7uxb4yzuB7vOD5VA>
    <xme:iN0Kah_ySFwZidVDkdkj_NL9tfHCrDNk8wrq5JPzwy96rqEQoG4VjkUzGMQVtAEPv
    kcjdTUCCOyl3hwmPiAYqThri_HH2tVV4EsUs6D9OB7Y47cN1iM>
X-ME-Received: <xmr:iN0KamKHyTDyRd0-zrbEuhnQ_UaO1DpkwQRjNOPrmAMXzdCpUJesaZgooD3eCtfskjEMdxZxzJ7XJUtExOByG31O6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehfffftd
    ehkeevfeeujeduhefggfetffeijefgkeelffdtjeefhedttdfffeffueenucffohhmrghi
    nhepsghoohhtlhhinhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohep
    vdekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrkhhushdrvghlfhhrih
    hnghesfigvsgdruggvpdhrtghpthhtohepuggrfigvihdrfhgvnhhgsehsvghurdgvughu
    rdgtnhdprhgtphhtthhopeiiihhlihhnsehsvghurdgvughurdgtnhdprhgtphhtthhope
    hnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsghhouhht
    hhgrmhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluh
    hnnhdrtghhpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:iN0Kal7zmnqRU7742nyAy3ndkhKLViVV2CVNu7t4NF7msDG9dlqtUw>
    <xmx:iN0KaruCW6BT3kZZzh6I4ORWubMhRyx3XY8M8mMhTGllGRCyHJgANQ>
    <xmx:iN0KajZmoy4H2vxErtOkJetSDpS1A_xTbAK0N3uhlQDMatexomMGUA>
    <xmx:iN0Kans-ooF5Dl2itzF58CnZDAZmXW1ZHPAu3h0pDuIgAvDgGdlYzw>
    <xmx:id0KatN8hGEHzbie003ukn4uTChKkYmtpD9Vg3DS4QgBU6_0TDoMniBO>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 05:36:08 -0400 (EDT)
Date: Mon, 18 May 2026 11:35:22 +0200
From: Greg KH <greg@kroah.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Dawei Feng <dawei.feng@seu.edu.cn>, Zilin Guan <zilin@seu.edu.cn>,
	netdev@vger.kernel.org, Sunil Goutham <sgoutham@marvell.com>,
	stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>, Paolo Abeni <pabeni@redhat.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Subject: Re: [PATCH net] octeontx2-pf: avoid double free of pool->stack on AQ
 init failure
Message-ID: <2026051817-identical-decibel-3953@gregkh>
References: <20260515151826.1005397-1-dawei.feng@seu.edu.cn>
 <fe233758-26b8-4abc-ada9-d1f7c4102b08@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe233758-26b8-4abc-ada9-d1f7c4102b08@web.de>
X-Rspamd-Queue-Id: 61F36569F35
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249242-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[web.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, May 18, 2026 at 11:23:30AM +0200, Markus Elfring wrote:
> …
> > Set pool->stack to NULL immediately after the local free so the shared
> …
>                                                  so that?
> 
> How do you think about to avoid a bit of duplicate source code
> in affected function implementations?
> https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c#L615-L629
> https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c#L1478-L1492
> 
> 
> > The bug was first flagged by an experimental analysis tool we are
> > developing for kernel memory-management bugs while analyzing
> > v6.13-rc1. The tool is still under development and is not yet publicly
> > available. Manual inspection confirms that the bug is still present in
> > v7.1-rc3.
> 
> Under which circumstances will the mentioned software revision gap
> be adjusted accordingly?
> 
> Regards,
> Markus
> 

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

