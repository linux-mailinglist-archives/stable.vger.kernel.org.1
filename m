Return-Path: <stable+bounces-263182-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aTnCGrviL2rNIQUAu9opvQ
	(envelope-from <stable+bounces-263182-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 13:32:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD142685C06
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 13:32:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="n9DR94/k";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263182-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263182-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96F423026C81
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 11:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65F43E44E1;
	Mon, 15 Jun 2026 11:31:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E62339705;
	Mon, 15 Jun 2026 11:31:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781523100; cv=none; b=t1L9iv32lJSjYiIj7PAXlI64SZVqMuRVUbJJT/Dju+6M3HM5myaGccZc0YtdGBUEF9A86rnvH928EzkJpUW9FlPd6huj3gFyIUmw+Ih4x/Oq5WYdiREeS9vw7Kw984HuheFRCa9OXZB2NCuLO1tpcQjPUqSX/KOgLSIJqUAudkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781523100; c=relaxed/simple;
	bh=q+Sb+MS14wtAR71a6JBitZykNs7vL9Bbyo4hJQ8mXvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=My6iyYVWfXRt1jqq3YP/pcU309Y7RuoMgvDihBndFIhW8LHaSrlf64A5SREw0bJ10aCbrLgjjd7vPGAhMrW8RMX1dj9ivLlYtgj4Ap7GCMxCvbXI2F1USKPFft4ZrHDux29MU5kw4BgyriwC7PReWgEnHp1Y39NRVp23LnS4dkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n9DR94/k; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+IHRqpe5VuuPChvf3GPuGg/o1F2Cz4vYdsniEOMnY6E=; b=n9DR94/kHaRRVOQMSbQVj4RZiA
	yyVwbEhqNkkT9jP+3SmWoAfop7EXXKWtZkosLy19+x7h5qzHxvMdfAOjCimdBh0Ril4YN/dnWGj8Y
	p5rinCRxk/MbzV9s4M7AB2t37yQMx47dqg1MRWrUNXpyoMdZiPLg2Hga40+Sagom36A8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZ5XQ-007n1I-5V; Mon, 15 Jun 2026 13:31:32 +0200
Date: Mon, 15 Jun 2026 13:31:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, fengxw06@126.com,
	horms@kernel.org, kees@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, qli01@tsinghua.edu.cn, stable@vger.kernel.org,
	wangao@seu.edu.cn, xuke@tsinghua.edu.cn,
	yangyx22@mails.tsinghua.edu.cn
Subject: Re: [PATCH net] atm: br2684: reject short VC-MUX bridged frames
Message-ID: <da2fe0d5-b26e-46f1-b3a6-0f40ca4eef49@lunn.ch>
References: <26ebc58c-6399-4a45-aa55-91a3bf398fef@lunn.ch>
 <20260615062756.31081-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615062756.31081-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263182-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:davem@davemloft.net,m:edumazet@google.com,m:fengxw06@126.com,m:horms@kernel.org,m:kees@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:qli01@tsinghua.edu.cn,m:stable@vger.kernel.org,m:wangao@seu.edu.cn,m:xuke@tsinghua.edu.cn,m:yangyx22@mails.tsinghua.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,126.com,kernel.org,vger.kernel.org,redhat.com,tsinghua.edu.cn,seu.edu.cn,mails.tsinghua.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD142685C06

On Mon, Jun 15, 2026 at 02:27:56PM +0800, Yizhou Zhao wrote:
> Hi Andrew,
> 
> On Sun, Jun 14, 2026 at 08:39:12PM +0800, Andrew Lunn wrote:
> 
> > Same questions as for the previous patch. Lots of parallel
> > discoveries? What hardware was used, etc.
> 
> I'm sorry that in this case no physical ATM/DSL hardware was 
> used either. I verified this in QEMU/KVM with a small dummy 
> ATM device as in the previous patch. I think that this is a
> real logical bug, but whether it can be triggered by a real
> Device was not verified.

Please also submit this one to net next.

       Andrew

