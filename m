Return-Path: <stable+bounces-262516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CVo2GCGBKWp6YAMAu9opvQ
	(envelope-from <stable+bounces-262516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 17:22:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B8366AAA3
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 17:22:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TtwsI9nw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262516-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262516-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FC8630A5E42
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 15:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509FD428464;
	Wed, 10 Jun 2026 15:14:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B24C416D1D;
	Wed, 10 Jun 2026 15:14:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104491; cv=none; b=fp+E5smqBdBXmBH2bFfaqgLul74G+iTIBthe+KoEGACEEWP8XCB+FbpUvH3BIIp8KH1NYeoPIen4RCP46fwE9Oh1LA7SqiqAPYypQD6/iqO4rlmrVqfKAWR24wGW07c5NJ7xumYSCaDaZt54mPaWg9XH641P+cIDh7zUUC2OBfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104491; c=relaxed/simple;
	bh=qujQ7F/3q/fn9IDdmZYMq+zpEgNokiXiIRhelNM3z4U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JUEoGpHUidVL/y3W6GJ642UNtRi/+gdA/01yAleXP+lGOIFrVtcu7lns+YWv6uAk+5PJQh39oB7nwtE3DRtNZlg+fbyxw+ouqkwOqSgaNTFq4hfT65vSTuDoZd/GnXSDOH2fxsc7cGu0ajXYCBClz54ALYBKU1E01d2nwJ/bPkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtwsI9nw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057711F00893;
	Wed, 10 Jun 2026 15:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781104489;
	bh=0L8Gq+UhfVf7Y/GmoFXGXIyxgBspF5hA+qM+Yf+c/+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TtwsI9nwxfkGT79klYybINZ8LOntEF3pmEDLaEdA6G1249kB9uWsTLplpw9BzYe5g
	 M0HjQUr3c1xVg+ZFkQ+mcX8Gw25UxnyNv/1e5f+fmLIM6inPqTppVKToBIXFK8KJwn
	 WZh1HUmL9MfONCtIp0l9/78DrdAUqx7qanyJcvgIz6muAQUQf1j+v+08D6KZfjSGks
	 19LTxAvzB7VR/abmlP2PuMvH4wtDs3/UyiJloHz2RRCWj+/kpalQElO20r7qrnNXnH
	 9MyA6xa65SP3zlIfym5U4y4POM8QCkH5jwF39g/msfIaITu3wcpXd4kwRxb4UR+wdq
	 NAQUPXavvwmyQ==
Date: Wed, 10 Jun 2026 08:14:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, Ao
 Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>, Qi Li
 <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>
Subject: Re: [PATCH net] fddi: validate skb length before parsing headers
Message-ID: <20260610081448.3a963be9@kernel.org>
In-Reply-To: <20260607112408.92988-1-zhaoyz24@mails.tsinghua.edu.cn>
References: <20260607112408.92988-1-zhaoyz24@mails.tsinghua.edu.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262516-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4B8366AAA3

On Sun,  7 Jun 2026 19:24:04 +0800 Yizhou Zhao wrote:
> KASAN reports this when such a frame is processed through a dummy FDDI
> netdev that calls the real fddi_type_trans() on an exact kmalloc() copy
> of the frame:
> 
>   BUG: KASAN: slab-out-of-bounds in fddi_type_trans+0x385/0x3a0
>   Read of size 2 at addr ffff888009c6fe33
>   The buggy address is located 4 bytes to the right of
>   allocated 15-byte region [ffff888009c6fe20, ffff888009c6fe2f)
> 
> Reject short frames before reading the fields: require the minimum 802.2
> header length before accessing dsap or daddr, and require the full SNAP
> header length before reading the SNAP ethertype.  Returning protocol 0
> causes the malformed packet to be ignored by protocol handlers.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org

I'm stripping these, the problem seems entirely theoretical.
"I invented a fake driver and it makes the stack crash" is not serious.

