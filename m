Return-Path: <stable+bounces-227249-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOIyNCrFu2n1ngIAu9opvQ
	(envelope-from <stable+bounces-227249-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:43:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 576952C8E60
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0E373217780
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508CF3B637A;
	Thu, 19 Mar 2026 09:36:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5013B27D6
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912977; cv=none; b=pFulQm2D4cvOOaCcowfzYk1aHi0aritt52j0aiCK1kPQMZUtnBDd8yMYngzPQ7eTohfIPkWj6oRdxYWlN8tFi17aIQwW3wqk8ThGSqp+TtyuP97+zoR7ta51v2+uTWQFFMv/7fRxzvfw4vPiBvRScDVukgYjM/l0DdVbYLJiYYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912977; c=relaxed/simple;
	bh=iOsjrh+7fT7eBiA8uBPw6vm41mDYgIncXBJx75Kg3PI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jotfI8iE1kD8YeoRvFAHkf6crgT/S2mcw3la1u4Qkhyen1ltp79th10BvL7BdPcF66z14Q/uD24vL8MCEjKXyjg7HvHCyvaQ3lxHZRR8kAQ4CLTIl6/6q960g3nw57W/EUOzGD+IDuY79fJhAdTqA+crsuwBOznNP6J2RIy7qP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-0003O7-OP; Thu, 19 Mar 2026 10:36:09 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-0013DZ-0u;
	Thu, 19 Mar 2026 10:36:09 +0100
Received: from [::1] (helo=dude04.red.stw.pengutronix.de)
	by dude04 with esmtp (Exim 4.98.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-00000008yzO-0Xqh;
	Thu, 19 Mar 2026 10:36:09 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Thu, 19 Mar 2026 10:35:59 +0100
Subject: [PATCH 02/11] net/9p/usbg: also disable endpoints on p9_usbg_close
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-9pfixes-v1-2-c977a7433185@pengutronix.de>
References: <20260319-9pfixes-v1-0-c977a7433185@pengutronix.de>
In-Reply-To: <20260319-9pfixes-v1-0-c977a7433185@pengutronix.de>
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hyungjung Joo <jhj140711@gmail.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=937;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=iOsjrh+7fT7eBiA8uBPw6vm41mDYgIncXBJx75Kg3PI=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBpu8OF8S1QKoQ23PyuWNvolvuq74l/AtJHo+WwI
 fNs7nHMUByJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCabvDhQAKCRC/aVhE+XH0
 q4iREACd4nb0rMWY8R5eaXv7LBnyJDWi9VS6cbJAqTyB1Wr0Ec3rEN258gDb2ZJMkJywVQPXzcE
 EnvcLhDxd/aKSVpri7IV+MRGRInshl84WhMC4xTQBfBkO0ay1MGCktnHRVzuqOO1NrgTeodeNpQ
 zT3qi1M4ECekponmuGekhyZvA8tcJqLic2M35mOH9gPrVK6F8rDwrcdCgX4Fjiipyk79gV0Z6ND
 dntC3ZhpyOpOb0Em+s8nrEtS/wbyoJlHCNawwXMKmW0Y1YNVKE9pKkmuE2UvE8otJ7qokcfx+7M
 DfF8/Iei5gDhfscxCPt9NL/vVrzCA5i/BdCNXSFvMD7MAD9irQEeP3GaPgZiAtuc/sq9gjbnkyD
 pP7a7lj6q+bnxfI38Dhi8s99lGVyaa8srDX6USLpFitG97EgFGn1PensrMBJJKqCuKQzuMTVuN+
 t9dk5YC4GRYl5Wq5eAwcLr2dIlkZ8Pi6UU6iA3XXobzs29C3/yMbA/EQGuOp6Irgt0fI6hyjITR
 jDnyEHo8kpG3d9ickOR4J2ahV0JEWfQ1oWGYkoqa3H+zF5XLZQjwBo1hgnRs+i6a0/pjzVCUn8X
 td0rRCspT304sUd3akU1YkPun/7RL5FIqPV3uSIYde3LpTtQQBADaIeWhhi78ypbHxJcL0MQ5M+
 YKVTFbYhOlcR3qw==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_TO(0.00)[kernel.org,ionkov.net,codewreck.org,crudebyte.com,linuxfoundation.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227249-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.grzeschik@pengutronix.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.953];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,pengutronix.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 576952C8E60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The close function has to fully reverse the state change of 9p_create
(mount) and the potential call of set_alt(1). This includes to ensure
that the usage of the endpoints is not active any more.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 net/9p/trans_usbg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index f7a94572013e7d1015d75fb5dbdde5eb81f7d7d0..fb05198dc2a7d604cfad2db26a63e40e632651a2 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -495,6 +495,8 @@ static void p9_usbg_close(struct p9_client *client)
 	mutex_lock(&usb9pfs_lock);
 	dev->inuse = false;
 	mutex_unlock(&usb9pfs_lock);
+
+	disable_usb9pfs(usb9pfs);
 }
 
 static int p9_usbg_request(struct p9_client *client, struct p9_req_t *p9_req)

-- 
2.47.3


