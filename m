Return-Path: <stable+bounces-102989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E87D69EF5E0
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3B416F6C6
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03AD222D5E;
	Thu, 12 Dec 2024 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TRIQH/si"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7552210CD;
	Thu, 12 Dec 2024 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023204; cv=none; b=ks4P870W3R2RwXsAdKmWOp68eS9EMww22SPY2mKY3CPO4w3T6RPcrxeU3mhN2IQAu+YlT+61uhN7jiZZAuxHPbnhfMM91fgPsVD6SMCvMJLpcik+NUWEklsHM0EdUkh3hU44aMxM5Jx3GTFEOS3NexAZUKVtoiLIELcGj/ncXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023204; c=relaxed/simple;
	bh=c682iFm63EXEG6uUniO5MqZekE6SqYkSHZOUmWoLSZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnRoGws46Nc3mluWE1tTNlx8SGJzmBbdnecYaKagKvA1pKCNlIb9ShMvfdUOihjBFa+qyRHWBTMk1PAzOGktgRqSAf6WCT5HSRR+yN657CLmlM/PupeblTPt7NVxHByEpndkJ/6TfhWzbwAgCDD3H6O4/E1IfGjQjcyBHjcbLcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TRIQH/si; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9A7C4CECE;
	Thu, 12 Dec 2024 17:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023204;
	bh=c682iFm63EXEG6uUniO5MqZekE6SqYkSHZOUmWoLSZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRIQH/sio6q0E7GxSGsajpZwc7iYgd7WlDjWgmFE5CsyO5fqVNv8fwJWbNVwaUj8x
	 +gDtCG2nHTne2kts2lnYolk07wzAl1zI8x2vXM1NHuHXoX4AhyZrTfuwd2ycVPp5Kk
	 GNVESGCbu4M6NwdsUR92G/FgekFHkWF5aSu+FH1E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gwendal Grignou <gwendal@chromium.org>,
	Can Guo <quic_cang@quicinc.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.15 458/565] scsi: ufs: core: sysfs: Prevent div by zero
Date: Thu, 12 Dec 2024 16:00:53 +0100
Message-ID: <20241212144329.828583247@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gwendal Grignou <gwendal@chromium.org>

commit eb48e9fc0028bed94a40a9352d065909f19e333c upstream.

Prevent a division by 0 when monitoring is not enabled.

Fixes: 1d8613a23f3c ("scsi: ufs: core: Introduce HBA performance monitor sysfs nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Link: https://lore.kernel.org/r/20241120062522.917157-1-gwendal@chromium.org
Reviewed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/ufs/ufs-sysfs.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -371,6 +371,9 @@ static ssize_t read_req_latency_avg_show
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 	struct ufs_hba_monitor *m = &hba->monitor;
 
+	if (!m->nr_req[READ])
+		return sysfs_emit(buf, "0\n");
+
 	return sysfs_emit(buf, "%llu\n", div_u64(ktime_to_us(m->lat_sum[READ]),
 						 m->nr_req[READ]));
 }
@@ -438,6 +441,9 @@ static ssize_t write_req_latency_avg_sho
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 	struct ufs_hba_monitor *m = &hba->monitor;
 
+	if (!m->nr_req[WRITE])
+		return sysfs_emit(buf, "0\n");
+
 	return sysfs_emit(buf, "%llu\n", div_u64(ktime_to_us(m->lat_sum[WRITE]),
 						 m->nr_req[WRITE]));
 }



