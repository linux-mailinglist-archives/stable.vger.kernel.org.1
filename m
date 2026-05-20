Return-Path: <stable+bounces-252202-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPosDyn7DWrO5AUAu9opvQ
	(envelope-from <stable+bounces-252202-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:19:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 012AC595CE4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC7E930E56C1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AFB3E832A;
	Wed, 20 May 2026 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CG+GLaZ4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E23ED3B8;
	Wed, 20 May 2026 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300059; cv=none; b=k1Uj99EE6dBoOJyfHS2usQkmPi1aD6iTmiT637108QCLda4u6eizPIQ3Wa/9AlUM8q1MIYQkP92dYwNKmKZpdJQ6hkT/O9t+8Zu4IzDtwrLWz+6LRa5Df4+XB1bsJhkDeYdz3xZIacKXxrqG+2+xYdA5/c7S6E9Dd2s74jF/yxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300059; c=relaxed/simple;
	bh=4n9ATU97h79/4N4qS+CrWJDigEBMI2bkoCRms3AX1rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMsH4XnHrR+ZNL8rp2KPvBxHqXmn9t0aNq3LJ6M1V8AUjabiBXAhW+f/vP0pdcrCorniPVFe2C268xTEZobznGUb+aZe3sxgxG9m7omxZuQxvrjlutPIRR0lk0x0igRzhgvV0E7kk4RxMVGsPgdUyG6IYhvAQCFa4da3mfOKcyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CG+GLaZ4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB241F000E9;
	Wed, 20 May 2026 18:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300058;
	bh=s4iGKR0+n223SsluzaL2aCSjC9r18boxoB0UhC+LzBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CG+GLaZ4VNAsqpeI+v4Q9f8x/sK14ICx4tc2QwTEzd7JVz+8HzNkMrMRTfvhwOHwp
	 C7WI+maW0QmwEEtac5Awxh4bRjJ8Lgs4mdRvfkWDRvs/QHb2Z7XoqomQGjLMS2AmDQ
	 47HYS9dWCd6IC59O9tqRRDKEgxdyLSOabbYFBR2U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiao Ni <xni@redhat.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 005/666] md/raid1: fix the comparing region of interval tree
Date: Wed, 20 May 2026 18:13:36 +0200
Message-ID: <20260520162111.348203440@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252202-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Queue-Id: 012AC595CE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiao Ni <xni@redhat.com>

[ Upstream commit de3544d2e5ea99064498de3c21ba490155864657 ]

Interval tree uses [start, end] as a region which stores in the tree.
In raid1, it uses the wrong end value. For example:
bio(A,B) is too big and needs to be split to bio1(A,C-1), bio2(C,B).
The region of bio1 is [A,C] and the region of bio2 is [C,B]. So bio1 and
bio2 overlap which is not right.

Fix this problem by using right end value of the region.

Fixes: d0d2d8ba0494 ("md/raid1: introduce wait_for_serialization")
Signed-off-by: Xiao Ni <xni@redhat.com>
Link: https://lore.kernel.org/linux-raid/20260305011839.5118-2-xni@redhat.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 093b04e6be675..eb583df45ecbc 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -61,7 +61,7 @@ static int check_and_add_serial(struct md_rdev *rdev, struct r1bio *r1_bio,
 	unsigned long flags;
 	int ret = 0;
 	sector_t lo = r1_bio->sector;
-	sector_t hi = lo + r1_bio->sectors;
+	sector_t hi = lo + r1_bio->sectors - 1;
 	struct serial_in_rdev *serial = &rdev->serial[idx];
 
 	spin_lock_irqsave(&serial->serial_lock, flags);
@@ -453,7 +453,7 @@ static void raid1_end_write_request(struct bio *bio)
 	int mirror = find_bio_disk(r1_bio, bio);
 	struct md_rdev *rdev = conf->mirrors[mirror].rdev;
 	sector_t lo = r1_bio->sector;
-	sector_t hi = r1_bio->sector + r1_bio->sectors;
+	sector_t hi = r1_bio->sector + r1_bio->sectors - 1;
 	bool ignore_error = !raid1_should_handle_error(bio) ||
 		(bio->bi_status && bio_op(bio) == REQ_OP_DISCARD);
 
-- 
2.53.0




