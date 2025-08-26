Return-Path: <stable+bounces-173587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1312B35D69
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286E37C5F44
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FFE2D6E6B;
	Tue, 26 Aug 2025 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IY7Yy3jZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C901FECAB;
	Tue, 26 Aug 2025 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208636; cv=none; b=do+j+sg9LcOLPX0UggiDk6ZDXB9ccl7xTdx51BPe+OUqfap9SvdmIr9gOiQeg/mxyYUtI9h8rr7wlwjWGqGu5gxFyBmhoZPaKtXvXHFJuMLIWage5W48y7ES/EK6+IChHeL/7oOcMh41saf61YJauaZRVALchVk08I2u9vheADI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208636; c=relaxed/simple;
	bh=Y2oATAEC9QNt8e9KGtLiK0AdYqslMXHeQeUZNRgtOcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qyKYyk6JMnICeBqbsrT9FtM5XLMk+HJ35bM3g7kRg1sCM0/rLXERmUnp6+159r4ZbG7tFmaYkPnV0WIYEDfxKAHuGT/0qMQ3su92cw8k2LfcT8faWoWIaDcd3ZfPLBVZfHCg5vYM3yHONuGN+mNF3K8dT1LArpXCVKk09A3OOGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IY7Yy3jZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C754C4CEF1;
	Tue, 26 Aug 2025 11:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208635;
	bh=Y2oATAEC9QNt8e9KGtLiK0AdYqslMXHeQeUZNRgtOcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IY7Yy3jZWhBjbaJQ5u1gISofm06xp/daOOIljMdr16z54nvdwQlQ4ylKCPl171jue
	 11kB4n+BoNtRnUdZx1hz0+j7s0MoENQdrIOUnQAFO7Hyny5TvZE1eimZI5tD8/8699
	 Sd/98HUTuuqSwg0cDRIZocb1tRDQnf4Vno507uYA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kris Karas <bugs-a21@moonlit-rail.com>,
	Mike Christie <michael.christie@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Igor Pylypiv <ipylypiv@google.com>
Subject: [PATCH 6.12 188/322] scsi: core: Fix command pass through retry regression
Date: Tue, 26 Aug 2025 13:10:03 +0200
Message-ID: <20250826110920.508347861@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Christie <michael.christie@oracle.com>

commit 8604f633f59375687fa115d6f691de95a42520e3 upstream.

scsi_check_passthrough() is always called, but it doesn't check for if a
command completed successfully. As a result, if a command was successful and
the caller used SCMD_FAILURE_RESULT_ANY to indicate what failures it wanted
to retry, we will end up retrying the command. This will cause delays during
device discovery because of the command being sent multiple times. For some
USB devices it can also cause the wrong device size to be used.

This patch adds a check for if the command was successful. If it is we
return immediately instead of trying to match a failure.

Fixes: 994724e6b3f0 ("scsi: core: Allow passthrough to request midlayer retries")
Reported-by: Kris Karas <bugs-a21@moonlit-rail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219652
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Link: https://lore.kernel.org/r/20250107010220.7215-1-michael.christie@oracle.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/scsi_lib.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -210,6 +210,9 @@ static int scsi_check_passthrough(struct
 	struct scsi_sense_hdr sshdr;
 	enum sam_status status;
 
+	if (!scmd->result)
+		return 0;
+
 	if (!failures)
 		return 0;
 



