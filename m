Return-Path: <stable+bounces-230625-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKzmIx9ixmm+JAUAu9opvQ
	(envelope-from <stable+bounces-230625-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:55:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D08E342EE4
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17730319EB54
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 10:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27653B9DA3;
	Fri, 27 Mar 2026 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="oWsXXiup"
X-Original-To: stable@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D095333DEC0
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774607815; cv=none; b=F64vkR8xHvT6VCKa7s0WQZBQWIuigf4k5WaNtqSYseoC5N0AbJRQlsn8CdtwHmqegBnbo5/kygius8ZZBxx5ey4/Xh5SUW/z6tvQo6EMBD+Wx9O/izjo43ibVaY3FOY8qJiBz/d95ZI5s/nM8xvGYbrOcv4KqPnS55fh+ej/Ttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774607815; c=relaxed/simple;
	bh=kiADp0oIVeiy85hA7sDgLExsP9t9qKCylHr0YIfxuR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4LpzN4Z1tVLlJ3wniZsCfs9+ql/8P5w+RKNcjmSx2PSXAOZivrYWr5DSiWE8CM/xjys+CG9WBH4FC3lRigqx2q60gTNRps15yLjDVr/xsaUKutY38F+68ltUmOLSFlRn8tp1LnS2wYvRqc5R+CfI3/xkXVg0lybYeYbxQpVcdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=oWsXXiup; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BUn054WgrrVQxYNeFMeRYp7kL0ePpGi/O2lo5unwhu8=; b=oWsXXiupb6HV+qlZ35NICEuWTj
	oaoEfsTEzIbEuKQCoPKYWnZYsugIjM3BtifJKjur/GaD6/c1XB1tNAUi6wNV35hnd9SI1KxHddTXL
	ehtr/drZ+MNbMC+TJl7M9SQqgHOnoW+eNH+7DgUZeKp27bzHXdPUK3g5rtKZu5/8QnCYnuUjxPiXU
	veZ/6p/vLgc92c7yO3AYd+Op0LtCUxYv3hTld2+qh00lyM5EdwG7GFehExEEUjJT14mRYqBXNKS1s
	hV5hHUf89g7iutiNLK8srcYbWRNgmLY1ttZbS0u/eX2+cYXl9/k86b2yZVyVO4JtxxluiVTSu/NX3
	mCVFU8hA==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1w64YG-0000000021Z-0gGn;
	Fri, 27 Mar 2026 11:36:28 +0100
Date: Fri, 27 Mar 2026 11:36:28 +0100
From: Phil Sutter <phil@nwl.cc>
To: Yuan Tan <yuantan098@gmail.com>
Cc: security@kernel.org, pablo@netfilter.org, fw@strlen.de,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, zhen.ni@easystack.cn,
	kadlec@netfilter.org, kees@kernel.org, tomapufckgml@gmail.com,
	dstsmallbird@foxmail.com, yifanwucs@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] netfilter: ipset: drop logically empty buckets in
 mtype_del
Message-ID: <acZdrEQ6mMpJLNH8@orbyte.nwl.cc>
References: <cover.1774578045.git.yifanwucs@gmail.com>
 <d3d1e38f2001ec225344f24e59727299f6a39a7a.1774578045.git.yifanwucs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3d1e38f2001ec225344f24e59727299f6a39a7a.1774578045.git.yifanwucs@gmail.com>
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230625-lists,stable=lfdr.de];
	DMARC_NA(0.00)[nwl.cc];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,netfilter.org,strlen.de,davemloft.net,google.com,redhat.com,easystack.cn,gmail.com,foxmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nwl.cc:email,foxmail.com:email]
X-Rspamd-Queue-Id: 1D08E342EE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 10:50:38PM -0700, Yuan Tan wrote:
> From: Yifan Wu <yifanwucs@gmail.com>
> 
> mtype_del() counts empty slots below n->pos in k, but it only drops the
> bucket when both n->pos and k are zero. This misses buckets whose live
> entries have all been removed while n->pos still points past deleted slots.
> 
> Treat a bucket as empty when all positions below n->pos are unused and
> release it directly instead of shrinking it further.
> 
> Fixes: 8af1c6fbd923 ("netfilter: ipset: Fix forceadd evaluation path")
> Cc: stable@vger.kernel.org
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <dstsmallbird@foxmail.com>
> Signed-off-by: Yifan Wu <yifanwucs@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>

Reviewed-by: Phil Sutter <phil@nwl.cc>

