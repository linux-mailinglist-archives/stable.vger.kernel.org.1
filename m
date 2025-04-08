Return-Path: <stable+bounces-131319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC6CA80A15
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86A08A4033
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21E926B08B;
	Tue,  8 Apr 2025 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2TYwmS0F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9B226A0EB;
	Tue,  8 Apr 2025 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116075; cv=none; b=WxkFE4yL2vPADhRn563IU5CqC1PpwOHk7MvARN1wkOwt9faOu9ctzIpijoXd9E1W1WKJ+ioOEcZ4vwa47OPKM8kAyy8g9Vhud0yadkZ+mRn2sSqSdhrrvQS9B4MBUAFzj50LEgx0lB6+odPH1T1hqgUpgvZmJk9fl/5vgpjlbD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116075; c=relaxed/simple;
	bh=emIuhWo0JPBqAxFU2ktvjSuOfMJrWIDFc6I3BkVUq+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AeBfJDucbSSWvSW9IBZOS1OBAaziCh8dpdebHOMZ87Ykm4gSnc/EuNNI/ltrPA2Po4UJ7w76YItvAGeIzAI6FMyn10Hk564Dlk9W9yOwrkD+uWU2iB+hNIdQsQH06UMwUfvMm7fu0VsVrK1gmL5xnCoJ2nmDqbjtUHJkIBHmOo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2TYwmS0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7A7C4CEE7;
	Tue,  8 Apr 2025 12:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116075;
	bh=emIuhWo0JPBqAxFU2ktvjSuOfMJrWIDFc6I3BkVUq+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2TYwmS0FyPpQZOnynQgb1uVWX2VTnJACMAdGmAzvLRSziaqkrzyeF8DnKE/mHxsrz
	 Rc0uEB+xAD0Uw4Tv5L+pOgjvEdTjlB0JVxuUaeH2HOP7YN0MMjd2gmnGgL8ZJJPN9/
	 0TSm4oUOou/pXlSgRGvLHDilz5uaMB7ExOr3HN2w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.1 204/204] NFSD: Skip sending CB_RECALL_ANY when the backchannel isnt up
Date: Tue,  8 Apr 2025 12:52:14 +0200
Message-ID: <20250408104826.312392909@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
References: <20250408104820.266892317@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

commit 8a388c1fabeb6606e16467b23242416c0dbeffad upstream.

NFSD sends CB_RECALL_ANY to clients when the server is low on
memory or that client has a large number of delegations outstanding.

We've seen cases where NFSD attempts to send CB_RECALL_ANY requests
to disconnected clients, and gets confused. These calls never go
anywhere if a backchannel transport to the target client isn't
available. Before the server can send any backchannel operation, the
client has to connect first and then do a BIND_CONN_TO_SESSION.

This patch doesn't address the root cause of the confusion, but
there's no need to queue up these optional operations if they can't
go anywhere.

Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memory condition")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6247,14 +6247,19 @@ deleg_reaper(struct nfsd_net *nn)
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
 		clp = list_entry(pos, struct nfs4_client, cl_lru);
-		if (clp->cl_state != NFSD4_ACTIVE ||
-			list_empty(&clp->cl_delegations) ||
-			atomic_read(&clp->cl_delegs_in_recall) ||
-			test_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags) ||
-			(ktime_get_boottime_seconds() -
-				clp->cl_ra_time < 5)) {
+
+		if (clp->cl_state != NFSD4_ACTIVE)
+			continue;
+		if (list_empty(&clp->cl_delegations))
+			continue;
+		if (atomic_read(&clp->cl_delegs_in_recall))
+			continue;
+		if (test_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags))
+			continue;
+		if (ktime_get_boottime_seconds() - clp->cl_ra_time < 5)
+			continue;
+		if (clp->cl_cb_state != NFSD4_CB_UP)
 			continue;
-		}
 		list_add(&clp->cl_ra_cblist, &cblist);
 
 		/* release in nfsd4_cb_recall_any_release */



