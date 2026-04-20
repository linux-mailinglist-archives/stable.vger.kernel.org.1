Return-Path: <stable+bounces-239945-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FHIKVpc5mmtvAEAu9opvQ
	(envelope-from <stable+bounces-239945-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:03:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B11F430757
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C9D931EA275
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93B434C9A6;
	Mon, 20 Apr 2026 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="dDEIDvLa"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0C4341ADF;
	Mon, 20 Apr 2026 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776702383; cv=none; b=WyJTlX4Nf7ThEYiewAXMqiAZXJ2BzKl8CiJCpUmJrLcup1t2cqSImKQSUpZEs+mLf6si9PXfcq9hr+T3YR6xqZY5hKf7FNqgG9lkJwaYx6zi//bo1SgyEZ6K42dIEXVb64+vuQFEcbTv3Gz6W6OQpFxqt2E9MA3TCOecRFYhHfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776702383; c=relaxed/simple;
	bh=WCG/mn04EZT2PRnQNwFez5dDdE2fCsqKIJdB0Yt9OAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXv/fy7sbL/Hg70zml5gG84ug3e38iZNrBZbori9Qyq8iV4pHLpCtnArs9FiadG1INLfRKAvCWz0W/I7Q9p3yIXCXgq65/P1k6OCU+RAsrRBd9CNPkMSH+RWKL2A3jzXdFH8iGBI2V391Unq03fARwWdW8C5WoexRcM8mS+J0vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=dDEIDvLa; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bfKBlctQH+DmmbUOLO8Xd/pZe8bt+P73byWQDYXv2Ho=; b=dDEIDvLaGT8anzdW64LzJBghhD
	bAMMg/WEt8K0RZLsWc3EGO07rUMbbVTP99T7SmkyttKSTLblp0v2+UPjQZb6AoVZuCj+t3td1GkK/
	9MdaSPhJhI7hBV6CZYP77X2Cv6ixpsI1oJighWOHGRKS/QIGzbqRCk67FYymmet8icBFObT2NWUzV
	KVaIbzEoLKtVPmG8yBZ4Mw4rMmd/sVwyjJx3abjOHmhIyKadJEQB9wsTXMjHMKt6Axq5yRAzaCx/p
	uhBDgM+Xb916WXQfHfUgDXr8OwBaXIoxONTxpbusAMQKjaH5zro6ib54iFW+RdMqq6QXmhzYYwJIF
	wbA1t39w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wErRm-000DAP-3B;
	Mon, 20 Apr 2026 16:26:07 +0000
Date: Mon, 20 Apr 2026 09:26:02 -0700
From: Breno Leitao <leitao@debian.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eryu Guan <eguan@linux.alibaba.com>, 
	Yiwen Jiang <jiangyiwen@huawei.com>, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] 9p: fix WARN_ON when dropping nlink on files with nlink=0
Message-ID: <aeZTjeyiYOnTLBVT@gmail.com>
References: <20260126-9p-v1-1-dc234d53ae87@debian.org>
 <aZGRkaFZPXfZW8a0@codewreck.org>
 <aeY32gOaV5jw1s8F@gmail.com>
 <aeZNdxmYw1K0Swg9@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeZNdxmYw1K0Swg9@codewreck.org>
X-Debian-User: leitao
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[debian.org];
	TAGGED_FROM(0.00)[bounces-239945-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B11F430757
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 12:59:51AM +0900, Dominique Martinet wrote:
> Breno Leitao wrote on Mon, Apr 20, 2026 at 07:31:14AM -0700:
> >     In cacheless mode the server is authoritative and the inode is on its
> >     way out, so locally adjusting nlink buys nothing. Skip v9fs_dec_count()
> >     entirely when neither CACHE_META nor CACHE_LOOSE is set, which both
> >     avoids the warning and removes a class of nlink races (two concurrent
> >     unlinkers observing nlink > 0 and both calling drop_nlink()) that an
> >     nlink == 0 guard alone would only narrow rather than close.
> 
> I need to check this doesn't actually leak memory or something but this
> sounds better to me, thanks.
> 
> Please send as a proper PATCH mail and I'll tentatively apply for 7.2
> (a bit too late for 7.1)

Ack, 7.2 is more than fine.

Thanks for your help,
--breno

