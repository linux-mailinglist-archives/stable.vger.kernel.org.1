Return-Path: <stable+bounces-52717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A5290CC5A
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976211C2336E
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEBB13AA41;
	Tue, 18 Jun 2024 12:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMfvlQSL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087E213A877;
	Tue, 18 Jun 2024 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714315; cv=none; b=UwWNlHTX1ht7stxDJ27jPxamAC7S/+E5BiZcDtzDjk+M1M9BTQNzLReSuPNkrYJAWiwNkymp7zb+fCdcAHKhFdG4vGovlqj5AVMRXM8cX7de9qQbdjUbhyJGf57beJ+sst5vXUeoo5Nj0zZh87hPW5kH8KeThSK3w8Ntt1mfbes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714315; c=relaxed/simple;
	bh=ElwEEKlltBx5dmTZseGkyQ9j+pnPgSlfITcDRLuO6OA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ESw6tI+jVqERXV7237anGInbfDcJpRsBVonMtd7kVmV6qcml4+4ug6DemnGWJyNWreEtbCTTLJdnAIDEGUqCtJ/hMKP1Pxq4nm2JkvnF8lNTB3OhrlK89mvujAYaXKbxMR1c0XWQa3vjRBEeNSgOdHEDXLCWYn4saOhwEay47iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMfvlQSL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380BDC3277B;
	Tue, 18 Jun 2024 12:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714314;
	bh=ElwEEKlltBx5dmTZseGkyQ9j+pnPgSlfITcDRLuO6OA=;
	h=From:To:Cc:Subject:Date:From;
	b=NMfvlQSLo3Xavk3X2tXb08vsHlDo+mkH3gHDy5y0mto6Di7cXRphvhFPeS6Et33zr
	 QLnP5A56Kh5OaXX8XrCV/ZnfbJiVcKNfQvD8fVTGSyAHBBB+aA8b73xi2f1m2DM9oZ
	 QfWuXi2KLuH4tdSZpVOnTIO8u6jVzQewds1N95HwxHhwqZbYFkjpmbr/mVZmQBvEuV
	 NBMW4bz2BQ1486biDxkV+IIqYgh963bX0badwsVbbzRMwGEjS39NIbPzswl15pxFR9
	 FXwQp1OnMvuI1rMzOuJLwBD7usPkUKQUQGXYNEox4dmEYIb8mPbXLvkEX4rFySNBkx
	 6UEfrry7YrbPw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin Wilck <martin.wilck@suse.com>,
	Rajashekhar M A <rajs@netapp.com>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Mike Christie <michael.christie@oracle.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	James.Bottomley@HansenPartnership.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/35] scsi: core: alua: I/O errors for ALUA state transitions
Date: Tue, 18 Jun 2024 08:37:21 -0400
Message-ID: <20240618123831.3302346-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.34
Content-Transfer-Encoding: 8bit

From: Martin Wilck <martin.wilck@suse.com>

[ Upstream commit 10157b1fc1a762293381e9145041253420dfc6ad ]

When a host is configured with a few LUNs and I/O is running, injecting FC
faults repeatedly leads to path recovery problems.  The LUNs have 4 paths
each and 3 of them come back active after say an FC fault which makes 2 of
the paths go down, instead of all 4. This happens after several iterations
of continuous FC faults.

Reason here is that we're returning an I/O error whenever we're
encountering sense code 06/04/0a (LOGICAL UNIT NOT ACCESSIBLE, ASYMMETRIC
ACCESS STATE TRANSITION) instead of retrying.

[mwilck: The original patch was developed by Rajashekhar M A and Hannes
Reinecke. I moved the code to alua_check_sense() as suggested by Mike
Christie [1]. Evan Milne had raised the question whether pg->state should
be set to transitioning in the UA case [2]. I believe that doing this is
correct. SCSI_ACCESS_STATE_TRANSITIONING by itself doesn't cause I/O
errors. Our handler schedules an RTPG, which will only result in an I/O
error condition if the transitioning timeout expires.]

[1] https://lore.kernel.org/all/0bc96e82-fdda-4187-148d-5b34f81d4942@oracle.com/
[2] https://lore.kernel.org/all/CAGtn9r=kicnTDE2o7Gt5Y=yoidHYD7tG8XdMHEBJTBraVEoOCw@mail.gmail.com/

Co-developed-by: Rajashekhar M A <rajs@netapp.com>
Co-developed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Martin Wilck <martin.wilck@suse.com>
Link: https://lore.kernel.org/r/20240514140344.19538-1-mwilck@suse.com
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/device_handler/scsi_dh_alua.c | 31 +++++++++++++++-------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index a226dc1b65d71..4eb0837298d4d 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -414,28 +414,40 @@ static char print_alua_state(unsigned char state)
 	}
 }
 
-static enum scsi_disposition alua_check_sense(struct scsi_device *sdev,
-					      struct scsi_sense_hdr *sense_hdr)
+static void alua_handle_state_transition(struct scsi_device *sdev)
 {
 	struct alua_dh_data *h = sdev->handler_data;
 	struct alua_port_group *pg;
 
+	rcu_read_lock();
+	pg = rcu_dereference(h->pg);
+	if (pg)
+		pg->state = SCSI_ACCESS_STATE_TRANSITIONING;
+	rcu_read_unlock();
+	alua_check(sdev, false);
+}
+
+static enum scsi_disposition alua_check_sense(struct scsi_device *sdev,
+					      struct scsi_sense_hdr *sense_hdr)
+{
 	switch (sense_hdr->sense_key) {
 	case NOT_READY:
 		if (sense_hdr->asc == 0x04 && sense_hdr->ascq == 0x0a) {
 			/*
 			 * LUN Not Accessible - ALUA state transition
 			 */
-			rcu_read_lock();
-			pg = rcu_dereference(h->pg);
-			if (pg)
-				pg->state = SCSI_ACCESS_STATE_TRANSITIONING;
-			rcu_read_unlock();
-			alua_check(sdev, false);
+			alua_handle_state_transition(sdev);
 			return NEEDS_RETRY;
 		}
 		break;
 	case UNIT_ATTENTION:
+		if (sense_hdr->asc == 0x04 && sense_hdr->ascq == 0x0a) {
+			/*
+			 * LUN Not Accessible - ALUA state transition
+			 */
+			alua_handle_state_transition(sdev);
+			return NEEDS_RETRY;
+		}
 		if (sense_hdr->asc == 0x29 && sense_hdr->ascq == 0x00) {
 			/*
 			 * Power On, Reset, or Bus Device Reset.
@@ -502,7 +514,8 @@ static int alua_tur(struct scsi_device *sdev)
 
 	retval = scsi_test_unit_ready(sdev, ALUA_FAILOVER_TIMEOUT * HZ,
 				      ALUA_FAILOVER_RETRIES, &sense_hdr);
-	if (sense_hdr.sense_key == NOT_READY &&
+	if ((sense_hdr.sense_key == NOT_READY ||
+	     sense_hdr.sense_key == UNIT_ATTENTION) &&
 	    sense_hdr.asc == 0x04 && sense_hdr.ascq == 0x0a)
 		return SCSI_DH_RETRY;
 	else if (retval)
-- 
2.43.0


