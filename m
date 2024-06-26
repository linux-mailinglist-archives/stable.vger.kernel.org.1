Return-Path: <stable+bounces-55886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC96C9199B5
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 23:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0FF1C220B1
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 21:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A05194094;
	Wed, 26 Jun 2024 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="W7Dm6rYw"
X-Original-To: stable@vger.kernel.org
Received: from forward205a.mail.yandex.net (forward205a.mail.yandex.net [178.154.239.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E44016A928;
	Wed, 26 Jun 2024 21:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719436823; cv=none; b=muBHW+roUSNXi6/0T98KqdRzE7mkQq2vMKa/eqYw/bh8kaPQIPXcGSPnw3spyjCOPt9VPMhqOu2q/gW8yqjBjyTeRnNEWVXsxz5gUSKdk6ddd8I/D6PBzs6J938zGk7kaMCM+ej2lV7qjZdhv0sa9g2ztHKBNZg6fe8mjzN7X7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719436823; c=relaxed/simple;
	bh=SIDe4m7k4he3g8/b/GoPMpMXk5vUpHz1qP3f4e8/Kds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aqbQfhli13FLd4g7uhjEbZ3BbtVRwuZJeGG+/pTu8wKW5Ig1zh9t56QvnYSiMZ7aY37vaH3k9KoqXWyJZkwD9TMXyXNhQwQW698btveeUGYGwhR+b3nm7A9cvu9tfJ2XywVEKYcv0EgqqdgZuHDV6rJy6v0yVv40Wi86B5nJoTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=W7Dm6rYw; arc=none smtp.client-ip=178.154.239.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
	by forward205a.mail.yandex.net (Yandex) with ESMTPS id 835336986D;
	Thu, 27 Jun 2024 00:14:18 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net [IPv6:2a02:6b8:c00:27aa:0:640:9471:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 8CF6F46C7A;
	Thu, 27 Jun 2024 00:14:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wDYBEa1MdOs0-gY2WGPwU;
	Thu, 27 Jun 2024 00:14:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1719436449; bh=7/sJn937goh/sUopg6CvXF8yyAafNE/SwUIKRZRjxnA=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=W7Dm6rYw5pQTacv0r/jaH/SCoU/Sv4UpxWkUbdSIWcq6KB6a4BlgM4On3eMDX9ApR
	 oj2hfXQMG7e1tjcb1xMlE2znXYuU4v0mVMvhcwz9egI9uxGAVIhDH3hBTX3Qxi8PBM
	 gT0fOTZhF1fb1QWRw7yW1MJKUmqayh7FlFCmbwzs=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Mikhail Ukhin <mish.uxin2012@yandex.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Mikhail Ukhin <mish.uxin2012@yandex.ru>,
	stable@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavel Koshutin <koshutin.pavel@yandex.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH v4 5.10/5.15] ata: libata-scsi: check cdb length for VARIABLE_LENGTH_CMD commands
Date: Thu, 27 Jun 2024 00:13:58 +0300
Message-Id: <20240626211358.148625-1-mish.uxin2012@yandex.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 the request of Damien Le Moal.
 v4: Extra opcode check removed.
 drivers/ata/libata-scsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index dfa090ccd21c..38488bd813d1 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3948,7 +3948,11 @@ static unsigned int ata_scsi_var_len_cdb_xlat(struct ata_queued_cmd *qc)
 	struct scsi_cmnd *scmd = qc->scsicmd;
 	const u8 *cdb = scmd->cmnd;
 	const u16 sa = get_unaligned_be16(&cdb[8]);

+	if (scmd->cmd_len < 32)
+		return 1;
+
 	/*
 	 * if service action represents a ata pass-thru(32) command,
 	 * then pass it to ata_scsi_pass_thru handler.
--
2.25.1

