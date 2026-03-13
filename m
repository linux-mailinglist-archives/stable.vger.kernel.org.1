Return-Path: <stable+bounces-225301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE61BNcGtGnjfQAAu9opvQ
	(envelope-from <stable+bounces-225301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 13:45:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9880D283319
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 13:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E3FA302F68F
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 12:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2CC239085;
	Fri, 13 Mar 2026 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DVHPsaRA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36F5298991
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773405907; cv=none; b=Nacy6m9Lwd9JsYCu0OpP6C8j6Z6bgDLoJMNWzfQAAUyrz8UR1N6x0E0YcW1cl0ZRd61Gka79NbwxDbTm6GNBlno29lnRjwe3oBxH5rG+F+AxpJXULIrIH9gZmgz8TxjpknzlC+ZeX+LTOIwsHKFmE3Itf6NbLwSYqGW/HtsuAAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773405907; c=relaxed/simple;
	bh=YPUgM1oYyjHaELzyKFInr4XZsQ717NDAukTaozxNc7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ4As5ZibF2x606pqP5xBAVU9a8FWoEeUU69VQY2YDh+yCe6S1ChoDdyY+qXruiBW1aNS7FjuDW5YkYPTcNquOU3f55WpzcMxXP+4SJOV3iRq1edr9lenpBmz59dlkenVt3K3n4VOrowAV45cRdnTNGRglG7muaKnwn89LDWUmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DVHPsaRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61409C19421;
	Fri, 13 Mar 2026 12:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773405907;
	bh=YPUgM1oYyjHaELzyKFInr4XZsQ717NDAukTaozxNc7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DVHPsaRAJVFPZgXKk1Zrws6DEyWHV3h09eKdaJpFMku6YPgetLc2Ri+RA19jVwdSh
	 rysIZF6n245K21yX2HuoywsHu4y0YkwcF8YoTMiod5n8gYIaAPjoC5Lk9+arwZbkqk
	 RbxSsP0jNDmNN8K3IS7w1LCgD8wToQ+ehzmu0bW8=
Date: Fri, 13 Mar 2026 13:44:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Dumazet <edumazet@google.com>
Cc: linux-stable <stable@vger.kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: Re: Backport to 6.6 and 6.1
Message-ID: <2026031351-carve-crayon-4496@gregkh>
References: <CANn89iJzYON_QPGsgXii6r5tONLU+PepfP-b6J4MGguB979BQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJzYON_QPGsgXii6r5tONLU+PepfP-b6J4MGguB979BQA@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-225301-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 9880D283319
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 01:34:27PM +0100, Eric Dumazet wrote:
> Hi team
> 
> Would you be kind enough to backport the following patch to 6.6 and 6.1 ?
> 
> For some reason we missed that the issue was serious, no Fixes: tag at
> that time :/
> 
> It applies cleanly.
> 
> commit 795a7dfbc3d95e4c7c09569f319f026f8c7f5a9c
> Author: Menglong Dong <menglong8.dong@gmail.com>
> Date:   Fri Jan 26 12:05:19 2024 +0800
> 
>     net: tcp: accept old ack during closing
> 
> Thanks a lot !
> 
> Related : packetdrill test sent to net-next today:
> 
> https://lore.kernel.org/netdev/20260313115429.3365751-1-edumazet@google.com/T/#u
> 

Now queued up,t hanks.

greg k-h

