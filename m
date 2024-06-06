Return-Path: <stable+bounces-48631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BB48FE9D4
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98921289479
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08020195FDF;
	Thu,  6 Jun 2024 14:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pAScogQj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B789519B5AF;
	Thu,  6 Jun 2024 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683070; cv=none; b=W5b11sNMXQZIxCgTMKYxJYKdBZsYjYlaaouW3eF8+Qr2/Q1l3TKw1K80Lnv7t1+W7N9H/8mrDePTjA3tyFtf8iik3Ym/6R91QgDT7lG92Qw9Weo50haNKP07Ipv3IQcjt+Z1Jg465u/Co6AiHEZ82XW1siYve9GAIDbHoHX9j7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683070; c=relaxed/simple;
	bh=ko6Xs96NIbNVFZuFC7wHYuP5BhNcC0NsQb+TCwlD8qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8cowqVv2qSZOJR/T2zKQ4MqKy+EU3Ho7Y+cFCg+xPwHBQx6CI0F1+Z8QF2F+FOX0xDUUsu03608FfPRQmwIfkTwM0HskOky69+UR/fAv7+YvMmKxN5OHBSW4zukkBNI/n1XGw3yxqRSVMPTjCxh8gS0B5/82EZ3f2AYCpO2Y9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pAScogQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9587FC32786;
	Thu,  6 Jun 2024 14:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683070;
	bh=ko6Xs96NIbNVFZuFC7wHYuP5BhNcC0NsQb+TCwlD8qY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pAScogQj5yRg+VaT/Q+5QWbXvCTX9BxJZXmubg92Ff+2kC0rs/QX4sCz7oJKunqqc
	 Vt+1krbP3g/2qQqc72bvAPgWpjrrHEABO0sWduYPhMv/Odx/90Gd3oMkuIxfi0n4Gc
	 WSzX1lwPciZiIdH7qSs9yPuJtMZUyTQqrZkiZD3g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 332/374] sd: also set max_user_sectors when setting max_sectors
Date: Thu,  6 Jun 2024 16:05:11 +0200
Message-ID: <20240606131702.970787968@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit bafea1c58b24be594d97841ced1b7ae0347bf6e3 ]

sd can set a max_sectors value that is lower than the max_hw_sectors
limit based on the block limits VPD page.   While this is rather unusual,
it used to work until the max_user_sectors field was split out to cleanly
deal with conflicting hardware and user limits when the hardware limit
changes.  Also set max_user_sectors to ensure the limit can properly be
stacked.

Fixes: 4f563a64732d ("block: add a max_user_discard_sectors queue limit")
Reported-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Link: https://lore.kernel.org/r/20240523182618.602003-2-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/sd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 65cdc8b77e358..caac482fff2ff 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3707,8 +3707,10 @@ static int sd_revalidate_disk(struct gendisk *disk)
 	 */
 	if (sdkp->first_scan ||
 	    q->limits.max_sectors > q->limits.max_dev_sectors ||
-	    q->limits.max_sectors > q->limits.max_hw_sectors)
+	    q->limits.max_sectors > q->limits.max_hw_sectors) {
 		q->limits.max_sectors = rw_max;
+		q->limits.max_user_sectors = rw_max;
+	}
 
 	sdkp->first_scan = 0;
 
-- 
2.43.0




