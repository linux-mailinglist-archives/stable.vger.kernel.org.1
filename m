Return-Path: <stable+bounces-108420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5476A0B4FA
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 12:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592F418862E5
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 11:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7501C07FC;
	Mon, 13 Jan 2025 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pv0hXVTU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FwDc9Sd4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PZ/KwP6P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Durt+2Ot"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934DE153824;
	Mon, 13 Jan 2025 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736766157; cv=none; b=XX3SbhcxGp69Mo/sYlQQIHwIs9E2mJCm9puErmzydXiutecaU6uKGS0zcNMHjqSUQWFEOqU2hZCNOl84cGfCdxIsN2xPjX0ZQCz71O0zhpW7mOoO//L+Or5IN+V2sk3z/9V+AIVsuLimYP5F951iiUN9VVDMwpJ0UfVmoM8eSGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736766157; c=relaxed/simple;
	bh=Jeb/3Y/fF4rIc3Bc7Icvx3g5IHdWFY7fwDOTcVEFCRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGy0xZ1FPp1xJIvdIaLxGaxX2vR6+VrcpaUaEs5FL0yJU66HgY8xAcr2UTa2sjknTzYyrLkDex7YhDBK1aYU43J3StOv28KWdEiUblT3suUExcqeAmQiS1W9iJgd8MO3/FmdpNlgTCiuyBOH93RtuHSgAcC3YzJ8eC9qlRyYSio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pv0hXVTU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FwDc9Sd4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PZ/KwP6P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Durt+2Ot; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C394A1F37E;
	Mon, 13 Jan 2025 11:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736766153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mN0rEsa03LtvBwIUOB/gkUTg9XhUpSCMt6n79WpDrCU=;
	b=Pv0hXVTUOb63a2ao7ZRqfxszUSiX1xZ2cNzKFSEEMjqrocm7Ebgo8UdkM48SpFIuSXb9q8
	A6neDqr5UcoAhU85DCvV5ChFKEh6rxKHszw0Rq0EyCZ4Urgrhv0geedHzJF515jaM8yhFH
	uj7QzxfVIuc4YL2IcOkg6gmBZpdaujI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736766153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mN0rEsa03LtvBwIUOB/gkUTg9XhUpSCMt6n79WpDrCU=;
	b=FwDc9Sd4NJArxciJtGsM2Fp5Kp086mNHXzAnQG4gn07A6JP6Kb1sO4Hk9ZyNIubMzMsRGL
	Cz2Py29IYWgC6ZDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="PZ/KwP6P";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Durt+2Ot
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736766152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mN0rEsa03LtvBwIUOB/gkUTg9XhUpSCMt6n79WpDrCU=;
	b=PZ/KwP6PBv2L9gB8K14MaVGHvs1iDafCSb63oorlzelrwTOM4oxXm2D9jVO9Sbisca1wjn
	DHM/igJkLmefywCUmqg0mIPaafiRoLi1+qLbjvk6rZkmWtMVPqX4d0J3/xmHGeh+7DWkVo
	dJ76eVd5VOCKKYVoamPoxicah9meaeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736766152;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mN0rEsa03LtvBwIUOB/gkUTg9XhUpSCMt6n79WpDrCU=;
	b=Durt+2Ot681uTnnYdpIEa1F0NGX7ajt1F2MhpbbMCyAvViGC3NCiKJ9AnsAWKTXNc8DthT
	dS1U/sc/JT6GSkDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2842813876;
	Mon, 13 Jan 2025 11:02:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SHIcB8jyhGcKdQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 13 Jan 2025 11:02:32 +0000
Date: Mon, 13 Jan 2025 12:02:26 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Breno Leitao <leitao@debian.org>, Rik van Riel <riel@surriel.com>,
	Muchun Song <muchun.song@linux.dev>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Ackerley Tng <ackerleytng@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-stable <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] mm/hugetlb: Fix avoid_reserve to allow taking
 folio from subpool
Message-ID: <Z4Tywpu-JpIRwh2G@localhost.localdomain>
References: <20250107204002.2683356-1-peterx@redhat.com>
 <20250107204002.2683356-2-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107204002.2683356-2-peterx@redhat.com>
