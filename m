Return-Path: <stable+bounces-147119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D37AC5634
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660D61BA6F56
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B407D1E89C;
	Tue, 27 May 2025 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NmdhXSiL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8AE26F469;
	Tue, 27 May 2025 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748366347; cv=none; b=Mmh1nv7ltc58uApbYNKizCp8ZInZBWkidAEmZaEbIBNNnsLCmYZwlvlkwkRx56xwzmWOY+zbuTqfCWZepnziLwhMRsaHZDFGWobIKJkgL8RrKiUQmjiTuaQgkciLbJvK+vhwA0XUFfrEFaRjlc1Vc9IDOPtgI1jPdcBFlFVRB98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748366347; c=relaxed/simple;
	bh=6SQyuNyc/stxQGUejz6jU+tPGdtmFUyYbaRnp14M/Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWMOMyenuoyxHcd6avBHeTn1EY+0TUNgzyWV9JG0rxqSWhmRPvuP604xoel7wcao+4/9i+aA37bK1rBRKChXjrs2fPTtkyAtIKZ7NyiLLY2XT1faXCNI30By0f2BNr7EV09lGc7U8INRfB7/TzsgbHL17Rz5QwYxVc/2tUeFhKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NmdhXSiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA88C4CEE9;
	Tue, 27 May 2025 17:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748366347;
	bh=6SQyuNyc/stxQGUejz6jU+tPGdtmFUyYbaRnp14M/Ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NmdhXSiLQAfu0T3LEG3+i3L7vqfNaPQ0fxDhk2fIO5pV00z44LVEnPnrXFCkNNKdh
	 qopBKPpqaPeO8yfp6bK5uj4It3JP52isY8iDIDesyFIq3CykXeMv4MqOabhwc7Wi57
	 bvGY3/k72XOA5zWqrzq4WtTTTNr2fnl3hXlcEs20=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 038/783] selftests/bpf: Mitigate sockmap_ktls disconnect_after_delete failure
Date: Tue, 27 May 2025 18:17:15 +0200
Message-ID: <20250527162514.680349195@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ihor Solodrai <ihor.solodrai@linux.dev>

[ Upstream commit f2858f308131a09e33afb766cd70119b5b900569 ]

"sockmap_ktls disconnect_after_delete" test has been failing on BPF CI
after recent merges from netdev:
* https://github.com/kernel-patches/bpf/actions/runs/14458537639
* https://github.com/kernel-patches/bpf/actions/runs/14457178732

It happens because disconnect has been disabled for TLS [1], and it
renders the test case invalid.

Removing all the test code creates a conflict between bpf and
bpf-next, so for now only remove the offending assert [2].

The test will be removed later on bpf-next.

[1] https://lore.kernel.org/netdev/20250404180334.3224206-1-kuba@kernel.org/
[2] https://lore.kernel.org/bpf/cfc371285323e1a3f3b006bfcf74e6cf7ad65258@linux.dev/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://lore.kernel.org/bpf/20250416170246.2438524-1-ihor.solodrai@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 2d0796314862a..0a99fd404f6dc 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -68,7 +68,6 @@ static void test_sockmap_ktls_disconnect_after_delete(int family, int map)
 		goto close_cli;
 
 	err = disconnect(cli);
-	ASSERT_OK(err, "disconnect");
 
 close_cli:
 	close(cli);
-- 
2.39.5




