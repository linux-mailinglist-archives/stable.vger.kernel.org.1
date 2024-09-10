Return-Path: <stable+bounces-74477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF59972F7C
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14930B2470E
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78248184101;
	Tue, 10 Sep 2024 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lpMunX1T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF9A224F6;
	Tue, 10 Sep 2024 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961920; cv=none; b=MkXUYPdoCFYz8Bcxz/e4gPBwE8cgcP5z2M8AXZzGWjPRUflmu/PXg6iU7dq8CouQ8M/QS71rj5JwJxmVEY0kL9ktTaD7La1oJwGE783kg14VWjJo9jaquawr6RWCiTRghd0KRXsVC6TKvGePBpe4Ngxc9zl8d3C08pzQIaKGOc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961920; c=relaxed/simple;
	bh=9qhLVxuNx52gVlexBxcVwi6/WzkhL/EA3uTvgV8MoXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSR9AgmxoV6We4MhxoVM73r0VQhZTwi71IVsGcCxpkZ9xJwclRxfZ6aEOAVn6u8XXisxlZg5C0WeSEarmvpFmhg+4l/XdywB8gbB53FwbroZ1+tif45rgOtqBX+K+Gr4IHPc4JYYHmjyvXrfucn9XIrkkYE2n3mOB0L1wDHzt9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lpMunX1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95A8C4CEC3;
	Tue, 10 Sep 2024 09:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961920;
	bh=9qhLVxuNx52gVlexBxcVwi6/WzkhL/EA3uTvgV8MoXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lpMunX1Tp6tiwN9hH+RoyJLDAR4lzCpJLMCspVp0fqcJ+OPUEAgZXX5L9MwjJ8NGx
	 CDeaw45XgVKI5k2In47qcq4qMDi949dqTaq7itwKDFs9gs1Ck1HGaitvI5sWUlEERk
	 Gldlj8dCvaxbvYkKzgOdggd5bQqtDRFWxihNHPr0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martin KaFai Lau <martin.lau@linux.dev>,
	syzbot+608a2acde8c5a101d07d@syzkaller.appspotmail.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 234/375] bpf: Remove tst_run from lwt_seg6local_prog_ops.
Date: Tue, 10 Sep 2024 11:30:31 +0200
Message-ID: <20240910092630.405873491@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit c13fda93aca118b8e5cd202e339046728ee7dddb ]

The syzbot reported that the lwt_seg6 related BPF ops can be invoked
via bpf_test_run() without without entering input_action_end_bpf()
first.

Martin KaFai Lau said that self test for BPF_PROG_TYPE_LWT_SEG6LOCAL
probably didn't work since it was introduced in commit 04d4b274e2a
("ipv6: sr: Add seg6local action End.BPF"). The reason is that the
per-CPU variable seg6_bpf_srh_states::srh is never assigned in the self
test case but each BPF function expects it.

Remove test_run for BPF_PROG_TYPE_LWT_SEG6LOCAL.

Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
Reported-by: syzbot+608a2acde8c5a101d07d@syzkaller.appspotmail.com
Fixes: d1542d4ae4df ("seg6: Use nested-BH locking for seg6_bpf_srh_states.")
Fixes: 004d4b274e2a ("ipv6: sr: Add seg6local action End.BPF")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/r/20240710141631.FbmHcQaX@linutronix.de
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index ab0455c64e49..55b1d9de2334 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11047,7 +11047,6 @@ const struct bpf_verifier_ops lwt_seg6local_verifier_ops = {
 };
 
 const struct bpf_prog_ops lwt_seg6local_prog_ops = {
-	.test_run		= bpf_prog_test_run_skb,
 };
 
 const struct bpf_verifier_ops cg_sock_verifier_ops = {
-- 
2.43.0




