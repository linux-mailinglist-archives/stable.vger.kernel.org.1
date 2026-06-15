Return-Path: <stable+bounces-263159-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Irs4O0e+L2qNFgUAu9opvQ
	(envelope-from <stable+bounces-263159-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 10:56:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 560FB684C6B
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 10:56:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=gfCcJ1v+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263159-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263159-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E9FA30451C4
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 08:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11883C4166;
	Mon, 15 Jun 2026 08:51:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF063DA5CE;
	Mon, 15 Jun 2026 08:51:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513506; cv=none; b=ENn+j0cVzxBFKNjl+ytIHkpgj3uiIg+1/ATQRrEKUP53NPfmD7dsS6mez8CFB9p9oZvGKHdkx3lIQDBvKFVgJ1N8HPCzZZ5E8bv3P4cQe51455f8eCxeDh+uUUoxt1rWWVUceRSBsrHdWMMK6sqMc9mnsLyr/ah/HePIZh/kLAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513506; c=relaxed/simple;
	bh=iB5iiAuuaaf4I/DCOhKKDpagC8tBIw10GFLuD3cYz2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZPUNYgLUgPl0Fs4Ky8kDTiFNpOOplAArVgzYYV/+jLMebr8RQgWL3QlFXl2ksAulHJHfQ2KteR2hNZ7YUiQEv8lznoq/upJhT00TEP7aLl4C1GMobQh1xLTpy0RPfe88gBK4oH86GcXZVpiNpZ/UU2IOU/MMSW0vpADKh5rva8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=gfCcJ1v+; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ERWHpm0rcxQI7VGqVOkDuXv6ZjP9THe81NYexLreENw=; b=gfCcJ1v+IuslnxVYW9JMXOKG3Z
	ztMtmfT0yJQHaT8NVF2RRqORdA7A+Ok4kST9gLLFpTPtkBT47/Bl7sesoTAymcYUsUB6phHZN9Kzw
	/LTGkaH388Y+jOMOXXo2FyQ+QCKdBc3dfSkE+I08CiSiuxlM7fqs0kTdtSHtVsRjTRiFzdDB8Jr+z
	GrL8b7SodDlSqof89Sst5vTamAQGQ3xHBv82awFm+TmE/NyQzt1xgURFBKu2Ms5UULwnALvV6EWa5
	op0tsko5y7fioQOouBGZzZ503E2JAPqF/RcDivCF69MBK2Kn5XXaRSoCJMjlRZLxtti1sYPqr27Dn
	vgy+iSaA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZ32I-00Cx6I-1L;
	Mon, 15 Jun 2026 08:51:14 +0000
Date: Mon, 15 Jun 2026 01:51:09 -0700
From: Breno Leitao <leitao@debian.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eryu Guan <eguan@linux.alibaba.com>, 
	Yiwen Jiang <jiangyiwen@huawei.com>, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] 9p: fix WARN_ON when dropping nlink on files with nlink=0
Message-ID: <ai-842Shp-LJIOBD@gmail.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263159-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:asmadeus@codewreck.org,m:ericvh@kernel.org,m:lucho@ionkov.net,m:linux_oss@crudebyte.com,m:akpm@linux-foundation.org,m:eguan@linux.alibaba.com,m:jiangyiwen@huawei.com,m:v9fs@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 560FB684C6B

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

Please, don't forget this one for 7.2. This is one is hurting me from
time to time.


Thanks,
--breno

