Return-Path: <stable+bounces-128408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E07A7CBD0
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 22:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24FA43B2AD6
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 20:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B8A1A5B98;
	Sat,  5 Apr 2025 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/PJo5Bj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB42719CC0E
	for <stable@vger.kernel.org>; Sat,  5 Apr 2025 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743885306; cv=none; b=HcffPACQ75IjiDdysUXM3O0brwxghlBte798dQSgZIZMjjEzDvPyGK3DPhanZ7YGy0bOG3Z7g2RPL+1+1DNpPZCp4EaDbRNsxS3+Eu3ryJZ0mIrwTOIeQiouW4quRi8WLkRxQRAcdPqj/P2XkQGYzWtFOwd73UCNVX9GgUEHNjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743885306; c=relaxed/simple;
	bh=Bht2whr9oldcW8MlRVjgit2iRnAtDlttpCg15khnpkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bs2WqdIima/rKAcCKlkKE5riNkyLXSI3ozKuP9x6Wa2x9X6HHepK9PVrhy43w3JlNBFpKjTnrLqQgChen/RyqfvMQOzw/BAw2fkw1zfmPPHYku4eOJ/y7fG/4TIWXyRZ2xKnTFl2h8Nv3T8+ucLj732lca9zbjDxD3NuOyQW2mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/PJo5Bj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE52AC4CEE4;
	Sat,  5 Apr 2025 20:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743885306;
	bh=Bht2whr9oldcW8MlRVjgit2iRnAtDlttpCg15khnpkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a/PJo5BjwDjF7ZFGDVteeBKY3sz8PYgVgk1LM4RDP1QpK4pIGZWaxkVYtT99RdDs9
	 znhcRUbFpKTMth0N7V5LcsdnL9x0MhF3LyOztx70r1iZA2lqxMLQ6Jepn8DPSYveuJ
	 XXFlHecNjccd3bNvKOGJ2a9G5Dzpf1G4j/bQNM9VhmiFAZnlcSR1QXVRxnwkis1JT7
	 nXurX5Ga9u3HEfDwRdKrScQ/YVp0rqNGV1VGlK5JDyW4FD6Knohb2Q4HqJUUfC/i1h
	 STx7aAEbv2GFhc3tTAEvMlDvJWQ6Kby0Q47qV23+pQ3kgNL6Xkge6c5mEctVSIEQ1Z
	 4qBwkevtHDcCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: He Zhe <zhe.he@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] cifs: Fix UAF in cifs_demultiplex_thread()
Date: Sat,  5 Apr 2025 16:35:00 -0400
Message-Id: <20250405081033-d477a5f9d93c5288@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250405053611.4039379-1-zhe.he@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: d527f51331cace562393a8038d870b3e9916686f

WARNING: Author mismatch between patch and upstream commit:
Backport author: He Zhe<zhe.he@windriver.com>
Commit author: Zhang Xiaoxu<zhangxiaoxu5@huawei.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: 908b3b5e97d2)

