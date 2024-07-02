Return-Path: <stable+bounces-56299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C129C91ED0E
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 04:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E351C2246A
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 02:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278E820332;
	Tue,  2 Jul 2024 02:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HNkcTudQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F388168A8
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 02:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719888463; cv=none; b=LY/bL0d2kM3VacxTfqVhq1G4m6//UdRoPzPtZ2qRGm0l0RLLkPqirDKixx7vYqrorpVxbCtgJCMW7hIfN1RfD3pcAYN7uSKO5Mm9v9VwdCu24xxUmyQAggjTFYg9NORKYqEjDSy4Llp7ZsglbSVA72Y5dNgvXFaUxgI1J6WRN5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719888463; c=relaxed/simple;
	bh=HTrgxcWff1OSSYrDj5ylupNG6UKIfx6wTzhICaZOCC4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ppj156mHZwE0hoa8EUK8cpMrYqsz2MhA3+OmsEQFh4cTq5DxiKjJCxZymFsc7V14064UKjSXQpO3IAE8NthdDZSiyIHLXZk1bOENRTSFoB9v/Jtq8baJoKnamAFn2r09QSFSKHhqYgHUprQQgmtVwNiJuIPIFKoqZ41NbGrZh2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HNkcTudQ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b8c0c2c9so6700516276.1
        for <stable@vger.kernel.org>; Mon, 01 Jul 2024 19:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719888461; x=1720493261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mbUb6G4m1uUehtvXxBjGbQF+Fq5mFzQsrUm91ddIqA=;
        b=HNkcTudQ67W1ugZIr7jLT10fu/hvsabY+UBGiMvwXc60jfyXsdde3BNqJN0DmO2qKZ
         k+M/vHm9hdxExdSRI0czdmPjh4Szr9yQSHitVSOqNJ1LZrZmoDNAM6cFscJ3qeQybx6Z
         92IwTcxzbC4Hi5vA5eLOTbKdO376qgS9WVDsOX3UXZXgNwPAXLI5krd+c+Y+066LKM8r
         YB5fOwiS1QRy+nTJl37gR/67hp6i0iuhn8EsPpDuuaWa9itAgEyBH48lUj01h8ay94lE
         F/wSMXVsT2g499ewvbqIj3LeLBNpvAalp9ydkTpY1gGXJLJCFzepbBa37pN/gJej/aev
         SEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719888461; x=1720493261;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+mbUb6G4m1uUehtvXxBjGbQF+Fq5mFzQsrUm91ddIqA=;
        b=Hlh5oCQV4WGGviW+im+b/4SjSvR8NgMx9ZHyzlsqcmWqr0KlyT1vFu7iHr2bnngCwQ
         LyBVYQzUCS+MfPNgw4nd6DhBo54iKkwe3QnNrWfFpPWioNPEvDMA0lt/7FcddPPJFEuw
         SLmp7lpvUChrKf5S25un3Zkt4/ASYHwUMdiovt3MWzP1zoTtmPhZSFYbvt5VVLpaF6A7
         ALP2E+3Fu6KOlKwldMk6A9MVPJlVgdew5YcfcnLmNJbk8O9QI4/JaduqKfZ6KS3IK6kW
         UILraabdJ8APM7CHsR3Pya6dTT5R1O23gchJniDvsdGLH7Gv4t53epAsNbCDLyQik2Zu
         ekRw==
X-Forwarded-Encrypted: i=1; AJvYcCVi1gth2JV1aa4l43Bhno1j6fTGuppDxxvvsUe2Kjp598IpCCFMoodCJ6NwBLv0aanylNSj1FKZwiI63BUuqaLIhDGjOP22
X-Gm-Message-State: AOJu0YwKtlAOfnn3zvDRAm1Xwvc31sJyUJgpp7xcz/oZpUC0D9xfQuB2
	uw6FKEwFmG0UofirvfJpLJYmPAzz6hkDnvWC5Ysydy9ykvjXDOcOTlMihHCAV9Q97FSprJdjfap
	zUhrgevlM/A==
X-Google-Smtp-Source: AGHT+IElMlsVkkIH/SoAz+8WBYWit8jbyFBfvfQcb/6vfTSYNoTYjYrLAnrzRdUSqlDyem0nhaD9sQJFjV9D8Q==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:2b13:b0:dff:ad2:3c13 with SMTP
 id 3f1490d57ef6-e036ec376bfmr558093276.9.1719888461370; Mon, 01 Jul 2024
 19:47:41 -0700 (PDT)