X-Rspamd-Queue-Id: C394A1F37E
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,debian.org,surriel.com,linux.dev,gmail.com,google.com,linux-foundation.org];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,localhost.localdomain:mid]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Jan 07, 2025 at 03:39:56PM -0500, Peter Xu wrote:
> Since commit 04f2cbe35699 ("hugetlb: guarantee that COW faults for a
> process that called mmap(MAP_PRIVATE) on hugetlbfs will succeed"),
> avoid_reserve was introduced for a special case of CoW on hugetlb private
> mappings, and only if the owner VMA is trying to allocate yet another
> hugetlb folio that is not reserved within the private vma reserved map.
> 
> Later on, in commit d85f69b0b533 ("mm/hugetlb: alloc_huge_page handle areas
> hole punched by fallocate"), alloc_huge_page() enforced to not consume any
> global reservation as long as avoid_reserve=true.  This operation doesn't
> look correct, because even if it will enforce the allocation to not use
> global reservation at all, it will still try to take one reservation from
> the spool (if the subpool existed).  Then since the spool reserved pages
> take from global reservation, it'll also take one reservation globally.
> 
> Logically it can cause global reservation to go wrong.
> 
> I wrote a reproducer below, trigger this special path, and every run of
> such program will cause global reservation count to increment by one, until
> it hits the number of free pages:
> 
>   #define _GNU_SOURCE             /* See feature_test_macros(7) */
>   #include <stdio.h>
>   #include <fcntl.h>
>   #include <errno.h>
>   #include <unistd.h>
>   #include <stdlib.h>
>   #include <sys/mman.h>
> 
>   #define  MSIZE  (2UL << 20)
> 
>   int main(int argc, char *argv[])
>   {
>       const char *path;
>       int *buf;
>       int fd, ret;
>       pid_t child;
> 
>       if (argc < 2) {
>           printf("usage: %s <hugetlb_file>\n", argv[0]);
>           return -1;
>       }
> 
>       path = argv[1];
> 
>       fd = open(path, O_RDWR | O_CREAT, 0666);
>       if (fd < 0) {
>           perror("open failed");
>           return -1;
>       }
> 
>       ret = fallocate(fd, 0, 0, MSIZE);
>       if (ret != 0) {
>           perror("fallocate");
>           return -1;
>       }
> 
>       buf = mmap(NULL, MSIZE, PROT_READ|PROT_WRITE,
>                  MAP_PRIVATE, fd, 0);
> 
>       if (buf == MAP_FAILED) {
>           perror("mmap() failed");
>           return -1;
>       }
> 
>       /* Allocate a page */
>       *buf = 1;
> 
>       child = fork();
>       if (child == 0) {
>           /* child doesn't need to do anything */
>           exit(0);
>       }
> 
>       /* Trigger CoW from owner */
>       *buf = 2;
> 
>       munmap(buf, MSIZE);
>       close(fd);
>       unlink(path);
> 
>       return 0;
>   }
> 
> It can only reproduce with a sub-mount when there're reserved pages on the
> spool, like:
> 
>   # sysctl vm.nr_hugepages=128
>   # mkdir ./hugetlb-pool
>   # mount -t hugetlbfs -o min_size=8M,pagesize=2M none ./hugetlb-pool
> 
> Then run the reproducer on the mountpoint:
> 
>   # ./reproducer ./hugetlb-pool/test
> 
> Fix it by taking the reservation from spool if available.  In general,
> avoid_reserve is IMHO more about "avoid vma resv map", not spool's.
> 
> I copied stable, however I have no intention for backporting if it's not a
> clean cherry-pick, because private hugetlb mapping, and then fork() on top
> is too rare to hit.
> 
> Cc: linux-stable <stable@vger.kernel.org>
> Fixes: d85f69b0b533 ("mm/hugetlb: alloc_huge_page handle areas hole punched by fallocate")
> Reviewed-by: Ackerley Tng <ackerleytng@google.com>
> Tested-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

