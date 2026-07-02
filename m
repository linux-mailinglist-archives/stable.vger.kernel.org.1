Return-Path: <stable+bounces-271541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CODeGwKwRmqRbgsAu9opvQ
	(envelope-from <stable+bounces-271541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 20:37:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 020046FC28C
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 20:37:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mareichelt.com header.s=202107 header.b=vTCha7Kk;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271541-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-271541-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mareichelt.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FF66303474B
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 18:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCAB353A66;
	Thu,  2 Jul 2026 18:37:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B03F346A02;
	Thu,  2 Jul 2026 18:37:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783017429; cv=none; b=flecd4xgdyYTTUKFtyeIsyOzyOEwovcBOjnIJ43Fv2lvCf8AaLWZnbt4zZL3E4IndZ4XnkXBC6UOiGFNWyISb+8Qi2WoQytrO+3pzl3wDbD3KReCK9SvVlSLQKFFQYQ5o2s6lUjrWP0bEjRGVDL5aMcu8Tdp29nwzV7RDfbzgzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783017429; c=relaxed/simple;
	bh=WOXCFsPAf+RefC9MBykYEMS9Isd99Or2XKYIGMnrl10=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZx7YMpEBEO7jIRi7oiI8ZLEUZQvmMsRGCTXeMkbGqFCqk/hcQNO5aqN72rRIyGGttIG3qhgkAdmiB2YhufX93ag7c3E+1HOEmK6w26afH3nYxyRxgQPzTtvTVx+OTXlHfH9xuqs1sNYx2L858lGb2ppt/N0HIntuZ5SrXHBzWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=vTCha7Kk; arc=none smtp.client-ip=91.227.220.155
Date: Thu, 2 Jul 2026 20:33:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mareichelt.com;
	s=202107; t=1783017209;
	bh=VidOYyXo6nIePnjujXp74XhnEt6pZoJ7yofkmtd7r4Y=;
	h=Date:From:To:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:date:
	 author:from:to:subject:message-id:in-reply-to:references:
	 mail-followup-to:openpgp:mime-version:content-type:
	 content-transfer-encoding:author:from:subject:date:to:cc:
	 resent-author:resent-date:resent-from:resent-sender:resent-to:
	 resent-cc:resent-reply-to:resent-message-id:in-reply-to:references:
	 mime-version:content-type:content-transfer-encoding:
	 content-disposition:content-id:content-description:message-id:
	 mail-followup-to:openpgp;
	b=vTCha7KkSbdePmFfeWrLC1sgK81+XlfA8lh8TkaPtz4mzDAS7U64bp5ObJP/UMLc3
	 0wVC1uWOgFIQTQguKQwPx7tMKgf51x3SZ9xp+HCmyl0vuqNub6MMUoNpJuBZ3i3Pjg
	 hdkeNSmU0+syznB0TIpyMni6iN4SFHpEmdr2y72WjqHOiCo8XHhJmpkJtPqeX7tMeM
	 P3qRwZzo/OGyt6CNQhZwGvqRV9RiLBFZlrAM+gkhKGuOc92FQEwCIzdzfbTV/jJ9c9
	 DmGmsTq57O/QhIFAP1u1ztAStaA+8X9/IIiAE2vNGXmcqnrqHQ0CLerqZK+EMkYruR
	 HA8USiPmHuvog==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7.1 000/120] 7.1.3-rc1 review
Message-ID: <20260702183328.GC27532@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260702155112.964534952@linuxfoundation.org>
 <0585b5ab-f9a1-4922-b2f4-167d0402758c@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0585b5ab-f9a1-4922-b2f4-167d0402758c@linuxfoundation.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mareichelt.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mareichelt.com:s=202107];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271541-lists,stable=lfdr.de,2023];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lkt@mareichelt.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[mareichelt.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkt@mareichelt.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 020046FC28C

* Shuah Khan <skhan@linuxfoundation.org> wrote:

> > https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.3-rc1.gz
> I am seeing 404 on this link. Maybe I will it more time for it to show up on
> kernel.org
> 
> Same with 6.18 link - haven't tried the others.

the problem seems to be that there is no kernel dir present at
https://www.kernel.org/pub/linux/


