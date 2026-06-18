Return-Path: <stable+bounces-267074-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A2LBFgS6M2oZFgYAu9opvQ
	(envelope-from <stable+bounces-267074-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 11:27:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4A069EDB4
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 11:27:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YSwp5csZ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267074-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267074-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EFAD30E0D57
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 09:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2F43D47B5;
	Thu, 18 Jun 2026 09:22:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCA63C5DBA;
	Thu, 18 Jun 2026 09:22:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774525; cv=none; b=ggQLHl3Xb56dr2/miZjuMJ2lN9lhLgawPxPehao7IQG+MKvBO+XJ8cQCMfISA0V8HegSHcX1KMwhTdQLVLcSecSy2dPmOR28MghvRB/FvjXyEhVWb4WqyzhZLtLLdYF1cG33d8rQk3Z2waCwUOMh4+ULNyZOCE/mhmJcd3SCs2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774525; c=relaxed/simple;
	bh=MbPWjRUf/gRHlRilzCV7APbvVzO7gSq3myyNmmtRYOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jd7Jva+4nEeQcFeAriIfVZWk5x8dnt2dHgXMOA7LuR4rG06nQ1ehSeKZ3FXn3YHxUzB0vLjVWDZJKZux8ITnwfDnF1+ePZDraUN55eSZ130HH/lRFhMp1rUbGBP4dY1TjPiOoB3/VMFSUXjwyMmOVpxvrqAL6eU35+/Rniv/RlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSwp5csZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE001F00A3A;
	Thu, 18 Jun 2026 09:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781774524;
	bh=fa1YYlGkltIgjHpqfoqi7k9iBQEAbJ8vTgNEroVuY9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YSwp5csZN+Y3+vwnpxpSHCoq2gC39DvV77NePEnEfzCcHL5be79JeYXXCpyupWgAi
	 +3qx2AcqReAT85/HxxNrF4B6upV9Vgo/RnUsEYaz4cz9WAkn1wGagC9tlMEAMsUcQ5
	 dCvPc8xFygRYqxXYyJjgiajWboF2LCmANKUu/7z/DL7UCN8omkperqkIqVu2EJevfo
	 sC+kHFBdn6hPjrtmZO+eyQBkxWGrW9ZaZ0qObBt/kXpKf2n99Z30fR+gN0dCdF4Y0v
	 DV3TMvIRNOXMWz5dfQ2zCBAnLSwHhDm6oWk7SP2tgC6s+f/EQ4fHADJH5PInYah7l2
	 gyHtiomXiCfCA==
Date: Thu, 18 Jun 2026 10:21:59 +0100
From: Simon Horman <horms@kernel.org>
To: Ross Porter <ross.porter@canonical.com>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Edoardo Canepa <edoardo.canepa@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Oscar Maes <oscmaes92@gmail.com>,
	Brett A C Sheffield <bacs@librecast.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] selftests: net: fix file owner for
 broadcast_ether_dst test
Message-ID: <20260618092159.GI827683@horms.kernel.org>
References: <20260610062230.71573-1-ross.porter@canonical.com>
 <20260610062230.71573-2-ross.porter@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610062230.71573-2-ross.porter@canonical.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267074-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ross.porter@canonical.com,m:linux-kselftest@vger.kernel.org,m:netdev@vger.kernel.org,m:stable@vger.kernel.org,m:edoardo.canepa@canonical.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:oscmaes92@gmail.com,m:bacs@librecast.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,canonical.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,librecast.net];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,vger.kernel.org:from_smtp,canonical.com:email,launchpad.net:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA4A069EDB4

On Wed, Jun 10, 2026 at 06:22:29PM +1200, Ross Porter wrote:
> Ensure the output file is always owned by root (even if tcpdump was 
> compiled with `--with-user`), by passing the `-Z root` argument when 
> invoking it.

Hi Ross,

I think that the motivation, described in the cover letter,
belongs here so it can be found more easily using git..

Also, as there is only one patch in the series, the cover letter
could be dropped.

And lastly, this should be targeted at net as it's a but fix
for code present there.

Subject: [PATCH net] ...

For more information on the Networking development workflow see
https://docs.kernel.org/process/maintainer-netdev.html

> 
> Cc: stable@vger.kernel.org
> Reported-by: Edoardo Canepa <edoardo.canepa@canonical.com>
> Closes: https://bugs.launchpad.net/ubuntu-kernel-tests/+bug/2129815
> Fixes: bf59028ea8d4 ("selftests: net: add test for destination in broadcast packets")
> Suggested-by: Edoardo Canepa <edoardo.canepa@canonical.com>
> Tested-by: Ross Porter <ross.porter@canonical.com>
> Signed-off-by: Ross Porter <ross.porter@canonical.com>

...

-- 
pw-bot: changes-requested