Note: The patch differs from the upstream commit:
---
1:  d527f51331cac ! 1:  fdd5e68583ce7 cifs: Fix UAF in cifs_demultiplex_thread()
    @@ Metadata
      ## Commit message ##
         cifs: Fix UAF in cifs_demultiplex_thread()
     
    +    commit d527f51331cace562393a8038d870b3e9916686f upstream.
    +
         There is a UAF when xfstests on cifs:
     
           BUG: KASAN: use-after-free in smb2_is_network_name_deleted+0x27/0x160
    @@ Commit message
         Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
         Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
         Signed-off-by: Steve French <stfrench@microsoft.com>
    +    [fs/cifs was moved to fs/smb/client since
    +    38c8a9a52082 ("smb: move client and server files to common directory fs/smb").
    +    We apply the patch to fs/cifs with some minor context changes.]
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
    +    Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
     
    - ## fs/smb/client/cifsglob.h ##
    -@@ fs/smb/client/cifsglob.h: static inline bool is_retryable_error(int error)
    + ## fs/cifs/cifsglob.h ##
    +@@ fs/cifs/cifsglob.h: static inline bool is_retryable_error(int error)
      #define   MID_RETRY_NEEDED      8 /* session closed while this request out */
      #define   MID_RESPONSE_MALFORMED 0x10
      #define   MID_SHUTDOWN		 0x20
    @@ fs/smb/client/cifsglob.h: static inline bool is_retryable_error(int error)
      /* Flags */
      #define   MID_WAIT_CANCELLED	 1 /* Cancelled while waiting for response */
     
    - ## fs/smb/client/transport.c ##
    + ## fs/cifs/transport.c ##
     @@
      void
      cifs_wake_up_task(struct mid_q_entry *mid)
    @@ fs/smb/client/transport.c
      	wake_up_process(mid->callback_data);
      }
      
    -@@ fs/smb/client/transport.c: static void __release_mid(struct kref *refcount)
    +@@ fs/cifs/transport.c: static void _cifs_mid_q_entry_release(struct kref *refcount)
      	struct TCP_Server_Info *server = midEntry->server;
      
      	if (midEntry->resp_buf && (midEntry->mid_flags & MID_WAIT_CANCELLED) &&
    @@ fs/smb/client/transport.c: static void __release_mid(struct kref *refcount)
      	    server->ops->handle_cancelled_mid)
      		server->ops->handle_cancelled_mid(midEntry, server);
      
    -@@ fs/smb/client/transport.c: wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ)
    +@@ fs/cifs/transport.c: wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ)
      	int error;
      
    - 	error = wait_event_state(server->response_q,
    --				 midQ->mid_state != MID_REQUEST_SUBMITTED,
    -+				 midQ->mid_state != MID_REQUEST_SUBMITTED &&
    -+				 midQ->mid_state != MID_RESPONSE_RECEIVED,
    - 				 (TASK_KILLABLE|TASK_FREEZABLE_UNSAFE));
    + 	error = wait_event_freezekillable_unsafe(server->response_q,
    +-				    midQ->mid_state != MID_REQUEST_SUBMITTED);
    ++				    midQ->mid_state != MID_REQUEST_SUBMITTED &&
    ++				    midQ->mid_state != MID_RESPONSE_RECEIVED);
      	if (error < 0)
      		return -ERESTARTSYS;
    -@@ fs/smb/client/transport.c: cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server)
      
    - 	spin_lock(&server->mid_lock);
    +@@ fs/cifs/transport.c: cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server)
    + 
    + 	spin_lock(&GlobalMid_Lock);
      	switch (mid->mid_state) {
     -	case MID_RESPONSE_RECEIVED:
     +	case MID_RESPONSE_READY:
    - 		spin_unlock(&server->mid_lock);
    + 		spin_unlock(&GlobalMid_Lock);
      		return rc;
      	case MID_RETRY_NEEDED:
    -@@ fs/smb/client/transport.c: cifs_compound_callback(struct mid_q_entry *mid)
    +@@ fs/cifs/transport.c: cifs_compound_callback(struct mid_q_entry *mid)
      	credits.instance = server->reconnect_instance;
      
      	add_credits(server, &credits, mid->optype);
    @@ fs/smb/client/transport.c: cifs_compound_callback(struct mid_q_entry *mid)
      }
      
      static void
    -@@ fs/smb/client/transport.c: compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
    +@@ fs/cifs/transport.c: compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
      			send_cancel(server, &rqst[i], midQ[i]);
    - 			spin_lock(&server->mid_lock);
    + 			spin_lock(&GlobalMid_Lock);
      			midQ[i]->mid_flags |= MID_WAIT_CANCELLED;
     -			if (midQ[i]->mid_state == MID_REQUEST_SUBMITTED) {
     +			if (midQ[i]->mid_state == MID_REQUEST_SUBMITTED ||
    @@ fs/smb/client/transport.c: compound_send_recv(const unsigned int xid, struct cif
      				midQ[i]->callback = cifs_cancelled_callback;
      				cancelled_mid[i] = true;
      				credits[i].value = 0;
    -@@ fs/smb/client/transport.c: compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
    +@@ fs/cifs/transport.c: compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
      		}
      
      		if (!midQ[i]->resp_buf ||
    @@ fs/smb/client/transport.c: compound_send_recv(const unsigned int xid, struct cif
      			rc = -EIO;
      			cifs_dbg(FYI, "Bad MID state?\n");
      			goto out;
    -@@ fs/smb/client/transport.c: SendReceive(const unsigned int xid, struct cifs_ses *ses,
    +@@ fs/cifs/transport.c: SendReceive(const unsigned int xid, struct cifs_ses *ses,
      	if (rc != 0) {
      		send_cancel(server, &rqst, midQ);
    - 		spin_lock(&server->mid_lock);
    + 		spin_lock(&GlobalMid_Lock);
     -		if (midQ->mid_state == MID_REQUEST_SUBMITTED) {
     +		if (midQ->mid_state == MID_REQUEST_SUBMITTED ||
     +		    midQ->mid_state == MID_RESPONSE_RECEIVED) {
      			/* no longer considered to be "in-flight" */
    - 			midQ->callback = release_mid;
    - 			spin_unlock(&server->mid_lock);
    -@@ fs/smb/client/transport.c: SendReceive(const unsigned int xid, struct cifs_ses *ses,
    + 			midQ->callback = DeleteMidQEntry;
    + 			spin_unlock(&GlobalMid_Lock);
    +@@ fs/cifs/transport.c: SendReceive(const unsigned int xid, struct cifs_ses *ses,
      	}
      
      	if (!midQ->resp_buf || !out_buf ||
    @@ fs/smb/client/transport.c: SendReceive(const unsigned int xid, struct cifs_ses *
      		rc = -EIO;
      		cifs_server_dbg(VFS, "Bad MID state?\n");
      		goto out;
    -@@ fs/smb/client/transport.c: SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
    +@@ fs/cifs/transport.c: SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
      
      	/* Wait for a reply - allow signals to interrupt. */
      	rc = wait_event_interruptible(server->response_q,
    @@ fs/smb/client/transport.c: SendReceiveBlockingLock(const unsigned int xid, struc
      		 (server->tcpStatus != CifsNew)));
      
      	/* Were we interrupted by a signal ? */
    - 	spin_lock(&server->srv_lock);
      	if ((rc == -ERESTARTSYS) &&
     -		(midQ->mid_state == MID_REQUEST_SUBMITTED) &&
     +		(midQ->mid_state == MID_REQUEST_SUBMITTED ||
     +		 midQ->mid_state == MID_RESPONSE_RECEIVED) &&
      		((server->tcpStatus == CifsGood) ||
      		 (server->tcpStatus == CifsNew))) {
    - 		spin_unlock(&server->srv_lock);
    -@@ fs/smb/client/transport.c: SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
    + 
    +@@ fs/cifs/transport.c: SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
      		if (rc) {
      			send_cancel(server, &rqst, midQ);
    - 			spin_lock(&server->mid_lock);
    + 			spin_lock(&GlobalMid_Lock);
     -			if (midQ->mid_state == MID_REQUEST_SUBMITTED) {
     +			if (midQ->mid_state == MID_REQUEST_SUBMITTED ||
     +			    midQ->mid_state == MID_RESPONSE_RECEIVED) {
      				/* no longer considered to be "in-flight" */
    - 				midQ->callback = release_mid;
    - 				spin_unlock(&server->mid_lock);
    -@@ fs/smb/client/transport.c: SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
    + 				midQ->callback = DeleteMidQEntry;
    + 				spin_unlock(&GlobalMid_Lock);
    +@@ fs/cifs/transport.c: SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
      		return rc;
      
      	/* rcvd frame is ok */
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

