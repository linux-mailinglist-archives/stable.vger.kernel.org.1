Return-Path: <stable+bounces-259726-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMq4B1l7HmrejQkAu9opvQ
	(envelope-from <stable+bounces-259726-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 08:42:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B823A6291E4
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 08:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FEED3003ECC
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 06:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0793A7F40;
	Tue,  2 Jun 2026 06:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="p6MC8xIh"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0F84204E;
	Tue,  2 Jun 2026 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382213; cv=none; b=NXQqmhJiseVDqETYRrR4GYNmjMlVLbCUOjZR1iDltp5PRpC8vnosqYjQjaJdWMmKSYst93kUnmtqAp5vlF9Z7JYdkGVfb7B2kLUMQt/5B8HAvBtrGrUoziq5jmsWReNGB9j6UuWtup7smlJsxIP/M3Tk6P984rnL28xlP8NxSpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382213; c=relaxed/simple;
	bh=hpM60ECSu6dT7z/73PUh64EF1RP0RcF1FXtP1wXOo5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cb6cg5OzEeSym5VrzUMQ4eP5OEXh9Q4/k8St4hgtzG9CVDSDMPajUh4h4nqpcxTGK5GxaMLYHV7NoofBgs/L8KLwfP33r9plh5nK6PyJntX7g+AH9LiiT5hSYCRL7+sxtwzg1o2belr9lJbxr2BP+q4ll2BuJavCqdNUVS7LsmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=p6MC8xIh; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE51232CF;
	Mon,  1 Jun 2026 23:36:45 -0700 (PDT)
Received: from [10.164.19.28] (unknown [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 501BC3F632;
	Mon,  1 Jun 2026 23:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780382210; bh=hpM60ECSu6dT7z/73PUh64EF1RP0RcF1FXtP1wXOo5Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p6MC8xIhKHmkf2W6HFKQ7QZ4vR+bfrEuDshR6Wi+MXh/bkI0sViriLHyI7KajfB0/
	 lx3Xo/r4+mfUm6f/ddif0SV/Bl7oWf5SFDDgxZ3/gsEdtPULneWc9tMQopmKCrgFZz
	 TnzwR72Cge9hd4K01+lgzkQwKxu40Dyn/1qlf6Mo=
Message-ID: <47959866-1289-41ba-9cb4-dea33fe8b721@arm.com>
Date: Tue, 2 Jun 2026 12:06:42 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] fs/proc/task_mmu: use huge_page_size() in
 pagemap_scan_hugetlb_entry()
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Lorenzo Stoakes <ljs@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>, stable@vger.kernel.org,
 Sashiko AI review <sashiko-bot@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Muhammad Usama Anjum <usama.anjum@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Andrei Vagin <avagin@gmail.com>, linux-fsdevel@vger.kernel.org
References: <20260529172331.356655-1-kas@kernel.org>
 <20260529172331.356655-3-kas@kernel.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20260529172331.356655-3-kas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,kernel.org,infradead.org,google.com,suse.de,rere.qmqm.pl,arm.com,arndb.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259726-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev.jain@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,arm.com:mid,arm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B823A6291E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 29/05/26 10:53 pm, Kiryl Shutsemau (Meta) wrote:
> The partial-page check compares against HPAGE_SIZE (PMD_SIZE), which
> is wrong for gigantic hugetlb hstates (e.g. 1G). The walker hands the
> callback a huge_page_size()-sized range, never start + HPAGE_SIZE, so
> the comparison always declares it partial and aborts the WP. Compare
> against the actual hstate's page size.
> 
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>


>  fs/proc/task_mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index e21a38ac745b..1489c67e88f7 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2960,7 +2960,7 @@ static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
>  	if (~categories & PAGE_IS_WRITTEN)
>  		goto out_unlock;
>  
> -	if (end != start + HPAGE_SIZE) {
> +	if (end != start + huge_page_size(hstate_vma(vma))) {
>  		/* Partial HugeTLB page WP isn't possible. */
>  		pagemap_scan_backout_range(p, start, end);
>  		p->arg.walk_end = start;


