Return-Path: <stable+bounces-204048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF53CE78CD
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64F3B301A0D4
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9BD333443;
	Mon, 29 Dec 2025 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gKM3sE+Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B1E331A4C;
	Mon, 29 Dec 2025 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767025902; cv=none; b=qQkt23WxZNtlBd1/Anp8qCwkawWC6MIbQtPOEojsSDXcSzqT4a3BDqI1/jPrAPZCDXY7Y6jeFuQHwCAhiItrNB3FX59uVMxWk7DwKXh4eFN7gMevd3aPXMbmrnGy1uEtjonoN65w1UMWos3swbecrBjqr1IGjxG0cPCcQI7WIUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767025902; c=relaxed/simple;
	bh=nbYjEBEnm7ETQJX2fao0tmEOAD8mwHIbV/jYAlCkMpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdTwr9dJJ1R8CveO5wk+yYpNI/cF0i/6YV09rxLy8FOFY+OL0mbp0tGpK0SjIQE6YCwgGCRfsenJVk5ERscKTQX1wYsO9vZarnHrGhGmFjGagE571AwT66y44OFUaV6Mn0tgQ7fvba9RNTAGjSsvzqIstcUdEIZKrxWBj5ytLcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gKM3sE+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4428C4CEF7;
	Mon, 29 Dec 2025 16:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767025902;
	bh=nbYjEBEnm7ETQJX2fao0tmEOAD8mwHIbV/jYAlCkMpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKM3sE+ZgqrbRJavj8367i9indh/jwdxk7JXsgbEoC0TgS2Iowzyypx+tr98bFigq
	 3kg5goq6iLja6EVKNfnaxhUsxf4NuuZxjwxA0QtKzce39N2XcL4jemyHofpNGSbvXm
	 ysjY1guG9jswSdljG2FIjcZYVWs7AXI7Gb5B2P7A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joshua Rogers <linux@joshua.hu>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.18 376/430] svcrdma: use rc_pageoff for memcpy byte offset
Date: Mon, 29 Dec 2025 17:12:58 +0100
Message-ID: <20251229160738.158189766@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
References: <20251229160724.139406961@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joshua Rogers <linux@joshua.hu>

commit a8ee9099f30654917aa68f55d707b5627e1dbf77 upstream.

svc_rdma_copy_inline_range added rc_curpage (page index) to the page
base instead of the byte offset rc_pageoff. Use rc_pageoff so copies
land within the current page.

Found by ZeroPath (https://zeropath.com)

Fixes: 8e122582680c ("svcrdma: Move svc_rdma_read_info::ri_pageno to struct svc_rdma_recv_ctxt")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -851,7 +851,7 @@ static int svc_rdma_copy_inline_range(st
 			head->rc_page_count++;
 
 		dst = page_address(rqstp->rq_pages[head->rc_curpage]);
-		memcpy(dst + head->rc_curpage, src + offset, page_len);
+		memcpy((unsigned char *)dst + head->rc_pageoff, src + offset, page_len);
 
 		head->rc_readbytes += page_len;
 		head->rc_pageoff += page_len;



