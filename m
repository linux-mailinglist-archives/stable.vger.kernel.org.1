Return-Path: <stable+bounces-268135-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JGkvEPOsO2q6bAgAu9opvQ
	(envelope-from <stable+bounces-268135-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 12:09:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9756BD397
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 12:09:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bytedance.com header.s=2212171451 header.b=Qo4SovjB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268135-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268135-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=bytedance.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D12913151A37
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 10:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933393B27E2;
	Wed, 24 Jun 2026 10:04:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from sg-3-112.ptr.tlmpb.com (sg-3-112.ptr.tlmpb.com [101.45.255.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030373BC680
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 10:04:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782295465; cv=none; b=f4Vwuiadpazy8BTFMARBIYoFOQtVW7PU8HSXHV8p5V8MX2c1B3WCK/8Qsyf4yecT6Rv5K/CwX3TKieFWzrtzpHnPpYW5qmwNBK/8p18DCEODJUe0TbAv1RG6sckoXOOiFv0is64XXRjtqsh7SmqQIFB7WczSm6H55LsPIqRf/hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782295465; c=relaxed/simple;
	bh=joBK+B3mYaMGNAxp3fOJTks/CETcFMfVsK+aX1v74NQ=;
	h=To:Cc:Message-Id:Mime-Version:In-Reply-To:Content-Type:References:
	 Subject:Date:From; b=nBLe1nUMj5lqEZ7jdv+bptvt8btY4gvGRVrQ9CwMQh+r1pElykqrxd3xqNvqaApENceDZaPTOx/nhQk+7gkK2bZW1IxJsr0zz/uaqgCaTRkAaG30Qu62/d+aOaUqpK3P+6qB6jnQ+bhEgYuPVBAtFLLmVy5h0E1yzMcwxTm8rtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Qo4SovjB; arc=none smtp.client-ip=101.45.255.112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1782294733; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=umShoTivTMViTlH/8dCfBir+diXBA0Qrg1F+tK6uXyw=;
 b=Qo4SovjBUNNjajxoqY/MsOZpFTAcbYMwHsGsALJDkMiBQkEQMq3mKh5ZZboe+cCTxsNuic
 proxRLjemkMxaMZaWbanMUS2cB9L54CP/j+X4F170Q5YdcXGC/Y0RdYdBI436SA07KFDBG
 frT81FqmsOOn2KHVSGyIDtSQL3UMT/mcstZo3/AgY8kSymMOfd0T0eHnY+cSgYFpDsM3Iw
 RqtoapK54KOHXjyjiECSuuwPOvAfI2vO5LL4E7kIFaJGNCNVT6fosN7vJUH+QTofoeN1UJ
 HBbLYPNPFHROWVPtI6QCxvCGqq1j1W7L4fIOmHiKgTo8kWD+10980/yPv/0vuQ==
To: "Zhang Yi" <yi.zhang@huaweicloud.com>
Content-Transfer-Encoding: 7bit
Cc: "Zhu Jia" <zhujia.zj@bytedance.com>, <tytso@mit.edu>, 
	<adilger.kernel@dilger.ca>, <libaokun@linux.alibaba.com>, <jack@suse.cz>, 
	<ojaswin@linux.ibm.com>, <ritesh.list@gmail.com>, 
	<linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>
Message-Id: <20260624094535.1-zhujia.zj@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <81ed36cc-b5c8-41cf-8b7d-16611e61e294@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
References: <20260623094947.7853-1-zhujia.zj@bytedance.com> <81ed36cc-b5c8-41cf-8b7d-16611e61e294@huaweicloud.com>
Subject: Re: [PATCH] ext4: cancel dirty accounting for folios without buffers
Date: Wed, 24 Jun 2026 17:52:06 +0800
X-Original-From: Zhu Jia <zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
From: "Zhu Jia" <zhujia.zj@bytedance.com>
X-Lms-Return-Path: <lba+26a3ba8cb+b21b49+vger.kernel.org+zhujia.zj@bytedance.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268135-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[zhujia.zj@bytedance.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:yi.zhang@huaweicloud.com,m:zhujia.zj@bytedance.com,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:libaokun@linux.alibaba.com,m:jack@suse.cz,m:ojaswin@linux.ibm.com,m:ritesh.list@gmail.com,m:linux-ext4@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:riteshlist@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bytedance.com,mit.edu,dilger.ca,linux.alibaba.com,suse.cz,linux.ibm.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhujia.zj@bytedance.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bytedance.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bytedance.com:dkim,bytedance.com:mid,bytedance.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F9756BD397

Hi Yi,

Thanks for taking a look.

Yes, clearing PAGECACHE_TAG_DIRTY/TOWRITE would make the page-cache state
cleaner. I had a version that did this by adding a helper around
folio_cancel_dirty() and clearing the xarray tags after confirming the
folio was still the same clean page-cache entry.

It looked like this:

static void ext4_cancel_dirty_folio(struct address_space *mapping,
				    struct folio *folio)
{
	XA_STATE(xas, &mapping->i_pages, folio->index);
	unsigned long flags;

	folio_cancel_dirty(folio);

	xas_lock_irqsave(&xas, flags);
	if (xas_load(&xas) == folio && !folio_test_dirty(folio)) {
		xas_clear_mark(&xas, PAGECACHE_TAG_DIRTY);
		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
	}
	xas_unlock_irqrestore(&xas, flags);
}

The reason I left the tags unchanged in this version is that I was not sure
whether it is appropriate for ext4 to open-code xarray tag cleanup directly.

If you think this is the right direction, I can add the helper back and
send a v2.

Thanks,
Jia

