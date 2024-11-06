Return-Path: <stable+bounces-90079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873C29BDFCD
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 08:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C48A2844D4
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 07:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D6A1D1F56;
	Wed,  6 Nov 2024 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="eJCtf7Ob"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77521D1724
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730879764; cv=none; b=rMh2cUNBUPrfXo8YM1z6GohLeLoTmoUgpJYgzzYJG61IM4OxrBIExXXhKWXq9RHagdbiZJle4e3YWaEn77R5NUTFVO/qSfjS9YaRJw4vZ8X5Z3RSGUPjm+LfVAFiDxrrXk0qI7wcPkhIbwfDyC9iv9jAM6R+u/0UiLNAaHUSTLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730879764; c=relaxed/simple;
	bh=+UjGtkMMC4oOadeOb4EaGKo1VDzVepDcF2ccau4AAcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=duR/6RQwU40hTrh44CSpviQr2yaDz+jMhq9x2hXqT9Jc1a7Qd1RNfH5qpWKkItcDR0LWAKo0YwFJ4MMU1uEhRfRiaGSfwiPcGBobeGXjobhrNDoiI+Rz3Eqb9V8wGsi/HxuvXjJ08mDeH1S4Oz1n7/IA0GPJ1i6d030H3xidIlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=eJCtf7Ob; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 527D214C1E2;
	Wed,  6 Nov 2024 08:55:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1730879753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a9MeM4NSgEHB7vTRku8APHtesJxqOu51xmhXXpdVGD0=;
	b=eJCtf7ObKsGUNVGClQFUk1yhmXyEkuKJMGuBMRQ8OanDiKwVM4gebzFx8u7j/rLoZiCMfL
	nn8OLHdwyuGGckhHleAshzU1fept3dVMMHBcIX9hxCVJ+BPKwCRicyrmJDDyrfQNrBeZL5
	4usMjLqnsUM+wOzexRHhbwQtJHAuWr/C8IuBHcQcqWG0viCQhKonJKGgU2lzjqdIDw0cf4
	c6Wzuo6ZmNb+BrDcWXkzPZPLGAT+BMLGsJzNhMmmaJhfGEBY0cuYaF70AaIt2EqkeFtf3D
	dpwnufr3g8/c9mEXIg5av8/42pnrMzJ2mHtHzVwl/mbKiWEJJLrkC+K9lKMjSA==
Received: from gaia.codewreck.org (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 2085c327;
	Wed, 6 Nov 2024 07:55:49 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 6.6 v2] SUNRPC: Remove BUG_ON call sites
Date: Wed,  6 Nov 2024 16:54:59 +0900
Message-ID: <20241106075457.201502-3-asmadeus@codewreck.org>
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
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
v2: resend with signoff properly set as requested
v1: https://lkml.kernel.org/r/20241102065203.13291-1-asmadeus@codewreck.org

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


