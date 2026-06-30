Return-Path: <stable+bounces-269850-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LF/oFGMYQ2pyQAoAu9opvQ
	(envelope-from <stable+bounces-269850-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 03:14:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D83276DF8B4
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 03:14:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hKBIQYHy;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269850-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269850-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB4493040C40
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 01:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881F224679C;
	Tue, 30 Jun 2026 01:12:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C9B23FC41;
	Tue, 30 Jun 2026 01:12:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782781950; cv=none; b=N+WWY5JMumriqQIUjol8yoPv7d97EcoiehbLXmL0f28sJRsV1SFQbj0qJL9Jt7mO9MWbRJ1THDI4EmE/OqRlUztBBlhLDnl+XQlFQx+6ThN9zH/LpkxGzh6qhOssOAUBWEo7jMvQjRQRbwAX2SLODULvEFSkdBpmMz7JkDZ2D8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782781950; c=relaxed/simple;
	bh=ZDJsIauFNP4VSQlcawu7htBZBnjncVxamZAfeCrOtrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEQV/kmFb8adIYM5AAOET2loZN2ycXAEqvtPJyRCDqzvCXYdc44mj0dtU7ILF4xnvhTidzT+inWw68fdfpKa1dfp+5vuK9CYgie/mWJlTH+aC+y/0TKsSwxLSIridnCLC3fd+7ZLWj4W/gVs344Y2eYsHwkOWzU34dt3LNbrEuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKBIQYHy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8E51F000E9;
	Tue, 30 Jun 2026 01:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782781949;
	bh=f4KG/X8MV7QZrgKJunvYu/eMHjk3xLJnP6aj383Xw5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hKBIQYHy9ClqCroiLhVPj/iYZ9jX+pmLL3fkbu4rZTRY36gntSHQrWj8lZiI+Rvif
	 5Fz3prlNEe6Wr6dnpFtVMFjuDzUcQSXAftL4fdj8P21ooE08n2vQTmX5pRuzHfeL1W
	 XwmNSJfJICCCktG0kna7FsdFKktj22DuRF4rXEEMfC44Z8bSGQAbNF/j2A/dohrn23
	 ZdItA1jPk0MU9gqGaERIDOQyr4L3z3m/h/twdJaJvGEncmMpSDbS8PqIKdxVcLbMob
	 wpYrjAq+eTSjAQcjE/6VfzTIZd86aUFMimvUlbO3FJSDMY5yhSyfI+/usYW8ryxL8z
	 sY7d2RY7WLpyQ==
Date: Mon, 29 Jun 2026 18:12:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, m-malladi@ti.com, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: fix XDP_TX from the
 AF_XDP zero-copy RX path
Message-ID: <20260629181227.4418d953@kernel.org>
In-Reply-To: <20260625063121.24746-1-devnexen@gmail.com>
References: <20260625063121.24746-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-269850-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:devnexen@gmail.com,m:danishanwar@ti.com,m:rogerq@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:m-malladi@ti.com,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:ast@kernel.org,m:daniel@iogearbox.net,m:bpf@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[ti.com,kernel.org,lunn.ch,vger.kernel.org,davemloft.net,google.com,redhat.com,gmail.com,fomichev.me,iogearbox.net,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D83276DF8B4

On Thu, 25 Jun 2026 07:31:21 +0100 David Carlier wrote:
> +	PRUETH_SWDATA_XDPF_TX,

Sorry for the naming nit on v3 but XDPF_TX is ambiguous, I spent
a bunch of time digging thru the driver. It should really be called
XDPF_LOCAL or some such to indicate that the frame originates locally.
XDPF_TX is ambiguous.
-- 
pw-bot: cr

