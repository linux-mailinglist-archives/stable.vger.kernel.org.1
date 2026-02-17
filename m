Return-Path: <stable+bounces-216775-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEiwOMlDlGkgBwIAu9opvQ
	(envelope-from <stable+bounces-216775-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 11:32:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1798814AE11
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 11:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD1A83004408
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 10:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C9D325727;
	Tue, 17 Feb 2026 10:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VOWVnnv0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C6123BF9F;
	Tue, 17 Feb 2026 10:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771324356; cv=none; b=nmMyqKraTpn1VT2L5DvT2wGwvzzLnQ/p038IJXSKPcGDJDi4A9iWGS9Zkm4RnJxg4XZ+VaHUbDolfwHqP3U3TdawiPWUFJ8oGD/nezAMAugUp1Zrv7ltWN8tz+snXCd2RfbwGf8i56+IoRWuWfuqchFIwLqNaELB8v7Rvn66VBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771324356; c=relaxed/simple;
	bh=EU+F3qBEfwa2qi2OJwmfpHEKvticwtw+Y9NIdZ3pMr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IavXp4j9gr/+3RkB59iSEzoyok3LHDLyxorokHUOA4hCMqyRPleI7tvWrs9TRK+MnCSrUtkwpdd7youYcWubfechGDCn44kCbpZdcm8SFOevuhDc60CLRW059TBL81fjZ+n0cvr7zuQ5+9RNHKX/gcql8oZuE6EGRhFfZZi2Xn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VOWVnnv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FC2C4CEF7;
	Tue, 17 Feb 2026 10:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771324356;
	bh=EU+F3qBEfwa2qi2OJwmfpHEKvticwtw+Y9NIdZ3pMr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VOWVnnv0/vR1b2OMZjXz5cRXcrLIPYXZ/Fqav7h70L/eCm6VBeLMYQV5vNmHCABRY
	 si58s7gzJHvwM8HHTMw0R5WPgONrQTXLuAe7hO6wBX8N0CZbpX1XL0hj6V7TTbGKRA
	 9m7+XgisfGN7I3xv9q8DcyH/Eaoq9Ka/tTw4m1kc=
Date: Tue, 17 Feb 2026 11:32:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Evans Jahja <evansjahja13@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>,
	Denis Gessert <denisgessert@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [REGRESSION] mt8183-kukui: dts: changes in dts caused display to
 no longer initialize - Was: Re: mt8183-kukui: drm/mediatek: dts: Invalid
 display hw pipeline when probing mediatek-drm
Message-ID: <2026021726-decibel-bootie-39ba@gregkh>
References: <CAFLVeg9hwH3PbKu5rPWZWqq6yz5mRRoB9oqxDkxNRdEDLGbVBw@mail.gmail.com>
 <CAFLVeg_soeYV4tOYKMo6TMYOtuWWU4TFCjUTxUrVEyGcRwMz7A@mail.gmail.com>
 <df6fcd73-fe0a-42fc-97ce-7e458c340553@leemhuis.info>
 <CAFLVeg-qeWu4ntgyqotsgjogPEyhqrMGG=UDWuZe+-D3K8YPTA@mail.gmail.com>
 <908f3c03-a8b0-4535-9cfa-294c6ade8152@collabora.com>
 <96e7f0fc-65f4-4613-b556-3a2d869dabb4@leemhuis.info>
 <86e2d0f9-5c25-4cce-b4a8-68fb569f987d@collabora.com>
 <6fce0406-1515-4cf8-afdf-24217148d1c8@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fce0406-1515-4cf8-afdf-24217148d1c8@leemhuis.info>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216775-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,lists.infradead.org,lists.linux.dev,abscue.de,collabora.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1798814AE11
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 09:18:00AM +0100, Thorsten Leemhuis wrote:
> On 2/16/26 11:46, AngeloGioacchino Del Regno wrote:
> > Il 13/02/26 10:27, Thorsten Leemhuis ha scritto:
> >> On 2/9/26 12:42, AngeloGioacchino Del Regno wrote:
> >>> Il 06/02/26 17:58, Denis Gessert ha scritto:
> >>>> Thanks for the quick response. I compiled 6.18.9 with this patch
> >>>> (without reverting the previous commit) and it boots successfully.
> >>> Happy to see further confirmation that the patch that we both
> >>> mentioned is
> >>> actually fixing the issue.
> >> The big question remains: Now that this landed in mainline, should we as
> >> the stable team to pick this up for 6.18.y and 6.19.y to get it resolved
> >> there quickly? They might pick it up on their own due to the Fixes tag,
> >> but that is not guaranteed.
> > Yes, please, that'd be great.
> 
> Hi stable team! Could you please pick up be0b304eeb8c5f ("arm64: dts:
> mediatek: mt8183: Add missing endpoint IDs to display graph") [merged
> v6.19-post, committed by Angelo, who ACKed this request; see quote
> above] for 6.18.y and 6.19.y? It fixes a regression in e72d63fa0563
> ("arm64: dts: mediatek: mt8183: Migrate to display controller OF
> graph"). tia! Ciao, Thorsten

Now queued up, thanks.

greg k-h

