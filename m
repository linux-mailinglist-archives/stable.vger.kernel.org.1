Return-Path: <stable+bounces-45633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624F18CCCAD
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 09:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85DD81C2224B
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 07:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA7713C9B8;
	Thu, 23 May 2024 07:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zpchGsiK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB8213AA24
	for <stable@vger.kernel.org>; Thu, 23 May 2024 07:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716447932; cv=none; b=SXRAx+zS0tWmCCXjYnSatoccOfiGpBr//xM2q8Z63gov+wX/zKPeluXCI9htuyJq8L8xnPjfo3pPtLMnP55dJDguIjPj3pwRfR3sQVpBj2jH23PSKHEMA/qQIymM5j8b02YvzwZjDSOugxmsExqYbaH8u5kz4kMDV1IN37Jnl/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716447932; c=relaxed/simple;
	bh=ck0jwkNu0VYcvLlDtNd5gGhZ1TV69nYpd5obgKCPHxU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FMxYfXOMYWFRkchGEP+jJJM6NP6Ds/ItQtJhPTy9bzxn6vvbYPE0BXpEFpyLHsAj43En1aJvDWTCM/WnyvZ+UxLtEGwGSQ/udA69h+RpF0OVGzb8PbI8MEFXq39PuIM1sffidKzBlHT7yHLqY0ATRGgR1N4dstbLVTQC9Q1tI6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zpchGsiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885D8C2BD10;
	Thu, 23 May 2024 07:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716447931;
	bh=ck0jwkNu0VYcvLlDtNd5gGhZ1TV69nYpd5obgKCPHxU=;
	h=Subject:To:Cc:From:Date:From;
	b=zpchGsiK7n8u8DCzjNPvpIRtSvMbrblzm/yFN6FP6VsiboaJ2uYnXy9JwUa5sS9cD
	 f3cOwiZPTUwhcvzBKHuPd7usxNbQipbFStlCx3c49F64Drr+K0GclXvikv5LwMlBre
	 tYHJTUTKOHENGCZZoE+IUdLCc7+9yxoDnlfB73qw=
Subject: FAILED: patch "[PATCH] Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_connect()" failed to apply to 5.10-stable tree
To: iam@sung-woo.kim,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 23 May 2024 09:05:25 +0200
Message-ID: <2024052324-onlooker-removal-e3ba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4d7b41c0e43995b0e992b9f8903109275744b658
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024052324-onlooker-removal-e3ba@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

4d7b41c0e439 ("Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_connect()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4d7b41c0e43995b0e992b9f8903109275744b658 Mon Sep 17 00:00:00 2001
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Tue, 30 Apr 2024 02:32:10 -0400
Subject: [PATCH] Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_connect()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extend a critical section to prevent chan from early freeing.
Also make the l2cap_connect() return type void. Nothing is using the
returned value but it is ugly to return a potentially freed pointer.
Making it void will help with backports because earlier kernels did use
the return value. Now the compile will break for kernels where this
patch is not a complete fix.

Call stack summary:

[use]
l2cap_bredr_sig_cmd
  l2cap_connect
  ┌ mutex_lock(&conn->chan_lock);
  │ chan = pchan->ops->new_connection(pchan); <- alloc chan
  │ __l2cap_chan_add(conn, chan);
  │   l2cap_chan_hold(chan);
  │   list_add(&chan->list, &conn->chan_l);   ... (1)
  └ mutex_unlock(&conn->chan_lock);
    chan->conf_state              ... (4) <- use after free

[free]
l2cap_conn_del
┌ mutex_lock(&conn->chan_lock);
│ foreach chan in conn->chan_l:            ... (2)
│   l2cap_chan_put(chan);
│     l2cap_chan_destroy
│       kfree(chan)               ... (3) <- chan freed
└ mutex_unlock(&conn->chan_lock);

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read
include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in _test_bit
include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in l2cap_connect+0xa67/0x11a0
net/bluetooth/l2cap_core.c:4260
Read of size 8 at addr ffff88810bf040a0 by task kworker/u3:1/311

Fixes: 73ffa904b782 ("Bluetooth: Move conf_{req,rsp} stuff to struct l2cap_chan")
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 84fc70862d78..868a370a16aa 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3902,13 +3902,12 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn,
 	return 0;
 }
 
-static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
-					struct l2cap_cmd_hdr *cmd,
-					u8 *data, u8 rsp_code, u8 amp_id)
+static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
+			  u8 *data, u8 rsp_code, u8 amp_id)
 {
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
-	struct l2cap_chan *chan = NULL, *pchan;
+	struct l2cap_chan *chan = NULL, *pchan = NULL;
 	int result, status = L2CAP_CS_NO_INFO;
 
 	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
@@ -3921,7 +3920,7 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 					 &conn->hcon->dst, ACL_LINK);
 	if (!pchan) {
 		result = L2CAP_CR_BAD_PSM;
-		goto sendresp;
+		goto response;
 	}
 
 	mutex_lock(&conn->chan_lock);
@@ -4008,17 +4007,15 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	}
 
 response:
-	l2cap_chan_unlock(pchan);
-	mutex_unlock(&conn->chan_lock);
-	l2cap_chan_put(pchan);
-
-sendresp:
 	rsp.scid   = cpu_to_le16(scid);
 	rsp.dcid   = cpu_to_le16(dcid);
 	rsp.result = cpu_to_le16(result);
 	rsp.status = cpu_to_le16(status);
 	l2cap_send_cmd(conn, cmd->ident, rsp_code, sizeof(rsp), &rsp);
 
+	if (!pchan)
+		return;
+
 	if (result == L2CAP_CR_PEND && status == L2CAP_CS_NO_INFO) {
 		struct l2cap_info_req info;
 		info.type = cpu_to_le16(L2CAP_IT_FEAT_MASK);
@@ -4041,7 +4038,9 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 		chan->num_conf_req++;
 	}
 
-	return chan;
+	l2cap_chan_unlock(pchan);
+	mutex_unlock(&conn->chan_lock);
+	l2cap_chan_put(pchan);
 }
 
 static int l2cap_connect_req(struct l2cap_conn *conn,


