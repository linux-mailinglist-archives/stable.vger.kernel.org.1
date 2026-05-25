Return-Path: <stable+bounces-254101-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG1gKAz+E2quIQcAu9opvQ
	(envelope-from <stable+bounces-254101-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 09:45:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2255C73B8
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 09:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B24953002D35
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 07:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE313D4108;
	Mon, 25 May 2026 07:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SDKF4niB"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176B43D410A;
	Mon, 25 May 2026 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779695111; cv=none; b=JoSbxNVUD5PM1rwDhHfT17lB5hdAl3hCRpmYA4ExIbVKO5hF+eHIi//5PiE98JGTIDC1LMCnDTd5nHgrW7kpC4rXrjgoKpTC9es+gglTPjiodd5vs7+GGVRy7hqJmkqpOS/Z+topm6ldWloEI3W3zO1F5DzuH/YXT3bE2e+JNG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779695111; c=relaxed/simple;
	bh=TIAz4wlLKlIAPWQt9dfhOzCP7ACSiDb+V5filsopots=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ufChhwj8WBqrEdCk1J7/JiVgsGKFLkBhgTHyLQiZ+i5Vvpur1vtRodQAFlfLPXDJZfNNeF6MzOpWPCsXYoOKlmZ0niVrxegq8FBCgxdegpSrlyfjsnA4M0XG5jj93TB6Kn+OI84aPZrg+GrVzTrF/lLCRBfDe0oAezfwST2pqlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=SDKF4niB; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1779695098; bh=jGZVhuzIUBDvzr37jEcw5y55t/s7RWVAMdOgkWac4OI=;
	h=From:To:Cc:Subject:Date;
	b=SDKF4niBWdaf55WAMiAORXm5sDrJ7tl28anQWGAYc23HBY7qcZS4X4CfzEAWC9u9r
	 HeceK3/wtdzK/wERMnr3zpCwqlYVfzBdPkIWd6fzm3HjLBUs8FNizjGxv71YA4KyQV
	 SDifCJl1DHuLc5YOxQ5ZI9p9+KrLwZd24ZTwi1eI=
Received: from NTT-kernel-dev ([60.247.85.88])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id B3689645; Mon, 25 May 2026 15:44:54 +0800
X-QQ-mid: xmsmtpt1779695094tc2zzl5dk
Message-ID: <tencent_C9D9ED71D51B177EDF71B708417942F4F206@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUAFbPCqhgAqlKhFTUmK401BqGnC/2AUQ0N66PdlRJPLvhh1uzbH4
	 sDLlRr0vCPeBHnh8Q1jglZviTR5VNsHD+I+mPMkS8jN3B+JfTtcKkKEi3HoMNMVLZqKLOR2Ax0XT
	 lWPSuuTCUZg3kjSwjrrOhLyn6F1FegzS0T4S8RokViRMHeZgi77VyDkDwRVKzK7a2bnCWy8CCKEL
	 oqKHMolv9IbqEvT6rzCT+MYLtKj/rPHC+YwLyXcc8/wBucwVyfR3Rjulbl3pcVWhxcOrgTKEAXJ5
	 NAm7NQqv7E+n/gq7sWdJ0z9hQoDli+qL/Pj/atv9y/1G9BWs+dwuYw7EBBrRGJp4ktFsc29Btq03
	 xkhxssIS+mOU3+T5pM2C/QBEsjL5rwzZKQo7Lom4qx3ffaiBPhLCd0TRFsYXF6La6GBAGRJAbpFT
	 vfoCfs7L2INhoe/Nv3Hx5rtbcj5hlSRJYb3q5t6HlbRxxchjCEcxUPxbt5w7sVDJe636sXFI4mX4
	 MEVbY7CAmoTykVmkNYflzTn00GKcFgprWMwADBHWtZ6SiK3dERjmkQFNcY5UxPM8WitjHg6/+Bd2
	 tmysrpEKFt3qds7APAKERq6hBhScWlDSSbClscXatsCkh6aVmNoi4OOKCpQQk5jkxgBRcUIVfagQ
	 z+ApHJzZ83R+9ynyaHY6aRWbgF0FYLJBkBJgASxxBhzXXattcw/vfDOYmr0dNm01dPKUVKNZ/NH4
	 9GkqAGTKMitJnCpEthfnqdYM/X5/67+3tvomuinhp5kreKDDGK0DbBxUwRWfCJUDOLk4TxXh8IKs
	 0a1HbdzrwOeeUSVhCODa+lXAADyZqDyLrQuK4WATuUSiV5ETSRpeuJGWKWMIUqJ3WVHt+t6D4Iqc
	 +KLGhJSe+L3o5a6/X40nCKXEbyKn7mUVrH7mcCaI6QyRESb8bh5qr0f2qb+4l53ogE2tCGBCLoXL
	 lIWlsyOTuezJRvsoBUkHOpMns/93x7J/Xz5s+s6SedREGi4tooZm1RqbtSzpunxCf4Vd04fPMg+0
	 cnWl8QpnHXYhqxzNmSDwOYJLK/U2k=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Fang Wang <32840572@qq.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	alison.schofield@intel.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	ming.li@zohomail.com,
	linux-cxl@vger.kernel.org
Subject: [PATCH 6.6.y] cxl/port: Fix use after free of parent_port in cxl_detach_ep()
Date: Mon, 25 May 2026 15:44:54 +0800
X-OQ-MSGID: <20260525074454.1150115-1-32840572@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[zohomail.com:email];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[qq.com,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	TAGGED_FROM(0.00)[bounces-254101-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[qq.com:s=s201512];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[32840572@qq.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,huawei.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,qq.com:email,qq.com:mid,qq.com:dkim]
X-Rspamd-Queue-Id: AF2255C73B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alison Schofield <alison.schofield@intel.com>

[ Upstream commit 19d2f0b97a131198efc2c4ca3eb7f980bba8c2b4 ]

cxl_detach_ep() is called during bottom-up removal when all CXL memory
devices beneath a switch port have been removed. For each port in the
hierarchy it locks both the port and its parent, removes the endpoint,
and if the port is now empty, marks it dead and unregisters the port
by calling delete_switch_port(). There are two places during this work
where the parent_port may be used after freeing:

First, a concurrent detach may have already processed a port by the
time a second worker finds it via bus_find_device(). Without pinning
parent_port, it may already be freed when we discover port->dead and
attempt to unlock the parent_port. In a production kernel that's a
silent memory corruption, with lock debug, it looks like this:

[]DEBUG_LOCKS_WARN_ON(__owner_task(owner) != get_current())
[]WARNING: kernel/locking/mutex.c:949 at __mutex_unlock_slowpath+0x1ee/0x310
[]Call Trace:
[]mutex_unlock+0xd/0x20
[]cxl_detach_ep+0x180/0x400 [cxl_core]
[]devm_action_release+0x10/0x20
[]devres_release_all+0xa8/0xe0
[]device_unbind_cleanup+0xd/0xa0
[]really_probe+0x1a6/0x3e0

Second, delete_switch_port() releases three devm actions registered
against parent_port. The last of those is unregister_port() and it
calls device_unregister() on the child port, which can cascade. If
parent_port is now also empty the device core may unregister and free
it too. So by the time delete_switch_port() returns, parent_port may
be free, and the subsequent device_unlock(&parent_port->dev) operates
on freed memory. The kernel log looks same as above, with a different
offset in cxl_detach_ep().

Both of these issues stem from the absence of a lifetime guarantee
between a child port and its parent port.

Establish a lifetime rule for ports: child ports hold a reference to
their parent device until release. Take the reference when the port
is allocated and drop it when released. This ensures the parent is
valid for the full lifetime of the child and eliminates the use after
free window in cxl_detach_ep().

This is easily reproduced with a reload of cxl_acpi in QEMU with CXL
devices present.

Fixes: 2345df54249c ("cxl/memdev: Fix endpoint port removal")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Link: https://patch.msgid.link/20260226184439.1732841-1-alison.schofield@intel.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Fang Wang <32840572@qq.com>
---
 drivers/cxl/core/port.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 7f28d1021fa9..5326150a1c64 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -527,6 +527,7 @@ static void cxl_port_release(struct device *dev)
 	xa_destroy(&port->dports);
 	xa_destroy(&port->regions);
 	ida_free(&cxl_port_ida, port->id);
+	put_device(dev->parent);
 	kfree(port);
 }
 
@@ -657,6 +658,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 		struct cxl_port *iter;
 
 		dev->parent = &parent_port->dev;
+		get_device(dev->parent);
 		port->depth = parent_port->depth + 1;
 		port->parent_dport = parent_dport;
 
-- 
2.34.1


