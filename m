Return-Path: <stable+bounces-6795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 965AB8145F8
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 11:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371311F24146
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 10:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804501F61E;
	Fri, 15 Dec 2023 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hPA92YN5"
X-Original-To: stable@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B491CF95
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
	Content-Type; bh=v3fQPKea24jmrGNK5NAnT+6ISVSDrV912y7d4YqCZU8=; b=hPA92YN5heH7
	/aCu2XsAGwsJPaCY/z19i0YPkYi3dCVNgbkBjWQ7ZLhP1Nl/xiHy4NGe4AshKeucQewS2It8hdya7
	1nDm7IBCpMQSuq9FQi9vZM9Lhi5EwjDKHep9Yzv4/3oL2oCkMqP1hKLOz2P2aQazpYjVZee+w1nVJ
	xPRwK3BOhgS+CmCGrxYI/H6ggLifzKO1m5BVEBEyy7f7NCgafun82h6IYf0QzH1JAHlWjmXcdro8w
	JVd4ZG18XxUsfUcjOEVI91jViwPKqExBKUeLKi7p4UZCLvxnUBkuiFZSKq0Mnra4aM0fxeDMZ5j9R
	ue9sqfe7opUSw/cjpfS24Q==;
Received: from [130.117.225.1] (helo=dev011.ch-qa.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <alexander.atanasov@virtuozzo.com>)
	id 1rE5Qb-001Ov4-05;
	Fri, 15 Dec 2023 11:30:18 +0100
From: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Hannes Reinecke <hare@suse.com>
Cc: kernel@openvz.org,
	stable@vger.kernel.org
Subject: [PATCH v2] scsi: code: always send batch on reset or error handling command
Date: Fri, 15 Dec 2023 12:30:13 +0200
Message-Id: <20231215103013.2879483-1-alexander.atanasov@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 8930a6c20791 ("scsi: core: add support for request batching")
blk-mq last flags was mapped to SCMD_LAST and used as an indicator to
send the batch for the drivers that implement it but the error handling
code was not updated.

scsi_send_eh_cmnd(...) is used to send error handling commands and
request sense. The problem is that request sense comes as a single
command that gets into the batch queue and times out.  As result
device goes offline after several failed resets. This was observed
on virtio_scsi device resize operation.

[  496.316946] sd 0:0:4:0: [sdd] tag#117 scsi_eh_0: requesting sense
[  506.786356] sd 0:0:4:0: [sdd] tag#117 scsi_send_eh_cmnd timeleft: 0
[  506.787981] sd 0:0:4:0: [sdd] tag#117 abort

To fix this always set SCMD_LAST flag in scsi_send_eh_cmnd and
scsi_reset_ioctl(...).

Fixes: 8930a6c20791 ("scsi: core: add support for request batching")
Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
---
 drivers/scsi/scsi_error.c | 2 ++
 1 file changed, 2 insertions(+)

v1->v2: fix it globally not only for virtio_scsi, as suggested by
Paolo Bonzini, to avoid reintroducing the same bug.

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index c67cdcdc3ba8..1223d34c04da 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1152,6 +1152,7 @@ static enum scsi_disposition scsi_send_eh_cmnd(struct scsi_cmnd *scmd,
 
 	scsi_log_send(scmd);
 	scmd->submitter = SUBMITTED_BY_SCSI_ERROR_HANDLER;
+	scmd->flags |= SCMD_LAST;
 
 	/*
 	 * Lock sdev->state_mutex to avoid that scsi_device_quiesce() can
@@ -2459,6 +2460,7 @@ scsi_ioctl_reset(struct scsi_device *dev, int __user *arg)
 	scsi_init_command(dev, scmd);
 
 	scmd->submitter = SUBMITTED_BY_SCSI_RESET_IOCTL;
+	scmd->flags |= SCMD_LAST;
 	memset(&scmd->sdb, 0, sizeof(scmd->sdb));
 
 	scmd->cmd_len			= 0;
-- 
2.39.3


