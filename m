Return-Path: <stable+bounces-266774-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fOdbK7GpMmqT3QUAu9opvQ
	(envelope-from <stable+bounces-266774-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:05:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D41969A66A
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:05:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=HVJN9GtG;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266774-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266774-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CCB1300B60E
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9304071FC;
	Wed, 17 Jun 2026 14:01:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7E838B149;
	Wed, 17 Jun 2026 14:01:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704875; cv=none; b=ZHYH/eQwinYXl5Zqd0JXPPgrEAcsoVoNi73YiwCLPB+QUMUJr5J5QWmsemp6oK/fJ7QnNNGrpLuUDMaBI6UwzTaU3DPTPHScyZPYYKlcO/aRr7fiIocMUKA+vPsBCkqoJmAEv8/3h0wWaQ77IhmAZtUmFWR1wCOyTDbwAz1knDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704875; c=relaxed/simple;
	bh=TIusgAdoSDza+x4r7JCqo0en5rY2AGlu+NtIOjX2TyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJHufcSoMXcMfTdNrfgbwbC10+J2+VmnLDa3lHtEyXjdMmsYuWlCfXhy2LTjLKITlfQFRsAV98YZ5pHTHJbT5ApGTEahjwAmJCRdEIOJ5Nj+rfqVpf2pNtZOUIQ6o0qv/29PCUnykLnlYkQ1RfjRSIu7CbmTx+NSB5Fe38Sdkpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HVJN9GtG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884891F000E9;
	Wed, 17 Jun 2026 14:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781704874;
	bh=dixPDattbyK6aGZAeEkXBvNOuSSv7cgGd6Gw3GLt8J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HVJN9GtGuti537H1wpbwqt3fB9eVSP4YcQxe3QaTEeFrrBPWVpHWS+3Tv6OXTl6lO
	 12S5DIZg7RveuVPyx3FATpDbyTZzVVg4DjgOq+Wuzc/m5Yr43UxhV5QD4tnNuaS1ta
	 69RTcT38ujPt9nPRrBwPzFH/gB8tTFYDUrsw82zg=
Date: Wed, 17 Jun 2026 19:30:06 +0530
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, stable@kernel.org,
	Sven Eckelmann <sven@narfation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 035/342] batman-adv: tp_meter: fix race condition in
 send error reporting
Message-ID: <2026061757-proximity-donator-6940@gregkh>
References: <20260616145048.348037099@linuxfoundation.org>
 <20260616145049.888286838@linuxfoundation.org>
 <f0be2ecfe2c27c1920a44b6f41d8db87611267f1.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0be2ecfe2c27c1920a44b6f41d8db87611267f1.camel@decadent.org.uk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ben@decadent.org.uk,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:sven@narfation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-266774-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid,narfation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D41969A66A

On Wed, Jun 17, 2026 at 11:01:11AM +0200, Ben Hutchings wrote:
> On Tue, 2026-06-16 at 20:25 +0530, Greg Kroah-Hartman wrote:
> > 5.10-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Sven Eckelmann <sven@narfation.org>
> > 
> > commit 71dce47f0758537fff78fddb5fb0d4632d29b29f upstream.
> [...]
> 
> No objection, but this is missing from the 5.15 and 6.1 queues.  (It was
> already applied to 6.6 and later.)

Good catch, I've queued both of these up now.

greg k-h

