Return-Path: <stable+bounces-261034-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dpasL2REJWrGFQIAu9opvQ
	(envelope-from <stable+bounces-261034-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:13:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 335E664F6D9
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:13:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=SShXd8v6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261034-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261034-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63F54303CA5D
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D6228688C;
	Sun,  7 Jun 2026 10:10:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77E330C157;
	Sun,  7 Jun 2026 10:10:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827040; cv=none; b=F2lQwqcZZGspyalKyJCU/pISf5D6OG+HCYM0sIIlcsOskqC0ZlLZ3buUlhKtX6rp0WPeC78Nl5fapuO0pJr6EWzEogW/eq2WH5Xs3nBWTKwjxpGK4qzsS6sMLxxQJ4Y8I78xMNKmGqi+uu6qtXciNnPhKKbt0Ld4cPn/6Z8ohCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827040; c=relaxed/simple;
	bh=AUZd4ez5+rwgppmG5hqCO7NGnTjdQbl3dju2Dd6SNmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sn5KOzqQZ13WSBBBK6RM6IMqIGBzYE6R1bt1pfTXTokWN0Wqz2SXmOrx0O/fw/nT+dsxC6k8gBGKwUHkIlqR3zhOaaxev+/MUQyK0bJIvphi6jstVnbv83qTX4Mg9rm3em5ZNQX5GaJEFWxSAdBVLJmJhp6Onz3DQnqgNJRliys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SShXd8v6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CC11F00893;
	Sun,  7 Jun 2026 10:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827039;
	bh=w3QXtdO3w3g6UjpJAoe2TGtL43tR+mHfm98y4IyEWmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SShXd8v697oTHurIbA4lnpA+3AtYTDPmGcPXxlAKzqIr4BMVCxyBjc4gwPGMG7BBx
	 hOWJtnO8gglmTmljS5sSm06CAzJVH9xgBZN8yDL99Lg8D0OT0mRmTOVS6LppXa2djs
	 6ef3FU6/EEtKyngLYDHtfls+Vr6eriSoCqNQStsg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ming Lei <tom.leiming@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 057/332] blk-mq: reinsert cached request to the list
Date: Sun,  7 Jun 2026 11:57:06 +0200
Message-ID: <20260607095730.222279896@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lst.de,kernel.org,nvidia.com,kernel.dk];
	TAGGED_FROM(0.00)[bounces-261034-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:tom.leiming@gmail.com,m:hch@lst.de,m:kbusch@kernel.org,m:kch@nvidia.com,m:axboe@kernel.dk,m:sashal@kernel.org,m:tomleiming@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:email,lst.de:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 335E664F6D9

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit b051bb6bf0a231117036aa607cadf55be8e63910 ]

A previous commit removed an optimization out of caution for a scenario
that turns out not to be real: all the "queue_exit" goto's are safe to
reinsert the request into the cached_rq's plug list as they are either
from a non-blocking path, or a successful merge that already holds the
queue reference. This optimization is most needed for small sequential
workloads that successfully merge into larger requests.

Fixes: dc278e9bf2b9 ("blk-mq: pop cached request if it is usable")
Suggested-by: Ming Lei <tom.leiming@gmail.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Link: https://patch.msgid.link/20260526153531.2365935-1-kbusch@meta.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 39986a742b981a..061c8ef4484a25 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3244,7 +3244,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!rq)
 		blk_queue_exit(q);
 	else
-		blk_mq_free_request(rq);
+		rq_list_add_head(&plug->cached_rqs, rq);
 }
 
 #ifdef CONFIG_BLK_MQ_STACKING
-- 
2.53.0




