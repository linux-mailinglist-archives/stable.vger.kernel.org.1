Return-Path: <stable+bounces-252140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAOBFxr3DWry4wUAu9opvQ
	(envelope-from <stable+bounces-252140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:02:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4CF595237
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CF9530B2020
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB003769E0;
	Wed, 20 May 2026 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tLwPrdrT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2792E3F7ABB;
	Wed, 20 May 2026 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299897; cv=none; b=IHzhn/2EIiTU309z4GFOrYry7eGECo6V6ZdFSfCzpMc6R2Q6taNSqs2YaOGrQJyj9yxWnjYYe/9L8Moaq2qvRJzwJ72hCZQo3vDw0/+1O+553yTn3wuU6ejWcaj33R/pcnHYq3Kqey4Gr8pZQ6PBizB1Mx4fEfvrQxkiSw9GUDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299897; c=relaxed/simple;
	bh=IZmtsA15vjSS123QNly4oma//P9iIf6Y2wM5ee6+hEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srSWgC8eyEkg9dtu7avaFuZ7xHVs208jfyP8KA4k+//H1QXWjU9BaoKMD+90CoNPyRsPiUmYl+f2BbJRw/ZvJi/+M1aTJisIWhanoXEwYMm44NBEUZV1X4z/+g/9g07vwbuMMdj05siErCSrssNjpIzMQ3Sqm4see2d84wbk4oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tLwPrdrT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EE51F00894;
	Wed, 20 May 2026 17:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299894;
	bh=wqsfiqCQcRVG9n8zj2aZ6nzm831zCG1wuZMgpm3aOdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tLwPrdrTfgAgtFSqLedkO4FyEyCDVRlTylkvANwgG3/LuaizT4vz+qt3+MPJGZ0S1
	 3NBqP/y5quD/UFw4KTnpnCy6OQFcaNGv7em3f4KLnzPCvjYa/Mle2ApTWRQXWPxIpL
	 ahkpqNHYzvC1cI03KJFjtHIoBGX26SBDb+H7xtVc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH 6.18 925/957] powerpc/warp: Fix error handling in pika_dtm_thread
Date: Wed, 20 May 2026 18:23:28 +0200
Message-ID: <20260520162154.644161318@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252140-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CD4CF595237
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make24@iscas.ac.cn>

commit 108d7f951271cbd36ca36efc5e5d106966f5180c upstream.

pika_dtm_thread() acquires client through of_find_i2c_device_by_node()
but fails to release it in error handling path. This could result in a
reference count leak, preventing proper cleanup and potentially
leading to resource exhaustion. Add put_device() to release the
reference in the error handling path.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 3984114f0562 ("powerpc/warp: Platform fix for i2c change")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20251116024411.21968-1-make24@iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/44x/warp.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/powerpc/platforms/44x/warp.c
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -293,6 +293,8 @@ static int pika_dtm_thread(void __iomem
 		schedule_timeout(HZ);
 	}
 
+	put_device(&client->dev);
+
 	return 0;
 }
 



