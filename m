Return-Path: <stable+bounces-216014-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGBgKZWQjmktDAEAu9opvQ
	(envelope-from <stable+bounces-216014-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 03:46:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F5613272F
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 03:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0BD230BF7A3
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 02:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3AC22F767;
	Fri, 13 Feb 2026 02:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0kICvzj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0C322B8B6;
	Fri, 13 Feb 2026 02:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770950755; cv=none; b=oASHRcUU3yQ5zUD/3DDaQLlxLwuAr/F9IZOjKGnb9tuI1EY2oK/qcF4ZsJwkORuondKLAFsHQF9dYJ8Ck8E1+yXn/CxURY3Wg/TfXuwshBmGWwosk7lzv6Qxg3aBKxfcn9ZkszeThUD8QwN/iVlPjt1IJ8e6j6Jwy/mRfguPIkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770950755; c=relaxed/simple;
	bh=9wTWXBieVtbtWKd0bQ+RIS2MegBR8vNVZWpOsI4mr6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Co45GaqHFEL0Vo2UD+XkuUIyjFTMqdYriHrdZetAniRXbAgBk1/TZd04wLp18ZjcgoH6XKqj65RF63kaxThIgbbySvHiDOdGM/AZHGocd8BOrFyGq7lqIsYWGJxKWgnKp2/PVcf8BPU6r4UlLKxsug6o1qtTw0gHOjuQmW/WC9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0kICvzj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50038C2BC86;
	Fri, 13 Feb 2026 02:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770950754;
	bh=9wTWXBieVtbtWKd0bQ+RIS2MegBR8vNVZWpOsI4mr6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z0kICvzjjVS7/wlsaQhOS/F7Vp6wS3ejidP9IZn5gjQ+546qhfFu6+k175lqt/2g9
	 0YySo0ok+qnmsH+50OqMjyXeI7GZvee/Ep0YiMIo+iidLGPNKgnF1TLGYj5bPwQqxp
	 Uzisn6NB5Bzu/wBAh1gWd8dt2t9jIw2FLiC0/5KTPWk6kG1rUUp1w8Jv4ZzngbFS48
	 iK0fUAU/Dgwo7q4OAvJ9BvASVBN1UHLYQBMoB2A9Nufn2aDKxyf9SZIiQnC675FTnD
	 pvSsOje/xzMOhXy6B4b2IV/2aRNUtZz2jEJcdtInr3OMO9YwFDVfcPMn0uuZsJvIGv
	 Ke3QKIuvlcQ6A==
Date: Thu, 12 Feb 2026 18:45:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Michael Grzeschik <m.grzeschik@pengutronix.de>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Zheyu Ma
 <zheyuma97@gmail.com>
Subject: Re: [PATCH v2] net: arcnet: com20020-pci: fix support for 2.5Mbit
 cards
Message-ID: <20260212184553.2dd00e45@kernel.org>
In-Reply-To: <20260210020012.11819-1-enelsonmoore@gmail.com>
References: <20260210020012.11819-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216014-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,pengutronix.de,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3F5613272F
X-Rspamd-Action: no action

On Mon,  9 Feb 2026 18:00:12 -0800 Ethan Nelson-Moore wrote:
> Commit 8c14f9c70327 ("ARCNET: add com20020 PCI IDs with metadata")
> converted the com20020-pci driver to use a card info structure instead
> of a single flag mask in driver_data. However, it failed to take into
> account that in the original code, driver_data of 0 indicates a card
> with no special flags, not a card that should not have any card info
> structure. This introduced a null pointer dereference when cards with
> no flags were probed.
> 
> Commit bd6f1fd5d33d ("net: arcnet: com20020: Fix null-ptr-deref in
> com20020pci_probe()") then papered over this issue by rejecting cards
> with no driver_data instead of resolving the problem at its source.
> 
> Revert the incorrect fix and fix the original issue by introducing a
> new card info structure for 2.5Mbit cards that does not set any flags.

Not sure this is enough, especially that you remove the null check.
IIUC user may add an ID via sysfs and that one will not have a driver
data. Why not catch the 0 driver data and assign card_info_2p5mbit as 
a default?
-- 
pw-bot: cr

