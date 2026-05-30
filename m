Return-Path: <stable+bounces-258139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHZ5KXokG2pm/ggAu9opvQ
	(envelope-from <stable+bounces-258139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:55:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2009C610A5A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8391B30160C7
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B362341AC7;
	Sat, 30 May 2026 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p05ODKQm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCEF261B9E;
	Sat, 30 May 2026 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163348; cv=none; b=nBAD+K6vr0yeEjBfCJPW7Rh4Bd2bCawR+yriWuET4Xjoe35gnfe2QnFMyc61xoGP3XaXst67R7Lt22BJdj5Qf9B6F5BqZOmOdOnzjOzmMJ+h+9Jt7KdzzCr/izCUqQbJAR2ACp5E25lqVxHMzt4jomyFClqNrlPiVuTxYtP3UqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163348; c=relaxed/simple;
	bh=VrN/W+wyCgc49qZF9UoRtGUhByBaCVpgT0KaT+xefEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENItQm3dbwvEWQOX36RXGLqECzFVv6kHAEe8LbMnTncpKH/3jd7QQ+pi+xGwdwmbfnBprVV1ZtVb3AAH4Kt0ptgAb6a2LTKEZ1XpD8bBMzXVJfdX9ZhgaIBR5VQrKuDq/ox6bzFzqMAx/N6BAuaWLN8boMb1AAzptD9EmQShLK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p05ODKQm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DEE1F00893;
	Sat, 30 May 2026 17:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163346;
	bh=Rmup59E2eI1KZyl9f4Gl9+rvJ7sbFYMLLLoqh9pujzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=p05ODKQmD/vFXT0bAvipr7Q/Ca//LpawsQqKfBSKp4omQMIUsiw8AAMEhkppNAWhA
	 m41S4Ui9CfJf8skIHMzpkhFZF2xpuUa0iOw/bj1YSmsXMcMb6foZciiwpeHgUYVtkG
	 3Yd+nqLGk6eDvbtoXIFp8OPgZjqIQcmIyHGm0jJo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <enjou1224z@gmail.com>,
	Zhengchuan Liang <zcliangcn@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15 200/776] net: caif: clear client service pointer on teardown
Date: Sat, 30 May 2026 17:58:34 +0200
Message-ID: <20260530160245.677443390@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258139-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,lzu.edu.cn,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lzu.edu.cn:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 2009C610A5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhengchuan Liang <zcliangcn@gmail.com>

commit f7cf8ece8cee3c1ee361991470cdb1eb65ab02e8 upstream.

`caif_connect()` can tear down an existing client after remote shutdown by
calling `caif_disconnect_client()` followed by `caif_free_client()`.
`caif_free_client()` releases the service layer referenced by
`adap_layer->dn`, but leaves that pointer stale.

When the socket is later destroyed, `caif_sock_destructor()` calls
`caif_free_client()` again and dereferences the freed service pointer.

Clear the client/service links before releasing the service object so
repeated teardown becomes harmless.

Fixes: 43e369210108 ("caif: Move refcount from service layer to sock and dev.")
Cc: stable@kernel.org
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Link: https://patch.msgid.link/9f3d37847c0037568aae698ca23cd47c6691acb0.1775897577.git.zcliangcn@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/caif/cfsrvl.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/net/caif/cfsrvl.c
+++ b/net/caif/cfsrvl.c
@@ -197,10 +197,20 @@ bool cfsrvl_phyid_match(struct cflayer *
 
 void caif_free_client(struct cflayer *adap_layer)
 {
+	struct cflayer *serv_layer;
 	struct cfsrvl *servl;
-	if (adap_layer == NULL || adap_layer->dn == NULL)
+
+	if (!adap_layer)
+		return;
+
+	serv_layer = adap_layer->dn;
+	if (!serv_layer)
 		return;
-	servl = container_obj(adap_layer->dn);
+
+	layer_set_dn(adap_layer, NULL);
+	layer_set_up(serv_layer, NULL);
+
+	servl = container_obj(serv_layer);
 	servl->release(&servl->layer);
 }
 EXPORT_SYMBOL(caif_free_client);



