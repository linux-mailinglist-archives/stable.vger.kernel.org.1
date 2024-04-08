Return-Path: <stable+bounces-37098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FD289C350
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4701C21D8D
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF01613A3E3;
	Mon,  8 Apr 2024 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xur5R97W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5DB13A275;
	Mon,  8 Apr 2024 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583244; cv=none; b=tUO9YmXZ4gXC74+uu4iEVLu35NR0Zqr+yGtTGLngxevwUMIQrILKGDYMiCqHNJP9lqJLccdjBb5V5qXkjtAnHaTAT50zYg6jeHVkwrdQ2QoobSQUmarQkxdkJubloI41YlRw9vUEo2W5fIMiMh/QgPMNxnJM2WPfKwTNPMV8Q2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583244; c=relaxed/simple;
	bh=2M9cLjYrVRQDVmHcxPuskutdDi2Vc6pPd0bLUQ/Vu3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mK1JTjKlWWvGYKlqW7qJ1gZ2XKnqCIZboUw5+pZ9yHryTXVw8JVeFUKe3NzczkEEpb0MBCQVx+mZ4MgAW4DYXa6tU6eugGW2gPbHhAYzT2S/lUDim5fudxCA+U3KvRp2fhoez1AAyTlZHgroV2ixEXfJkWvgB1BaRfi64OXHLEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xur5R97W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63EAC433F1;
	Mon,  8 Apr 2024 13:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583244;
	bh=2M9cLjYrVRQDVmHcxPuskutdDi2Vc6pPd0bLUQ/Vu3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xur5R97WC/s3JTlBu7u/2f4JqY+eqr+81A2OVlkb4xCPerITeVFmberWGZJwB3r3F
	 LYQGXIlIoaeDfJCW6Go3H1LDimTo70ZVUiK+Lu46XjRpe3JZTJp74tZkQBbMhmqYKF
	 p2ex88v20VfbRrh3wHQ+zCCWTCqaYjfw9NP89Ynw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 226/690] NFSD: handle errors better in write_ports_addfd()
Date: Mon,  8 Apr 2024 14:51:32 +0200
Message-ID: <20240408125407.729171810@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.de>

[ Upstream commit 89b24336f03a8ba560e96b0c47a8434a7fa48e3c ]

If write_ports_add() fails, we shouldn't destroy the serv, unless we had
only just created it.  So if there are any permanent sockets already
attached, leave the serv in place.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index d0761ca8cb542..162866cfe83a2 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -742,7 +742,7 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 		return err;
 
 	err = svc_addsock(nn->nfsd_serv, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
-	if (err < 0) {
+	if (err < 0 && list_empty(&nn->nfsd_serv->sv_permsocks)) {
 		nfsd_destroy(net);
 		return err;
 	}
-- 
2.43.0




