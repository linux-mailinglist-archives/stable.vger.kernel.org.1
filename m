Return-Path: <stable+bounces-89556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BACFA9B9D8B
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 08:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543E91F20F57
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 07:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF39155330;
	Sat,  2 Nov 2024 06:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="JdAC0uQY"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88871DFEF
	for <stable@vger.kernel.org>; Sat,  2 Nov 2024 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730530797; cv=none; b=UsI2uRMcajbpp/i0VAea/kc7+HB56GsfNIGXMQPJYVQ4Dg0WJEqrfhSyFvDamJtvG0UOO3B0gaKCxQewm3vRm1Ijeq9J0ycACMNyT52rPElaHXXX+ryn7N4/z7lFCe+vveuRtjMCyje9B4raie6FErhZKZhtmSl8KvAl+TiTlQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730530797; c=relaxed/simple;
	bh=3SuXeR3qMWVcCOwNqVRoMT2CToJnQUqGMezQTzGx7jY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UhlMvNS/56IIcpUYOrhPpEjitxBGSIYe5dkKttjrub3CoXF6gCfy7KHQJ3qZ5mI3ObuVzxGQqHJZzR/ABq6do4zho95/q9c7mSuYXgc8ViOBOKJn4XjLBP2xpoA8zQvDEr9kKtkrWPU3VOuAYdfjHyOp8K3kpZRdAgzvy6IU0FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=JdAC0uQY; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 173C914C1E1;
	Sat,  2 Nov 2024 07:52:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1730530362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1cqmhe98XHA5K4FIC4/cNhp8nkeCYpPnEJ2DFASqSP8=;
	b=JdAC0uQYDjl0cpvyAFlMKCLUU1YjmGFWJ3GfsnmSNmRUSgEIzbruIi0l41a41IjUIJ1zVn
	wLRXLzMC/d/ItCKvPF/Hz+SEwjfaVmm43Ced6febwqf0POlYEDrtxveHErn9hRpiZWgELh
	S7eQDtqANmwHdUncVXw2A9drsBdgoJrSQlxB5y/B8j4EUl42v0c8W3O0HWByYGL5F9s23A
	5m7UQa8nPHwKM96goN1O/+85yydI4HjCrX/hfn4bcZS3jupajbQkER6RtM3zaj1BqsNV08
	zz2ebEo2CCCyZ+8KFuLwEuF0arlL7HxXpE9la8GB63nFE8j9S/0K4gbWBh3UvQ==
Received: from gaia.codewreck.org (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id db38cc66;
	Sat, 2 Nov 2024 06:52:39 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.6] SUNRPC: Remove BUG_ON call sites
Date: Sat,  2 Nov 2024 15:52:03 +0900
Message-ID: <20241102065203.13291-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 789ce196a31dd13276076762204bee87df893e53 ]

There is no need to take down the whole system for these assertions.

I'd rather not attempt a heroic save here, as some bug has occurred
that has left the transport data structures in an unknown state.
Just warn and then leak the left-over resources.

Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
I've hit this BUG at home when restarting the nfs-server service and
while that didn't bring the whole system down it did kill a thread with
the nfsd_mutex lock held, making exportfs & other related commands all
hang in unkillable state trying to grab the lock.

So this is purely selfish so that this won't happen again next time I
upgrade :-)

I'd like to say I have any idea why the bug hit on that 6.6.42 (the
sv_permsocks one did) and help with the underlying issue, but I honestly
didn't do anything fancy and don't have anything interesting in logs
(except the bug itself, happy to forward it if someone cares); would
have been possible to debug this if I had a crash dump but it's not
setup on this machine and just having this down to WARN if probably
good enough...

Cheers,

 net/sunrpc/svc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 029c49065016..b43dc8409b1f 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -577,11 +577,12 @@ svc_destroy(struct kref *ref)
 	timer_shutdown_sync(&serv->sv_temptimer);
 
 	/*
-	 * The last user is gone and thus all sockets have to be destroyed to
-	 * the point. Check this.
+	 * Remaining transports at this point are not expected.
 	 */
-	BUG_ON(!list_empty(&serv->sv_permsocks));
-	BUG_ON(!list_empty(&serv->sv_tempsocks));
+	WARN_ONCE(!list_empty(&serv->sv_permsocks),
+		  "SVC: permsocks remain for %s\n", serv->sv_program->pg_name);
+	WARN_ONCE(!list_empty(&serv->sv_tempsocks),
+		  "SVC: tempsocks remain for %s\n", serv->sv_program->pg_name);
 
 	cache_clean_deferred(serv);
 
-- 
2.46.1


