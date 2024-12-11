Return-Path: <stable+bounces-100639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C479ED0EC
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56EEC188229A
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652CD1DA633;
	Wed, 11 Dec 2024 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OT85b+bt"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C981D5CDD;
	Wed, 11 Dec 2024 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933516; cv=none; b=fNW2XwtzsXSt8vl1Y9YVuKczGDFS78Ac2VdkDW4ZDUWu9YDQnSCAk+bpcZCI1c5Dmfhpx8rbwCSe8bHd2XDPrvzDvx/FcapoRWkjjda1BTg4+MwKmAyiBbu84uDFhMuD1/aDfeKe/LVi4gUmM88LRlO6FJin8W4l5NhkAMg4RfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933516; c=relaxed/simple;
	bh=wJ5OqJBeGWWmdsTg8ym9xIvebDAVnS+p9nEVLIRJrxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jp+uLedB8oJhkHQVCI1xIAsNbjQLk6iedvZ+SfPT0GQjHvnCybY4GaRDOFKAMKhgO9qZYmq+mKBaPrcnwRR6MR0xVeAY/09Am/pLH55tgK+GOEvhP5X+StwFACXa2bWeaQmdPm9BpvWMho0/+fD8tUU39DCr5EHSdXLrrTthCgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OT85b+bt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SAnZ8YcNssD3ArYzWOAZV328GFxY+hCoZbW29XHAxwg=; b=OT85b+btxfKhjBTUI7TRpGfoY/
	VBXcKnHcHhi4lQKkyxkP+4JFJQsvw5L/gfyXot6Pu2jlJgbXV0sweGt82SDoCsF+aIFwQazY3c6Hx
	ZMAZRhm+pHyRhSJIdblGcjHGULJHVTWTt+l8NnczYwwDslyE4kmG0yKiB6Wf0mxNeLSg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tLPJM-0007FE-LU; Wed, 11 Dec 2024 17:11:40 +0100
Date: Wed, 11 Dec 2024 17:11:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Robert Hodaszi <robert.hodaszi@digi.com>
Cc: netdev@vger.kernel.org, vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
	alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: tag_ocelot_8021q: fix broken reception
Message-ID: <41a2686b-d549-40c5-9f6f-bad8f308b729@lunn.ch>
References: <20241211142932.1409538-1-robert.hodaszi@digi.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211142932.1409538-1-robert.hodaszi@digi.com>

On Wed, Dec 11, 2024 at 03:29:32PM +0100, Robert Hodaszi wrote:
> Commit dcfe7673787b4bfea2c213df443d312aa754757b ("net: dsa: tag_sja1105:
> absorb logic for not overwriting precise info into dsa_8021q_rcv()")
> added support to let the DSA switch driver set source_port and
> switch_id. tag_8021q's logic overrides the previously set source_port
> and switch_id only if they are marked as "invalid" (-1). sja1105 and
> vsc73xx drivers are doing that properly, but ocelot_8021q driver doesn't
> initialize those variables. That causes dsa_8021q_rcv() doesn't set
> them, and they remain unassigned.
> 
> Initialize them as invalid to so dsa_8021q_rcv() can return with the
> proper values.
> 
> Fixes: dcfe7673787b ("net: dsa: tag_sja1105: absorb logic for not overwriting precise info into dsa_8021q_rcv()")
> Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>

Hi Robert

The code is easy, processes are hard.

We ask that you put a version number in the subject

[PATCH v2 net] ....

That helps us keep track of the different versions of a patch.

Please wait 24 hours, and then post v3 with Vladimirs suggestions.

    Andrew

---
pw-bot: cr

