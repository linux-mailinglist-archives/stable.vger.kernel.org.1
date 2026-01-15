Return-Path: <stable+bounces-209924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FAED278B8
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 19:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB5CC30AC152
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF973BFE4C;
	Thu, 15 Jan 2026 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ju2+C3o0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704673B8BC0;
	Thu, 15 Jan 2026 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768500080; cv=none; b=YdJmdU47X/R+9Tz46kMbC3nTQuOE4SFwVAgY4qL7BA6dGkjcnzl0/PAPVjVAKn7KywyxKePIPmbdrdNmn6XJ3vogEbeeMlQG0HJSODQtfJfkxPnGWMuwe/P9gOUqQVb0WBv9E+uV8BH45TTBX5FtB14+Uv67rN51v3SUyfyRJuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768500080; c=relaxed/simple;
	bh=dmvnBP9+xo10RY6bI2mBJEA2BYztnekHZaV56IhSCE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhV9uZ2soiQcCUNCFeUp+6Ce6bT0wGqCfzFyrGmB9suZgT0mw6v+zC7uChQS0SbPB6t+ZciqmZFiU/LpAKVJw0ubGVTLfceBmAiCqbJt2NwKfEZfdCKNbORvKv2m3MDdtY5gajQpTcwJBOh//qNJJVLaATRcxkgLjrW36vMXaRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ju2+C3o0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFFAC116D0;
	Thu, 15 Jan 2026 18:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768500080;
	bh=dmvnBP9+xo10RY6bI2mBJEA2BYztnekHZaV56IhSCE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ju2+C3o0GNV+Uzh+Bv2jrLq4TPFO/QkIuF6Bokv0oAi9xE7MSm63+ahaymfvFEFxg
	 sjN04WIFOC8D8HDzZh/Bs7pSxYFYjZHk5IYg9ZiyB6lY6b69lavO4Mcxw7mEpSDKQZ
	 wFRuAO5Vv+IpwCvLU1eOCohkLGgppO226yRfOhUI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>,
	Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Subject: [PATCH 5.10 418/451] libceph: make calc_target() set t->paused, not just clear it
Date: Thu, 15 Jan 2026 17:50:19 +0100
Message-ID: <20260115164246.059224338@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164230.864985076@linuxfoundation.org>
References: <20260115164230.864985076@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit c0fe2994f9a9d0a2ec9e42441ea5ba74b6a16176 upstream.

Currently calc_target() clears t->paused if the request shouldn't be
paused anymore, but doesn't ever set t->paused even though it's able to
determine when the request should be paused.  Setting t->paused is left
to __submit_request() which is fine for regular requests but doesn't
work for linger requests -- since __submit_request() doesn't operate
on linger requests, there is nowhere for lreq->t.paused to be set.
One consequence of this is that watches don't get reestablished on
paused -> unpaused transitions in cases where requests have been paused
long enough for the (paused) unwatch request to time out and for the
subsequent (re)watch request to enter the paused state.  On top of the
watch not getting reestablished, rbd_reregister_watch() gets stuck with
rbd_dev->watch_mutex held:

  rbd_register_watch
    __rbd_register_watch
      ceph_osdc_watch
        linger_reg_commit_wait

It's waiting for lreq->reg_commit_wait to be completed, but for that to
happen the respective request needs to end up on need_resend_linger list
and be kicked when requests are unpaused.  There is no chance for that
if the request in question is never marked paused in the first place.

The fact that rbd_dev->watch_mutex remains taken out forever then
prevents the image from getting unmapped -- "rbd unmap" would inevitably
hang in D state on an attempt to grab the mutex.

Cc: stable@vger.kernel.org
Reported-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ceph/osd_client.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1529,6 +1529,7 @@ static enum calc_target_result calc_targ
 	struct ceph_pg_pool_info *pi;
 	struct ceph_pg pgid, last_pgid;
 	struct ceph_osds up, acting;
+	bool should_be_paused;
 	bool is_read = t->flags & CEPH_OSD_FLAG_READ;
 	bool is_write = t->flags & CEPH_OSD_FLAG_WRITE;
 	bool force_resend = false;
@@ -1597,10 +1598,16 @@ static enum calc_target_result calc_targ
 				 &last_pgid))
 		force_resend = true;
 
-	if (t->paused && !target_should_be_paused(osdc, t, pi)) {
-		t->paused = false;
+	should_be_paused = target_should_be_paused(osdc, t, pi);
+	if (t->paused && !should_be_paused) {
 		unpaused = true;
 	}
+	if (t->paused != should_be_paused) {
+		dout("%s t %p paused %d -> %d\n", __func__, t, t->paused,
+		     should_be_paused);
+		t->paused = should_be_paused;
+	}
+
 	legacy_change = ceph_pg_compare(&t->pgid, &pgid) ||
 			ceph_osds_changed(&t->acting, &acting,
 					  t->used_replica || any_change);



