Return-Path: <stable+bounces-242250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGmPBohw9GmKBQIAu9opvQ
	(envelope-from <stable+bounces-242250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 11:21:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3564AB430
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 11:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE30530059A1
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 09:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D20F3815F4;
	Fri,  1 May 2026 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BmUzrO16"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6F33806AD
	for <stable@vger.kernel.org>; Fri,  1 May 2026 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777627268; cv=none; b=K/RCW0Gsz8BqtJRAk7SD0Ew5+/M+aNJRV6fsIRkg9zXaWp1+qwcHyZtgu/DlyM+NtSl6TDofSejvWUb4Jc2LEdzxV7TMt6Yv8IuB940WNXu8ECy9o2yYYaJJX8v9n+Hrbnnrnqjs1XmsBpecyNnXwX8VEsBzVL65rujvq2jEXf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777627268; c=relaxed/simple;
	bh=tdKSiIAwEctJYHhTWBuqPk3FC4+o78ANNDgtNPUJtrs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IFL/nq1iBoNZTdEicaEU6KLsNYx6Sp3JqTnruzhAtfRqCVY2Q0Au0lFqqv9wZduaYJBrDohBSNJhh1Jl/K9zAuxOPXhnriosooBCJSGD+qsYGl1HY53P5iPTbh7mgHX5eEg6cnUzCF/RDBeqrxL3qXCdNNtVdjsMi+cX3GoHWiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BmUzrO16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5312C2BCB4;
	Fri,  1 May 2026 09:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777627268;
	bh=tdKSiIAwEctJYHhTWBuqPk3FC4+o78ANNDgtNPUJtrs=;
	h=Subject:To:Cc:From:Date:From;
	b=BmUzrO16J8s2X0uW0sEIdDuAUCOHEeq/8ScrmR/qIfpJXCoiZaQpRYtCWtBZ7aqW4
	 QbOYbvCTYUhLvn/cymT654mfzBSleldbKDcbqLpxZxiiz5W6tW0mtUcBRgzI7YMSq6
	 KoREZIuq98/EvijccngEwiOGrtmq7L8sbFbfctSc=
Subject: FAILED: patch "[PATCH] mm/zsmalloc: copy KMSAN metadata in zs_page_migrate()" failed to apply to 6.12-stable tree
To: syoshida@redhat.com,akpm@linux-foundation.org,mark-pk.tsai@mediatek.com,minchan@kernel.org,senozhatsky@chromium.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 11:21:05 +0200
Message-ID: <2026050105-tremor-wispy-7169@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AC3564AB430
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242250-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chromium.org:email]


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 4fb61d95ad21c3b6f1c09f357ff49d70abb0535e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050105-tremor-wispy-7169@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4fb61d95ad21c3b6f1c09f357ff49d70abb0535e Mon Sep 17 00:00:00 2001
From: Shigeru Yoshida <syoshida@redhat.com>
Date: Sat, 21 Mar 2026 22:29:11 +0900
Subject: [PATCH] mm/zsmalloc: copy KMSAN metadata in zs_page_migrate()

zs_page_migrate() uses copy_page() to copy the contents of a zspage page
during migration.  However, copy_page() is not instrumented by KMSAN, so
the shadow and origin metadata of the destination page are not updated.

As a result, subsequent accesses to the migrated page are reported as
use-after-free by KMSAN, despite the data being correctly copied.

Add a kmsan_copy_page_meta() call after copy_page() to propagate the KMSAN
metadata to the new page, matching what copy_highpage() does internally.

Link: https://lkml.kernel.org/r/20260321132912.93434-1-syoshida@redhat.com
Fixes: afb2d666d025 ("zsmalloc: use copy_page for full page copy")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index e7417ece1c12..63128ddb7959 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1753,6 +1753,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	 */
 	d_addr = kmap_local_zpdesc(newzpdesc);
 	copy_page(d_addr, s_addr);
+	kmsan_copy_page_meta(zpdesc_page(newzpdesc), zpdesc_page(zpdesc));
 	kunmap_local(d_addr);
 
 	for (addr = s_addr + offset; addr < s_addr + PAGE_SIZE;