Date: Tue,  2 Jul 2024 02:47:29 +0000
In-Reply-To: <20240702024735.1152293-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240702024735.1152293-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240702024735.1152293-2-ipylypiv@google.com>
Subject: [PATCH v5 1/7] ata: libata-scsi: Fix offsets for the fixed format
 sense data
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>, 
	Akshat Jain <akshatzen@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Correct the ATA PASS-THROUGH fixed format sense data offsets to conform
to SPC-6 and SAT-5 specifications. Additionally, set the VALID bit to
indicate that the INFORMATION field contains valid information.

INFORMATION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

SAT-5 Table 212 =E2=80=94 "Fixed format sense data INFORMATION field for th=
e ATA
PASS-THROUGH commands" defines the following format:

+------+------------+
| Byte |   Field    |
+------+------------+
|    0 | ERROR      |
|    1 | STATUS     |
|    2 | DEVICE     |
|    3 | COUNT(7:0) |
+------+------------+

SPC-6 Table 48 - "Fixed format sense data" specifies that the INFORMATION
field starts at byte 3 in sense buffer resulting in the following offsets
for the ATA PASS-THROUGH commands:

+------------+-------------------------+
|   Field    |  Offset in sense buffer |
+------------+-------------------------+
| ERROR      |  3                      |
| STATUS     |  4                      |
| DEVICE     |  5                      |
| COUNT(7:0) |  6                      |
+------------+-------------------------+

COMMAND-SPECIFIC INFORMATION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

SAT-5 Table 213 - "Fixed format sense data COMMAND-SPECIFIC INFORMATION
field for ATA PASS-THROUGH" defines the following format:

+------+-------------------+
| Byte |        Field      |
+------+-------------------+
|    0 | FLAGS | LOG INDEX |
|    1 | LBA (7:0)         |
|    2 | LBA (15:8)        |
|    3 | LBA (23:16)       |
+------+-------------------+

SPC-6 Table 48 - "Fixed format sense data" specifies that
the COMMAND-SPECIFIC-INFORMATION field starts at byte 8
in sense buffer resulting in the following offsets for
the ATA PASS-THROUGH commands:

Offsets of these fields in the fixed sense format are as follows:

+-------------------+-------------------------+
|       Field       |  Offset in sense buffer |
+-------------------+-------------------------+
| FLAGS | LOG INDEX |  8                      |
| LBA (7:0)         |  9                      |
| LBA (15:8)        |  10                     |
| LBA (23:16)       |  11                     |
+-------------------+-------------------------+

Reported-by: Akshat Jain <akshatzen@google.com>
Fixes: 11093cb1ef56 ("libata-scsi: generate correct ATA pass-through sense"=
)
Cc: stable@vger.kernel.org
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index bb4d30d377ae..a9e44ad4c2de 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -855,7 +855,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cm=
d *qc)
 	struct scsi_cmnd *cmd =3D qc->scsicmd;
 	struct ata_taskfile *tf =3D &qc->result_tf;
 	unsigned char *sb =3D cmd->sense_buffer;
-	unsigned char *desc =3D sb + 8;
 	u8 sense_key, asc, ascq;
=20
 	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
@@ -877,7 +876,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cm=
d *qc)
 		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
 	}
=20
-	if ((cmd->sense_buffer[0] & 0x7f) >=3D 0x72) {
+	if ((sb[0] & 0x7f) >=3D 0x72) {
+		unsigned char *desc;
 		u8 len;
=20
 		/* descriptor format */
@@ -916,21 +916,21 @@ static void ata_gen_passthru_sense(struct ata_queued_=
cmd *qc)
 		}
 	} else {
 		/* Fixed sense format */
-		desc[0] =3D tf->error;
-		desc[1] =3D tf->status;
-		desc[2] =3D tf->device;
-		desc[3] =3D tf->nsect;
-		desc[7] =3D 0;
+		sb[0] |=3D 0x80;
+		sb[3] =3D tf->error;
+		sb[4] =3D tf->status;
+		sb[5] =3D tf->device;
+		sb[6] =3D tf->nsect;
 		if (tf->flags & ATA_TFLAG_LBA48)  {
-			desc[8] |=3D 0x80;
+			sb[8] |=3D 0x80;
 			if (tf->hob_nsect)
-				desc[8] |=3D 0x40;
+				sb[8] |=3D 0x40;
 			if (tf->hob_lbal || tf->hob_lbam || tf->hob_lbah)
-				desc[8] |=3D 0x20;
+				sb[8] |=3D 0x20;
 		}
-		desc[9] =3D tf->lbal;
-		desc[10] =3D tf->lbam;
-		desc[11] =3D tf->lbah;
+		sb[9] =3D tf->lbal;
+		sb[10] =3D tf->lbam;
+		sb[11] =3D tf->lbah;
 	}
 }
=20
--=20
2.45.2.803.g4e1b14247a-goog


