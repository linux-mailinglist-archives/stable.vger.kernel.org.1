Return-Path: <stable+bounces-236151-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED1PDnkP3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236151-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:44:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5AC3EE227
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1DE4300E5BD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BF53E1CFA;
	Mon, 13 Apr 2026 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3pphuZZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174513BF68E;
	Mon, 13 Apr 2026 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095087; cv=none; b=GOXgkXdH3NVr/Ou6sOkkKhDCn6qThlc4gDQsx6Y5AdRK8IjXe5eiDfa15GdMu3Gi9gqfz3p4JfGnkGAYFHzkd0JcLp5n9vzySgRn8sAzcyYWGrQF3NSBeTt2nKMfNFLACzvKm8/DE2XFbPvgEZbT1ok4HTAHGUlyzpAywcSo3Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095087; c=relaxed/simple;
	bh=h41+zKHDSlFppU8dT93Av6vuqeQYpMYo6zzpg+uma10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5KkkjOuhD0gm3+LDZHW80drF0DiIKU68UryTQu/qw+ln6iCHaLvpayjSEruRlAJCLIGxg+Gfs1fS5bkuS40n4JuP/6Z2q7BSuYz/jnmJLN6Ill2NwROZbdCVC59+2rNwbsir1fiz+CXV7CEz5mC36apeAtd/NAUHKMQVfVoYi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3pphuZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B17C2BCB4;
	Mon, 13 Apr 2026 15:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776095087;
	bh=h41+zKHDSlFppU8dT93Av6vuqeQYpMYo6zzpg+uma10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q3pphuZZRzTukYyn0eA67SLzaRGQhs0Nk03/JEepeovDGCePM+la3sJnGAHBN37LC
	 kjAmH/cBGBbj+zCd05N7msrabdci/ZaXvRF4bchs8su7AqtSp2A86yKQw7MxTWQIrX
	 uwoj5rRxhem0d8p5Rx12SAqFv14v9trUsj38ScKUspCCE//nuKe/Ho885VBW5dk/q3
	 JccpBKZ9uZ94uCRb4A4x+W/AcC9158L13zY3/X3jTTTzsVqUspEu2X6D2jgyr+9P/g
	 kjdfjfFJ0a7A5iMXu43QROJMIkg49LZSQWI5K+xitHO93DzV5iVxKkwiFH21LAFsyL
	 stobwcAh4mgIQ==
Date: Mon, 13 Apr 2026 08:44:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Marek Vasut <marex@nabladev.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Nicolai
 Buchwitz <nb@tipi-net.de>, Paolo Abeni <pabeni@redhat.com>, Ronald Wahl
 <ronald.wahl@raritan.com>, Yicong Hui <yiconghui@gmail.com>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [net,PATCH v2] net: ks8851: Reinstate disabling of BHs around
 IRQ handler
Message-ID: <20260413084445.59fe28d6@kernel.org>
In-Reply-To: <20260413125744.TVKkZcEK@linutronix.de>
References: <20260408162535.98108-1-marex@nabladev.com>
	<20260412090141.21bf1534@kernel.org>
	<2558832d-c821-436d-898d-b708c5e0a228@nabladev.com>
	<20260412105125.48f0c58f@kernel.org>
	<20260413125744.TVKkZcEK@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236151-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nabladev.com,vger.kernel.org,davemloft.net,lunn.ch,google.com,tipi-net.de,redhat.com,raritan.com,gmail.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A5AC3EE227
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 14:57:44 +0200 Sebastian Andrzej Siewior wrote:
> On 2026-04-12 10:51:25 [-0700], Jakub Kicinski wrote:
> > > Does the backtrace make the problem clearer, with the annotation abov=
e ? =20
> >=20
> > Sebastian, do you have any recommendation here? tl;dr is that the drive=
r does =20
> =E2=80=A6
>=20
> What about this:

Thanks for taking a look (according to you auto-reply immediately after
a vacation ;))

TBH changing the driver feels like a workaround / invitation for a
whack-a-mole game. I'd prefer to fix the skb allocation.
Is there any way we can check if any locks which were _irq() on non-RT
are held?

