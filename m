Return-Path: <stable+bounces-236900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF9BKBwe3WmSaAkAu9opvQ
	(envelope-from <stable+bounces-236900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:47:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9593EFCB4
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E2EC303BF16
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A252F90C5;
	Mon, 13 Apr 2026 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZkH+mRjo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C2E2D8364;
	Mon, 13 Apr 2026 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098081; cv=none; b=ScRA/CNuBWWKoZRVmNALdqvY9bMc9dUD8kilhltU6hjD7AJkblq/xfvaqyGaG5WA+J0dIwQZ0ulTdaZx5re/GQexqFVzF2d6z1vZov5NowHjA5fUtZDbemqewPnUij5uQiZ8CfJOXIu/vc5hdZ117aBeUaaGb/Eeqrc3Z0c9348=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098081; c=relaxed/simple;
	bh=v6PQ0af9/QMQMsEq6ckC14MX2updPPAWWFRF99ykDCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzyxUESjzqc7ydDYSbqBug2oS3fAqQurEwhY2msDMjcyoiGBny5cabgz3SmvvJsaCHt93JCmRfX8TIUvxM14biN7nPpwnzSKMIytkB0ioiChqNeFrlnzOh5CLrF8zsRNMMg+5RJjKs0IkkEWYr+62LDBvmJmg/4+Vvm6R2uqla8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZkH+mRjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F459C2BCAF;
	Mon, 13 Apr 2026 16:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098081;
	bh=v6PQ0af9/QMQMsEq6ckC14MX2updPPAWWFRF99ykDCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZkH+mRjo8V+vszFHvEVhHtd+EfQc2trd8OLTQdmeVMwVFiNGAm29Z2lhSqWhPiHnn
	 epA25OY72MJjQg1AuMPJnTQTI5dQocBAN/0dpqeYWI+OUCqaa7CdwR3XjM4q3OtK0r
	 wqkGhkAoGc4wKNHTPXdV6vnWZK/phYWwLV25Locc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Jiang <dave.jiang@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 386/570] dmaengine: idxd: Fix not releasing workqueue on .release()
Date: Mon, 13 Apr 2026 17:58:37 +0200
Message-ID: <20260413155844.937196566@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236900-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: BB9593EFCB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

[ Upstream commit 3d33de353b1ff9023d5ec73b9becf80ea87af695 ]

The workqueue associated with an DSA/IAA device is not released when
the object is freed.

Fixes: 47c16ac27d4c ("dmaengine: idxd: fix idxd conf_dev 'struct device' lifetime")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Link: https://patch.msgid.link/20260121-idxd-fix-flr-on-kernel-queues-v3-v3-7-7ed70658a9d1@intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/idxd/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 489a9d8850764..ee208dfdd0cb5 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1271,6 +1271,7 @@ static void idxd_conf_device_release(struct device *dev)
 {
 	struct idxd_device *idxd = confdev_to_idxd(dev);
 
+	destroy_workqueue(idxd->wq);
 	kfree(idxd->groups);
 	kfree(idxd->wqs);
 	kfree(idxd->engines);
-- 
2.53.0




