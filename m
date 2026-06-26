Return-Path: <stable+bounces-268792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DKWILhJPPmrIDAkAu9opvQ
	(envelope-from <stable+bounces-268792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 12:06:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4696CBE9D
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 12:06:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bytedance.com header.s=2212171451 header.b=JE4g0LCy;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268792-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268792-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=bytedance.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79AF73028EEF
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 10:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C38E3EB0EE;
	Fri, 26 Jun 2026 10:05:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632A63EA953
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 10:05:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782468332; cv=none; b=WjBm9t3yGFd+6ht5ucVzwYLl2MFRQnMKhweW4ysgakz6FXITDSvDp9N/bnY+bnyIE2s5MOlfTMBbas8NG0XIoi5jzMPYdgSMHTwKLOYN+KtJk3C8+NbQF23qkcdfpZID8cu8lNnpFNZn+2Y8UZm+cf7gf8hm3/nqqYYUmndk6is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782468332; c=relaxed/simple;
	bh=C6g3oSTRv01LcmdPXswFH3AfN8+ZBuwOKaByhSZrN6o=;
	h=References:Mime-Version:To:Cc:From:Message-Id:Subject:In-Reply-To:
	 Date:Content-Type; b=nAQ97M4WDtx00Y8/4x1vkpDUGKn611MWdO8MAH425d/erjojW/DUS1j5n1P7N9TqX/zeH6WgVY588nI0XJ/Ii2Aiy/R5AiwZsgY7HXHgbXB8PjL+KzWns7bpR2ftlQhknXmY7FHsvZf8qKTmp+q4EyaPe9xpUqCxzNWL6pPGxm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JE4g0LCy; arc=none smtp.client-ip=209.127.230.111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1782468319; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=vrWJEdeaP+BWIo9pqHkAnAToTeZrL9b56uLfVI+0FFw=;
 b=JE4g0LCyQ3qb74xBJGriRR4hLPlC4XEf5BqV6mY13ZRAeZzIzjHHbsWb7rU2J5hqQN/+Xc
 E7r8alvuKMEZ3kfnoRrupPr5ZcRV21wOkV6/ndzU0jXx4rSOBwGmitxJYzzzwNqqV/E52T
 3GXpY2sG94I9O/333tZJdcndXRYmRYf9ds9lGg0zPtpnCcCNAeVB10PeixKcWNMe1vN2dd
 Z5OzUeYAWWMbblQAKtP9uAZcUKNzMTr4tO3Xmj9xza8F/nIVPxRnR28FFgym0Aebz91ugX
 XBkGr8IJOcK7vh/TfnhqAvRC8vVhEmqWNKqR/+gEX6v+F7kjo8RfQ9tdCdxi8A==
References: <20260623094947.7853-1-zhujia.zj@bytedance.com> <81ed36cc-b5c8-41cf-8b7d-16611e61e294@huaweicloud.com> <20260624094535.1-zhujia.zj@bytedance.com> <x3jm3mhgsr7zx4hvfgdvmwoqyz5vxx2fjyxy6gs6him46767f6@dkkirnw54x6x> <7471b9cb-158a-4ed4-a1ce-95270ef38974@gmail.com> <qwe3wrfaoqoowiywhskhewfcjbh5aolmgeoy7am6xcl7id4fam@zxqmz7266uaq>
X-Original-From: Zhu Jia <zhujia.zj@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: "Jan Kara" <jack@suse.cz>, "Zhang Yi" <yizhang089@gmail.com>
Cc: "Zhu Jia" <zhujia.zj@bytedance.com>, 
	"Zhang Yi" <yi.zhang@huaweicloud.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	"Andreas Dilger" <adilger.kernel@dilger.ca>, 
	"Baokun Li" <libaokun@linux.alibaba.com>, 
	"Ojaswin Mujoo" <ojaswin@linux.ibm.com>, 
	"Ritesh Harjani" <ritesh.list@gmail.com>, <linux-ext4@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
From: "Zhu Jia" <zhujia.zj@bytedance.com>
Message-Id: <20260626095734.1-zhujia.zj@bytedance.com>
Subject: Re: [PATCH] ext4: cancel dirty accounting for folios without buffers
In-Reply-To: <qwe3wrfaoqoowiywhskhewfcjbh5aolmgeoy7am6xcl7id4fam@zxqmz7266uaq>
Date: Fri, 26 Jun 2026 18:05:12 +0800
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Lms-Return-Path: <lba+26a3e4edd+cf508d+vger.kernel.org+zhujia.zj@bytedance.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[suse.cz,gmail.com];
	TAGGED_FROM(0.00)[bounces-268792-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jack@suse.cz,m:yizhang089@gmail.com,m:zhujia.zj@bytedance.com,m:yi.zhang@huaweicloud.com,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:libaokun@linux.alibaba.com,m:ojaswin@linux.ibm.com,m:ritesh.list@gmail.com,m:linux-ext4@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:riteshlist@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhujia.zj@bytedance.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhujia.zj@bytedance.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[bytedance.com,huaweicloud.com,mit.edu,dilger.ca,linux.alibaba.com,linux.ibm.com,gmail.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B4696CBE9D

On Thu, Jun 25, 2026 at 01:18:31PM +0200, Jan Kara wrote:
> On Wed 24-06-26 21:29:58, Zhang Yi wrote:
> > On 6/24/2026 8:32 PM, Jan Kara wrote:
> > > On Wed 24-06-26 17:52:06, Zhu Jia wrote:
> > > > The reason I left the tags unchanged in this version is that I was not sure
> > > > whether it is appropriate for ext4 to open-code xarray tag cleanup directly.
> > > > 
> > > > If you think this is the right direction, I can add the helper back and
> > > > send a v2.
> > > 
> > > That was a good judgement! Playing with xarray tags like this in filesystem
> > > code is certainly not a good thing. For now, I'd leave the xarray tags
> > > dangling - they will be eventually synced with reality on next writeback
> > > attempt. If this inconsistency of tags needs to be fixed, the fix belongs
> > > to the generic code (so that it can be used in other places as well).
> > 
> > Yes, I agree. Directly clearing the tag via open code is not a good
> > approach. However, I took a look at the !nr_to_submit branch in
> > ext4_bio_write_folio(), and it seems to have a similar simple handling
> > pattern - it directly calls __folio_start_writeback() and
> > folio_end_writeback(), which appears to be an elegant way to clear them.
> > Could we also call these two helpers just after folio_cancel_dirty()
> > here?
>
> Right, that would be actually doable there and would keep things more
> consistent so I think that's a good idea! Thanks!

Thanks Jan and Yi, your discussion makes sense. I will send v2 shortly.

Thanks,
Jia

