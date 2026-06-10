Return-Path: <stable+bounces-262402-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GNoBBwjAKGohJAMAu9opvQ
	(envelope-from <stable+bounces-262402-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 03:38:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2931C665424
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 03:38:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XT37wAKu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262402-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-262402-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D03B302023D
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 01:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168F52D0C72;
	Wed, 10 Jun 2026 01:37:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E652BE033;
	Wed, 10 Jun 2026 01:37:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781055438; cv=none; b=of2CKfFT839YufwGGV9I5enYsacz/575dzJYHyV6pSIiUiv+3PmxvRGtQd3rtdYygqVU06D3M+F/w37y1Yc/UnG7jseG8ZRn27C2pYvvNxfuADGCrZsolWxCg9f/hK5/T1aBn8G/qvImFXMHVM90PbtA21hCN5HAE6RVejo74ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781055438; c=relaxed/simple;
	bh=m55+gK7sZpsKWCJFxXo8IOEm873NXSSucsIWi9IY8S0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXS2bXCJPj7KkJgpSzriZ7/4v6F1uyt6l7c6FzooTNwtemqXERqu1hOifIpTJWJulrKRF+h6A043Vjg/12m0D8gcl3Zh8PkLvvBd2dPtjHs77zRf+KEFb7Ly2csB+CVrUQMW1pkFLbybakCiWly15fRAIEQwysVKMgVtvJqhf+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XT37wAKu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608391F00893;
	Wed, 10 Jun 2026 01:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781055436;
	bh=oj+3BrWIohO8/102gzT0FtplulPKa4TBCTbQ5ava1A0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XT37wAKuDJUqM0FtoBBj1B9u7+lLwkWs/MTQNoggeRTqpCUa+WqL4F1k1PjQ0e3C9
	 Lxl6uRoOL04d6s/jaF/HcTLsdP6ERV6YAwkINUTgUa5oyhYrp8JGLfKtSKr5LcsDrD
	 22oW6bIfTBMyLfq5kSKbxZ0gUMelnnyVZWViM9U1qUHmKX/O5KqM06mRd8agSiwlKx
	 NVNz7AfRguZkG/U8ohRASXWhtmO/Az9NNMC9oOPKY6qNVaimbxqMDA00yQTn7kpAzv
	 R2IArgRniPbCsk2GZUy5rI3GFttPHF/22hvoWJSlgGQHHmPHtrl2J2f5Zdaa0MawDY
	 qqCRtw21KYTZQ==
Date: Tue, 9 Jun 2026 18:37:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Yuxiang Yang
 <yangyx22@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>, Xuewei Feng
 <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu
 <xuke@tsinghua.edu.cn>
Subject: Re: [PATCH net] vlan: prevent cross-netns promisc/allmulti
 propagation
Message-ID: <20260609183715.006f7bd4@kernel.org>
In-Reply-To: <20260607113529.98178-1-zhaoyz24@mails.tsinghua.edu.cn>
References: <20260607113529.98178-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262402-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2931C665424

On Sun,  7 Jun 2026 19:35:28 +0800 Yizhou Zhao wrote:
> vlan_dev_change_rx_flags() propagates IFF_PROMISC and IFF_ALLMULTI
> changes from a VLAN device to its real device. If the VLAN device has
> been moved to another network namespace, a user with CAP_NET_ADMIN in
> that namespace can toggle these flags on the VLAN device and change the
> promiscuity/allmulti counters on the real device in the original
> namespace.

I'd think that's expected. There's a higher chance this patch will
break someone's intentional setup than prevent an issue...

If anyone on the list disagrees please speak up
-- 
pw-bot: reject

