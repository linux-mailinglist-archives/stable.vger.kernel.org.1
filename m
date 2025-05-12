Return-Path: <stable+bounces-143471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73196AB4006
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C50817B16E4
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB95255222;
	Mon, 12 May 2025 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eKSl7UQU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6BD339A8;
	Mon, 12 May 2025 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072049; cv=none; b=AKnkE70v5tBA9xBdFi9b1RnmWHFESH/bSQGKmjySuYS1psm+RHWAchTUyP1cN8UeRDGpcdMmO55GxzGAHxqSFrAQGNZxiCH/zXcVvUbsGmy38GtKDDcHKvLZjRZZjOJ9onOq4uAOcsyNYDvOtNuqGrmrbbgmOIIGR4rCru4QsBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072049; c=relaxed/simple;
	bh=TFv4xYlu57U1fi4EOXsSTbmVfJJAcl2Wx8ZOYmQ8HYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nnvJFNsK4aOk+2C+MAu1UQiuaB+8UVPmM6bS71OYIDJGXnaQgUkeuKmTvbE178cNiIZ7GoHVZewQFHUo4+5rDREOjsFqVuRjudGDDnd1iu5Lq9I3Xfz91Sds6e9y6iFWyAQ2MfrzX+KdDtNJ/wzfCrA+8SRhNq8EYGsQwspSdgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eKSl7UQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2ECCC4CEE7;
	Mon, 12 May 2025 17:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747072049;
	bh=TFv4xYlu57U1fi4EOXsSTbmVfJJAcl2Wx8ZOYmQ8HYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eKSl7UQUCWhDg++trFn7Qm7uS1J9qL61OiMvqYN4+LMNq6XiQsutNicg/Eo5lY5AJ
	 GSgv48NOUn2Njv//qc8dlK8PS05JOdmIB9rSKCIhvbQVbCgVynKdYsI211VsscdjDd
	 FGigAQc0ttXh9JhlXgwlK0Z2z8oKTlvqbhUnCWsw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Jason Andryuk <jason.andryuk@amd.com>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH 6.14 121/197] xenbus: Use kref to track req lifetime
Date: Mon, 12 May 2025 19:39:31 +0200
Message-ID: <20250512172049.312386104@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172044.326436266@linuxfoundation.org>
References: <20250512172044.326436266@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Andryuk <jason.andryuk@amd.com>

commit 1f0304dfd9d217c2f8b04a9ef4b3258a66eedd27 upstream.

Marek reported seeing a NULL pointer fault in the xenbus_thread
callstack:
BUG: kernel NULL pointer dereference, address: 0000000000000000
RIP: e030:__wake_up_common+0x4c/0x180
Call Trace:
 <TASK>
 __wake_up_common_lock+0x82/0xd0
 process_msg+0x18e/0x2f0
 xenbus_thread+0x165/0x1c0

process_msg+0x18e is req->cb(req).  req->cb is set to xs_wake_up(), a
thin wrapper around wake_up(), or xenbus_dev_queue_reply().  It seems
like it was xs_wake_up() in this case.

It seems like req may have woken up the xs_wait_for_reply(), which
kfree()ed the req.  When xenbus_thread resumes, it faults on the zero-ed
data.

Linux Device Drivers 2nd edition states:
"Normally, a wake_up call can cause an immediate reschedule to happen,
meaning that other processes might run before wake_up returns."
... which would match the behaviour observed.

Change to keeping two krefs on each request.  One for the caller, and
one for xenbus_thread.  Each will kref_put() when finished, and the last
will free it.

This use of kref matches the description in
Documentation/core-api/kref.rst

Link: https://lore.kernel.org/xen-devel/ZO0WrR5J0xuwDIxW@mail-itl/
Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Fixes: fd8aa9095a95 ("xen: optimize xenbus driver for multiple concurrent xenstore accesses")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20250506210935.5607-1-jason.andryuk@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/xenbus/xenbus.h              |    2 ++
 drivers/xen/xenbus/xenbus_comms.c        |    9 ++++-----
 drivers/xen/xenbus/xenbus_dev_frontend.c |    2 +-
 drivers/xen/xenbus/xenbus_xs.c           |   18 ++++++++++++++++--
 4 files changed, 23 insertions(+), 8 deletions(-)

