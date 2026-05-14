Return-Path: <stable+bounces-247263-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIuGAlkNBmrSeQIAu9opvQ
	(envelope-from <stable+bounces-247263-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:58:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1F2545955
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E82053013D7B
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C329638F951;
	Thu, 14 May 2026 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQeOgyZx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6E314A98
	for <stable@vger.kernel.org>; Thu, 14 May 2026 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778781521; cv=none; b=myzKHoRvKaUWdZ4+/bQxdMWiRJVyhsW0xHpagYL66CYB9a3ZaPMhKpclWBONpkjf3Es9Jv6HMNKl9lBPtMwBHNNF3cuR/AKvIth+eJejXu4ZrCL2gr2pz2Gz9tJXjbD/fmsQA3uwsrez0zm+Ar7LePztIPee2Y4osRbCLAHVuGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778781521; c=relaxed/simple;
	bh=wuJeNaxl3TE0stnA8RyBanmZvJeaUNRKWctGs86zin8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjxorYVGQxtfS88Uh4bVEgqdLZMQxGumRvASIjj5x6vH6hVfvkBU7qn3SvtqT5orH5xbQYY+g/ydyze77GJ2eaVeZjR6PDQ7xgREo23nvZz2LBmJjY6UdoLF7rWv+I4s6jcHjnolJPyXcJb/93+5Irb9+xLe3KCr/gKCpHtUP/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQeOgyZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6643BC2BCB3;
	Thu, 14 May 2026 17:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778781521;
	bh=wuJeNaxl3TE0stnA8RyBanmZvJeaUNRKWctGs86zin8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UQeOgyZxAVHNc+G9dxiBouD9W10x8HP3JKLMCb9TyKfOUIy780yfQiK7eDf/1h+M5
	 Qrr0MrnILi3b8Nrq0rajI2pRglNMAWGtio+lFL2vP+psPCGVTjB/XSt1Qklt0BpZny
	 qlTFb2oIV6iB5dd5W0dYTjDR0rQvzCdqUKt6WJCyV3fR9YyBzJ4BaAHHg2Crd7hUX8
	 mMSZqwaaQyUiPjgfOLKXwABDof8X+LANH3CxRCDqqpcdMoNl79xyF4uE4QlXUof4mS
	 toZPzKxAdGztNisxzzTfO5agbCL4kD4q1f29oTataPiRqOGuvEGA9KinE1MBltwgdp
	 blvOaR3oFm8Dg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] block: cleanup blkdev_report_zones()
Date: Thu, 14 May 2026 13:58:35 -0400
Message-ID: <20260514175837.526481-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051255-scale-proactive-9452@gregkh>
References: <2026051255-scale-proactive-9452@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF1F2545955
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247263-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Action: no action

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit e8ecb21f081fe0cab33dc20cbe65ccbbfe615c15 ]

The variable capacity is used only in one place and so can be removed
and get_capacity(disk) used directly instead.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: b7d4ffb51037 ("block: fix zone write plug removal")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-zoned.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index f63070f0e4405..c9b5b590400ab 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -163,7 +163,6 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data)
 {
 	struct gendisk *disk = bdev->bd_disk;
-	sector_t capacity = get_capacity(disk);
 	struct disk_report_zones_cb_args args = {
 		.disk = disk,
 		.user_cb = cb,
@@ -173,7 +172,7 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 	if (!bdev_is_zoned(bdev) || WARN_ON_ONCE(!disk->fops->report_zones))
 		return -EOPNOTSUPP;
 
-	if (!nr_zones || sector >= capacity)
+	if (!nr_zones || sector >= get_capacity(disk))
 		return 0;
 
 	return disk->fops->report_zones(disk, sector, nr_zones,
-- 
2.53.0


