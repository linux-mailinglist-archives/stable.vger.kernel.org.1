Return-Path: <stable+bounces-224743-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDoSOVuxsWmXEgAAu9opvQ
	(envelope-from <stable+bounces-224743-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 19:15:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10690268790
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 19:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E694304CCD0
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF63285CB3;
	Wed, 11 Mar 2026 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="pBBVOS28"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEEB3E3DA6;
	Wed, 11 Mar 2026 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773252951; cv=none; b=jAtOrJYFJc8ejUxW9tnxaUsrYyQVeUlCiAKg2pYXzh5gPJv7zwIhTmf+ITrYlKvsp5m1bIAMBPGe6Q8nnII1arQtw5fzIUurAZihu6HNRp6Ku2F/AaXt2w6kgzesjpLSacl4XJGxWW/QtUXi59GxjPe7IAqFI/pQ4qpzBuy2q4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773252951; c=relaxed/simple;
	bh=mhXBbC0jZZ3C2IzhNqn79wYdoC0r5cHoon09Ub+qHbI=;
	h=Date:To:From:Subject:Message-Id; b=gkmMHvLO9F1yqh205vSbRzdEKR6+BhcHltwmrSZCeCVSEDYxUL7sqAkj+yP8S673+NDb6B8gsXK5TaQB1MdQcZqrZFMffXgcU6xzB3BW522/2Xjul9QXJLjzLEZvnpDdqQBdK8gnEdEpvtuTbxKRiU3TnJuOxpBenVEvQdECmNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=pBBVOS28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C3AC4CEF7;
	Wed, 11 Mar 2026 18:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773252951;
	bh=mhXBbC0jZZ3C2IzhNqn79wYdoC0r5cHoon09Ub+qHbI=;
	h=Date:To:From:Subject:From;
	b=pBBVOS2880bWGRHRl9JqIO4AiEmohXGzFvIX3XCafh2bPYu3Gy3nVe1B6Kwq9eojf
	 ykyqI3+DUXVfwbVaiHzmWrK6G9RSzoC2cXw/KQx9y3LInNf2ZHdNtSbykhrIMAHNcD
	 kPIqdGK4PP7czNtm6nHFDiU4GghCzaLcrBziSA80=
Date: Wed, 11 Mar 2026 11:15:50 -0700
To: mm-commits@vger.kernel.org,zkabelac@redhat.com,urezki@gmail.com,stable@vger.kernel.org,sj@kernel.org,mhocko@suse.com,hch@lst.de,anshuman.khandual@arm.com,mpatocka@redhat.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [alternative-merged] mm-allow-__gfp_retry_mayfail-in-vmalloc.patch removed from -mm tree
Message-Id: <20260311181551.25C3AC4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224743-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,redhat.com,gmail.com,kernel.org,suse.com,lst.de,arm.com,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:email,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10690268790
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The quilt patch titled
     Subject: mm: allow __GFP_RETRY_MAYFAIL in vmalloc
has been removed from the -mm tree.  Its filename was
     mm-allow-__gfp_retry_mayfail-in-vmalloc.patch

This patch was dropped because an alternative patch was or shall be merged

------------------------------------------------------
From: Mikulas Patocka <mpatocka@redhat.com>
Subject: mm: allow __GFP_RETRY_MAYFAIL in vmalloc
Date: Thu, 12 Feb 2026 17:33:30 +0100 (CET)

The commit 07003531e03c8 ("mm/vmalloc: warn on invalid vmalloc gfp flags")
breaks the device mapper VDO target.  The VDO target calls vmalloc with
__GFP_RETRY_MAYFAIL and this flag is not in the mask of allowed flags.

There is no reason why vmalloc couldn't support __GFP_RETRY_MAYFAIL, so
let's add this flag to GFP_VMALLOC_SUPPORTED.

Link: https://lkml.kernel.org/r/ff48283b-be21-7f9a-d616-e303a4a1ebe6@redhat.com
Fixes: 07003531e03c ("mm/vmalloc: warn on invalid vmalloc gfp flags")
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reported-by: Zdenek Kabelac <zkabelac@redhat.com>
Acked-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: <stable@vger.kernel.org>	[6.19]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/vmalloc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/vmalloc.c~mm-allow-__gfp_retry_mayfail-in-vmalloc
+++ a/mm/vmalloc.c
@@ -3941,6 +3941,7 @@ fail:
  */
 #define GFP_VMALLOC_SUPPORTED (GFP_KERNEL | GFP_ATOMIC | GFP_NOWAIT |\
 				__GFP_NOFAIL |  __GFP_ZERO | __GFP_NORETRY |\
+				__GFP_RETRY_MAYFAIL |\
 				GFP_NOFS | GFP_NOIO | GFP_KERNEL_ACCOUNT |\
 				GFP_USER | __GFP_NOLOCKDEP)
 
_

Patches currently in -mm which might be from mpatocka@redhat.com are



