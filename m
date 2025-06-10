Return-Path: <stable+bounces-152276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD002AD34EA
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 13:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81EB91897258
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 11:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D62228CBE;
	Tue, 10 Jun 2025 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xK6BQllu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qfqYsKTm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xK6BQllu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qfqYsKTm"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15D229B02
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749554854; cv=none; b=cfZ6mPceRJgqN+AaEZCYNBVOAoVqj7BgbZcmbWWJCR84b2M1VYyIH4cGzI7lg6ZZK6vX/IUjrsM4oXJYfZJvhGO0xDwexBglZGKwWUbgNdbtiVx4c7bd+dXgIYE8L+dh7q4xSCECAagqrqlJYMWav7ewafXKRnmziuG6b1E0O60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749554854; c=relaxed/simple;
	bh=hRoQIZYiq3nhqjjYoHVy73OcxFTpdAi7Jj9xLxwUkoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkutuzRTisa8wjdmTVwgXLc0izZiTza9GabYrhYYZ6zvjJ1Xwbyo9hOlXC4ZYAJnqj3N7fd4Fv+At4xkHT39s888ydHGXtzRsgXBLiyRXCJGMZuLj2mq3GDQO6kKuwvVL1WVGkiqe9Nrk7OxY/bvMoP1Qyx9cgVgP7LfRPYL6HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xK6BQllu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qfqYsKTm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xK6BQllu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qfqYsKTm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9211E2128F;
	Tue, 10 Jun 2025 11:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749554851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8NfIZhip3HhypAA9aUPNgZWLln4aNqFwLQ/jhikKqm4=;
	b=xK6BQllu/XC62OAQXzxtzd6vGDP1r6tlxuGD5AdlPMlLzzdDzOds4Hqc+U5/NHvz/VuFT8
	4tFyXfaXXEEOl0dvy4cyLwMwGBvgH9/1FvXyP657+lCcE5uKpFtIX5S/xrgDdM9crvmozL
	XWg6SH7WxNtAMGy89rhz9vssZSqg2kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749554851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8NfIZhip3HhypAA9aUPNgZWLln4aNqFwLQ/jhikKqm4=;
	b=qfqYsKTm9lggbneIXSyWp7q6I1rrFfTTBB0p7nUZqxZ3oiZvyHOMHecZkKSvRL3dLF+9mp
	iv7nxgKkNAaeKKAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749554851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8NfIZhip3HhypAA9aUPNgZWLln4aNqFwLQ/jhikKqm4=;
	b=xK6BQllu/XC62OAQXzxtzd6vGDP1r6tlxuGD5AdlPMlLzzdDzOds4Hqc+U5/NHvz/VuFT8
	4tFyXfaXXEEOl0dvy4cyLwMwGBvgH9/1FvXyP657+lCcE5uKpFtIX5S/xrgDdM9crvmozL
	XWg6SH7WxNtAMGy89rhz9vssZSqg2kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749554851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8NfIZhip3HhypAA9aUPNgZWLln4aNqFwLQ/jhikKqm4=;
	b=qfqYsKTm9lggbneIXSyWp7q6I1rrFfTTBB0p7nUZqxZ3oiZvyHOMHecZkKSvRL3dLF+9mp
	iv7nxgKkNAaeKKAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8734013964;
	Tue, 10 Jun 2025 11:27:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z1nTHaIWSGhgVAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 10 Jun 2025 11:27:30 +0000
Date: Tue, 10 Jun 2025 12:27:28 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Aishwarya <aishwarya.tcv@arm.com>
Cc: pulehui@huaweicloud.com, Liam.Howlett@oracle.com, 
	akpm@linux-foundation.org, jannh@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, mhiramat@kernel.org, oleg@redhat.com, 
	peterz@infradead.org, pulehui@huawei.com, stable@vger.kernel.org, vbabka@suse.cz, 
	broonie@kernel.org, Ryan.Roberts@arm.com, Dev.Jain@arm.com
Subject: Re: [PATCH v1 4/4] selftests/mm: Add test about uprobe pte be orphan
 during vma merge
Message-ID: <f5tx6ko7xu2ulvfwu6srlaly6omqcciez2qh6jmcd6fob3szgm@cedwkuqgw34b>
References: <20250529155650.4017699-5-pulehui@huaweicloud.com>
 <20250610103729.72440-1-aishwarya.tcv@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610103729.72440-1-aishwarya.tcv@arm.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 

On Tue, Jun 10, 2025 at 11:37:29AM +0100, Aishwarya wrote:
> Hi,
> 
> kselftest-mm test 'merge.handle_uprobe_upon_merged_vma' is failing
> against mainline master v6.16-rc1 with Arm64 on Ampere Altra/TX2 in our
> CI. The kernel was built using defconfig along with the additional
> config fragment from:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/mm/config
> 
> I understand the failure is already being discussed and is expected to be
> addressed by including sys/syscall.h.Sharing this observation here 
> for reference.

This is a different problem.

> 
> A bisect identified commit efe99fabeb11b030c89a7dc5a5e7a7558d0dc7ec as the
> first bad commit. This was bisected against tag v6.16-rc1 from:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 
> This test passes on Linux version v6.15-13627-g119b1e61a769.
> 
> Failure log:
> 
>   7151 12:46:54.627936  # # #  RUN           merge.handle_uprobe_upon_merged_vma ...
>   7152 12:46:54.639014  # # f /sys/bus/event_source/devices/uprobe/type
>   7153 12:46:54.639306  # # fopen: No such file or directory
>   7154 12:46:54.650451  # # # merge.c:473:handle_uprobe_upon_merged_vma:Expected read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type) (1) == 0 (0)
>   7155 12:46:54.650730  # # # handle_uprobe_upon_merged_vma: Test terminated by assertion
>   7156 12:46:54.661750  # # #          FAIL  merge.handle_uprobe_upon_merged_vma
>   7157 12:46:54.662030  # # not ok 8 merge.handle_uprobe_upon_merged_vma
> 

So, basically we're not finding the uprobe (I guess CONFIG_UPROBES isn't set in
defconfig, and it's not in the mm/config either), and the test just fails instead
of skipping.

-- 
Pedro

