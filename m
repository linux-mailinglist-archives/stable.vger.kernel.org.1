Return-Path: <stable+bounces-239643-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMPJIsJi5mmavgEAu9opvQ
	(envelope-from <stable+bounces-239643-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:30:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E034314D1
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 737B33090B36
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4594033D6FC;
	Mon, 20 Apr 2026 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="UNLvioDs"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58702E2665;
	Mon, 20 Apr 2026 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700822; cv=none; b=u32B1FLbUZqvUbeZsJNU9rcq7x7iqmjZskBsEmgHliNyz1mwYFyb7+0jwCfVAbJpibqMfbgUolzecsH5+oToHNGitWqTZM31PtlIW92qd+oKxMMjXBa9SEnDGKgjWeVb7tpUPx9mlzf3Oq+r/eHbuAJb8+HsHtqlac/Zw2RJoMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700822; c=relaxed/simple;
	bh=CBxdSz3HRlXbyzcgi0uREQOVOMTE/kLOkz+bvBOe3FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho9mEWBiCxdsfqwOqrmgdB2iYB9QFd3RIL4/TR3JFPBXEcDGGTmM9IBpGzNthBfxzfs++UZDXjJiBlSaP9TDwCFiL0LjypeWNTvwLd7nR7FCT2zNBfEgTjlQCxmwDl40rx3U3wNBx22U3AH63mjVX6KRRWkDpfQWSNbUB+DkX+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=UNLvioDs; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C267914C2D6;
	Mon, 20 Apr 2026 18:00:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1776700811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YSL1lWXBXhC7F1QwQu5zl7hcUoWyUOARtlkJCZejuT4=;
	b=UNLvioDsmlrbya2+p57LjJAl6IJfSme6aeuMuFs4DdTBLaxVli9i1J7nyNfdP2OBe/pd64
	4qRbV36FQt79xDz1rtTICKUPyZOPexLvqgdxw/yKQnRCLOvSVDMCBn+fAfvBZzNGBBwUrv
	P+FkpP4xwhY3FJRoAfnwt4vSBwoVCMJIXntjfjlaRT3iN5SpLVMSiYoSCfHLlxKWVEJ4uw
	j9LH4Vq5lmiTYiZnWeE7U91aPJQhfX7P5VCVIPz1BMK+cLbINodAytFMH9Sh483hp803+P
	j9YkHQkFmqDEbHNdWU0g6viPlDowhiUfMFBzxTMqwUdCLa1mBUTNWBwsyqPV5g==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 79eba00f;
	Mon, 20 Apr 2026 16:00:07 +0000 (UTC)
Date: Tue, 21 Apr 2026 00:59:51 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Breno Leitao <leitao@debian.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eryu Guan <eguan@linux.alibaba.com>,
	Yiwen Jiang <jiangyiwen@huawei.com>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] 9p: fix WARN_ON when dropping nlink on files with nlink=0
Message-ID: <aeZNdxmYw1K0Swg9@codewreck.org>
References: <20260126-9p-v1-1-dc234d53ae87@debian.org>
 <aZGRkaFZPXfZW8a0@codewreck.org>
 <aeY32gOaV5jw1s8F@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeY32gOaV5jw1s8F@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codewreck.org,none];
	R_DKIM_ALLOW(-0.20)[codewreck.org:s=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[codewreck.org:+];
	TAGGED_FROM(0.00)[bounces-239643-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmadeus@codewreck.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,codewreck.org:dkim,codewreck.org:mid]
X-Rspamd-Queue-Id: 63E034314D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Breno Leitao wrote on Mon, Apr 20, 2026 at 07:31:14AM -0700:
>     In cacheless mode the server is authoritative and the inode is on its
>     way out, so locally adjusting nlink buys nothing. Skip v9fs_dec_count()
>     entirely when neither CACHE_META nor CACHE_LOOSE is set, which both
>     avoids the warning and removes a class of nlink races (two concurrent
>     unlinkers observing nlink > 0 and both calling drop_nlink()) that an
>     nlink == 0 guard alone would only narrow rather than close.

I need to check this doesn't actually leak memory or something but this
sounds better to me, thanks.

Please send as a proper PATCH mail and I'll tentatively apply for 7.2
(a bit too late for 7.1)

-- 
Dominique Martinet | Asmadeus

