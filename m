Return-Path: <stable+bounces-262727-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Cq05Ora/KmqpwAMAu9opvQ
	(envelope-from <stable+bounces-262727-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 16:01:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7D467285E
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 16:01:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QVl2JW8b;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262727-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-262727-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 067AE300A269
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 14:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614053AD50F;
	Thu, 11 Jun 2026 14:01:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3331B3EDE61;
	Thu, 11 Jun 2026 14:01:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781186474; cv=none; b=c/oPEZJN1qu8SycUrS+BekUPmopY09kG64oDGUChFaccA4eJ1PCs87pm4SHP1HtpTtVbvYOLeDm4tMmWt0jb70/KNR00/VcWAEiA2v8KwPV1PU3zWwao7WTYuUUgPlEZu7AgptAvNoITdjF292+JwJzq1h98bVq8a2EGD1ACc88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781186474; c=relaxed/simple;
	bh=TVWPiGxrSgezWlwbj60FVQeK7nFLbzLjvGXBQ5/tZlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZ2tXA8SYAyMjNlsPmjj8IYJYUdFzMoe+RlHXLCSEQ5CcJLJkIMvUeRqkCGEhVwn8o9v19+CGw7DS3NGAT/m1VxLo3iIlUWqb+DsC0VJNko3glggCBhRI41U741Hb26EbDVHl6ZhgyR7xYgM6CTC1q4RfFeM3XrWL9Tx7uMMrr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVl2JW8b; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF941F00893;
	Thu, 11 Jun 2026 14:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781186473;
	bh=M5bIcWhv/OWdGZjF2z3Jaxz5u3oE53odG++5eqZWP9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QVl2JW8bAclirz3a1EYtL3eblzB/KT7URc+EG/pG3GhHuMfuiyqM+xogm1KIRTcMF
	 MI5eBiGdHSGJDOHXvGMk1fRzRaTaJ8kl2gPUVwEH6q+SL9g3anFWpLdD+eZai3KvKl
	 4vPvKIMxEdi0skJvZnqlnmIfr/rptL2WExpm6byiTYKNFdC0e6Pnre6r3O4SXzB9g9
	 GYR0gAE0pf/5OrDVd69LpE2WkW9Fbwl51V3dSpSirJncNMVRoudB9xtOMye400L4ph
	 I2V25P6MFmEI/WrcZYs/OOwTtHHxAmOeFybuUAAFS0TVhhP6A30keNaxjCESo3pMzO
	 +PY+kHKwSBZdA==
Date: Thu, 11 Jun 2026 15:01:08 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: olteanv@gmail.com, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: sja1105: fix refcount leak in
 sja1105_setup_tc_taprio()
Message-ID: <20260611140108.GR3920875@horms.kernel.org>
References: <20260609074002.204113-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609074002.204113-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262727-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:olteanv@gmail.com,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[sashiko.dev:query timed out];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,iscas.ac.cn:email,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A7D467285E

On Tue, Jun 09, 2026 at 07:40:02AM +0000, Wentao Liang wrote:
> In sja1105_setup_tc_taprio(), taprio_offload_get() acquires a
> reference on the new offload and stores it in
> tas_data->offload[port]. If sja1105_init_scheduling() or
> sja1105_static_config_reload() later fails, the function returns
> without releasing the reference via taprio_offload_free(). The
> stored pointer is thus leaked, as the driver will not clean it up
> unless a subsequent TAPRIO_CMD_DESTROY is received, which may
> never happen.
> 
> Fix the leak by calling taprio_offload_free() and resetting
> tas_data->offload[port] to NULL on both error paths.
> 
> Cc: stable@vger.kernel.org
> Fixes: 317ab5b86c8e ("net: dsa: sja1105: Configure the Time-Aware Scheduler via tc-taprio offload")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Hi Wentao,

There is AI-generated review of this patch-set available on both
https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/
I would appreciate it if you could look over that with a view
to addressing any issues that directly affect this patch.

