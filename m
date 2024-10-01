Return-Path: <stable+bounces-78519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525F898BED7
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8639B20D47
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F471C0DD1;
	Tue,  1 Oct 2024 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LRNiruS+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ABC19C54A
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791397; cv=none; b=GYg6YPG5bke6ytL6U3Vnp5PmUba8qdxyfEQBRaA2eJ6zay43Vd+dNxXJzhFKC9lYPabzE7r22JLD4Aj4du/38ZSgmomO66VXq3SIOzZWI9Ah2hER3Q9xQq9yik7Vazb3lh90tDfgsd49DCDDEff1xVqnm0RRd4/TXHIKhN5uniY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791397; c=relaxed/simple;
	bh=pZT1BksTatY2QqOITU8f56mun92K+i79xz4IIv21nMw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WAWGk8JZmf5hJHOKs59WapSedkhsKCWOF3ive5b+kSA6zLs9qzOuMp5WKZW5Nrxv5wyPKkF6DxspVOAYML9ezM/ux99d46IlK6IzEcFDEVmyrWeMSZHES2hjaNdV2/aB0tOyyeDlzFEfqgkXadTO5YPfoLqN9RSCmYFejD9E11E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LRNiruS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6BBC4CEC6;
	Tue,  1 Oct 2024 14:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727791396;
	bh=pZT1BksTatY2QqOITU8f56mun92K+i79xz4IIv21nMw=;
	h=Subject:To:Cc:From:Date:From;
	b=LRNiruS+hEYbUkY/03YevZoBw+NW2k9lYbpsd8Onw6z2gxFCFot/Q4I1sx7oLvci8
	 f4F0ZBxnoiWnoOWg/wfYJcsVlORAGMsADG0/gRRXDBwKo1z1IqfjEohQu0O6qKAmJj
	 fOneJTzQoCu9dHuQNDilENBpI0g0Y65mSn3wpSYs=
Subject: FAILED: patch "[PATCH] padata: use integer wrap around to prevent deadlock on seq_nr" failed to apply to 5.4-stable tree
To: vangiang.nguyen@rohde-schwarz.com,christian.gafert@rohde-schwarz.com,daniel.m.jordan@oracle.com,herbert@gondor.apana.org.au,max.ferger@rohde-schwarz.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 16:03:11 +0200
Message-ID: <2024100110-smokiness-detract-b410@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 9a22b2812393d93d84358a760c347c21939029a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100110-smokiness-detract-b410@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

9a22b2812393 ("padata: use integer wrap around to prevent deadlock on seq_nr overflow")
57ddfecc72a6 ("padata: Fix list iterator in padata_do_serial()")
f601c725a6ac ("padata: remove padata_parallel_queue")
4611ce224688 ("padata: allocate work structures for parallel jobs from a pool")
f1b192b117cd ("padata: initialize earlier")
305dacf77952 ("padata: remove exit routine")
bfcdcef8c8e3 ("padata: update documentation")
3facced7aeed ("padata: remove reorder_objects")
91a71d612128 ("padata: remove cpumask change notifier")
894c9ef9780c ("padata: validate cpumask without removed CPU during offline")
bbefa1dd6a6d ("crypto: pcrypt - Avoid deadlock by using per-instance padata queues")
07928d9bfc81 ("padata: Remove broken queue flushing")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9a22b2812393d93d84358a760c347c21939029a6 Mon Sep 17 00:00:00 2001
From: VanGiang Nguyen <vangiang.nguyen@rohde-schwarz.com>
Date: Fri, 9 Aug 2024 06:21:42 +0000
Subject: [PATCH] padata: use integer wrap around to prevent deadlock on seq_nr
 overflow

When submitting more than 2^32 padata objects to padata_do_serial, the
current sorting implementation incorrectly sorts padata objects with
overflowed seq_nr, causing them to be placed before existing objects in
the reorder list. This leads to a deadlock in the serialization process
as padata_find_next cannot match padata->seq_nr and pd->processed
because the padata instance with overflowed seq_nr will be selected
next.

To fix this, we use an unsigned integer wrap around to correctly sort
padata objects in scenarios with integer overflow.

Fixes: bfde23ce200e ("padata: unbind parallel jobs from specific CPUs")
Cc: <stable@vger.kernel.org>
Co-developed-by: Christian Gafert <christian.gafert@rohde-schwarz.com>
Signed-off-by: Christian Gafert <christian.gafert@rohde-schwarz.com>
Co-developed-by: Max Ferger <max.ferger@rohde-schwarz.com>
Signed-off-by: Max Ferger <max.ferger@rohde-schwarz.com>
Signed-off-by: Van Giang Nguyen <vangiang.nguyen@rohde-schwarz.com>
Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/kernel/padata.c b/kernel/padata.c
index 53f4bc912712..222bccd0c96b 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -404,7 +404,8 @@ void padata_do_serial(struct padata_priv *padata)
 	/* Sort in ascending order of sequence number. */
 	list_for_each_prev(pos, &reorder->list) {
 		cur = list_entry(pos, struct padata_priv, list);
-		if (cur->seq_nr < padata->seq_nr)
+		/* Compare by difference to consider integer wrap around */
+		if ((signed int)(cur->seq_nr - padata->seq_nr) < 0)
 			break;
 	}
 	list_add(&padata->list, pos);


