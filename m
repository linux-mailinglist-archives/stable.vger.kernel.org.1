Return-Path: <stable+bounces-227399-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGOFDzWCvGm3zgIAu9opvQ
	(envelope-from <stable+bounces-227399-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 00:09:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A48312D3FB9
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 00:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 675503010270
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 23:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C73E3A758C;
	Thu, 19 Mar 2026 23:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0gfAE1Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01B3332635;
	Thu, 19 Mar 2026 23:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773961778; cv=none; b=A8yQzhDf/Hjdci3LApJmbaezyyaQflDOZdpus6wDwmxWfl/NroMYA8E7OVk4xEJ/k7HB2KhKI1eckYjEcdGpJPBeHCJxYdTDKVsDViONJ+uAzCUsUoVJC+yarYMQ4GwlqFJ4MEibf/nPpvQBET+62qlzhwUtVOHRowZ7m6wWxKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773961778; c=relaxed/simple;
	bh=+j3zMyv1kxkRvoPAXUMnrI8opptFe1VkIiWcvT9/Kjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQem2HfSraHhMrJs2k6spfl6a6+aQXco4aReRJUrBX04koIBT3oFKt8j9NZyNvQN+wCtBj0C6QwxSsF6/6I5Kaltec5SWDoEZm4WZ0oiYNDbMCzWu23pwzlML98q1edj+47ABFdtFhtFTPnhE4+uGQrYnzHMU9ZrHLXWZFfbeVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0gfAE1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6710C19424;
	Thu, 19 Mar 2026 23:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773961777;
	bh=+j3zMyv1kxkRvoPAXUMnrI8opptFe1VkIiWcvT9/Kjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P0gfAE1ZAXC9c867TKb2BGxFt6eYxeBZFxR7WyaQMtcGfpnCBy2eEUsk7tHP6eKPI
	 MW1Rp1+HWE2KgX8Gtq4v6m060MSF0dsjTNhUUtER0TVRRA8qei7+2tRgjF1ITUka92
	 gTrd7abcd1KJUlHy329Diby5edoHkIQCLndZy3av6UVndoqbsZC8YBOWwJHfuAgI6l
	 Ood2kUt+XCZDWeE19mSGJyxP/Xt10LcUlpB9iegiCOKlcdlPy6FQmEs7hBh1Wqf3Hg
	 Hd6gHrqL0KI6DR+y5V6fzksmSD8om5LR33MJc4//Z2C8WAZlrQK7RqtSPbYmgUuXL+
	 urWI6B4cKLGGw==
Date: Fri, 20 Mar 2026 00:09:32 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Carlos Song <carlos.song@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, Stefan Eichenberger <eichest@gmail.com>, 
	"o.rempel@pengutronix.de" <o.rempel@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"stefan.eichenberger@toradex.com" <stefan.eichenberger@toradex.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] i2c: imx: ensure no clock is generated after last
 read
Message-ID: <abyBxAvJcMshvB7G@zenone.zhora.eu>
References: <20260218150940.131354-1-eichest@gmail.com>
 <20260218150940.131354-3-eichest@gmail.com>
 <aZXoTGK_v3L4pc-E@lizhi-Precision-Tower-5810>
 <aZXq4gn4xhInQQlq@eichest-laptop>
 <aaamYByn9dZEIBWb@eichest-laptop>
 <aacECsJ6O8QjHsUa@lizhi-Precision-Tower-5810>
 <PAWPR04MB9960F0118ACC092BCAAB0142E87CA@PAWPR04MB9960.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAWPR04MB9960F0118ACC092BCAAB0142E87CA@PAWPR04MB9960.eurprd04.prod.outlook.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,pengutronix.de,toradex.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-227399-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andi.shyti@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A48312D3FB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Carlos,

> > > > > > When reading from the I2DR register, right after releasing the
> > > > > > bus by clearing MSTA and MTX, the I2C controller might still
> > > > > > generate an additional clock cycle which can cause devices to
> > > > > > misbehave. Ensure to
> > > > >
> > > > > Do you means SCL have additional toggle? You capture waveform?
> > > > >
> > > >
> > > > Yes exactly. We were able to capture the waveform when the issue
> > > > happens. It doesn't always happen though, it depends on how much
> > > > time passes between clearing MSTA and MTX and reading from I2DR.
> > > >
> > > > If you want to see the waveform, I uploaded it to our server:
> > > > https://share.toradex.com/dwnhcrl6b9toib6
> > > > You can see the additional clock at the right end, after "0x17 + NAK".
> > >
> > > Have you had a chance to look at the waveform? Do you have any
> > > concerns about the proposed solution?
> > 
> > I am fine. Add carlos, who did many work about I2C.
> > 
> > Frank
> 
> Hi, 
> 
> Just review this series, looks this series patch make this fix for the limitation[1] safer:
> "It must generate STOP before read I2DR to prevent controller from generating another clock cycle".
> 
> Previous patch[2] has done this to avoid the limitation. However according to the waveform, I2C controller still generated an additional clock cycle sometime.
> 
> The key of patch is ensure to read the last bytes after the bus is not busy anymore to avoid this another clock cycle.So these patches are fine to me also.
> 
> [1] 054b62d9f25c ("i2c: imx: fix the i2c bus hang issue when do repeat restart")
> [2] 5f5c2d4579ca ("i2c: imx: prevent rescheduling in non dma mode")

Sorry, I'm not understanding your point here. Are you suggesting
to change the Fixes tag to [1]?

Thanks,
Andi

