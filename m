Return-Path: <stable+bounces-36141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2C289A2A8
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 18:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A40287B99
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 16:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601BF16F275;
	Fri,  5 Apr 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KztXR1UL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C210161915;
	Fri,  5 Apr 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335092; cv=none; b=jK8LLkRVkFBY00SIjDA7jWi8QO2M923JVX0Pw7KDuIscu4Xe7Vu+cEvE2yVl2ZHtOk8pEZRCiCoYKTh5Xb8evq6/Q/25Nv02Yeo2gHOhvIOK26RfxwHfD7Yf0NDqbu5JVUwm0K1Gs3QlkY0rVka4i2cUs8Bd025T96Oldtv1mD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335092; c=relaxed/simple;
	bh=pxm850hyCfKjvNoJ/0bxv/wxjBo5naOgTvcUoxh7/tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sld2IdVhTXUO1t02BFfreI3FOR53N7XmKwX+1MEnBaLZ5oe+WNmNQfltLBx0iXD6uuKswQEGc71nJbPtysH8JjvQhRkvmnC7j4gzy++QDUOOdtFS0ENu4lpE13bY1TkMU83hfikjbZWbKqkgqATrfZjZodfoA3fo5BQBIsXhOno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KztXR1UL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3D9C43394;
	Fri,  5 Apr 2024 16:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712335091;
	bh=pxm850hyCfKjvNoJ/0bxv/wxjBo5naOgTvcUoxh7/tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KztXR1ULCYoHC5l879sed6nW3p/pEvsHhaB54wRnPhoO1H0tMXUZvXuZIYFXqhYXo
	 nasw1Ff5slUS8wDWS63K7lbYEMmqK4oJCIgZehkPzAw59EMDHY5W0Ttes6J8lcGXBU
	 0x53ODDXjV2nXZjMPlFgnp0FuJ1FivB8dRnpYMvzDJyuHrtiHKyIzevrM2/WVLFqub
	 W6MljIr+oci2VHqWFZj2sZtriy6s79DKgri4+K4daiR+2Ir7dvlSYi+CUZwg/dx2q5
	 x3lChXVa2A6xHGj9lGQof6ssN67/PC/6JoovRNgvV7D7R4xgSENiKWUa1dXiOT/Qs0
	 Ln5Jn3k8yYtvA==
From: Andrii Nakryiko <andrii@kernel.org>
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 6.6.y 1/2] bpf: put uprobe link's path and task in release callback
Date: Fri,  5 Apr 2024 09:38:05 -0700
Message-ID: <20240405163806.45495-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024040548-lid-mahogany-fd86@gregkh>
References: <2024040548-lid-mahogany-fd86@gregkh>
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
index 1d76f3b014ae..4d49a9f47e68 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3065,6 +3065,9 @@ static void bpf_uprobe_multi_link_release(struct bpf_link *link)
 
 	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
 	bpf_uprobe_unregister(&umulti_link->path, umulti_link->uprobes, umulti_link->cnt);
+	if (umulti_link->task)
+		put_task_struct(umulti_link->task);
+	path_put(&umulti_link->path);
 }
 
 static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
@@ -3072,9 +3075,6 @@ static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
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


