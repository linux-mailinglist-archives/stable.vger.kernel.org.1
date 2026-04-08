Return-Path: <stable+bounces-234257-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFFgGsqc1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234257-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:22:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 802273C0809
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB546301B852
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FA63D6694;
	Wed,  8 Apr 2026 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NAm8vODa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEEB324B1F;
	Wed,  8 Apr 2026 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672391; cv=none; b=hbS1DSmo6ja2ipL7Krx0KsXgr8x62SsK42DQJ5wYuy4WiFwbqITXCufXnx8eYCBgmqSkFgBcXVWdIitNpm/tDT5wtiEAMbykzd8KFPhk1mgZN6vCvv/ifoT5v+yELslVmUz//TQWEYUhAdbMArHYJfs4/Mp7Jl1ThlVnSHTEfO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672391; c=relaxed/simple;
	bh=lhvu2Ir/MEDK1t35MN+r+wX2zB9cyBKdkUTnngGkoZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXBuAP9QaT2RDAcHmXO7II+euuxPBZ6PY9nvHDiZQd13J07xKei/9y2jUBWMAklvoPnjziuQNjRi2yKKUSANc0zUxi+cnoXFe/Usx+aL4FMKMFFX1Zt85oKVeJIrDTq5HmiA3vE2xAiEW1/v0GjY59vMxM+/z95Rmmb49PsC+ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NAm8vODa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B8EC19421;
	Wed,  8 Apr 2026 18:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672390;
	bh=lhvu2Ir/MEDK1t35MN+r+wX2zB9cyBKdkUTnngGkoZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NAm8vODaIG6Fi/C0d8cO8WjvBB7HAMTQ/jIil12KpFPTff8ov7YLR8/CLkjj24NjO
	 V+stc8wy209tofnfmzXBQIhBKiTu9zh4HYtFtJ+Mb+rnO7S8299YSwahybtY4gPCq1
	 IUKZ28WbYE+yPVXJ/QKmkl3ZabzmibVyQl7330r4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuen-Han Tsai <khtsai@google.com>
Subject: [PATCH 6.1 269/312] usb: gadget: f_subset: Fix unbalanced refcnt in geth_free
Date: Wed,  8 Apr 2026 20:03:06 +0200
Message-ID: <20260408175943.796324629@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234257-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 802273C0809
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuen-Han Tsai <khtsai@google.com>

commit caa27923aacd8a5869207842f2ab1657c6c0c7bc upstream.

geth_alloc() increments the reference count, but geth_free() fails to
decrement it. This prevents the configuration of attributes via configfs
after unlinking the function.

Decrement the reference count in geth_free() to ensure proper cleanup.

Fixes: 02832e56f88a ("usb: gadget: f_subset: add configfs support")
Cc: stable@vger.kernel.org
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
Link: https://patch.msgid.link/20260320-usb-net-lifecycle-v1-1-4886b578161b@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_subset.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/usb/gadget/function/f_subset.c
+++ b/drivers/usb/gadget/function/f_subset.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2008 Nokia Corporation
  */
 
+#include <linux/cleanup.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -451,8 +452,13 @@ static struct usb_function_instance *get
 static void geth_free(struct usb_function *f)
 {
 	struct f_gether *eth;
+	struct f_gether_opts *opts;
+
+	opts = container_of(f->fi, struct f_gether_opts, func_inst);
 
 	eth = func_to_geth(f);
+	scoped_guard(mutex, &opts->lock)
+		opts->refcnt--;
 	kfree(eth);
 }
 



