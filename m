Return-Path: <stable+bounces-203639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D403ECE718F
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33E863001015
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C5C322C81;
	Mon, 29 Dec 2025 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c0CfF3dy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E2B322A27
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767019410; cv=none; b=RgMbFMUzr0PhZfXCnV3RTwLVCOcQFhOy98IoX2wakQsiYY9Kd4iq7p1GO67eyCBhWMpeJPIUccJBHzyCl8T+Sc0/uPfCUdOzCUKevuAJl64s84H9H6e8qQUiAycDNVLxraDZqlom5Hu/D72PttcKkVNAZlFTiV2FxYCXQvuE9h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767019410; c=relaxed/simple;
	bh=EWjPxxTIevYbxLzGTEIfAY6+OiL5PMkaDgA5xhyIhoA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HNjsEnMe6cuhrE0IJ2sLDR+ITkcWpmfqPhzevCvbf8Xh4VSRqH7S9Yk7TuwtG5nPOCihJ1b+1YbDbfaReKK+aSN9jhPNdBdFShwNn4VH4SWhAVoQtiTk6+8DCAXm0ADbmhhYS8MIRfwNkdI+HZ+iVPnCgo9QAW/gOZMhMhbZJjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c0CfF3dy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905AEC116C6;
	Mon, 29 Dec 2025 14:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767019409;
	bh=EWjPxxTIevYbxLzGTEIfAY6+OiL5PMkaDgA5xhyIhoA=;
	h=Subject:To:Cc:From:Date:From;
	b=c0CfF3dyroxGUllSj/Y5MqQCaSmXy+jmIl5Vz7fUsNmU8s79sfUSMMm8+PCVXaGuJ
	 Z4yOiHZ9UqrIRasaJhU/COan2g+PbKc1r3B2ULLb3TorOz3+U7n57VaYvmAeNlxfD5
	 2Q4I5vxsRtsFID6U+nNlcitnxJ9SQEMtz5fn2cJA=
Subject: FAILED: patch "[PATCH] svcrdma: bound check rq_pages index in inline path" failed to apply to 6.6-stable tree
To: linux@joshua.hu,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:43:18 +0100
Message-ID: <2025122918-oversight-jolliness-46c2@gregkh>
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
git cherry-pick -x d1bea0ce35b6095544ee82bb54156fc62c067e58
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122918-oversight-jolliness-46c2@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d1bea0ce35b6095544ee82bb54156fc62c067e58 Mon Sep 17 00:00:00 2001
From: Joshua Rogers <linux@joshua.hu>
Date: Fri, 7 Nov 2025 10:09:49 -0500
Subject: [PATCH] svcrdma: bound check rq_pages index in inline path

svc_rdma_copy_inline_range indexed rqstp->rq_pages[rc_curpage] without
verifying rc_curpage stays within the allocated page array. Add guards
before the first use and after advancing to a new page.

Fixes: d7cc73972661 ("svcrdma: support multiple Read chunks per RPC")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index e813e5463352..310de7a80be5 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -841,6 +841,9 @@ static int svc_rdma_copy_inline_range(struct svc_rqst *rqstp,
 	for (page_no = 0; page_no < numpages; page_no++) {
 		unsigned int page_len;
 
+		if (head->rc_curpage >= rqstp->rq_maxpages)
+			return -EINVAL;
+
 		page_len = min_t(unsigned int, remaining,
 				 PAGE_SIZE - head->rc_pageoff);
 


