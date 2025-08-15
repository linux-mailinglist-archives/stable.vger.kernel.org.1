Return-Path: <stable+bounces-169744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A791B2837C
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 18:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5790DAC1E1C
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 16:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A67B291C18;
	Fri, 15 Aug 2025 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b2Eyb+Dn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5BD1DA21
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755273809; cv=none; b=LfxETBtg0Z7HG0MhiuqZBRCQickwg6fP0qOvTipIO5lHi6ZkO14J0a2NO0jKrr9jtVwm6vecOWmdUo9TmDLagQGpkczdGsPe1Q34GyI0qysKCr07EeDkkd71BzwmUKsCeveJSta5xU1Wr9V2NnuEplYxYZGN3m92qbcl3XZZcAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755273809; c=relaxed/simple;
	bh=cXXjeNhnZBLvaw/hpqfBH2V+8KYuCzWRddOGhDzS/3I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y6yFCh0Pc4TUT4NEtjtkBdWGDbljOpL0AIM/FF5WcR06+CD9w2fKUgVnuOTj8DVaodfi+Vt+3nLOfDptqGTAQc/20Rb6WvzjDGzaN6DNosRGCTQrEKMl1IJP59Ls6hAcrMYxWpN2FKlA+dMIazXsiL+hv4zzL78G5j7nCYdBjps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b2Eyb+Dn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7D8C4CEEB;
	Fri, 15 Aug 2025 16:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755273808;
	bh=cXXjeNhnZBLvaw/hpqfBH2V+8KYuCzWRddOGhDzS/3I=;
	h=Subject:To:Cc:From:Date:From;
	b=b2Eyb+DnMZ11vViqPJFPp2GyfHzXEhn/ZWGau9UOXWj5L1KbDTX/iGdsxcH/1bHVk
	 laQ78rPI618UzhnRSQN3iKeGpWgu7vAgGSiBqfUj2gVjOJH+KK4hbCSlstQ3wByKfS
	 FFURDoaZJquzxzRAJm8oj0Ds/Db2CryDCqSjV57s=
Subject: FAILED: patch "[PATCH] nfsd: handle get_client_locked() failure in" failed to apply to 5.4-stable tree
To: jlayton@kernel.org,chuck.lever@oracle.com,llfamsec@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 Aug 2025 18:03:25 +0200
Message-ID: <2025081525-comprised-nastily-418e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 908e4ead7f757504d8b345452730636e298cbf68
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081525-comprised-nastily-418e@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 908e4ead7f757504d8b345452730636e298cbf68 Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 4 Jun 2025 12:01:10 -0400
Subject: [PATCH] nfsd: handle get_client_locked() failure in
 nfsd4_setclientid_confirm()

Lei Lu recently reported that nfsd4_setclientid_confirm() did not check
the return value from get_client_locked(). a SETCLIENTID_CONFIRM could
race with a confirmed client expiring and fail to get a reference. That
could later lead to a UAF.

Fix this by getting a reference early in the case where there is an
extant confirmed client. If that fails then treat it as if there were no
confirmed client found at all.

In the case where the unconfirmed client is expiring, just fail and
return the result from get_client_locked().

Reported-by: lei lu <llfamsec@gmail.com>
Closes: https://lore.kernel.org/linux-nfs/CAEBF3_b=UvqzNKdnfD_52L05Mqrqui9vZ2eFamgAbV0WG+FNWQ@mail.gmail.com/
Fixes: d20c11d86d8f ("nfsd: Protect session creation and client confirm using client_lock")
Cc: stable@vger.kernel.org
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a0e3fa2718c7..95d88555648d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4690,10 +4690,16 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 	}
 	status = nfs_ok;
 	if (conf) {
-		old = unconf;
-		unhash_client_locked(old);
-		nfsd4_change_callback(conf, &unconf->cl_cb_conn);
-	} else {
+		if (get_client_locked(conf) == nfs_ok) {
+			old = unconf;
+			unhash_client_locked(old);
+			nfsd4_change_callback(conf, &unconf->cl_cb_conn);
+		} else {
+			conf = NULL;
+		}
+	}
+
+	if (!conf) {
 		old = find_confirmed_client_by_name(&unconf->cl_name, nn);
 		if (old) {
 			status = nfserr_clid_inuse;
@@ -4710,10 +4716,14 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 			}
 			trace_nfsd_clid_replaced(&old->cl_clientid);
 		}
+		status = get_client_locked(unconf);
+		if (status != nfs_ok) {
+			old = NULL;
+			goto out;
+		}
 		move_to_confirmed(unconf);
 		conf = unconf;
 	}
-	get_client_locked(conf);
 	spin_unlock(&nn->client_lock);
 	if (conf == unconf)
 		fsnotify_dentry(conf->cl_nfsd_info_dentry, FS_MODIFY);


