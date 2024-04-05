Return-Path: <stable+bounces-36137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C5E89A282
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 18:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24D52821F8
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 16:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC5D17109D;
	Fri,  5 Apr 2024 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ET+tglv6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A98716F27B;
	Fri,  5 Apr 2024 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334578; cv=none; b=VsuLjSVaefDCdy64okjlGf5haBI01BzK9sn3TZcoiZswvos5ZEalqF2OVgZV1btBr3n1FLu5YDKug6EaGin4xWpH+kj6QCJQRXsveTdpuuxAAdPHjW3Fz+8evfOV2n4rGdji7nl1Rf3V1lVMa+UBxMd1p3nLjQgQLmuTdJZqotg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334578; c=relaxed/simple;
	bh=KihqcYDrq7c/A9UdGLxFUePTlzZ5bk4ZzDlVQv1u4hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXeJeJb2O+UHzlhH6UuvX7xXLQ1kOC9cKN1L/whzL+qPLBGec5O/2p0o7Cz1g4X9snyV33ABcYUHlRbJX2N/3H7vXfO9KnWiS6GoqMdeOdEoyeyi12/aSabRg2+H0YrngnRaeJy6BTfaYNbke1cUOEWGBUakw+GgvQsCErVZxjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ET+tglv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156CFC433F1;
	Fri,  5 Apr 2024 16:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712334578;
	bh=KihqcYDrq7c/A9UdGLxFUePTlzZ5bk4ZzDlVQv1u4hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ET+tglv6ZpdQ20prrQhOxrNnaJbTbGKeRFtRh54QbnofpKo3eG8TuHp73MG4ONZvt
	 XfV85v294NkWnwGeqiEKo3985kxNziWG//Lo5YSMs1BWzm7kHimxFfQSGSXfn4R/+j
	 vi1SXDDD9C+AwsMTqiCv6HD2LrCZEdpgm2odcDKKkN2CNVUKb17nsWsXPxEUCUr8GV
	 JvK3osnf3J/Miytcb3cDEqVZ5LVCgwib9oM6RxeOK5xTeVL2jSpBtHxCMIwqlGMPeS
	 EDQkw71X9/9GE6Zs2aTqlYvojtja5AksLfiuzbNmY7mJfgJDc6MvHXRdbwhvgO+xhy
	 jP97t7/Kpc8EA==
From: Andrii Nakryiko <andrii@kernel.org>
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 6.8.y 1/2] bpf: put uprobe link's path and task in release callback
Date: Fri,  5 Apr 2024 09:29:31 -0700
Message-ID: <20240405162932.4047185-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024040527-propeller-immovably-a6d8@gregkh>
References: <2024040527-propeller-immovably-a6d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to delay putting either path or task to deallocation
step. It can be done right after bpf_uprobe_unregister. Between release
and dealloc, there could be still some running BPF programs, but they
don't access either task or path, only data in link->uprobes, so it is
safe to do.

On the other hand, doing path_put() in dealloc callback makes this
dealloc sleepable because path_put() itself might sleep. Which is
problematic due to the need to call uprobe's dealloc through call_rcu(),
which is what is done in the next bug fix patch. So solve the problem by
releasing these resources early.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240328052426.3042617-1-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
(cherry picked from commit e9c856cabefb71d47b2eeb197f72c9c88e9b45b0)
---
 kernel/trace/bpf_trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 7ac6c52b25eb..45de8a4923e2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3142,6 +3142,9 @@ static void bpf_uprobe_multi_link_release(struct bpf_link *link)
 
 	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
 	bpf_uprobe_unregister(&umulti_link->path, umulti_link->uprobes, umulti_link->cnt);
+	if (umulti_link->task)
+		put_task_struct(umulti_link->task);
+	path_put(&umulti_link->path);
 }
 
 static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
@@ -3149,9 +3152,6 @@ static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
 	struct bpf_uprobe_multi_link *umulti_link;
 
 	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
-	if (umulti_link->task)
-		put_task_struct(umulti_link->task);
-	path_put(&umulti_link->path);
 	kvfree(umulti_link->uprobes);
 	kfree(umulti_link);
 }
-- 
2.43.0


