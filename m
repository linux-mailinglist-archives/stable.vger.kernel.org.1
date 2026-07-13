Return-Path: <stable+bounces-273652-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yx0MJhrOVGo8fAAAu9opvQ
	(envelope-from <stable+bounces-273652-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:38:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCC274A6DD
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:38:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lwsqz1Ru;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273652-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-273652-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E4D0300A590
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 11:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239253E9589;
	Mon, 13 Jul 2026 11:37:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0713E866B;
	Mon, 13 Jul 2026 11:37:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942674; cv=none; b=H9zsGQvXZghr0Jx6LM1w5vDbRPOfm43MDpqqCmzrkjhDBGSIwrnrATgcx95ZMBK6Ku5b3nqOy5I9NAFlWRHGjcg5pa0tDbg0A1ZVjdciN4ZJOEsZFE9aY4WAc2pkiWwJdREXpxTWcvhgEp4BFQo0urQqQ9fqxnmyRoFbyilJIAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942674; c=relaxed/simple;
	bh=T9I9LggSZGnd+opeAplGGNQctxNzn/jhs9k9J87eSGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1MhnXsx/MXEN9FG+xPazoEZij0FKTIu2rnbdS9kP/tJ5V2xHIm7MMsR0cVrsNi961wCvKsTMib78bSDcb/I5/uJ3Jc8NX9KHA8XQLfdF2HZAzwkkKSBbnvMFLf5wIiZsDQpGBU6cjinVmN46GBhCTlrEks+SHN6wVBnoF4lx2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwsqz1Ru; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126A51F000E9;
	Mon, 13 Jul 2026 11:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783942673;
	bh=/BjtT2J2J6zXKuxGY/oNhYmRT76YRdnfRvP+EVhF3Q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lwsqz1RuU3/1+c0OVzE60Yb3p9ZEdRyv87rOvJQj2jHlLDEJ9FJh3edRHAabzd8wG
	 camah820QByAwHgAARZVVejvD11aO+S9Ik8ny9LouWcULNkE1aQXCemywImUs6WKfe
	 GDEVgH7ZgoNJI7HcE1g7bcNYXDtt8CrQ/eWnGg2fEWMwktPX7Fww8DmwHln3sdp12T
	 D3uAw0aHU9doRMgRKZY8ITJ7+5ZQAQtLaK2rBS+h//zPXpg/FDXOpqa8jixTrT3CLp
	 7T5xptgnEXNSjzGBE9uqCjgtRrEMT7yXfCEDCtOh+IFFSelv4KHvpqcfasikBCvYr5
	 LvZXZRZnbq1mQ==
Date: Mon, 13 Jul 2026 12:37:46 +0100
From: Will Deacon <will@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Toshi Kani <toshi.kani@hpe.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Carlier <devnexen@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org,
	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/2] mm: fix UAF caused by race between ptdump and vmap
 pgtable freeing
Message-ID: <alTOCtzQh9RMfWbc@willie-the-truck>
References: <20260710-series-vmap-race-fix-v1-0-5b3794c113fe@kernel.org>
 <8e320b30-9658-4e9f-ac4c-f99dcf855944@arm.com>
 <alNQccqtx5-QApup@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alNQccqtx5-QApup@lucifer>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ljs@kernel.org,m:dev.jain@arm.com,m:akpm@linux-foundation.org,m:surenb@google.com,m:liam@infradead.org,m:vbabka@kernel.org,m:shakeel.butt@linux.dev,m:david@kernel.org,m:rppt@kernel.org,m:mhocko@suse.com,m:urezki@gmail.com,m:toshi.kani@hpe.com,m:catalin.marinas@arm.com,m:devnexen@gmail.com,m:ryan.roberts@arm.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,m:syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273652-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[will@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[arm.com,linux-foundation.org,google.com,infradead.org,kernel.org,linux.dev,suse.com,gmail.com,hpe.com,kvack.org,vger.kernel.org,lists.infradead.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,fd95a72470f5a44e464c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,willie-the-truck:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BCC274A6DD

On Sun, Jul 12, 2026 at 09:46:46AM +0100, Lorenzo Stoakes wrote:
> On Sun, Jul 12, 2026 at 12:50:08PM +0530, Dev Jain wrote:
> > Will Deacon had pushed back on a similar approach:
> > https://lore.kernel.org/all/20250530123527.GA30463@willie-the-truck/
> >
> > Although now when I read back that thread, it feels more so like my
> > incompetency to convince :) because:
> 
> No haha not so, I think more like this stuff is fiddly.

Yup, not disputing that this is hard to get right.

Conceptually, adding locking purely to deal with a vanishingly rare,
debug reader does turn my head but I'm _far_ less concerned about it if
it's done in the core code, as is the case here. x86 needs it and we're
recently running into related locking issues with the set_memory_*()
APIs if we want to collapse the page-table on arm64 [1]. If the overhead
is flagged as an issue, we can see if it's worth generalising the static
key trick that the second patch reverts but I definitely wouldn't start
from that position.

Will

[1] https://lore.kernel.org/linux-arm-kernel/799181c3-a1a1-4de7-bc6a-576d3282efb0@arm.com/

