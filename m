Return-Path: <stable+bounces-252206-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Mq0MaT4DWqR5AUAu9opvQ
	(envelope-from <stable+bounces-252206-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:08:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5726C595603
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B62E8313C0E2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386643F8707;
	Wed, 20 May 2026 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q/P1VM01"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08413F4DDB;
	Wed, 20 May 2026 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300069; cv=none; b=AGL2BkBGmz3FHTh+o4kWdwoqzyCm/GfsgYyH/DokzK6AaSc738iXz1gw2fw8Tybsbcvmfqqn+akatVYygcW7E1k+Xkc2Ipu6iyBvJM6m85h64kT9c2NZZtj4u6ovVdmwsPytAS35BEF7PtpIxneoJwwLumUmC5CRPHgBn1rlSG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300069; c=relaxed/simple;
	bh=xHbWFv8EUsgmbxQTnIBNoJ3y8Npc5BwaqoLPOIoW4RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvqrLQICW+YuHbPZUB16wK7ZuoQxZyflkf42S3vnUlmqrDFTUNOhrVWjyfDvSezMAQgsCExp4enfOfiR7DO0hxfduVS5Y/OsWEpJSoDfG7oY/TB025TI6JcmIADoJKhNzDoqf98Xi4Kt3E1jJvfQSLhwiazjlboPKJZZpIu24iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q/P1VM01; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EDA1F000E9;
	Wed, 20 May 2026 18:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300068;
	bh=x3xJkkK9BUWZZNcfUIzMKvLmOu4isYhrzL+yP2EOR28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=q/P1VM01s9iXO3j8WEwywMja3Xe2r0MNKdGxkzMhm6geuGQGH43T3flZA4sv8xrv6
	 WR96i4MqlpSRiQ+Gxt2cJcaX/xv7HE+U1HAe7By/BdNAh02gD2AnlI4BMLgeBnypiC
	 ZQ8GoRbakspX9L7mM8B+jS/IXGWiUmIGRVdXSiDU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jackie Liu <liuyun01@kylinos.cn>,
	Tejun Heo <tj@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 009/666] blk-cgroup: fix disk reference leak in blkcg_maybe_throttle_current()
Date: Wed, 20 May 2026 18:13:40 +0200
Message-ID: <20260520162111.433555719@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-252206-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,kernel.dk:email,kylinos.cn:email,lst.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 5726C595603
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jackie Liu <liuyun01@kylinos.cn>

[ Upstream commit 23308af722fefed00af5f238024c11710938fba3 ]

Add the missing put_disk() on the error path in
blkcg_maybe_throttle_current(). When blkcg lookup, blkg lookup, or
blkg_tryget() fails, the function jumps to the out label which only
calls rcu_read_unlock() but does not release the disk reference acquired
by blkcg_schedule_throttle() via get_device(). Since current->throttle_disk
is already set to NULL before the lookup, blkcg_exit() cannot release
this reference either, causing the disk to never be freed.

Restore the reference release that was present as blk_put_queue() in the
original code but was inadvertently dropped during the conversion from
request_queue to gendisk.

Fixes: f05837ed73d0 ("blk-cgroup: store a gendisk to throttle in struct task_struct")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/20260331085054.46857-1-liu.yun@linux.dev
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 9a198001cfa56..a0fbb427a7a62 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1985,6 +1985,7 @@ void blkcg_maybe_throttle_current(void)
 	return;
 out:
 	rcu_read_unlock();
+	put_disk(disk);
 }
 
 /**
-- 
2.53.0




