Return-Path: <stable+bounces-271798-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b4ncJ2TFR2ogfAAAu9opvQ
	(envelope-from <stable+bounces-271798-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:21:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EA07035D2
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:21:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codewreck.org header.s=2 header.b=vi+e17oX;
	dmarc=pass (policy=none) header.from=codewreck.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271798-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271798-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6179C3098414
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 14:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D8B3DDDB3;
	Fri,  3 Jul 2026 14:17:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3043E0C5F;
	Fri,  3 Jul 2026 14:17:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088244; cv=none; b=JfPjEoCmXzDUfVC+rHKkz7juC6WGSbhSFgS5AEo0mK6E7/mI2rlSDkAAKnUOAkfHJm+HdZLJeMdX9Qfgi3mkuFhXNSUw17Qy+8BsTHRE/iilFsXxwnXGloPI8LYGP7A3tawVKyQv7388rgGp//X3VeXRGJaF5akNWZTNXMEXTHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088244; c=relaxed/simple;
	bh=RyoUpzyXE/7znmuPerg2ja01YbdFuIXsPb1n9JsGwE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eguqcNMOfsQ0qTx5xSyR475SbYfz1jdTcc1OadtUuMNezMilkKZgBABmiiLmcqqMj1hrCmfTZ7ZqFTGtHaNqVU1OpFi++pTNiPgX2E3YQOn23RW1HRbGogFQuf/ZubpiMTLr+nBBJDqo6wKTyz0J7rO4/QcjbBG2+jZzbBGBPJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=vi+e17oX; arc=none smtp.client-ip=62.210.214.84
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 4412614C2DE;
	Fri,  3 Jul 2026 16:17:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1783088237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h0/G1RbQfTBkk4DxEYT0JUXdIjg59u9DH5wVt7CJFkc=;
	b=vi+e17oXEyM0Wq0B0T3TNhe2ReIP5YxlFV29e+FvwJbeniYoVSVyug2eSxq684gkryTsnj
	HOLunvTP/CHHnOyFKiaseNsLBerLXNS4zrFj/gTGtkxLpCSNLuT+55QYxK7HtPHuIZjOsc
	oybt/5YIVJvkBnkLEVwkGCPYd7+iqkRJ/fWbPcqEt4UGJlUWFj6C8HEuMivIPLncisbLON
	Ssg+JFLWNZcK/4lmaamMVGZERo1giNSUWWBh6KXtCOjAEisnJQAG7arLhE/4K56rJLJmcu
	B5NCBz0EQIOM6IT5VMoE3uw4NOPHm3LXX+ffCLifTImO0iu9fSC4BjWal2gE6w==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id ac786db3;
	Fri, 3 Jul 2026 14:17:13 +0000 (UTC)
Date: Fri, 3 Jul 2026 23:16:58 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: v9fs@lists.linux.dev, Latchesar Ionkov <lucho@ionkov.net>,
	Eric Sandeen <sandeen@redhat.com>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] 9p: fix privport option setting wrong RDMA field
Message-ID: <akfEWuCw8rp_RhzT@codewreck.org>
References: <20260703102254.114446-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260703102254.114446-1-sgarzare@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codewreck.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[codewreck.org:s=2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271798-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[codewreck.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sgarzare@redhat.com,m:v9fs@lists.linux.dev,m:lucho@ionkov.net,m:sandeen@redhat.com,m:linux_oss@crudebyte.com,m:linux-kernel@vger.kernel.org,m:ericvh@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[asmadeus@codewreck.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmadeus@codewreck.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6EA07035D2

Stefano Garzarella wrote on Fri, Jul 03, 2026 at 12:22:54PM +0200:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> While reviewing a patch adding vsock transport to 9p, I noticed that
> since commit 1f3e4142c0eb ("9p: convert to the new mount API"), the
> Opt_privport case incorrectly sets rdma_opts->port instead of
> rdma_opts->privport, so mounting with the privport option overwrites
> the RDMA port number instead of enabling privileged port usage.
> 
> Fixes: 1f3e4142c0eb ("9p: convert to the new mount API")
> Cc: stable@vger.kernel.org
> Cc: sandeen@redhat.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks, this is obviously correct so picking it up.

-- 
Dominique Martinet | Asmadeus

