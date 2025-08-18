Return-Path: <stable+bounces-171056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0BDB2A7E3
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D2D6E0B27
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5999D335BC6;
	Mon, 18 Aug 2025 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c35nb7vK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17566335BA3;
	Mon, 18 Aug 2025 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524675; cv=none; b=ZueLAvfg9D3ate2KKwxclxzwJfUuglxuooRTeSNTJhZX3mCtiwJDjw8CkKguuUvRxpOXpfV/ewiNEnsc050p8GbgQwHeuJNCl41fQzTGGtLdycDJ7uKb0uGdjYHiGQTJe2sEc3XeD2j3iDDrgvefqrTxslYcVnyB1npv3GpJMBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524675; c=relaxed/simple;
	bh=DxDdMJZ9nL7ruDFgGG0ZCib4NiewEDg/hyXZdT1ph0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDwMtGdDzFrqSDMIbTiGD6CRzN72HvQOl1rE1X8Ni06TjUdhiCC8WZwewG0mF92eCnznhf4+lx6sajQdDuZDiPtkK6aars/ZGXZmnJKS/K/jhSerxA+wHfoSqOYieMNA90e8BSextsSVoin/c/9/Qmha1qktOe9jJUmsf23dvbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c35nb7vK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265E6C4CEEB;
	Mon, 18 Aug 2025 13:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755524674;
	bh=DxDdMJZ9nL7ruDFgGG0ZCib4NiewEDg/hyXZdT1ph0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c35nb7vKW5PqQ9u5fj8XcVK/TQGQ6JC1Xjyt365nJ5qbaB0SycND9EZAQHiTQi1US
	 DhFgDVPhtYvrQ8CFXAbV56LfjrjOOB1TcP65kKEGUV7aYBZRoI1ufD2TA5qYh876K5
	 Nl04wq7dEh2ROii1RGN/shtDymV01FznkrOIFBLE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+23727438116feb13df15@syzkaller.appspotmail.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.16 004/570] io_uring/memmap: cast nr_pages to size_t before shifting
Date: Mon, 18 Aug 2025 14:39:51 +0200
Message-ID: <20250818124505.958550911@linuxfoundation.org>
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

From: Jens Axboe <axboe@kernel.dk>

commit 33503c083fda048c77903460ac0429e1e2c0e341 upstream.

If the allocated size exceeds UINT_MAX, then it's necessary to cast
the mr->nr_pages value to size_t to prevent it from overflowing. In
practice this isn't much of a concern as the required memory size will
have been validated upfront, and accounted to the user. And > 4GB sizes
will be necessary to make the lack of a cast a problem, which greatly
exceeds normal user locked_vm settings that are generally in the kb to
mb range. However, if root is used, then accounting isn't done, and
then it's possible to hit this issue.

Link: https://lore.kernel.org/all/6895b298.050a0220.7f033.0059.GAE@google.com/
Cc: stable@vger.kernel.org
Reported-by: syzbot+23727438116feb13df15@syzkaller.appspotmail.com
Fixes: 087f997870a9 ("io_uring/memmap: implement mmap for regions")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/memmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/io_uring/memmap.c
+++ b/io_uring/memmap.c
@@ -156,7 +156,7 @@ static int io_region_allocate_pages(stru
 				    unsigned long mmap_offset)
 {
 	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_NOWARN;
-	unsigned long size = mr->nr_pages << PAGE_SHIFT;
+	size_t size = (size_t) mr->nr_pages << PAGE_SHIFT;
 	unsigned long nr_allocated;
 	struct page **pages;
 	void *p;



