Return-Path: <stable+bounces-223458-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OANPG2G5rWk+6gEAu9opvQ
	(envelope-from <stable+bounces-223458-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 19:01:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A8D231821
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 19:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDDA73011773
	for <lists+stable@lfdr.de>; Sun,  8 Mar 2026 18:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89FD31D362;
	Sun,  8 Mar 2026 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dTMvt5zr"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ECD393DFD;
	Sun,  8 Mar 2026 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772992804; cv=none; b=uu63+p2/J5tIIX6BT/Z7937kSe8pKmqQjMXf4HvL+IutOYeXl4Q8OMr1NPyIw3/ns972QS6bBAT75UW/jNDMw5qSB1flO1QMgNneOdm8Xvq2Nqwlt6Uh5jDJ67v7yZ4aav+dclYFPINjNodTV8IHWqeCvC560Mrfqm1ez/L7nhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772992804; c=relaxed/simple;
	bh=woG6B0/Edt9gQwKF22OCwrjWBOFo8sGZFZLQ6kxGX8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCQLUMb2kXesyvpdNmTJ0BGX82z9j2wXYZ3mXCz/2j3BetdYQBcJZWEv8j+tZ71a31FsUxblyPXcZgzpKGHdg29bF8Rf6LaG0irMJfXp2Mx3bE+AWWhBj3bvcf/4kf56vTSewSSX4lZBhvH9tXevrmSdJx752hcZbSrjeym6XVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dTMvt5zr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=COX7CpTb/27v5+RAJjpmWzEICJkLOwS/U54SdgdwvJ0=; b=dT
	Mvt5zreya8sYFTIdBVn+u2Cr+TZpKI2sHjC2eOz50+u7Z9bcgWi9rBmOKKmEgNT9xNvbN2WV71V+Y
	MTg2bknSvJlEcZlhzC8/RD+LOfjFVJwRy0Suiwp0bqKJXu0GL9C9yJfORHH9scM7YznnM23vGIC03
	WMxQMzpeato1q7o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vzIPq-00Ajv8-GI; Sun, 08 Mar 2026 18:59:46 +0100
Date: Sun, 8 Mar 2026 18:59:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?5ZC05Yeh?= <12321260@zju.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	heiko@sntech.de, romain.perier@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, stable@vger.kernel.org
Subject: Re: Re: [PATCH] net: ethernet: arc: fix use-after-free in probe
 error path
Message-ID: <1bb942f0-d512-4834-bf01-49f9a9d7fd77@lunn.ch>
References: <20260304025303.145493-1-fanwu01@zju.edu.cn>
 <b6ac1471-e33a-41d3-9e67-e6463612f05b@lunn.ch>
 <54c76f66.7eea7.19ccca93975.Coremail.12321260@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54c76f66.7eea7.19ccca93975.Coremail.12321260@zju.edu.cn>
X-Rspamd-Queue-Id: 02A8D231821
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223458-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,lunn.ch,sntech.de,gmail.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, Mar 08, 2026 at 04:56:08PM +0800, 吴凡 wrote:
> You are right that normal device interrupt generation is enabled in arc_emac_open() via R_ENABLE, so we certainly don't expect regular RX/TX traffic interrupts during probe.
> 
> My main concern here is the lifetime ordering in the error path. arc_emac_probe() installs the IRQ handler via devm_request_irq(..., ndev), but if emac_rockchip_probe() fails later, it explicitly calls free_netdev(ndev) well before the devres cleanup routine runs.
> 
> In that specific gap, if an IRQ is somehow delivered—perhaps from a pending/latched line left by the firmware/bootloader, or other non-traffic anomalies—arc_emac_intr() will immediately dereference dev_id as a struct net_device *. Since ndev has already been manually freed, this results in a UAF.
> 
> So while I completely agree this isn't a normal pre-open traffic path, the mixed lifetime management (managed IRQ vs. manual netdev free) still creates a real race window.
> 
> Switching to devm_alloc_etherdev() puts both resources under devres management, permanently fixing this teardown ordering issue. I would be happy to send a v2 and reword the commit log to emphasize this as a potential race window and a hardening fix. Let me know what you think.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#clean-up-patches

  1.7.4. Clean-up patches¶

  Netdev discourages patches which perform simple clean-ups, which are
  not in the context of other work. For example:

  Addressing checkpatch.pl, and other trivial coding style warnings

  Addressing Local variable ordering issues

  Conversions to device-managed APIs (devm_ helpers)

  This is because it is felt that the churn that such changes produce
  comes at a greater cost than the value of such clean-ups.


Some percentage of devm_ conversation patches break drivers. We
Reviewers need to look at all such patches and try to detect such
breakage. In general, it is nor worth it. Hence we generally reject
patches like this.

This is however slightly different. It looks like this driver was
broken from the beginning. The race you point out has always been
there. That is something worth pointing out in the commit message.

But take a step back. Think about interrupt handling in general. Do
you think it is good practice to request interrupts before configuring
the hardware about what interrupts it will deliver?

If the driver wrote to R_ENABLE in probe, before requesting the
interrupt, enabled the needed interrupts in open, disabled the
interrupts in close, the different lifetimes would not matter.

So, for stable, please add code to put interrupts into a well known
state before requesting the interrupt. Please use the net tree, and
add a Fixes: tag.

You can submit this patch to net-next, but we might reject it, because
of the policy. If you are working on this driver, adding other
features, this patch is part of a bigger patchset, we are more likely
to accept it.

    Andrew

---
pw-bot: cr

