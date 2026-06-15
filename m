Return-Path: <stable+bounces-263205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tMGSJgUFMGp6LwUAu9opvQ
	(envelope-from <stable+bounces-263205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 15:58:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0CA686E4A
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 15:58:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=Mm4YyDFj;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263205-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263205-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9AE49300CB2E
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 13:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D1C3F54B4;
	Mon, 15 Jun 2026 13:58:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09873EDAA3;
	Mon, 15 Jun 2026 13:58:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531905; cv=none; b=TG5DjSmuEiHy9rvkArV8EfsNZ5GolXJKxjPcc/w5YrKqM/fKoyhId3I+YTDqhwPDXRpf79CNz6CSNvsgyUJWFuO8p0dvnVXvHwccVMPMh77fYO60L42qN4Eeb7lKUwpr+gsPFrr+QRsRdrO1zQdPORit6SpkOBlrMUALXCZ5WI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531905; c=relaxed/simple;
	bh=kVwPPwNyAeWGI2+qh3hL/g8B12MS6vl5MsKNv7jf5NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGCM+gcJdIz1jH2c6ZhY4ZQUobfBbfGYVk3cIPmox7yM8OpyvTwnMAI8xOzFsiXwMnt4W04lK9d8clQcaY2mB0ID1ANUQlsT3+apYCXHTKvTQv76aRaoelXgfTdTEok2K86QY1YBADrtte8oCOY0O2zhIib3ICbQUNnuiemneFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Mm4YyDFj; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ju4T+RVYyWMpT3dI6nGVGRDOuCutXNq5/3aIQaCuSDQ=; b=Mm4YyDFjTRnOQh+Dst7wqeKRG0
	K3GOie8OQjDG9Jf2fVKx4MkdyBKxclbWBypf5D2BAGVMa21e2EGFf5LGm1cW3cRIIvtLhRbzeuSA9
	sGSbjszPdUa3zQlVJtEzFAIyZOy0KyxBUlnHefaM3cADMwA68GS3NPuuAaJXtHNiHMIyMkokfHPNB
	3I3N56O1mzOXbSSpyp4jHxRjegRsNdiYf8wJg0DnHIGDKPfx3zY+wRVj6OxUjok77A4EStsGXZQyd
	TGaG+H9DoL89Lp+aveXD3EY9t+Yo4rpTzhLQhQFMyeGxADtC99d6gw7k8GkSuhF0mxn6mIm6NRVxQ
	gegGid3A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZ7pJ-00D7Yh-24;
	Mon, 15 Jun 2026 13:58:09 +0000
Date: Mon, 15 Jun 2026 06:58:03 -0700
From: Breno Leitao <leitao@debian.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eryu Guan <eguan@linux.alibaba.com>, 
	Yiwen Jiang <jiangyiwen@huawei.com>, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] 9p: fix WARN_ON when dropping nlink on files with nlink=0
Message-ID: <ajAE36BxIdkLEToh@gmail.com>
References: <20260126-9p-v1-1-dc234d53ae87@debian.org>
 <aZGRkaFZPXfZW8a0@codewreck.org>
 <aeY32gOaV5jw1s8F@gmail.com>
 <aeZNdxmYw1K0Swg9@codewreck.org>
 <ai-842Shp-LJIOBD@gmail.com>
 <ai_77Gr0h_n5SkET@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ai_77Gr0h_n5SkET@codewreck.org>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263205-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:asmadeus@codewreck.org,m:ericvh@kernel.org,m:lucho@ionkov.net,m:linux_oss@crudebyte.com,m:akpm@linux-foundation.org,m:eguan@linux.alibaba.com,m:jiangyiwen@huawei.com,m:v9fs@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F0CA686E4A

On Mon, Jun 15, 2026 at 10:19:40PM +0900, Dominique Martinet wrote:
> Breno Leitao wrote on Mon, Jun 15, 2026 at 01:51:09AM -0700:
> > > Please send as a proper PATCH mail and I'll tentatively apply for 7.2
> > > (a bit too late for 7.1)
> > 
> > Please, don't forget this one for 7.2. This is one is hurting me from
> > time to time.
> 
> Thanks for the reminder, that did fall through the cracks, with the
> dozen of LLM-generated patches that came in lately and my attention
> being more than limited..

I know what you mean! :-)

> I've picked 20260421-9p-v2-1-48762d294fad@debian.org up, and will send
> it to Linus at the end of the week unless something bad happens

Thanks!
--breno

