Return-Path: <stable+bounces-234087-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCd7DtWa1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234087-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:13:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C669E3C037A
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5B433035A66
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B983D8917;
	Wed,  8 Apr 2026 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mOhDaUFd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2A6347503;
	Wed,  8 Apr 2026 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671951; cv=none; b=qMAHCX7TmusIpxoAjVqHhUnueGJczSxyfPzU6isE5HupO68TIoobAbpLi38GOJGar42t3h4aYtg+kw1ukqidOTR/EkkxECa8Lrw/N+iRavTCK2372vRH/Hb/52Vawhl9Ki/xbn+9FEgXtm3qOuc7M+XOiFb7LVuB1Ma4jVucRPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671951; c=relaxed/simple;
	bh=TbTAwjXV5VIKkLHOg3tk6HKHTYxIWfVrRmWGHtI0fxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBktUecoq5WeTwVBOX9cXPkU5sGjadU7DQAiweHY081+rtLW+dmNZALpE/JS/wwy2Tphr4JsKBDmD6Pcp7D9rmflyI0v51XRt81Bh/9+XFLq1byMg31vW3od76blq6/Wgo2IKht9yYuzqmrXu+FeZ7p2WhdSry1PneM3aVznjI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mOhDaUFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19020C19421;
	Wed,  8 Apr 2026 18:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775671951;
	bh=TbTAwjXV5VIKkLHOg3tk6HKHTYxIWfVrRmWGHtI0fxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mOhDaUFdltjYZlMGkwhylzm9fYikoNRdPxxFl0QHk2LQT9FvBgLcm+z3kDVP7bPYB
	 wc6N1HA5Jq+IG5H4pdaDa+gIaLfxvLQju5I6AEHoxNQPpG26n2fiMmCRFe8V3ZSAOL
	 cLNSzsQ7Utr1JI5Bt7oepovEL2ToWjPS4BnzpBow=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Jiang <dave.jiang@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 132/312] dmaengine: idxd: Fix freeing the allocated ida too late
Date: Wed,  8 Apr 2026 20:00:49 +0200
Message-ID: <20260408175938.701562443@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234087-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: C669E3C037A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

[ Upstream commit c311f5e9248471a950f0a524c2fd736414d98900 ]

It can happen that when the cdev .release() is called, the driver
already called ida_destroy(). Move ida_free() to the _del() path.

We see with DEBUG_KOBJECT_RELEASE enabled and forcing an early PCI
unbind.

Fixes: 04922b7445a1 ("dmaengine: idxd: fix cdev setup and free device lifetime issues")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Link: https://patch.msgid.link/20260121-idxd-fix-flr-on-kernel-queues-v3-v3-9-7ed70658a9d1@intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/idxd/cdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index e42c9a9f3c238..622cc47c6a182 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -45,11 +45,7 @@ struct idxd_user_context {
 static void idxd_cdev_dev_release(struct device *dev)
 {
 	struct idxd_cdev *idxd_cdev = dev_to_cdev(dev);
-	struct idxd_cdev_context *cdev_ctx;
-	struct idxd_wq *wq = idxd_cdev->wq;
 
-	cdev_ctx = &ictx[wq->idxd->data->type];
-	ida_free(&cdev_ctx->minor_ida, idxd_cdev->minor);
 	kfree(idxd_cdev);
 }
 
@@ -410,11 +406,15 @@ int idxd_wq_add_cdev(struct idxd_wq *wq)
 
 void idxd_wq_del_cdev(struct idxd_wq *wq)
 {
+	struct idxd_cdev_context *cdev_ctx;
 	struct idxd_cdev *idxd_cdev;
 
 	idxd_cdev = wq->idxd_cdev;
 	wq->idxd_cdev = NULL;
 	cdev_device_del(&idxd_cdev->cdev, cdev_dev(idxd_cdev));
+
+	cdev_ctx = &ictx[wq->idxd->data->type];
+	ida_free(&cdev_ctx->minor_ida, idxd_cdev->minor);
 	put_device(cdev_dev(idxd_cdev));
 }
 
-- 
2.53.0




