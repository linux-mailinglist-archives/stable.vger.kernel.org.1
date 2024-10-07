Return-Path: <stable+bounces-81339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B479930B7
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3B2BB241E4
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 15:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41A41DB365;
	Mon,  7 Oct 2024 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y2UCG/pa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A190D1DB350
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313609; cv=none; b=P8/+0ETiecUoFcBIc6lBYCAMxxVqmA/SY7Lrte761x+No6RiioCAQIysoH4RWP8RZp2TaKh2nzuzdGfZDo4M+lD8wTSeHJn/O9Qh+BW5Sj7+uByuc7bcNrwJsIB8vOHzdUiNx+Bb8mYZhnsjMYf/yxnj59hJ/UyGc7A8LSlR2as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313609; c=relaxed/simple;
	bh=D4yYKehsV3AvBEu2arCTqx4yOouPNeoQo8l8KaaYCXM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SUGqeqzWlF8MS2tPV2lBWE98IQLp3Bb/UCTC8WCSSu0F8q2MuIRH5pE4Jylhf1TQVyn1L8KKNrXt2uvFcUEvLCDi3o9/xULe24M5RNnzoymyzfIXs2LD2stVKgh5zpPDfR4fYvBCSahbvTjOUC7E1tO0Cd3VfI/cE7ka5fHVdUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y2UCG/pa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91B5C4CEC6;
	Mon,  7 Oct 2024 15:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728313609;
	bh=D4yYKehsV3AvBEu2arCTqx4yOouPNeoQo8l8KaaYCXM=;
	h=Subject:To:Cc:From:Date:From;
	b=y2UCG/paXkHuFDLuLNdcme+MKiTtfuvGNH0fr9rI0c/t0sQx1g/xGYfvXxvr5ASQy
	 JZEuRK7kUgri46S+VYCRE9auHO+X1JTCzP9gnF9ToUrLijKjXsQk3RZWZkxehK+lXJ
	 uS9P8lPyUUC1xOJskQv9VB2/OIPghlYrjiv2/hx0=
Subject: FAILED: patch "[PATCH] zram: free secondary algorithms names" failed to apply to 6.6-stable tree
To: senozhatsky@chromium.org,akpm@linux-foundation.org,minchan@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 17:06:24 +0200
Message-ID: <2024100724-used-ventricle-7559@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 684826f8271ad97580b138b9ffd462005e470b99
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100724-used-ventricle-7559@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

684826f8271a ("zram: free secondary algorithms names")
f2bac7ad187d ("zram: introduce zcomp_params structure")
1d3100cf148d ("zram: add 842 compression backend support")
84112e314f69 ("zram: add zlib compression backend support")
dbf2763cec21 ("zram: pass estimated src size hint to zstd")
73e7d81abbc8 ("zram: add zstd compression backend support")
c60a4ef54446 ("zram: add lz4hc compression backend support")
22d651c3b339 ("zram: add lz4 compression backend support")
2152247c55b6 ("zram: add lzo and lzorle compression backends support")
917a59e81c34 ("zram: introduce custom comp backends API")
04cb7502a5d7 ("zsmalloc: use all available 24 bits of page_type")
43d746dc49bb ("mm/zsmalloc: use a proper page type")
8db00ad56461 ("mm: allow reuse of the lower 16 bit of the page type with an actual type")
6d21dde7adc0 ("mm: update _mapcount and page_type documentation")
ff202303c398 ("mm: convert page type macros to enum")
46df8e73a4a3 ("mm: free up PG_slab")
d99e3140a4d3 ("mm: turn folio_test_hugetlb into a PageType")
fd1a745ce03e ("mm: support page_mapcount() on page_has_type() pages")
29cfe7556bfd ("mm: constify more page/folio tests")
443cbaf9e2fd ("crash: split vmcoreinfo exporting code out from crash_core.c")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 684826f8271ad97580b138b9ffd462005e470b99 Mon Sep 17 00:00:00 2001
From: Sergey Senozhatsky <senozhatsky@chromium.org>
Date: Wed, 11 Sep 2024 11:54:56 +0900
Subject: [PATCH] zram: free secondary algorithms names

We need to kfree() secondary algorithms names when reset zram device that
had multi-streams, otherwise we leak memory.

[senozhatsky@chromium.org: kfree(NULL) is legal]
  Link: https://lkml.kernel.org/r/20240917013021.868769-1-senozhatsky@chromium.org
Link: https://lkml.kernel.org/r/20240911025600.3681789-1-senozhatsky@chromium.org
Fixes: 001d92735701 ("zram: add recompression algorithm sysfs knob")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1f1bf175a6c3..0207a7fc0a97 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2112,6 +2112,11 @@ static void zram_destroy_comps(struct zram *zram)
 		zram->num_active_comps--;
 	}
 
+	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
+		kfree(zram->comp_algs[prio]);
+		zram->comp_algs[prio] = NULL;
+	}
+
 	zram_comp_params_reset(zram);
 }
 


