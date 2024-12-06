Return-Path: <stable+bounces-99746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E139E731F
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4512893AC
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269E6153BE8;
	Fri,  6 Dec 2024 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZcdRcnlU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86EB14F9F4;
	Fri,  6 Dec 2024 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498214; cv=none; b=UN6zEGU/wlQxaziE5gjMskZdLrn7TWlj/vwg5ZAfuCm0js3OSFWCqW+dLbMBtlRVXWw9FefdFGGQPA1pnGawffFOlt6CXRvdkj1mXN4fg9W6xYJXpjjNnB5t4f77YrhH3L9QqCRDmTlHzI2tLm3MLiTs27/ctx00nPt/MN5Z5dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498214; c=relaxed/simple;
	bh=7mAxMbMfWoE04Rg/4LnUj1MePdwZ0rR35CYrIoyhgyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j67XgY8Qp/tA0TGnxvAqRSOkIUOeWQnv9SgBIgAE8JIg6ARKFctuQUNGNNdcwYarIX9GCkdMhCJ2lBjj2lXaCT1ae8FF3Vnp9Sm0N0pRzQQZ/FGBia6sLWptVmS8s/G60AbI1VibcPPBnOZHuXFpp2EXMIlfp/bdachM83S50u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZcdRcnlU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3E7C4CED1;
	Fri,  6 Dec 2024 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733498214;
	bh=7mAxMbMfWoE04Rg/4LnUj1MePdwZ0rR35CYrIoyhgyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZcdRcnlUr9oPkpN0gT5YMMTxR6Vh+vO+xJWY2DTtORfByvFa/fPzfj072lzpa9z0U
	 +hbsTe9IQlWhUOuKOtGDvbAQZHTlgftB/Ns3aAVDA8nCN0MlxZDHYKuKFCssM2B+8w
	 4ScTHzbRdRGxb+oC8OKpinY+XIi5RyqdioYAAXck=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH 6.6 487/676] apparmor: test: Fix memory leak for aa_unpack_strdup()
Date: Fri,  6 Dec 2024 15:35:06 +0100
Message-ID: <20241206143712.384337194@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinjie Ruan <ruanjinjie@huawei.com>

commit 7290f59231910ccba427d441a6e8b8c6f6112448 upstream.

The string allocated by kmemdup() in aa_unpack_strdup() is not
freed and cause following memory leaks, free them to fix it.

	unreferenced object 0xffffff80c6af8a50 (size 8):
	  comm "kunit_try_catch", pid 225, jiffies 4294894407
	  hex dump (first 8 bytes):
	    74 65 73 74 69 6e 67 00                          testing.
	  backtrace (crc 5eab668b):
	    [<0000000001e3714d>] kmemleak_alloc+0x34/0x40
	    [<000000006e6c7776>] __kmalloc_node_track_caller_noprof+0x300/0x3e0
	    [<000000006870467c>] kmemdup_noprof+0x34/0x60
	    [<000000001176bb03>] aa_unpack_strdup+0xd0/0x18c
	    [<000000008ecde918>] policy_unpack_test_unpack_strdup_with_null_name+0xf8/0x3ec
	    [<0000000032ef8f77>] kunit_try_run_case+0x13c/0x3ac
	    [<00000000f3edea23>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<00000000adf936cf>] kthread+0x2e8/0x374
	    [<0000000041bb1628>] ret_from_fork+0x10/0x20
	unreferenced object 0xffffff80c2a29090 (size 8):
	  comm "kunit_try_catch", pid 227, jiffies 4294894409
	  hex dump (first 8 bytes):
	    74 65 73 74 69 6e 67 00                          testing.
	  backtrace (crc 5eab668b):
	    [<0000000001e3714d>] kmemleak_alloc+0x34/0x40
	    [<000000006e6c7776>] __kmalloc_node_track_caller_noprof+0x300/0x3e0
	    [<000000006870467c>] kmemdup_noprof+0x34/0x60
	    [<000000001176bb03>] aa_unpack_strdup+0xd0/0x18c
	    [<0000000046a45c1a>] policy_unpack_test_unpack_strdup_with_name+0xd0/0x3c4
	    [<0000000032ef8f77>] kunit_try_run_case+0x13c/0x3ac
	    [<00000000f3edea23>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<00000000adf936cf>] kthread+0x2e8/0x374
	    [<0000000041bb1628>] ret_from_fork+0x10/0x20

Cc: stable@vger.kernel.org
Fixes: 4d944bcd4e73 ("apparmor: add AppArmor KUnit tests for policy unpack")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/apparmor/policy_unpack_test.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/security/apparmor/policy_unpack_test.c
+++ b/security/apparmor/policy_unpack_test.c
@@ -281,6 +281,8 @@ static void policy_unpack_test_unpack_st
 			   ((uintptr_t)puf->e->start <= (uintptr_t)string)
 			   && ((uintptr_t)string <= (uintptr_t)puf->e->end));
 	KUNIT_EXPECT_STREQ(test, string, TEST_STRING_DATA);
+
+	kfree(string);
 }
 
 static void policy_unpack_test_unpack_strdup_with_name(struct kunit *test)
@@ -296,6 +298,8 @@ static void policy_unpack_test_unpack_st
 			   ((uintptr_t)puf->e->start <= (uintptr_t)string)
 			   && ((uintptr_t)string <= (uintptr_t)puf->e->end));
 	KUNIT_EXPECT_STREQ(test, string, TEST_STRING_DATA);
+
+	kfree(string);
 }
 
 static void policy_unpack_test_unpack_strdup_out_of_bounds(struct kunit *test)
@@ -313,6 +317,8 @@ static void policy_unpack_test_unpack_st
 	KUNIT_EXPECT_EQ(test, size, 0);
 	KUNIT_EXPECT_NULL(test, string);
 	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, start);
+
+	kfree(string);
 }
 
 static void policy_unpack_test_unpack_nameX_with_null_name(struct kunit *test)



