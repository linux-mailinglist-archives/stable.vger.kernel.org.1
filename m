Return-Path: <stable+bounces-73567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6AA96D565
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 12:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E20C1C221ED
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 10:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADFF195F04;
	Thu,  5 Sep 2024 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jSSbNgTC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BE01922CC;
	Thu,  5 Sep 2024 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530651; cv=none; b=VjSlU+Pv0uYySMAcIDrkQmJfFBgdO2QCdTAsStrNRqtFdXRx+UetErO4l36pdjE8hI7y8QWs3r7mSTmnDzjiuB0KeUutvTLjNYd6t06iA+K4ev60cRrc8UoYe/SM26I6z2BDoke6abN4uSP0U7V156cxkSuqhZLtYG8oq7mM0XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530651; c=relaxed/simple;
	bh=2H+QE4DY0dUxhy4qW4RVKWrLz0OqwrRehvzMs/FUzKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFMf+InACjkidN9VtAGL1+yXpzV+9um9NjmeABDq3or5pfwhuMroJPX5WthJFxELyZNxr1sha2+L0QvS1kRKMkiVkhFKP7fNr0z5WaJyJJtvCsXBu+mXUFjjD/ZPpuNkrX97RjoWK7x8YIiNEvW4tG9V9ewX6g1QdRADTfiu8EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jSSbNgTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8BCC4CEC3;
	Thu,  5 Sep 2024 10:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725530651;
	bh=2H+QE4DY0dUxhy4qW4RVKWrLz0OqwrRehvzMs/FUzKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jSSbNgTCyx+rwps5Lx2q6Ep38Vurs+tDKIENuTnQN5jPzudMIWLpCBmM5GNSEQQ2N
	 MtQa1y8G90J1thfCekKIvRyZCmJ7M/7srXGSQR33Vdj7EC/lXwtFuzx5ychLLz7IwN
	 ADZvLdpBEIKVFgIsOkSwy+SlqQOFg7BSsN6vrrPk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 089/101] block: remove the blk_flush_integrity call in blk_integrity_unregister
Date: Thu,  5 Sep 2024 11:42:01 +0200
Message-ID: <20240905093719.607959438@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093716.075835938@linuxfoundation.org>
References: <20240905093716.075835938@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit e8bc14d116aeac8f0f133ec8d249acf4e0658da7 ]

Now that there are no indirect calls for PI processing there is no
way to dereference a NULL pointer here.  Additionally drivers now always
freeze the queue (or in case of stacking drivers use their internal
equivalent) around changing the integrity profile.

This is effectively a revert of commit 3df49967f6f1 ("block: flush the
integrity workqueue in blk_integrity_unregister").

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Link: https://lore.kernel.org/r/20240613084839.1044015-7-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-integrity.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 69eed260a823..e2d88611d5bf 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -431,8 +431,6 @@ void blk_integrity_unregister(struct gendisk *disk)
 	if (!bi->profile)
 		return;
 
-	/* ensure all bios are off the integrity workqueue */
-	blk_flush_integrity();
 	blk_queue_flag_clear(QUEUE_FLAG_STABLE_WRITES, disk->queue);
 	memset(bi, 0, sizeof(*bi));
 }
-- 
2.43.0




