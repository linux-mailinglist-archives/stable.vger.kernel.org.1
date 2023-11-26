Return-Path: <stable+bounces-2683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3E27F92DA
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 14:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174D21C20A17
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 13:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CC2D277;
	Sun, 26 Nov 2023 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jidanni.org header.i=@jidanni.org header.b="Bbarbw0t"
X-Original-To: stable@vger.kernel.org
Received: from snail.cherry.relay.mailchannels.net (snail.cherry.relay.mailchannels.net [23.83.223.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41364A3
	for <stable@vger.kernel.org>; Sun, 26 Nov 2023 05:33:27 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|jidanni@jidanni.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 99B492C1D13;
	Sun, 26 Nov 2023 13:25:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6327A2C204A;
	Sun, 26 Nov 2023 13:25:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1701005141; a=rsa-sha256;
	cv=none;
	b=+XdnVd1yKc7pkF2lKTVYCsr6/eAQPvCi50CkCuAd2NRnO4rXeHKWBIFfD7xBdbr8AQdjB8
	gMCLzQfww5ook/NmMxDdtcEZVeVUuvB0N5H0WG4rfC/wRHwD8zCyq2Co35eB2UYwBnhxIz
	OXF4fNPQGaJmoyL0vegomP9MjgthTJxJFPxyd5dHGmKvJGU+A+1c4uO06XviXvit9S/PgH
	93jvgzd1zH07FR2uZWxtaN6/v7q5X4yX0fICHI+NlXmBAlThbKonNKiXWHJWJ5SmsMkis8
	yHqfz84o0bSi74KaIh6d8EBC65XVWNIqwu9NErXGKzU2yTReGuJBIGmjy1cvXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1701005141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vykT+AeaVVU8MZ2Cwp9DPzN9GBLR/uYb82aG57JDDV8=;
	b=Sm6WiuyzWu9wJWuIHXJ3H5k7wjCd6lO5pqg18bxjyspNVpT2RdSSCZVi4uLDKVLV1ANaq7
	sLw/GnRuQjQBpzfoSXxroae6BNMMcbWciRu5euHm5hIV7nT54XMgc4i6qFVx4TLIlyVkfn
	ky/OLyqqHCdlN/TcPG9eGNRQBgd6AkYnO+NnAahL4MxPjW7BROn9n8x7ZR3xzONx4/HLOC
	qriPICRxFvdaDiHP9fOmlIq05bVmIl3sCgTi1cxoDqxDy9HHGHaMGMpkoYeGaL5XmbZebJ
	f0tbhzlN4WeAT7MFtAuTsshWyi5b/G+iBKwx0edKgh6GOj6B9PmBhLk+Mcb5zg==
ARC-Authentication-Results: i=1;
	rspamd-d88d8bd54-b7hhr;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=jidanni@jidanni.org
X-Sender-Id: dreamhost|x-authsender|jidanni@jidanni.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|jidanni@jidanni.org
X-MailChannels-Auth-Id: dreamhost
X-Illustrious-Ski: 12d91047542fcfd6_1701005141449_2311476042
X-MC-Loop-Signature: 1701005141449:2137638455
X-MC-Ingress-Time: 1701005141449
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.11.72 (trex/6.9.2);
	Sun, 26 Nov 2023 13:25:41 +0000
Received: from webmail.dreamhost.com (ip-66-33-200-4.dreamhost.com [66.33.200.4])
	(Authenticated sender: jidanni@jidanni.org)
	by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPA id 4SdTxK1PGfz3C;
	Sun, 26 Nov 2023 05:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jidanni.org;
	s=dreamhost; t=1701005141;
	bh=vykT+AeaVVU8MZ2Cwp9DPzN9GBLR/uYb82aG57JDDV8=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=Bbarbw0tqX/QGPZuGoEJGfdu3arT4wfr0pefpFwCJqoelnfTiX4kOu1LJ7+96vW9t
	 obf8QqTOnwGCtvGM0AvwnR7OTR9S/CXs2XixNhcalA5JYmdc6bqRMixu+8qGvJLmad
	 wQ0bo47yM29epcTar4iYgK4CCBPea/IjBT7GYKRieHMmDF1ESdPn4VRcSaLrhbu1fl
	 WQQT+FCC1jWDH5PpMoSvg/FJcdqCyd9dpjLZ2xXXLOcVBdGc2+XiLgHboETmj1Njim
	 3BeHXD8KThn0HXNewDReeZwHHXh7D+Mmvx9QilQTA2CR2/cc05WziabRZbbN7DGqDn
	 LHFn8a0VDZxNA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 26 Nov 2023 21:25:41 +0800
From: Dan Jacobson <jidanni@jidanni.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Greg KH <greg@kroah.com>, stable@vger.kernel.org
Subject: Re: Say that it was Linux that printed "Out of memory"
In-Reply-To: <20231126092044.GA7407@1wt.eu>
References: <9399ce7b9ffa0ff6da062e9f65543362@jidanni.org>
 <2023112613-decorator-unroasted-500d@gregkh> <20231126092044.GA7407@1wt.eu>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <283079ceaea37a99e84800b1ed16a68e@jidanni.org>
X-Sender: jidanni@jidanni.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

OK, sorry. I now filed
https://github.com/Perl/perl5/issues/21672
to make sure they say "Perl: " in front of such messages.

