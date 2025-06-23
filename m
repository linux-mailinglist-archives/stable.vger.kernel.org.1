Return-Path: <stable+bounces-156537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8F6AE5038
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEA3C7A46D4
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A7D1ACEDA;
	Mon, 23 Jun 2025 21:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vDFmqJnQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32947482;
	Mon, 23 Jun 2025 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713656; cv=none; b=Tyf8sFDUAJBAx4wNQ3lI/tvUzkwtT5EnU/X+3c/Y/hGorAmt5dNGOlflWTmYFatrxuJCxjYGg7luvYeP+Igw8Q9r+emQq7BqzSCKcjfk9OEsIY+LLUU7BfZMLBqIXzo6C1ZHsASzs9gyStRyDaLEmIVdnHtnHJdJGhV2M/uyMHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713656; c=relaxed/simple;
	bh=ZTlgaRRjSoL9UzXJ17XtpdBXA7tzJYVtDh8EtMR0OIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMP7tN2V7V3l0nqfme1ty9qg98CkoSSQz9GsSZv8j9ixne/bR4gRnbDgLm+f1m8JGCscaRh3Hh3yW+ChQqoE40LE+sAn+sklr64rJlSIN8DvjUC9m3dVFrpp6JiaexXhmIZ4rB0zYXod3B8GX2z7X94P7hG/AcJNX/QRBQbA4E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vDFmqJnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73036C4CEEA;
	Mon, 23 Jun 2025 21:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750713655;
	bh=ZTlgaRRjSoL9UzXJ17XtpdBXA7tzJYVtDh8EtMR0OIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vDFmqJnQqgKuFK7tBkI/MRYFB/dZiVBYc6ICg63relLjXyo7uTif6Feff2KRoB/YP
	 mfKMlmd98xHHisHI3H+Go59wx9oP2NLLjzW3CFTLXsxCCa9lsJ72N35bL7o6wZouON
	 Ea/vlXRJkG/ePFROGwMam0lxuXmvicB2108/7uOI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 5.4 198/222] erofs: remove unused trace event erofs_destroy_inode
Date: Mon, 23 Jun 2025 15:08:53 +0200
Message-ID: <20250623130618.183092035@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130611.896514667@linuxfoundation.org>
References: <20250623130611.896514667@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <hsiangkao@linux.alibaba.com>

commit 30b58444807c93bffeaba7d776110f2a909d2f9a upstream.

The trace event `erofs_destroy_inode` was added but remains unused. This
unused event contributes approximately 5KB to the kernel module size.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Closes: https://lore.kernel.org/r/20250612224906.15000244@batman.local.home
Fixes: 13f06f48f7bf ("staging: erofs: support tracepoint")
Cc: stable@vger.kernel.org
Reviewed-by: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20250617054056.3232365-1-hsiangkao@linux.alibaba.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/trace/events/erofs.h |   18 ------------------
 1 file changed, 18 deletions(-)

--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -235,24 +235,6 @@ DEFINE_EVENT(erofs__map_blocks_exit, z_e
 	TP_ARGS(inode, map, flags, ret)
 );
 
-TRACE_EVENT(erofs_destroy_inode,
-	TP_PROTO(struct inode *inode),
-
-	TP_ARGS(inode),
-
-	TP_STRUCT__entry(
-		__field(	dev_t,		dev		)
-		__field(	erofs_nid_t,	nid		)
-	),
-
-	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
-		__entry->nid	= EROFS_I(inode)->nid;
-	),
-
-	TP_printk("dev = (%d,%d), nid = %llu", show_dev_nid(__entry))
-);
-
 #endif /* _TRACE_EROFS_H */
 
  /* This part must be outside protection */



