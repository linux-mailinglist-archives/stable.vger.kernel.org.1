Return-Path: <stable+bounces-216888-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FDaAtW3lGlmHQIAu9opvQ
	(envelope-from <stable+bounces-216888-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:47:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A04E614F545
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE331300B473
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 18:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5604374186;
	Tue, 17 Feb 2026 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izzlXLJi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89472374160
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771354066; cv=none; b=MoCNMZNkeXDGGCi0mmDfDT/3Y+4yG41FpLAjn5Nw8LE8U5x09LqiM99y9cY3StY1uZDIjo0+VdW6KxK1fNo9lqQuunGhq3ckr20LzO1D2cGd6oeVuusj1CV6Ig21hiEGthPNdQVzC0i+PG9wpuPsovyjVUH+DUdFZDCE7m5qWiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771354066; c=relaxed/simple;
	bh=mVN5aQAva8RLLXCXmjfdUnPLKVDEhsoR1jqKqCJXYEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMLg2xjjxYXWFBV3NPCeewg6Wk01eXolfpHXKTGpZcw4vqIZOZnxTdzqwlilh0MUZ1Xr5rRf9WtHltlXepFigfQeT4VMH/fdmi+OA3e8g2SWW17P0XIA4bNld6dAHzScHcJKVGoJsCLkYyVWuiIfFSp+qHsssuDACxey3nWJOXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izzlXLJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA93CC4CEF7;
	Tue, 17 Feb 2026 18:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771354066;
	bh=mVN5aQAva8RLLXCXmjfdUnPLKVDEhsoR1jqKqCJXYEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=izzlXLJiCitlvfctJFJMuwW7XWYFj2iV4coDbV6kN2bi9H2HWJ/iOIhOA+6P/YwLX
	 /rv6yHsqXlgbPogFK/M3oquWCxL6eWKtd3IP9ZqCQogk77KNHrGdxkhpKcOAg5EPyt
	 G570xGhwJLXREjyF13nO5xaqtkPcOyFoZ6ie0S9NdYE0FykCdbz2u2dF0ZGtbxXHe4
	 jzLboorboTfUcy+QgMHojuyG/yXprlafgsnigRb8aM8u3kzX+mJhYmXJBcQ9nPOZ9Y
	 vsDZQFWbs0/cuoNMHr2r7tGXLUex26W0mBoNl5F+5q/JwK51LMCHTjS8LRPYeVUtv2
	 8e8LLnuXkH+vw==
Date: Tue, 17 Feb 2026 13:47:44 -0500
From: Sasha Levin <sashal@kernel.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hostinger NOC <noc@hostinger.com>, stable <stable@vger.kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: Please apply commit 9990ddf47d41 ("net: tunnel: make
 skb_vlan_inet_prepare() return drop reasons") down to 6.1.y at least
Message-ID: <aZS30CAA7rPhx7h-@laps>
References: <177132401902.2893171.1371685164011289024@eldamar.lan>
 <2026021740-mom-remix-8103@gregkh>
 <aZSzfA3yFQxzj-N4@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aZSzfA3yFQxzj-N4@eldamar.lan>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216888-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linuxfoundation.org,hostinger.com,vger.kernel.org,gmail.com,kernel.org,davemloft.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A04E614F545
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 07:29:16PM +0100, Salvatore Bonaccorso wrote:
>Hi Greg,
>
>I'm sorry having wasted your time, I relayed the testing result, let
>me loop in the user which tested the fix:
>
>On Tue, Feb 17, 2026 at 11:57:25AM +0100, Greg Kroah-Hartman wrote:
>> On Tue, Feb 17, 2026 at 11:28:20AM +0100, Salvatore Bonaccorso wrote:
>> > Hi stable maintainers,
>> >
>> > 9990ddf47d41 ("net: tunnel: make skb_vlan_inet_prepare() return drop
>> > reasons") was alrady backported as well to 6.12.71 to address a
>> > regression when backporting 81c734dae203 ("ip6_tunnel: use
>> > skb_vlan_inet_prepare() in __ip6_tnl_rcv()") (this one was backported
>> > without the prequisite commit to 6.12.67, 6.6.122, 6.1.162, 5.15.199
>> > and 5.10.249).
>> >
>> > Can you pick please as well 9990ddf47d41 for the other stable series
>> > as needed? I can only give a confirmation that it works as exepcted
>> > for the 6.1.y series as per https://bugs.debian.org/1127823#36 .
>>
>> it does not apply to any of those older kernels, which is probably why
>> it didn't get added there.  I tried to do the backport myself, but the
>> changes to drivers/net/vxlan/vxlan_core.c doesn't make sense to me, so I
>> can't do it, sorry.
>>
>> Do you have a working backport anywhere?
>
>"Hostinger NOC" team, can you followup to the above? Can you provide a
>working backport down to the 6.1.y series to Greg?

I've queued up backports for 6.6 and 6.1. If you need anything older, please
send a backport :)

-- 
Thanks,
Sasha

