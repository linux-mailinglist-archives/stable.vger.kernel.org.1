Return-Path: <stable+bounces-67490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583F4950649
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 15:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC5E1F21F9F
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 13:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2060719CD05;
	Tue, 13 Aug 2024 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A54MgT4M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA5619AD6E;
	Tue, 13 Aug 2024 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555146; cv=none; b=bzdPXqzcsbUEG5wYDYNJ+neKQKcf6sA2HflaO/5GitcJQ7p6PhrhWTT1OJixCFX+XgzNalL5j3hc1rpXktxowG+pzXNwZa/pcpR7mFPbsF1LJWdC6LIyaCt3n6ZAi5xsW94o5OT08JpOYjCvBihYeQRkDBxRrgjcN6+dKOjETD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555146; c=relaxed/simple;
	bh=k6UmuWWU+5OWpY/TlzGbBpOY05z+pfvzbhKtMvZXl8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWwK2yJdeDTh1DXaXKWkpj+yhFm8MO+XXkR+I4X6BCPW0bjrM8NEoCtqTvaPv8AHp9ATCYGWChdFsoS9flZXGoH6upueyINIfCg6R/Knxiu+V/q0KW7GknYMp65H7ErsIPiXcmQBBZyWpmSX9vxcg8tw2IOkTAH/PtdX92aG7Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A54MgT4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1871FC4AF12;
	Tue, 13 Aug 2024 13:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723555146;
	bh=k6UmuWWU+5OWpY/TlzGbBpOY05z+pfvzbhKtMvZXl8Y=;
	h=From:To:Cc:Subject:Date:From;
	b=A54MgT4M/2Az7iWALCzHuDsIf9jTu8C3bRwzpy/+VEPhuZQWBLVofbN2HYQvpTfGa
	 bCjg8Wnmq3t6vf/HKgrniAdkiKeOsobx1qkBlq0U+tT+qt1yicuecvpZogKR3PBExF
	 OZ6TjMFdsQRFH20KYaJCspsejgdP2N77jIOUAlRBuLhbUiK+7S2OlH6LPT0I09Rw4F
	 c8NAevThN23ANtFLRUsaWwhf3mOnODgRAmUftlcnoL2s4/JOSnzoMZdgc60j5KltjE
	 LD3oDhOTNuHUMNBgPlxXWbkfWKff9ltbPCnR4gSL9jmCfqmKk2/jHFmDND88iTMurH
	 5KylqTeD4Eilw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Igor Pylypiv <ipylypiv@google.com>,
	Hannes Reinecke <hare@suse.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	stable@vger.kernel.org,
	Stephan Eisvogel <eisvogel@seitics.de>,
	Christian Heusel <christian@heusel.eu>,
	linux-ide@vger.kernel.org
Subject: [PATCH] Revert "ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error"
Date: Tue, 13 Aug 2024 15:19:01 +0200
Message-ID: <20240813131900.1285842-2-cassel@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3145; i=cassel@kernel.org; h=from:subject; bh=k6UmuWWU+5OWpY/TlzGbBpOY05z+pfvzbhKtMvZXl8Y=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJ2x7ooRnscTSgN7E95VW+y8Ew8b3qVDt+PZT3yLifW9 mkrfa7sKGVhEONikBVTZPH94bK/uNt9ynHFOzYwc1iZQIYwcHEKwESitBj+SkizeBwpfJk0M/nO vMSFxRmdkp95DLi3XOp/0iKXnCGty8iw89daMSuxJ7NqxTf9nV51Mu+8vUbXB4dZl99XGrdxbWh nAwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

This reverts commit 28ab9769117ca944cb6eb537af5599aa436287a4.

Sense data can be in either fixed format or descriptor format.

SAT-6 revision 1, "10.4.6 Control mode page", defines the D_SENSE bit:
"The SATL shall support this bit as defined in SPC-5 with the following
exception: if the D_ SENSE bit is set to zero (i.e., fixed format sense
data), then the SATL should return fixed format sense data for ATA
PASS-THROUGH commands."

The libata SATL has always kept D_SENSE set to zero by default. (It is
however possible to change the value using a MODE SELECT SG_IO command.)

Failed ATA PASS-THROUGH commands correctly respected the D_SENSE bit,
however, successful ATA PASS-THROUGH commands incorrectly returned the
sense data in descriptor format (regardless of the D_SENSE bit).

Commit 28ab9769117c ("ata: libata-scsi: Honor the D_SENSE bit for
CK_COND=1 and no error") fixed this bug for successful ATA PASS-THROUGH
commands.

However, after commit 28ab9769117c ("ata: libata-scsi: Honor the D_SENSE
bit for CK_COND=1 and no error"), there were bug reports that hdparm,
hddtemp, and udisks were no longer working as expected.

These applications incorrectly assume the returned sense data is in
descriptor format, without even looking at the RESPONSE CODE field in the
returned sense data (to see which format the returned sense data is in).

Considering that there will be broken versions of these applications around
roughly forever, we are stuck with being bug compatible with older kernels.

Cc: stable@vger.kernel.org # 4.19+
Reported-by: Stephan Eisvogel <eisvogel@seitics.de>
Reported-by: Christian Heusel <christian@heusel.eu>
Closes: https://lore.kernel.org/linux-ide/0bf3f2f0-0fc6-4ba5-a420-c0874ef82d64@heusel.eu/
Fixes: 28ab9769117c ("ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d6f5e25e1ed8..473e00a58a8b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -951,8 +951,19 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
 	} else {
-		/* ATA PASS-THROUGH INFORMATION AVAILABLE */
-		ata_scsi_set_sense(qc->dev, cmd, RECOVERED_ERROR, 0, 0x1D);
+		/*
+		 * ATA PASS-THROUGH INFORMATION AVAILABLE
+		 *
+		 * Note: we are supposed to call ata_scsi_set_sense(), which
+		 * respects the D_SENSE bit, instead of unconditionally
+		 * generating the sense data in descriptor format. However,
+		 * because hdparm, hddtemp, and udisks incorrectly assume sense
+		 * data in descriptor format, without even looking at the
+		 * RESPONSE CODE field in the returned sense data (to see which
+		 * format the returned sense data is in), we are stuck with
+		 * being bug compatible with older kernels.
+		 */
+		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
 	}
 }
 
-- 
2.46.0