--- a/drivers/xen/xenbus/xenbus.h
+++ b/drivers/xen/xenbus/xenbus.h
@@ -77,6 +77,7 @@ enum xb_req_state {
 struct xb_req_data {
 	struct list_head list;
 	wait_queue_head_t wq;
+	struct kref kref;
 	struct xsd_sockmsg msg;
 	uint32_t caller_req_id;
 	enum xsd_sockmsg_type type;
@@ -103,6 +104,7 @@ int xb_init_comms(void);
 void xb_deinit_comms(void);
 int xs_watch_msg(struct xs_watch_event *event);
 void xs_request_exit(struct xb_req_data *req);
+void xs_free_req(struct kref *kref);
 
 int xenbus_match(struct device *_dev, const struct device_driver *_drv);
 int xenbus_dev_probe(struct device *_dev);
--- a/drivers/xen/xenbus/xenbus_comms.c
+++ b/drivers/xen/xenbus/xenbus_comms.c
@@ -309,8 +309,8 @@ static int process_msg(void)
 			virt_wmb();
 			req->state = xb_req_state_got_reply;
 			req->cb(req);
-		} else
-			kfree(req);
+		}
+		kref_put(&req->kref, xs_free_req);
 	}
 
 	mutex_unlock(&xs_response_mutex);
@@ -386,14 +386,13 @@ static int process_writes(void)
 	state.req->msg.type = XS_ERROR;
 	state.req->err = err;
 	list_del(&state.req->list);
-	if (state.req->state == xb_req_state_aborted)
-		kfree(state.req);
-	else {
+	if (state.req->state != xb_req_state_aborted) {
 		/* write err, then update state */
 		virt_wmb();
 		state.req->state = xb_req_state_got_reply;
 		wake_up(&state.req->wq);
 	}
+	kref_put(&state.req->kref, xs_free_req);
 
 	mutex_unlock(&xb_write_mutex);
 
--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -406,7 +406,7 @@ void xenbus_dev_queue_reply(struct xb_re
 	mutex_unlock(&u->reply_mutex);
 
 	kfree(req->body);
-	kfree(req);
+	kref_put(&req->kref, xs_free_req);
 
 	kref_put(&u->kref, xenbus_file_free);
 
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -112,6 +112,12 @@ static void xs_suspend_exit(void)
 	wake_up_all(&xs_state_enter_wq);
 }
 
+void xs_free_req(struct kref *kref)
+{
+	struct xb_req_data *req = container_of(kref, struct xb_req_data, kref);
+	kfree(req);
+}
+
 static uint32_t xs_request_enter(struct xb_req_data *req)
 {
 	uint32_t rq_id;
@@ -237,6 +243,12 @@ static void xs_send(struct xb_req_data *
 	req->caller_req_id = req->msg.req_id;
 	req->msg.req_id = xs_request_enter(req);
 
+	/*
+	 * Take 2nd ref.  One for this thread, and the second for the
+	 * xenbus_thread.
+	 */
+	kref_get(&req->kref);
+
 	mutex_lock(&xb_write_mutex);
 	list_add_tail(&req->list, &xb_write_list);
 	notify = list_is_singular(&xb_write_list);
@@ -261,8 +273,8 @@ static void *xs_wait_for_reply(struct xb
 	if (req->state == xb_req_state_queued ||
 	    req->state == xb_req_state_wait_reply)
 		req->state = xb_req_state_aborted;
-	else
-		kfree(req);
+
+	kref_put(&req->kref, xs_free_req);
 	mutex_unlock(&xb_write_mutex);
 
 	return ret;
@@ -291,6 +303,7 @@ int xenbus_dev_request_and_reply(struct
 	req->cb = xenbus_dev_queue_reply;
 	req->par = par;
 	req->user_req = true;
+	kref_init(&req->kref);
 
 	xs_send(req, msg);
 
@@ -319,6 +332,7 @@ static void *xs_talkv(struct xenbus_tran
 	req->num_vecs = num_vecs;
 	req->cb = xs_wake_up;
 	req->user_req = false;
+	kref_init(&req->kref);
 
 	msg.req_id = 0;
 	msg.tx_id = t.id;



