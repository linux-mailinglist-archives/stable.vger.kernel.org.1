Return-Path: <stable+bounces-268353-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id igFDJ8IOPWrswQgAu9opvQ
	(envelope-from <stable+bounces-268353-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:19:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F40CB6C50E7
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:19:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=R5ebWx5G;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=R8uIuPLg;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=R5ebWx5G;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=R8uIuPLg;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268353-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268353-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA02D3091C47
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3BA3D904E;
	Thu, 25 Jun 2026 11:18:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E453DA7CA
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 11:18:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386322; cv=none; b=SOr3k220VWD3cRtFr9uMu7F1OSGTZN1LjAt2k8vrND8yCc51y9dCt2CBr9QA2guApB2Drs36BmVDi9Rdne8stFLFCtZE12g2UB0WYJZOBEHHOkse4yv5vi68T+TxGOhFFAKFR1PJV2J/riRVGXN50zworRVhE+33NOnm3nFLavI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386322; c=relaxed/simple;
	bh=xmLOoiT6TBzwkK85DlSaoo1fNthMCp/kt7uhTP/ogdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8dqEp77YCk+ao6CJLo/WzcMUw9YMkgdabcRiqaD5QznLvyJ31dnFVh91wz+h69hZUWkevv4pax1vYC0cD5c2/qpkcQPSRfP7tVXC/mBd+U3JdliGoA6NQC+AwR0Z4VGaiWYuZa6NDltin5LB8qHOLIuDL6FLRHsBa6CwA2BixM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R5ebWx5G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R8uIuPLg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R5ebWx5G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R8uIuPLg; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1FE766C558;
	Thu, 25 Jun 2026 11:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782386316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVgh/MYhZLl584hQFz+xIWLcKAARijhFU0ERTJx69SY=;
	b=R5ebWx5GgaT29sOWNrdQb/Q0Srp4RlnNoflJI1+GSQRxQ/BQnzMl1aBffLPtv3pqCNUCbI
	xlryBlRGtZQA0RcZrZcBVFPiBAgIi++7CXkX04k/q1WWmFJa2MvibcygfDM//36xBWV//6
	m/eTbNs/2Q/+ooQ8TE/PLsmaa3QB+F8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782386316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVgh/MYhZLl584hQFz+xIWLcKAARijhFU0ERTJx69SY=;
	b=R8uIuPLgM5Ek10jLihxNngQ9GLXA4c/l6PaEFAK1jzOE2Ma2GZ7jwrbemT1iMIrniEQ4/N
	QvoOGGRDPbEdR9Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782386316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVgh/MYhZLl584hQFz+xIWLcKAARijhFU0ERTJx69SY=;
	b=R5ebWx5GgaT29sOWNrdQb/Q0Srp4RlnNoflJI1+GSQRxQ/BQnzMl1aBffLPtv3pqCNUCbI
	xlryBlRGtZQA0RcZrZcBVFPiBAgIi++7CXkX04k/q1WWmFJa2MvibcygfDM//36xBWV//6
	m/eTbNs/2Q/+ooQ8TE/PLsmaa3QB+F8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782386316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVgh/MYhZLl584hQFz+xIWLcKAARijhFU0ERTJx69SY=;
	b=R8uIuPLgM5Ek10jLihxNngQ9GLXA4c/l6PaEFAK1jzOE2Ma2GZ7jwrbemT1iMIrniEQ4/N
	QvoOGGRDPbEdR9Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12AF1779A8;
	Thu, 25 Jun 2026 11:18:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lbGLBIwOPWqpXQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Jun 2026 11:18:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AD1DBA10A3; Thu, 25 Jun 2026 13:18:31 +0200 (CEST)
Date: Thu, 25 Jun 2026 13:18:31 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yizhang089@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Zhu Jia <zhujia.zj@bytedance.com>, 
	Zhang Yi <yi.zhang@huaweicloud.com>, tytso@mit.edu, adilger.kernel@dilger.ca, 
	libaokun@linux.alibaba.com, ojaswin@linux.ibm.com, ritesh.list@gmail.com, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ext4: cancel dirty accounting for folios without buffers
Message-ID: <qwe3wrfaoqoowiywhskhewfcjbh5aolmgeoy7am6xcl7id4fam@zxqmz7266uaq>
References: <20260623094947.7853-1-zhujia.zj@bytedance.com>
 <81ed36cc-b5c8-41cf-8b7d-16611e61e294@huaweicloud.com>
 <20260624094535.1-zhujia.zj@bytedance.com>
 <x3jm3mhgsr7zx4hvfgdvmwoqyz5vxx2fjyxy6gs6him46767f6@dkkirnw54x6x>
 <7471b9cb-158a-4ed4-a1ce-95270ef38974@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7471b9cb-158a-4ed4-a1ce-95270ef38974@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yizhang089@gmail.com,m:jack@suse.cz,m:zhujia.zj@bytedance.com,m:yi.zhang@huaweicloud.com,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:libaokun@linux.alibaba.com,m:ojaswin@linux.ibm.com,m:ritesh.list@gmail.com,m:linux-ext4@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:riteshlist@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[jack@suse.cz,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-268353-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.com:email,suse.cz:dkim,suse.cz:from_mime,zxqmz7266uaq:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[suse.cz,bytedance.com,huaweicloud.com,mit.edu,dilger.ca,linux.alibaba.com,linux.ibm.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F40CB6C50E7

On Wed 24-06-26 21:29:58, Zhang Yi wrote:
> On 6/24/2026 8:32 PM, Jan Kara wrote:
> > On Wed 24-06-26 17:52:06, Zhu Jia wrote:
> > > Hi Yi,
> > > 
> > > Thanks for taking a look.
> > > 
> > > Yes, clearing PAGECACHE_TAG_DIRTY/TOWRITE would make the page-cache state
> > > cleaner. I had a version that did this by adding a helper around
> > > folio_cancel_dirty() and clearing the xarray tags after confirming the
> > > folio was still the same clean page-cache entry.
> > > 
> > > It looked like this:
> > > 
> > > static void ext4_cancel_dirty_folio(struct address_space *mapping,
> > > 				    struct folio *folio)
> > > {
> > > 	XA_STATE(xas, &mapping->i_pages, folio->index);
> > > 	unsigned long flags;
> > > 
> > > 	folio_cancel_dirty(folio);
> > > 
> > > 	xas_lock_irqsave(&xas, flags);
> > > 	if (xas_load(&xas) == folio && !folio_test_dirty(folio)) {
> > > 		xas_clear_mark(&xas, PAGECACHE_TAG_DIRTY);
> > > 		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
> > > 	}
> > > 	xas_unlock_irqrestore(&xas, flags);
> > > }
> > > 
> > > The reason I left the tags unchanged in this version is that I was not sure
> > > whether it is appropriate for ext4 to open-code xarray tag cleanup directly.
> > > 
> > > If you think this is the right direction, I can add the helper back and
> > > send a v2.
> > 
> > That was a good judgement! Playing with xarray tags like this in filesystem
> > code is certainly not a good thing. For now, I'd leave the xarray tags
> > dangling - they will be eventually synced with reality on next writeback
> > attempt. If this inconsistency of tags needs to be fixed, the fix belongs
> > to the generic code (so that it can be used in other places as well).
> > 
> > 								Honza
> 
> Yes, I agree. Directly clearing the tag via open code is not a good
> approach. However, I took a look at the !nr_to_submit branch in
> ext4_bio_write_folio(), and it seems to have a similar simple handling
> pattern—it directly calls __folio_start_writeback() and
> folio_end_writeback(), which appears to be an elegant way to clear them.
> Could we also call these two helpers just after folio_cancel_dirty()
> here?

Right, that would be actually doable there and would keep things more
consistent so I think that's a good idea! Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

