Return-Path: <stable+bounces-223691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDVdAjLtrmkWKQIAu9opvQ
	(envelope-from <stable+bounces-223691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:54:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABA423C2C2
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22B823067C40
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 15:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1363C3DA7EC;
	Mon,  9 Mar 2026 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C2tDBMf9"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F363DA7EB;
	Mon,  9 Mar 2026 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070707; cv=none; b=bxo6jV8BvyZJL0M4iZlsvCxLMAdVc3U6GruoOVKwtxAgkwjbSYBXUgk50z6UdRE41d6U+DL1Dgj7k2BTPUyRpzrwunw0s4/j8J1KTR7FO5b1AP0c7p6WFhVBR0xM7x6hrnZhFTJhkMrLQ6IxiRIRRiHemYcYc3W5p0vz3E/cxqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070707; c=relaxed/simple;
	bh=/5ynGWICZzQDBA7TvuJ43IB5Zbq1ElgWFH1QlBBPyro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsPOsBaMuaxnpL8DzB5kQYyM1a5VsNVYRUPyZIPezgDcjTJuxjlrc+r3cbWnplDXWVZKXSh0devyCru/WvlcbO1TaMHpz7/m/mIxACCtsPnJAqo9IRIE668wutxG2mOrvuVWiS2zJRYDdnjptkNn1V9CKt0fhjDDmE1LmX/Q1aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C2tDBMf9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C7sMITIeHcAA5EyDdi31r5Bd3d/PSwOH7dQ59Jw/Kgs=; b=C2tDBMf9ENmojPzH9erp33Q+1i
	wtrCgv5nt545Xfg52tZYZELno++MtEdy/QJ4xGnXI+iHSNUPU65ikeVnMcquRotvNcIrVU40JeHnq
	8NFuy/k1peJmZQy39RejI2RYMMORtP7SMR9HL8DMOv7ZO8T2vzrA/G7GNKiE5xlthuOnrF33FCl6c
	Wukt6XYIQVDcNKTIZ9WjOGdMSjb6P2fMCUT1qLXR/nshTTXHO3GpgKgB7fN6rvNg6g3/98fGl7qkC
	1gyM3or/CqP/D+F3awzG/2udCt3pwVS5w0A74QfGggro28q24FIAcLyplJNZDHwfFzA2RQzz1vKEV
	KKDxHrRw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzcgZ-00000006ANo-1trr;
	Mon, 09 Mar 2026 15:38:23 +0000
Date: Mon, 9 Mar 2026 15:38:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Johnny Hao <johnny_haocn@sina.com>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, slava@dubeyko.com,
	vishal.moola@gmail.com
Subject: Re: [PATCH 6.1.y 0/3] Fix patch backport review
Message-ID: <aa7pb3ppx7lgj-F2@casper.infradead.org>
References: <20260309050130.912344-1-johnny_haocn@sina.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309050130.912344-1-johnny_haocn@sina.com>
X-Rspamd-Queue-Id: 0ABA423C2C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223691-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[sina.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,dubeyko.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,infradead.org:dkim,casper.infradead.org:mid]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 01:01:27PM +0800, Johnny Hao wrote:
> This patch series is to backport the fix 736a0516a162
> ("hfs: fix general protection fault in hfs_find_init()")
> to 6.1.y and the other 2 patches are its dependence.

Please explain why backporting this fix is important.  The bug has
been present for years and this is not a widely-used filesystem.

