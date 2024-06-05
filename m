Return-Path: <stable+bounces-48248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0457F8FD92E
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 23:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4A51C21DE9
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 21:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E0F15F41D;
	Wed,  5 Jun 2024 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="eEGbfY6F"
X-Original-To: stable@vger.kernel.org
Received: from forward204b.mail.yandex.net (forward204b.mail.yandex.net [178.154.239.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CCF15F3FF;
	Wed,  5 Jun 2024 21:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623441; cv=none; b=ZBGaXM0907G1wkSt6gaeoHpmvW4bdEHRngrTEsObmGlkvmCtdV3leSEoeuzAe/dtMsqVUmp2qU8l/RGPueKF2xS2EvxeUDHRWGGxSa7J4TN3YbWwVRgQTXk/cRkjNRUY4Ti7C7ZHd0SZz246yWkRtgEPezvY/mineK+0ahUi774=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623441; c=relaxed/simple;
	bh=I1MC/J9J5wZTsyCTVV7/Js6exyl5QJIVotMGCkz7gHE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gCysgjTVeTLTHcxCvECj/7+XNDkwmVdsc5Hjh9iZPlJfn0rZ12RsIPDZGvXzwYInCObAxnM0yYbUmHlmvW/fs2gY4UFoPLqhRnMeKXXnEuJYFtTFh8iI3J8y5Q5jDq5dJcR2RfEBL8mJtVoGx4oKJHVl1fwYPtcqwYyMSiOg120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=eEGbfY6F; arc=none smtp.client-ip=178.154.239.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
	by forward204b.mail.yandex.net (Yandex) with ESMTPS id A7FF36677C;
	Thu,  6 Jun 2024 00:34:42 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:4486:0:640:b366:0])
	by forward103c.mail.yandex.net (Yandex) with ESMTPS id 56F26608E1;
	Thu,  6 Jun 2024 00:34:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id VYgH11SMo8c0-8YgXmBOX;
	Thu, 06 Jun 2024 00:34:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1717623273; bh=JvVC7BaTilq9Ww7g4mw3O5T4PPv3xf2DesSD7h+cHxQ=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=eEGbfY6FDHA/a4AYVa9egz65CoedLqMAD0KicAFtGcohEDS7vLrVtcIBYSa1d/o64
	 KYw/NwsCGJzEocE9uqbi4vYJRCUoFJYqt6F7edcUSidRwinI52zL3WLD3gh3BOtjL3
	 +tEI8vrLVZ81XoHSrRIfr4Gh262osk7RrVhiZ71s=
Authentication-Results: mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Mikhail Ukhin <mish.uxin2012@yandex.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Mikhail Ukhin <mish.uxin2012@yandex.ru>,
	stable@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavel Koshutin <koshutin.pavel@yandex.ru>,
	lvc-project@linuxtesting.org,
	Artem Sadovnikov <ancowi69@gmail.com>,
	Mikhail Ivanov <iwanov-23@bk.ru>
Subject: [PATCH v3 5.10/5.15] ata: libata-scsi: check cdb length for VARIABLE_LENGTH_CMD commands
Date: Thu,  6 Jun 2024 00:34:28 +0300
Message-Id: <20240605213428.4040-1-mish.uxin2012@yandex.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No upstream commit exists for this patch.

Fuzzing of 5.10 stable branch reports a slab-out-of-bounds error in
ata_scsi_pass_thru.

The error is fixed in 5.18 by commit ce70fd9a551a ("scsi: core: Remove the
cmd field from struct scsi_request") upstream.
Backporting this commit would require significant changes to the code so
it is bettter to use a simple fix for that particular error.

The problem is that the length of the received SCSI command is not
validated if scsi_op == VARIABLE_LENGTH_CMD. It can lead to out-of-bounds
reading if the user sends a request with SCSI command of length less than
32.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>
Signed-off-by: Mikhail Ivanov <iwanov-23@bk.ru>
Signed-off-by: Mikhail Ukhin <mish.uxin2012@yandex.ru>
---
 v2: The new addresses were added and the text was updated.
 v3: Checking has been moved to the function ata_scsi_var_len_cdb_xlat at
 the request of Damien Le Moal
 drivers/ata/libata-scsi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index dfa090ccd21c..38488bd813d1 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3948,7 +3948,11 @@ static unsigned int ata_scsi_var_len_cdb_xlat(struct ata_queued_cmd *qc)
 	struct scsi_cmnd *scmd = qc->scsicmd;
 	const u8 *cdb = scmd->cmnd;
 	const u16 sa = get_unaligned_be16(&cdb[8]);
+	u8 scsi_op = scmd->cmnd[0];
 
+	if (scsi_op == VARIABLE_LENGTH_CMD && scmd->cmd_len < 32)
+        	return 1;
+	
 	/*
 	 * if service action represents a ata pass-thru(32) command,
 	 * then pass it to ata_scsi_pass_thru handler.
-- 
2.25.1


