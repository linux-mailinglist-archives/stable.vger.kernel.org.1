Return-Path: <stable+bounces-139780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC64AA9F5B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADADE4606F0
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B129B2820BE;
	Mon,  5 May 2025 22:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppOT3UVk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648532820B5;
	Mon,  5 May 2025 22:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483324; cv=none; b=PY0Bjns12rQdvZJtkpCWyk4jlGQr18MVuAhrMD7niPrTKWlQyS4Im+kWKt6vIJ7+uH4cMQZfoNwXx6UzAtaIu0l+slHq5HKD0nnkTMNSZXWEe1K1/kXzKoW1vmKaAoFGwaz2MGkiSzPWCPHMiIQAa32gZ8suPfShwyMs+IefnhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483324; c=relaxed/simple;
	bh=jTQOrB6egtLeBV+5u8WXazKOAGwD6P3SZZKw7rNqx50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bJZi4u9oB7/a+y4sIPPfnLTeQdJTfKkogA2zFOpIlPG89HVYfWQyN/v94wBvoQEq8g1jeyPM7N70qf0mr69TN7G5ZMTfhHqsj1Hwqz9opsTXXuUi2WeCAcG2NMip2v0SUuz7+t5174QDW+9ZHC9Eyl2o+Mec1DRbdJHWgh+gGes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppOT3UVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473FBC4CEF2;
	Mon,  5 May 2025 22:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483323;
	bh=jTQOrB6egtLeBV+5u8WXazKOAGwD6P3SZZKw7rNqx50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ppOT3UVk/lHZ2zD7zKgzG2aRTJP4/IVLyHl2ms4nlKtKUdmYoS6a9z/PmUIeVgVp8
	 6uENeOltlKTxVzs+aAHWF/Jzw0Fir3LZUpmIzOA+Bi998uzHvK86gZZeHx7GELKBKB
	 wf5Dr7ldRllyHxG6BcSZ6aWHwkV7F2wDQ/Qtqbxm/8HYnTLA5VzbHw6IXqd2BNKdco
	 Lu/6/LxYaIoPkG0SGQQ0Htm1cixWBL1UAtP1DCi3L7iUs6/Zwv82+hj5noO+zG+5T/
	 zAL4fG3aF9SzdbPiD7DnQSerKJt8QyAhsm4YmJ1Ebsw8RMnPLh82H41FLquAb+tTqI
	 FAPYqk5sk2QRA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	chuck.lever@oracle.com,
	trondmy@kernel.org,
	anna@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 033/642] SUNRPC: rpc_clnt_set_transport() must not change the autobind setting
Date: Mon,  5 May 2025 18:04:09 -0400
Message-Id: <20250505221419.2672473-33-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit bf9be373b830a3e48117da5d89bb6145a575f880 ]

The autobind setting was supposed to be determined in rpc_create(),
since commit c2866763b402 ("SUNRPC: use sockaddr + size when creating
remote transport endpoints").

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/clnt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 2fe88ea79a70c..c9c5f0caef6bd 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -270,9 +270,6 @@ static struct rpc_xprt *rpc_clnt_set_transport(struct rpc_clnt *clnt,
 	old = rcu_dereference_protected(clnt->cl_xprt,
 			lockdep_is_held(&clnt->cl_lock));
 
-	if (!xprt_bound(xprt))
-		clnt->cl_autobind = 1;
-
 	clnt->cl_timeout = timeout;
 	rcu_assign_pointer(clnt->cl_xprt, xprt);
 	spin_unlock(&clnt->cl_lock);
-- 
2.39.5


