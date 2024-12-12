Return-Path: <stable+bounces-102349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA7B9EF29E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352F6178113
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905C122D4C6;
	Thu, 12 Dec 2024 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xLjdMJTx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B81213792B;
	Thu, 12 Dec 2024 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020903; cv=none; b=O1ixwi7dd/aKUnpP09ajwXgfqq4IY19eBzxvwL1IQ8IAC4XdJ8z27cJHF/xNz2I/lhscwnd8dmr6F1u1aZ50/DDYb76y04YBJJZ4bpVEHPSpsbDfp1P8XTTPDSjUlvrar2K5D24JskLuwy5eml5KhjHHxuJuQdvfRT78PK1HQLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020903; c=relaxed/simple;
	bh=NqL9fDXvnI8vcqnJ689HZak6DNJOu9GYKVfZrZfSwyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqHLTMvpwPMaf0ZdVggTPVuHzk+yy9PvLaAN/PyX5hKC3eZ7kE0lc0Jm4jal3opUi9sO+c6qhNMqW8ajISHqTrQGBmo9/fWXckGke9DAKpgMv/T8jbTZHgMnkte98NgYE3vfe3XJ3niHuUMzkKAxJvJT0Te5LLb950LkLQcNMkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xLjdMJTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37660C4CED0;
	Thu, 12 Dec 2024 16:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734020902;
	bh=NqL9fDXvnI8vcqnJ689HZak6DNJOu9GYKVfZrZfSwyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xLjdMJTxirUmYu0+RhSx3PLfQBHDeBQRWZTHLnSpwBj2n1es8/lYIFfrUPwcUttxq
	 pYnjQ+LBtTcRwmymlcd7sRKEsBIjQXVq0Avw1PFYvv1+v/a4Jk3JPQK9fB6Ro2Irhe
	 xRDugAy7vbBIMDVG5zfL/SOrYdPJgSjAqh9Se3JI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 593/772] scsi: scsi_debug: Fix hrtimer support for ndelay
Date: Thu, 12 Dec 2024 15:58:58 +0100
Message-ID: <20241212144414.434623564@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

From: John Garry <john.g.garry@oracle.com>

[ Upstream commit 6918141d815acef056a0d10e966a027d869a922d ]

Since commit 771f712ba5b0 ("scsi: scsi_debug: Fix cmd duration
calculation"), ns_from_boot value is only evaluated in schedule_resp()
for polled requests.

However, ns_from_boot is also required for hrtimer support for when
ndelay is less than INCLUSIVE_TIMING_MAX_NS, so fix up the logic to
decide when to evaluate ns_from_boot.

Fixes: 771f712ba5b0 ("scsi: scsi_debug: Fix cmd duration calculation")
Signed-off-by: John Garry <john.g.garry@oracle.com>
Link: https://lore.kernel.org/r/20241202130045.2335194-1-john.g.garry@oracle.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index b77035ddc9440..2493e07a1a5ba 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5672,7 +5672,7 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 	if (sdebug_host_max_queue)
 		sd_dp->hc_idx = get_tag(cmnd);
 
-	if (polled)
+	if (polled || (ndelay > 0 && ndelay < INCLUSIVE_TIMING_MAX_NS))
 		ns_from_boot = ktime_get_boottime_ns();
 
 	/* one of the resp_*() response functions is called here */
-- 
2.43.0




