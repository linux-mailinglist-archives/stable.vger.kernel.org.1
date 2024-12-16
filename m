Return-Path: <stable+bounces-104328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 008609F2FA4
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 12:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FC918819DB
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 11:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A81200B8C;
	Mon, 16 Dec 2024 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kolumbus.fi header.i=@kolumbus.fi header.b="GCfDkvzh"
X-Original-To: stable@vger.kernel.org
Received: from fgw22-4.mail.saunalahti.fi (fgw22-4.mail.saunalahti.fi [62.142.5.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E3B200121
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 11:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734349185; cv=none; b=YAz9TcLu41KeTzh6p/+L3GD4dHrrd54Y2YUvSc5kvNR9LwdM4eyyiyt/l8/kmGgH/GBdAMzOONvF1aGYE2Qve7Cf8Zg67pFjGnAqxBadpgWUoUJZ+x/++PXa11jGk7qBIkjn3ozWRR2UlPjjaszirfAvRBREM8dtqOS4BAG04wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734349185; c=relaxed/simple;
	bh=nJcrKjbb/izKfhO5ZCTPYd6zolh1/6O7j/l3sTLP/NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RAsPwp65qjHXYU4M3KkShpoTs17FZYQo7+Hj98uI2ts2e6v7vCovqEH/582VAvqCPakfOkFDM3TG83RE0viC2cQssmX3+fvuFZ2qyfrtt3FkC7SFkeMhNlImXmeBSDVC1xOkF1ZKvx+8oKXk/z0ONr/SIq5yI53OD5xZvomNXcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kolumbus.fi; spf=pass smtp.mailfrom=kolumbus.fi; dkim=pass (2048-bit key) header.d=kolumbus.fi header.i=@kolumbus.fi header.b=GCfDkvzh; arc=none smtp.client-ip=62.142.5.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kolumbus.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolumbus.fi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kolumbus.fi; s=elisa1;
	h=content-transfer-encoding:content-type:mime-version:message-id:date:subject:
	 cc:to:from:from:to:cc:reply-to:subject:date:in-reply-to:references:
	 list-archive:list-subscribe:list-unsubscribe:content-type:
	 content-transfer-encoding:message-id;
	bh=nQ/yC+8xWtNHB16AC7Zp2qZMVpjX31p5rRFFK6w3pLg=;
	b=GCfDkvzhqb7rTXUPy1KQQaNd6o3SVWoogVimHogTCazU4aVJPidYVr41kx630NglfcSQu26Cax+5b
	 rxbEl0k8BA+Q2NBslkfqzEjPrzEmdfM2h/VNSQR/BD3dQCMZ6rTfUf/FuzSbM15v8k4uy1s7HdDPtn
	 /LJgm+s4rUbGTbXfxchsvF2+CCor+8palLwYiYVUyBTP5VCaDzQznp7YjPSwLVSKjj1Tn0nAhUfjRb
	 629RDPGZOqsKwdBtGay29EvCVSCTci87U9M5RRaxTh17C0Lk9zeknhyzdQNXnPS98qnlNzTPy6ApBz
	 j8OFMyOWUxNXbffv/5n15710KcSc0+g==
Received: from kaipn1.makisara.private (85-156-116-90.elisa-laajakaista.fi [85.156.116.90])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTPSA
	id 3ed63cc6-bba2-11ef-a13a-005056bdfda7;
	Mon, 16 Dec 2024 13:38:19 +0200 (EET)
From: =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>
To: linux-scsi@vger.kernel.org,
	jmeneghi@redhat.com
Cc: martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com,
	loberman@redhat.com,
	=?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: st: Regression fix: Don't set pos_unknown just after device recognition
Date: Mon, 16 Dec 2024 13:37:55 +0200
Message-ID: <20241216113755.30415-1-Kai.Makisara@kolumbus.fi>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 9604eea5bd3a ("scsi: st: Add third party poweron reset handling")
in v6.6 added new code to handle the Power On/Reset Unit Attention
(POR UA) sense data. This was in addition to the existing method. When
this Unit Attention is received, the driver blocks attempts to read,
write and some other operations because the reset may have rewinded
the tape. Because of the added code, also the initial POR UA resulted
in blocking operations, including those that are used to set the driver
options after the device is recognized. Also, reading and writing are
refused, whereas they succeeded before this commit.

This patch adds code to not set pos_unknown to block operations if the
POR UA is received from the first test_ready() call after the st device
has been created. This restores the behavior before v6.6.

Signed-off-by: Kai Mäkisara <Kai.Makisara@kolumbus.fi>
Fixes: 9604eea5bd3a ("scsi: st: Add third party poweron reset handling")
Closes: https://lore.kernel.org/linux-scsi/2201CF73-4795-4D3B-9A79-6EE5215CF58D@kolumbus.fi/
CC: stable@vger.kernel.org
---
 drivers/scsi/st.c | 6 ++++++
 drivers/scsi/st.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index e8ef27d7ef61..ebbd50ec0cda 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -1030,6 +1030,11 @@ static int test_ready(struct scsi_tape *STp, int do_wait)
 			retval = new_session ? CHKRES_NEW_SESSION : CHKRES_READY;
 		break;
 	}
+	if (STp->first_tur) {
+		/* Don't set pos_unknown right after device recognition */
+		STp->pos_unknown = 0;
+		STp->first_tur = 0;
+	}
 
 	if (SRpnt != NULL)
 		st_release_request(SRpnt);
@@ -4328,6 +4333,7 @@ static int st_probe(struct device *dev)
 	blk_queue_rq_timeout(tpnt->device->request_queue, ST_TIMEOUT);
 	tpnt->long_timeout = ST_LONG_TIMEOUT;
 	tpnt->try_dio = try_direct_io;
+	tpnt->first_tur = 1;
 
 	for (i = 0; i < ST_NBR_MODES; i++) {
 		STm = &(tpnt->modes[i]);
diff --git a/drivers/scsi/st.h b/drivers/scsi/st.h
index 7a68eaba7e81..1aaaf5369a40 100644
--- a/drivers/scsi/st.h
+++ b/drivers/scsi/st.h
@@ -170,6 +170,7 @@ struct scsi_tape {
 	unsigned char rew_at_close;  /* rewind necessary at close */
 	unsigned char inited;
 	unsigned char cleaning_req;  /* cleaning requested? */
+	unsigned char first_tur;     /* first TEST UNIT READY */
 	int block_size;
 	int min_block;
 	int max_block;
-- 
2.43.0


