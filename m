Return-Path: <stable+bounces-223019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNEmFxL4p2mtmwAAu9opvQ
	(envelope-from <stable+bounces-223019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 10:14:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E24961FD64B
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 10:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12761315FD43
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 09:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BC8394476;
	Wed,  4 Mar 2026 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vq1o+FMC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942BA38E13F;
	Wed,  4 Mar 2026 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772615326; cv=none; b=II7MqsJE4qCxQBJePsG05n3ScBzt/3tuH6OVBWNg5PJx2C4c5R/rczvqKVG1VNyPoLep7upaj6WIvxzFTzEP6V5mP1EQnpavsLV/n6TlWiXc1ZYDe7k5LeJO1zC3mdmwwuT9TIvrmP/ybM7q/syoIIhmHMNJmDNDziiaQFCmC8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772615326; c=relaxed/simple;
	bh=YTBzXEONIR/YGbi9i3V2CuKzSCBY8prKwQ6jRB0nMKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCPgYcgp850ddj+PMYpIPOt/j53LWp6XVXVQKgBMBn++YHIHNvcnclYrzouk2gBBhoT8PsQAr2B87ivN7QzMYPyJbm0TafetQkkniZJbK2b+H+Elllfkyi6ij57m49QwWG3QRK6AX7U7nGNxEk7pyAzOcZulntvG5f510V1TGng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vq1o+FMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F8AC19423;
	Wed,  4 Mar 2026 09:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772615326;
	bh=YTBzXEONIR/YGbi9i3V2CuKzSCBY8prKwQ6jRB0nMKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vq1o+FMC26MHJk2ckhspSUSnoqA9J4KtfFJJuajQ1k6Mn5aUKi2JDHOMGAJio49Fd
	 8nsCl9DsFCc/JThPKrrRgp7+KEIkmOr7eZavgjgv5NFwMPIJP4xIP+vA2dp+JNFqbA
	 88n3P+O23uyahBFrHPvbmbIH4FF1tGMZu5Sdep6k=
Date: Wed, 4 Mar 2026 10:08:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: stable@vger.kernel.org, broonie@kernel.org,
	alexander.stein@ew.tq-group.com, linux-sound@vger.kernel.org
Subject: Re: [PATCH stable] ASoC: fsl_xcvr: provide regmap names
Message-ID: <2026030422-snore-parsley-2501@gregkh>
References: <20260303132143.766078-1-festevam@gmail.com>
 <20260303132143.766078-2-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303132143.766078-2-festevam@gmail.com>
X-Rspamd-Queue-Id: E24961FD64B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223019-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 10:21:43AM -0300, Fabio Estevam wrote:
> From: Alexander Stein <alexander.stein@ew.tq-group.com>
> 
> commit 08fd332eeb88515af4f1892d91f6ef4ea7558b71 upstream.
> 
> This driver uses multiple regmaps, which will causes name conflicts
> in debugfs like:
>   debugfs: '30cc0000.xcvr' already exists in 'regmap'
> Fix this by adding a name for the non-core regmap configurations.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Link: https://patch.msgid.link/20251216084931.553328-1-alexander.stein@ew.tq-group.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  sound/soc/fsl/fsl_xcvr.c | 3 +++
>  1 file changed, 3 insertions(+)

What kernel tree(s) is this for?

