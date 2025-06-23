Return-Path: <stable+bounces-155390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3378BAE41D4
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024C5173CE5
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EDA252292;
	Mon, 23 Jun 2025 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NQ5aEnBz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8421F2505CE;
	Mon, 23 Jun 2025 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684302; cv=none; b=Tr1B0xrZxOLcOA8MLbKUEi0VFaFEAem1h7aGMOnFi0nURLKjuI1xXS3iMlf+fYrCHc7GXbqJkG6LjOajL4LDFHKn8ApH5EdZNGIk3aFuYrhjyc4jciVpgUM0P8J7wiHMocy3eGX1Lyi8SYai4Kzxt84sMFLoQulGj2xQFqo+YZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684302; c=relaxed/simple;
	bh=sxU3OmJPwBBAJR8zd1RPoEbyapsOnWVZ2uGxbERTltA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvFPVAHvscDkrQsjRJVB5drBNbXKVEvNh+wa1L+mbVjR+t2Wh6fnu58Bn6hKN2x/qA8uQYcg2+Uv9iSXqxNDzURzLDWEsp9YTKzlJ+NLQu2b3gGdAa3a9yGouUCxplh9ScZoOEeG1bbswJQBhvRxcR8LvrOoWZ/1sWP94FXgU/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NQ5aEnBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DCBC4CEEA;
	Mon, 23 Jun 2025 13:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750684302;
	bh=sxU3OmJPwBBAJR8zd1RPoEbyapsOnWVZ2uGxbERTltA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NQ5aEnBzaG3Pa37vLXcIj58JpnvIcCho8RBkz97TlP0hGJNV0EE5XHgwvNgHRBrOX
	 wcwT80Z2v8Egrm0ZxiUMKE/YqKoiuUQ5HyODWQc78fh81WIc8og64HKS44QXhGt/ay
	 4KDZ281IfML873O1X/vT/zn31Riv5gwA5iibbEkM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.15 017/592] io_uring: account drain memory to cgroup
Date: Mon, 23 Jun 2025 14:59:35 +0200
Message-ID: <20250623130700.634696878@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Begunkov <asml.silence@gmail.com>

commit f979c20547e72568e3c793bc92c7522bc3166246 upstream.

Account drain allocations against memcg. It's not a big problem as each
such allocation is paired with a request, which is accounted, but it's
nicer to follow the limits more closely.

Cc: stable@vger.kernel.org # 6.1
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/f8dfdbd755c41fd9c75d12b858af07dfba5bbb68.1746788718.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1689,7 +1689,7 @@ queue:
 	spin_unlock(&ctx->completion_lock);
 
 	io_prep_async_link(req);
-	de = kmalloc(sizeof(*de), GFP_KERNEL);
+	de = kmalloc(sizeof(*de), GFP_KERNEL_ACCOUNT);
 	if (!de) {
 		ret = -ENOMEM;
 		io_req_defer_failed(req, ret);



