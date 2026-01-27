Return-Path: <stable+bounces-211824-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBX+MBzJeGmNtQEAu9opvQ
	(envelope-from <stable+bounces-211824-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:18:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BDD957D9
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BC7E30055EF
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01213101BB;
	Tue, 27 Jan 2026 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rCmqxUW3"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A1426FD9A
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523257; cv=none; b=FtrD2OmKW6iNqvxFo/fn/1m2JY8k1s7Jup6jp++J/N25L+GUSkjw7IiDxoMkWcUzbvT4C3/bmz3XaIo4gklnmIVpWxgKSjsV25ihoTHnNURsJPmR2nfmOiAksPmkll0vy2oc8+il471FCMBc6fR0advMAVKhKd0UL5HRL8ucA1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523257; c=relaxed/simple;
	bh=jRcA7Mg/uP3nRyG38zgih/EHZEvaiCITPi9rxccuT2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOyiLImi5QApfPDo8QQipwrvWgpEsR33zhTPEpN7HGlBdcClxvPMwSRnSu+j/QsUmJYWMGuRHViGR8AXyBL7tUf2tEG5G5sAw0FoUeUCNjTu4Sx8uNRCJrkeUA9vE7HpcPgS3SRKDVVY00h7Zp4DieedCtS60691SpwLqagf8No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rCmqxUW3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jRcA7Mg/uP3nRyG38zgih/EHZEvaiCITPi9rxccuT2g=; b=rCmqxUW3nBsbC4L+ESHyPXMkqb
	nsAQSILaGDun/Le4vcshGpFlE2vboXsVs7/njjhS4k8GdwVIRP2hOgk1rwaWca1uZkLgTP5KIfRso
	GwqzlOke+QkG99TM+t/B2v5kR4QK3mZDTAc4Eyg6+oWqnv4UsDitUHBrsRgLVibRwzJ8kE6v6kv9H
	CcGKU4sdablWVsu8gCXGqANy7dwgr98yaDa90nOWbiKVTF7+aZXXZkKQ4bAfk2F9p6fqme6DCCxrI
	ProLieQFIU/83fZOi5j9UTI7yW7X9ej52SPQII3DNhW9bxCUJA/q6jbBJ0nbOJev7FUmM9aHDxirq
	ySBjhp2w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkjpT-00000007XbQ-2RCz;
	Tue, 27 Jan 2026 14:14:03 +0000
Date: Tue, 27 Jan 2026 14:14:03 +0000
From: Matthew Wilcox <willy@infradead.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com,
	david@kernel.org, gourry@gourry.net, jannh@google.com,
	joshua.hahnjy@gmail.com, lance.yang@linux.dev,
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com, rakie.kim@sk.com, riel@surriel.com,
	stable@vger.kernel.org, vbabka@suse.cz,
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Subject: Re: FAILED: patch "[PATCH] migrate: correct lock ordering for
 hugetlb file folios" failed to apply to 6.1-stable tree
Message-ID: <aXjIK6dhZ1EfpKFX@casper.infradead.org>
References: <2026012707-hazard-unmanaged-494d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026012707-hazard-unmanaged-494d@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,sk.com,kernel.org,gourry.net,google.com,gmail.com,linux.dev,oracle.com,intel.com,surriel.com,vger.kernel.org,suse.cz,linux.alibaba.com];
	TAGGED_FROM(0.00)[bounces-211824-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,infradead.org:dkim]
X-Rspamd-Queue-Id: D5BDD957D9
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 02:09:07PM +0100, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 6.1-stable tree.

The 6.6 patch applies fine to 6.1

