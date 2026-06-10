Return-Path: <stable+bounces-262507-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PxBwEGx0KWpwXAMAu9opvQ
	(envelope-from <stable+bounces-262507-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 16:27:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B6A66A35D
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 16:27:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oXv2rDp6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262507-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262507-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3DD103017CF2
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 14:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6B23264EF;
	Wed, 10 Jun 2026 14:24:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE6033D4F8;
	Wed, 10 Jun 2026 14:24:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101462; cv=none; b=SmyFv55Vb/0R9gYn950OIciYsFefvTCU2cmp/wXT6UcW77QtkeSnZk07VkcXbanvK5SvNnZthUq3KX7jkEd1hik5yuPx88XaxJBPc0K3vIG7ycYNZbNgnuiyuzleQ6PuDK5GuzGzmIHI5kS3sajS6tNnfh10vq/nMxMjYuPEmfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101462; c=relaxed/simple;
	bh=ElmB4OBBTwA6tWwN0Dtih6hAJROQmt0w7//QP93Mujc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1kVjFDFyJLOTovWa7P3J+Dk9z2gxWWEwre0y9LRTsBWiCUULS6IkA2BHXvLuPGvD+kE7q0CUmGnGRBxuYVB7Idf/5SVWnz2SL0Gd2MhV70Bi5I/I/2btT70owSyPmpegyGO+zCeutrhHEBmrIH9fN793ZbjxhPt7mtpAbpoVS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXv2rDp6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD881F00893;
	Wed, 10 Jun 2026 14:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781101459;
	bh=zakMQGUFyRqVPoEp0E3Q0J9UpH/xxjiw6cW9yl4lynY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oXv2rDp6mwgsUADmkaDzIHMFZsojNRMh6BjhBC3xOqlQBt3ZjxLEtb+hZqHWoZDYy
	 6Fx5NskM7U4NBReZtmjCVd8PMUOopflUnh/+8FubKOcRUuE8i6HzxMkst8uc/LYZp+
	 Z6OjA59fQye/7xjrSPOAvII6RfBEWP8OheC7AI240AXWaxOtgUHn9eDINd0eyEF/t+
	 HKaSWnHltspSukUCJdes9w3kB3w7KNK51QaRuEnlE8mWHLzT+MwlaN5DE5bL0c4umC
	 93t6hU658/5enAQE8cZcjQquoD7ZSAREM+EZRKA991a1CjEvdScII232s7j/+BIqRY
	 eO+JkdoQF4vHQ==
Date: Wed, 10 Jun 2026 15:24:14 +0100
From: Simon Horman <horms@kernel.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>
Subject: Re: [PATCH net] fddi: validate skb length before parsing headers
Message-ID: <20260610142414.GM3920875@horms.kernel.org>
References: <20260607112408.92988-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607112408.92988-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262507-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32B6A66A35D

On Sun, Jun 07, 2026 at 07:24:04PM +0800, Yizhou Zhao wrote:
> fddi_type_trans() reads FDDI header fields from skb->data without first
> checking that the received frame is long enough for those fields.
> 
> The destination address spans offsets 1-6 and the LLC dsap field is at
> offset 13.  For SNAP frames, fddi->hdr.llc_snap.ethertype is at offsets
> 19-20.  A truncated 15-byte frame with dsap != 0xe0 therefore enters the
> SNAP branch and reads the ethertype past the end of the frame.
> 
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
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

I believe that drivers ensure that in practice packets hitting this path
are linear, so checking skb->len is sufficient to protect against OOB
reads.

Reviewed-by: Simon Horman <horms@kernel.org>

