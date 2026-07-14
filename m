Return-Path: <stable+bounces-274518-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hd+DHdOJVmpH8gAAu9opvQ
	(envelope-from <stable+bounces-274518-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 21:11:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C576E7581CE
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 21:11:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=1ubEDfd2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274518-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274518-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 454423045010
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 19:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2055C3054EF;
	Tue, 14 Jul 2026 19:11:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61603358AF;
	Tue, 14 Jul 2026 19:11:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056267; cv=none; b=GUJ5DWgdbNogEsjq/rZf66UdmGfaW98PI+caCg04AkBpzyNGPzxFge8abJq7TF2Oh8KQc5gm9bc7ISUywcaDYa0L9J/Ajg0JOuHP+kGfQmNoQ7SPpiUy2QcoowMIKEQ4WP8g12UXZhDnTcumol0f3Dc3+1JNQXlbzeylRhJ13Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056267; c=relaxed/simple;
	bh=f4JuB3xjIDrmmKEJgfI8bPfxrdLKnwMUYrwZ16RcEKg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QmUTYLtchgAjXNWt77A0by0HwU3YCrFfJ13+/p/GGR/qHCksHZDCR2KjzlBl3qP84rq+TnbImBMsXYZdYk/jAF3d0IpWmoR3uJ76/CQ1Wm4R+lC3r9yw4as1p4q1oH+gTcbnFysU/UUNWFgkl6dOw6zYYvCHSFT4eZgoFh4dkLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1ubEDfd2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C740A1F000E9;
	Tue, 14 Jul 2026 19:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784056263;
	bh=w6alW6kAgplsNU9MfVHgcE3PqiC79iFkgMzFjduJ5sQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=1ubEDfd2R3TAeYbwE0NtyG9rf0Dt9m11go+ZNpZ99iG+RnxImznq3aOOsz5c9eTc6
	 krHoU0nLrt5epm3hWxpU2WqYggIoI9WP/O47lr/puJ1MOxkLyocPEqwOLTWCTbskuH
	 IUe7SZrZnxZGODba8idgTvTKApYNyA9BPbBrjoeU=
Date: Tue, 14 Jul 2026 12:11:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt
 <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Uladzislau
 Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dev Jain
 <dev.jain@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, David Carlier
 <devnexen@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org,
 syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH mm-hotfixes v3 0/4] mm: fix UAF caused by race between
 ptdump and vmap pgtable freeing
Message-Id: <20260714121102.9cb28d080556c94d45a6bc3e@linux-foundation.org>
In-Reply-To: <20260714-series-vmap-race-fix-v3-0-b812eccfa0f9@kernel.org>
References: <20260714-series-vmap-race-fix-v3-0-b812eccfa0f9@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ljs@kernel.org,m:surenb@google.com,m:liam@infradead.org,m:vbabka@kernel.org,m:shakeel.butt@linux.dev,m:david@kernel.org,m:rppt@kernel.org,m:mhocko@suse.com,m:urezki@gmail.com,m:toshi.kani@hpe.com,m:dave.hansen@linux.intel.com,m:luto@kernel.org,m:peterz@infradead.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:kas@kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:dev.jain@arm.com,m:ryan.roberts@arm.com,m:devnexen@gmail.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,m:syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-274518-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,infradead.org,kernel.org,linux.dev,suse.com,gmail.com,hpe.com,linux.intel.com,redhat.com,alien8.de,zytor.com,arm.com,kvack.org,vger.kernel.org,lists.infradead.org,syzkaller.appspotmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,fd95a72470f5a44e464c];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux-foundation.org:from_mime,linux-foundation.org:dkim,linux-foundation.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C576E7581CE

On Tue, 14 Jul 2026 18:24:22 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:

> Kernel page table walkers fall into two broad categories - those ranges
> where no exclusion is required via walk_kernel_page_table_range_lockless()
> and those where exclusion is required via walk_kernel_page_table_range()
> or walk_page_range_debug().
> 
> ...
>
> This series works around this by #ifndef CONFIG_ARM64'ing the mmap read
> lock in vmap logic, then partially reverting commit fa93b45fd397 ("arm64:
> Enable vmalloc-huge with ptdump"), keeping the enablement of huge vmap
> support, and removing the ifdeffery with the partial revert patch.

Thanks, I've updated mm-hotfixes-unstable.

> v3:
> * Rebased on latest master of Linus's tree.
> * Accumulated tags, thanks everybody!
> * Reworded commit messages as per Kiryl and Boris.

I've confirmed that v3 introduced no code alterations.

