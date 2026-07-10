Return-Path: <stable+bounces-273104-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HQzDOgRWUGrMwwIAu9opvQ
	(envelope-from <stable+bounces-273104-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 04:16:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D917369C9
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 04:16:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273104-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273104-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78BDB30293E4
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 02:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D981DF248;
	Fri, 10 Jul 2026 02:16:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D02218DB1F;
	Fri, 10 Jul 2026 02:16:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783649793; cv=none; b=p1pcXvIEBIWMADHyOYdt8pMsG3EEKpQXgW65ZqfYCGsHjiBpkYcwKkb46XUWj+6ACdyrcJ97BgDRmebO/yXjZ1V7tDDU6718Ik3zyG2xVG9R8qf7QWiBv/5ym5MC8JyCVbmjSuSH7lmdbm77E1fjHypKXmgxP6CE9pcVRcqvhOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783649793; c=relaxed/simple;
	bh=KldnIJzxwL5T5pYMNoSQZM+2y8T4U6TiFm6hAdsZCi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mhat5HcRb0dyg3fvgod5vweyUykrZpbybeVMZ/dCMfONZ8qy8r2mKMD6RNnkZG+j5r9+BcSmCEJ9qoaE4E652HTk4xvWlKT5p6qERZtKjao9CwM0DjXZMHVovO+SltkX5XsgmgmyKRUd4OxdH8pNwB5kX5qnj5Ry72VeKe/o+HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 5864fae27c0511f1aa26b74ffac11d73-20260710
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:25006c85-7c24-48a6-9d7e-4c3a866fb2bd,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.12,REQID:25006c85-7c24-48a6-9d7e-4c3a866fb2bd,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-15
X-CID-META: VersionHash:e7bac3a,CLOUDID:2429cd1f8d4a075bfa61a2a91ef3cb40,BulkI
	D:260710101625J7Z3KJ6P,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|865
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5864fae27c0511f1aa26b74ffac11d73-20260710
X-User: tanze@kylinos.cn
Received: from desktop-od00ebi.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <tanze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 984822242; Fri, 10 Jul 2026 10:16:22 +0800
From: tanze <tanze@kylinos.cn>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ze Tan <tanze@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v1] net/9p: abort interrupted RPCs on fatal signals
Date: Fri, 10 Jul 2026 10:15:51 +0800
Message-ID: <20260710021602.15241-1-tanze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273104-lists,stable=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[tanze@kylinos.cn,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ericvh@kernel.org,m:lucho@ionkov.net,m:asmadeus@codewreck.org,m:v9fs@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:tanze@kylinos.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tanze@kylinos.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21D917369C9

From: Ze Tan <tanze@kylinos.cn>

Syzkaller reported a hung task while a thread group was dumping core:

  INFO: task syz.1.4497:22259 blocked for more than 143 seconds.
  Call trace:
   __switch_to
   __schedule
   schedule
   schedule_timeout
   __wait_for_common
   wait_for_completion_state
   vfs_coredump
   get_signal
   do_notify_resume

In current mainline this is get_signal() -> vfs_coredump() ->
coredump_wait(), where coredump_wait() waits for the other threads in the
thread group to enter the core-dump rendezvous.

The workload also creates 9p fd mounts backed by pipes. One thread may be
blocked in p9_client_rpc() waiting for a reply from the 9p server, while
another thread in the same thread group enters the coredump path. The
coredump code sends a fatal signal to the blocked thread and waits for it
to exit, but the 9p client handles the interruption like a normal signal:
it sends TFLUSH and waits for the flush reply. If the 9p server is not
replying, the blocked thread cannot exit and vfs_coredump() remains stuck
in coredump_wait().

Commit 6b4f48728faa ("net/9p: fix infinite loop in p9_client_rpc on fatal
signal") made the P9_TFLUSH wait itself stop retrying on a fatal signal.
That still leaves the caller's original non-flush RPC entering the flush
path after a fatal signal. A fatal signal is not a recoverable
interruption; the task needs to return to signal handling rather than
trying to synchronously cancel the 9p request.

Skip the TFLUSH path on fatal signals. Let the transport cancel unsent
requests as before. If the request has already been sent, mark it
REQ_STATUS_ABORTED and return to the caller while keeping the tag and
request object alive until a late reply arrives or the transport is torn
down. Teach reply paths that match requests by status to accept aborted
requests and consume their replies without waking a waiter.

This lets the fatal-signal path reach thread exit/coredump completion
while still preventing tag reuse and late-reply misdelivery.

Fixes: 91b8534fa8f5 ("9p: make rpc code common and rework flush code")
Cc: stable@vger.kernel.org
Signed-off-by: Ze Tan <tanze@kylinos.cn>
---
 include/net/9p/client.h |  3 +++
 net/9p/client.c         | 37 +++++++++++++++++++++++++++++++++++++
 net/9p/trans_fd.c       |  7 ++++++-
 net/9p/trans_usbg.c     |  7 ++++++-
 net/9p/trans_xen.c      | 12 +++++++++---
 5 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 55c6cb54bd25..700dcb37c1dc 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -58,6 +58,8 @@ enum p9_trans_status {
  * @REQ_STATUS_UNSENT: request waiting to be sent
  * @REQ_STATUS_SENT: request sent to server
  * @REQ_STATUS_RCVD: response received from server
+ * @REQ_STATUS_ABORTED: caller stopped waiting, but the request keeps its tag
+ *                      reserved until a reply arrives or the transport closes
  * @REQ_STATUS_FLSHD: request has been flushed
  * @REQ_STATUS_ERROR: request encountered an error on the client side
  */
@@ -67,6 +69,7 @@ enum p9_req_status_t {
 	REQ_STATUS_UNSENT,
 	REQ_STATUS_SENT,
 	REQ_STATUS_RCVD,
+	REQ_STATUS_ABORTED,
 	REQ_STATUS_FLSHD,
 	REQ_STATUS_ERROR,
 };
diff --git a/net/9p/client.c b/net/9p/client.c
index ef64546c6d52..3ad2fc0f415a 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -538,6 +538,21 @@ static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
 	return ERR_PTR(err);
 }
 
+static void p9_client_abort(struct p9_client *c, struct p9_req_t *req)
+{
+	/*
+	 * A fatal signal cannot wait for TFLUSH, but a sent request must keep
+	 * its tag until a late reply arrives or the transport is torn down.
+	 */
+	if (READ_ONCE(req->status) >= REQ_STATUS_RCVD)
+		return;
+
+	if (!c->trans_mod->cancel(c, req))
+		return;
+
+	cmpxchg(&req->status, REQ_STATUS_SENT, REQ_STATUS_ABORTED);
+}
+
 /**
  * p9_client_rpc - issue a request and wait for a response
  * @c: client session
@@ -612,6 +627,17 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 		err = req->t_err;
 	}
 	if (err == -ERESTARTSYS && c->status == Connected) {
+		if (READ_ONCE(req->status) == REQ_STATUS_RCVD) {
+			err = 0;
+			goto recalc_sigpending;
+		}
+
+		if (fatal_signal_pending(current)) {
+			p9_debug(P9_DEBUG_MUX, "fatal signal: skip flush\n");
+			p9_client_abort(c, req);
+			goto recalc_sigpending;
+		}
+
 		p9_debug(P9_DEBUG_MUX, "flushing\n");
 		sigpending = 1;
 		clear_thread_flag(TIF_SIGPENDING);
@@ -697,6 +723,17 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 		err = req->t_err;
 	}
 	if (err == -ERESTARTSYS && c->status == Connected) {
+		if (READ_ONCE(req->status) == REQ_STATUS_RCVD) {
+			err = 0;
+			goto recalc_sigpending;
+		}
+
+		if (fatal_signal_pending(current)) {
+			p9_debug(P9_DEBUG_MUX, "fatal signal: skip flush\n");
+			p9_client_abort(c, req);
+			goto recalc_sigpending;
+		}
+
 		p9_debug(P9_DEBUG_MUX, "flushing\n");
 		sigpending = 1;
 		clear_thread_flag(TIF_SIGPENDING);
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index eb685b52aeb2..1ceb6192ece6 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -293,7 +293,9 @@ static void p9_read_work(struct work_struct *work)
 			 m, m->rc.size, m->rc.tag);
 
 		m->rreq = p9_tag_lookup(m->client, m->rc.tag);
-		if (!m->rreq || (m->rreq->status != REQ_STATUS_SENT)) {
+		if (!m->rreq ||
+		    (m->rreq->status != REQ_STATUS_SENT &&
+		     m->rreq->status != REQ_STATUS_ABORTED)) {
 			p9_debug(P9_DEBUG_ERROR, "Unexpected packet tag %d\n",
 				 m->rc.tag);
 			err = -EIO;
@@ -332,6 +334,9 @@ static void p9_read_work(struct work_struct *work)
 		if (m->rreq->status == REQ_STATUS_SENT) {
 			list_del(&m->rreq->req_list);
 			p9_client_cb(m->client, m->rreq, REQ_STATUS_RCVD);
+		} else if (m->rreq->status == REQ_STATUS_ABORTED) {
+			list_del(&m->rreq->req_list);
+			p9_client_cb(m->client, m->rreq, REQ_STATUS_ABORTED);
 		} else if (m->rreq->status == REQ_STATUS_FLSHD) {
 			/* Ignore replies associated with a cancelled request. */
 			p9_debug(P9_DEBUG_TRANS,
diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 419cda13a7b5..c2b4cf839829 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -203,7 +203,9 @@ static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, void *buf)
 		 usb9pfs, rc.size, rc.tag);
 
 	p9_rx_req = p9_tag_lookup(usb9pfs->client, rc.tag);
-	if (!p9_rx_req || p9_rx_req->status != REQ_STATUS_SENT) {
+	if (!p9_rx_req ||
+	    (p9_rx_req->status != REQ_STATUS_SENT &&
+	     p9_rx_req->status != REQ_STATUS_ABORTED)) {
 		p9_debug(P9_DEBUG_ERROR, "Unexpected packet tag %d\n", rc.tag);
 		return NULL;
 	}
@@ -245,6 +247,9 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
 	if (!p9_rx_req)
 		return;
 
+	if (p9_rx_req->status == REQ_STATUS_ABORTED)
+		status = REQ_STATUS_ABORTED;
+
 	if (req_size > p9_rx_req->rc.capacity) {
 		dev_err(&cdev->gadget->dev,
 			"%s received data size %u exceeds buffer capacity %zu\n",
diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index f9fb2db7a066..e15d56f8add3 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -201,7 +201,9 @@ static void p9_xen_response(struct work_struct *work)
 				     XEN_9PFS_RING_SIZE(ring));
 
 		req = p9_tag_lookup(priv->client, h.tag);
-		if (!req || req->status != REQ_STATUS_SENT) {
+		if (!req ||
+		    (req->status != REQ_STATUS_SENT &&
+		     req->status != REQ_STATUS_ABORTED)) {
 			dev_warn(&priv->dev->dev, "Wrong req tag=%x\n", h.tag);
 			cons += h.size;
 			virt_mb();
@@ -233,8 +235,12 @@ static void p9_xen_response(struct work_struct *work)
 		cons += h.size;
 		ring->intf->in_cons = cons;
 
-		status = (req->status != REQ_STATUS_ERROR) ?
-			REQ_STATUS_RCVD : REQ_STATUS_ERROR;
+		if (req->status == REQ_STATUS_ERROR)
+			status = REQ_STATUS_ERROR;
+		else if (req->status == REQ_STATUS_ABORTED)
+			status = REQ_STATUS_ABORTED;
+		else
+			status = REQ_STATUS_RCVD;
 
 		p9_client_cb(priv->client, req, status);
 	}
-- 
2.43.0


