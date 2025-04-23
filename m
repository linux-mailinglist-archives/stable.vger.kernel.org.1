Return-Path: <stable+bounces-135590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E84A98F24
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B398920D30
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C72827F4CA;
	Wed, 23 Apr 2025 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vTIPkRQV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F6619DF4C;
	Wed, 23 Apr 2025 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420324; cv=none; b=oFNxI55bbO5wn1UONtyYV6Sg4/H58WMFEFt1HVrH+Xu7R6auIzgUb45pTEboXF0zMV63fyT7m36DaoKrg3MupwBwTwkrMlVSUjJFAkbDt64BlnVrDknosuIaZlEuv878UAE9KW/qp3mL02xWl2dUSdc9DP8X+47xKru7m6qe5BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420324; c=relaxed/simple;
	bh=AtdxKvor7etCHBlZNmXD3SvJVW8sItYCazOms7k/BhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b463Mc+mjj4h4Yq2XpcJgF1Rw7qGffHSXVyeVFT5Dx8aCtLlcMGuMGxL68zOYZTAGX7/GbnbuRc37w440+ib7/XwGrcGd3aM36w2Fcn1FWKYR7US7T4XzG10qHPPhzEfqZGvqyCoDKog1/VXKo0/5yjhS2QNYq08Mtmu5j6nuxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vTIPkRQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0390C4CEE8;
	Wed, 23 Apr 2025 14:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420324;
	bh=AtdxKvor7etCHBlZNmXD3SvJVW8sItYCazOms7k/BhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vTIPkRQV40YjsGqSzDFUpTajdI34oNFgMDmnzrMLHBCFVng96iQZkACI6PpTrqfMi
	 kLTvYKHRZ//QS54qid0EJLGzZCHNTgijlpRxIzEsvybusu5IA6kFzfX6FbtnqD4n2N
	 xd1I/0yStaJP0KqdkzWVAyHk0OPE+IEVY/4FNPBA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12 119/223] mm: fix filemap_get_folios_contig returning batches of identical folios
Date: Wed, 23 Apr 2025 16:43:11 +0200
Message-ID: <20250423142621.956713542@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
References: <20250423142617.120834124@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vishal Moola (Oracle) <vishal.moola@gmail.com>

commit 8ab1b16023961dc640023b10436d282f905835ad upstream.

filemap_get_folios_contig() is supposed to return distinct folios found
within [start, end].  Large folios in the Xarray become multi-index
entries.  xas_next() can iterate through the sub-indexes before finding a
sibling entry and breaking out of the loop.

This can result in a returned folio_batch containing an indeterminate
number of duplicate folios, which forces the callers to skeptically handle
the returned batch.  This is inefficient and incurs a large maintenance
overhead.

We can fix this by calling xas_advance() after we have successfully adding
a folio to the batch to ensure our Xarray is positioned such that it will
correctly find the next folio - similar to filemap_get_read_batch().

Link: https://lkml.kernel.org/r/Z-8s1-kiIDkzgRbc@fedora
Fixes: 35b471467f88 ("filemap: add filemap_get_folios_contig()")
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reported-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
Closes: https://lkml.kernel.org/r/b714e4de-2583-4035-b829-72cfb5eb6fc6@gmx.com
Tested-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/filemap.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2222,6 +2222,7 @@ unsigned filemap_get_folios_contig(struc
 			*start = folio->index + nr;
 			goto out;
 		}
+		xas_advance(&xas, folio_next_index(folio) - 1);
 		continue;
 put_folio:
 		folio_put(folio);



