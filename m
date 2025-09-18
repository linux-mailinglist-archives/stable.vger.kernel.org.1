Return-Path: <stable+bounces-171607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B2EB2AAE4
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E35F1B6398F
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5413830EF7A;
	Mon, 18 Aug 2025 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vf1nbFJN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E909345727;
	Mon, 18 Aug 2025 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526504; cv=none; b=OXHzRpD05xqiyfdmjiCpsD+HThS7TfEraiYeGjuc2Gx4MGtF2hA4isEx8lDSK5WdetfA+o2uXvdzZ41P7nnNo+iUX00sHkc7Dz/ifQNxTZbh7LScmUvUoBG4sn9yHgxPccBQnt94+ctx2haq9ocMELE8OLIUF+GGqvSQQBAWg1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526504; c=relaxed/simple;
	bh=N+zv2TqfdSlzq9nxU9UwXIyjQqMmkAmvLJEsaey7bJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhjPiFm/S1ZK1vdYCMK84AzR6SwdKC49yw+P0tBdLXIgXARl23arMbrmIHnIHfIGaZqIO1MkISSKIUxfrMH4CpWkcjCYGgUk5nAHUlQ47Ame3lRhWBUxRuFt+te+BfS2+RU7Jz7+l+086ys2geUiqcITtLBehbEe0zhfJuqWhvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vf1nbFJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7082AC4CEEB;
	Mon, 18 Aug 2025 14:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755526503;
	bh=N+zv2TqfdSlzq9nxU9UwXIyjQqMmkAmvLJEsaey7bJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vf1nbFJN9SZu01YhDWRrklqfyJcTUFVA4M+fBXauGk1Fkfiqn5162xDeTgP7oR8yC
	 Acb2CK+kTzDH33aFIyQF9X6rHNNEUNRrQgu3HNKbM9gh2d6pxHmjNUKGk4QfI+XmM5
	 VvhhNrTc+jM61zWpZWIojl8YroyEQpXoy8BkYH6k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>,
	David Howells <dhowells@redhat.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 6.16 556/570] RDMA/siw: Fix the sendmsg byte count in siw_tcp_sendpages
Date: Mon, 18 Aug 2025 14:49:03 +0200
Message-ID: <20250818124527.291147821@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pedro Falcato <pfalcato@suse.de>

commit c18646248fed07683d4cee8a8af933fc4fe83c0d upstream.

Ever since commit c2ff29e99a76 ("siw: Inline do_tcp_sendpages()"),
we have been doing this:

static int siw_tcp_sendpages(struct socket *s, struct page **page, int offset,
                             size_t size)
[...]
        /* Calculate the number of bytes we need to push, for this page
         * specifically */
        size_t bytes = min_t(size_t, PAGE_SIZE - offset, size);
        /* If we can't splice it, then copy it in, as normal */
        if (!sendpage_ok(page[i]))
                msg.msg_flags &= ~MSG_SPLICE_PAGES;
        /* Set the bvec pointing to the page, with len $bytes */
        bvec_set_page(&bvec, page[i], bytes, offset);
        /* Set the iter to $size, aka the size of the whole sendpages (!!!) */
        iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
try_page_again:
        lock_sock(sk);
        /* Sendmsg with $size size (!!!) */
        rv = tcp_sendmsg_locked(sk, &msg, size);

This means we've been sending oversized iov_iters and tcp_sendmsg calls
for a while. This has a been a benign bug because sendpage_ok() always
returned true. With the recent slab allocator changes being slowly
introduced into next (that disallow sendpage on large kmalloc
allocations), we have recently hit out-of-bounds crashes, due to slight
differences in iov_iter behavior between the MSG_SPLICE_PAGES and
"regular" copy paths:

(MSG_SPLICE_PAGES)
skb_splice_from_iter
  iov_iter_extract_pages
    iov_iter_extract_bvec_pages
      uses i->nr_segs to correctly stop in its tracks before OoB'ing everywhere
  skb_splice_from_iter gets a "short" read

(!MSG_SPLICE_PAGES)
skb_copy_to_page_nocache copy=iov_iter_count
 [...]
   copy_from_iter
        /* this doesn't help */
        if (unlikely(iter->count < len))
                len = iter->count;
          iterate_bvec
            ... and we run off the bvecs

Fix this by properly setting the iov_iter's byte count, plus sending the
correct byte count to tcp_sendmsg_locked.

Link: https://patch.msgid.link/r/20250729120348.495568-1-pfalcato@suse.de
Cc: stable@vger.kernel.org
Fixes: c2ff29e99a76 ("siw: Inline do_tcp_sendpages()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202507220801.50a7210-lkp@intel.com
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: Bernard Metzler <bernard.metzler@linux.dev>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -332,18 +332,17 @@ static int siw_tcp_sendpages(struct sock
 		if (!sendpage_ok(page[i]))
 			msg.msg_flags &= ~MSG_SPLICE_PAGES;
 		bvec_set_page(&bvec, page[i], bytes, offset);
-		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
+		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, bytes);
 
 try_page_again:
 		lock_sock(sk);
-		rv = tcp_sendmsg_locked(sk, &msg, size);
+		rv = tcp_sendmsg_locked(sk, &msg, bytes);
 		release_sock(sk);
 
 		if (rv > 0) {
 			size -= rv;
 			sent += rv;
 			if (rv != bytes) {
-				offset += rv;
 				bytes -= rv;
 				goto try_page_again;
 			}



