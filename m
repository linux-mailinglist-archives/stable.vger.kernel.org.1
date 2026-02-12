Return-Path: <stable+bounces-215973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNv/EyrsjWnG8gAAu9opvQ
	(envelope-from <stable+bounces-215973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 16:05:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B1312EC1A
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 16:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF5C43072448
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 15:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6093286400;
	Thu, 12 Feb 2026 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8c/L0BI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BED21CC64;
	Thu, 12 Feb 2026 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770908554; cv=none; b=IsAnwHCS+c/O7b6XHXnwgY1N4TEIyhuBKg/IogHfaSONt10X86ZmeOWxhoVZMqeLzGuUEBmPEAB3bbfwD/uEzZlpaQQhaR66Ve0/Yi8deou18gRcusxfgtZQLuV4soNVCYhYM/22iaMgWC54WtoT7vHuz5qItPs/KqOLtzPuVLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770908554; c=relaxed/simple;
	bh=EMoDt1IiNsxkfqiKjCS0UPDXsAwhArjBJsUXQW8L6vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUuiFWyEeE7FLzldYCFAconaOwS6R0L193rPwt/I5oKKbl/dilG4jXT+xBzMB7R9NTyIsrhq1adhoHS0wpYi/qHePT/F7NojbaSYhVSxZxzmd2xaDO03lPtBUOhelzVvZDAzZC2WNsj//bsigKLz6WIAsLXsb85xyCy3gHbY4aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8c/L0BI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40583C16AAE;
	Thu, 12 Feb 2026 15:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770908554;
	bh=EMoDt1IiNsxkfqiKjCS0UPDXsAwhArjBJsUXQW8L6vU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a8c/L0BIsS1ke73oi1t0EZDfo8QIdqzaWM1nV6ZIXWZo4QozN3QbT5uEy1EJD7u7A
	 QBTKui+slf0xBu+H+MX4RoqXlZszimHjTb5mMVMOYtiPyVGJTFaESsJRsw6l9tAT/A
	 o/OgjaamyEel2Y/CzJe/jzF+dVuxk2tERpFjnN79tqJh0XnnUdhqs1T/UlcOlr1Gi5
	 e6EmvI4kB6DjBn2PBNGn/nQl6ckZMiZW/uInyowUIrokv8hyve8Uwd8uSiUVtSWFpg
	 DiSFsEL1fUaTCEI1UDHaCp6Fc6Gh9jibLwhz+Nx4Qf2AagRMaudOMmd04Y4Fu/vnAO
	 vNSBHUAQZIqAA==
Date: Thu, 12 Feb 2026 15:02:30 +0000
From: Simon Horman <horms@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Zheyu Ma <zheyuma97@gmail.com>
Subject: Re: [PATCH net-next] net: arcnet: com20020-pci: fix support for
 2.5Mbit cards
Message-ID: <aY3rhuzCG-SdRrC2@horms.kernel.org>
References: <20260205065113.33547-1-enelsonmoore@gmail.com>
 <aYoAMrEVDNydXQdq@horms.kernel.org>
 <CADkSEUjdGka7vpZEKrF0a0R1S=S+bzjCpDRidF5d93_H7b2qtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADkSEUjdGka7vpZEKrF0a0R1S=S+bzjCpDRidF5d93_H7b2qtw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215973-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D7B1312EC1A
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 01:58:38PM -0800, Ethan Nelson-Moore wrote:
> Hi, Simon,
> 
> On Mon, Feb 9, 2026 at 7:41 AM Simon Horman <horms@kernel.org> wrote:
> > I do wonder if this should be targeted at net rather than net-next.
> Should I send a new version redone against net, or will this be taken
> care of by a maintainer?

I'm unsure.
But at this point - a few days have past - I'd lean towards reposting for net.

