Return-Path: <stable+bounces-267601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oSVGJ3jJOGpniAcAu9opvQ
	(envelope-from <stable+bounces-267601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 07:34:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C326ACCC2
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 07:34:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=UpgvY5+e;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267601-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267601-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 964BB302AD1A
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 05:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21152358D27;
	Mon, 22 Jun 2026 05:33:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D3935B137;
	Mon, 22 Jun 2026 05:33:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106392; cv=none; b=nm4D5lAqKKlZVIFTY/+xu5e/6JlydUztRcuUs6vd17bK1loHEaxVOiOZusNgqRm7oLu/Gg3L09U6SdVtfe31dtBx5gC68+sYKGPcnX9HMKVtKoRtrrvokO/yN42OaoKG4FLY7FwfmvZSE/lxJ0I//0H/pe+UPdtn7Ux9HAWfKj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106392; c=relaxed/simple;
	bh=rNoK9fF43K4ybem9tlRR6n5CVAlpePxuA56MoHLiusU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bShOt4yRAUvhckBmfbQ99fAHFNyT4rCDAlzp6zaIpPEactqGaj3bMBPsw8313Vs1nmuVijwVJ+Fd/XJAORW5IYzhHa6KX3Uw07d4XD3w+Roz9gupv8ZoP8mHPYaCXB0nlolJd3RvMaI9pYObtXrzvn0q0rhOnJEthqTuXrwIR+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UpgvY5+e; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3A01F000E9;
	Mon, 22 Jun 2026 05:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782106391;
	bh=FnU02T+zKMErLH/eeB9bLxYz2Tm1NphmIy9sh7U8WKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UpgvY5+e1fDZ/6fEw0Pnebokaf9evWPUmG9hAkFLD8oRdHC5Vc1yUG7FSH47XKRg8
	 5hiODGo9hVgAbfg1IHC2aWIbKJVrgomL3KNQa9NJWeaKLd0+f8WqkEV/U3AeAtM4Wo
	 9cqHrlYoSV7lBnyN0NJrFpJBH3KsuxhOpVV+A7DY=
Date: Mon, 22 Jun 2026 07:32:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Some 7.1-post fixes that might be worth picking up rather sooner
 than later
Message-ID: <2026062236-ludicrous-detached-6e20@gregkh>
References: <91281f28-eccf-4681-8f62-faaa8a3ba529@leemhuis.info>
 <2026061917-flinch-idealism-898f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026061917-flinch-idealism-898f@gregkh>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267601-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:regressions@leemhuis.info,m:sashal@kernel.org,m:regressions@lists.linux.dev,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21C326ACCC2

On Fri, Jun 19, 2026 at 11:43:41AM +0200, Greg KH wrote:
> On Fri, Jun 19, 2026 at 08:04:35AM +0200, Thorsten Leemhuis wrote:
> > Hi Stable Team! From the regressions point I think it might be nice to
> > pick up the following changes for the next round of stable updates (e.g.
> > 7.1.2), as they seem to fix regressions I've seen multiple people report
> > with 7.1:
> > 
> > * 426e5846eba75f ("HID: Input: Add battery list cleanup with devm action")
> > * 12f58a6caad3be ("drm/amd/display: Fix Color Manager (3DLUT, Shaper,
> > Blend)") [v7.1-post]

This doesn't apply to 7.1.y, and would need a working backport.

thanks,

greg k-h

