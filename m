Return-Path: <stable+bounces-216779-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA9mGZ9JlGmZCAIAu9opvQ
	(envelope-from <stable+bounces-216779-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 11:57:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B2214B0F6
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 11:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BCB13004619
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 10:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA13932B9AA;
	Tue, 17 Feb 2026 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wP3DFH/1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9DB2E0901
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771325849; cv=none; b=SIV2w7NQfoJSbW8tOUm7k9o2lqdgdVskV5AT1nrq7jtVCRKEDnojMSNHsjJnYMtWqg7RRe5iaHU5ioimqI6+nllPxen2TdBUwTMi/LspnWwAdICHDi+fd+FR6j0qGO2vMPrAgNiTx7AdHmkfsZxP6xL6SBeX2UK3zzVphshaZtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771325849; c=relaxed/simple;
	bh=jjfZwCSiSu5Yn2SNqEe4EjR6KKxygkF5Mg4PSpfXmnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfgDRRAGtC3kYUCLVhXIz/xaMq9JdLJyRSksre3WZwUf/0zd6Pfz+JciB6jYXrLIhTZL86ApSJfJZC1omjQntQx0MEPSdx4n3dRhZDVb7ug4KqPH7DXzBbu1ZAMPrENgltVw5NrzQj3BDDxmb3R9gjwhmmKMD8P3Qj+FyXug/sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wP3DFH/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E182C4CEF7;
	Tue, 17 Feb 2026 10:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771325849;
	bh=jjfZwCSiSu5Yn2SNqEe4EjR6KKxygkF5Mg4PSpfXmnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wP3DFH/134lAEvPH/1xLSK8DWrN8gVwV/nS8fXu/ax5jNAxDDeLvqyIRwqW2WS8Ww
	 AeIuR52iixkFe4ua0frg++V/VZKW5svSrz+YctGU035BP9QGBaFi4QOJui+ZG2sFp0
	 XtJhd4oV1C7Vwcx36Q5KE+lVhocJdTiR80WupIDQ=
Date: Tue, 17 Feb 2026 11:57:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: Please apply commit 9990ddf47d41 ("net: tunnel: make
 skb_vlan_inet_prepare() return drop reasons") down to 6.1.y at least
Message-ID: <2026021740-mom-remix-8103@gregkh>
References: <177132401902.2893171.1371685164011289024@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177132401902.2893171.1371685164011289024@eldamar.lan>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216779-lists,stable=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 90B2214B0F6
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 11:28:20AM +0100, Salvatore Bonaccorso wrote:
> Hi stable maintainers,
> 
> 9990ddf47d41 ("net: tunnel: make skb_vlan_inet_prepare() return drop
> reasons") was alrady backported as well to 6.12.71 to address a
> regression when backporting 81c734dae203 ("ip6_tunnel: use
> skb_vlan_inet_prepare() in __ip6_tnl_rcv()") (this one was backported
> without the prequisite commit to 6.12.67, 6.6.122, 6.1.162, 5.15.199
> and 5.10.249).
> 
> Can you pick please as well 9990ddf47d41 for the other stable series
> as needed? I can only give a confirmation that it works as exepcted
> for the 6.1.y series as per https://bugs.debian.org/1127823#36 .

it does not apply to any of those older kernels, which is probably why
it didn't get added there.  I tried to do the backport myself, but the
changes to drivers/net/vxlan/vxlan_core.c doesn't make sense to me, so I
can't do it, sorry.

Do you have a working backport anywhere?

thanks,

greg k-h

