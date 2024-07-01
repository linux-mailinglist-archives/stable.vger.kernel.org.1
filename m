Return-Path: <stable+bounces-56272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B926291E8FE
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 21:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD3A1C21D4E
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 19:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D8417106E;
	Mon,  1 Jul 2024 19:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qIO5CXwX"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C30A16FF47
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863888; cv=none; b=aJmXN74aj8tyh+kHEkDcHeN2f+UaHnm4A/SWjZlrK+9n5X2fhTgLRYuqCQIoCJ288tJwszC6OilWtPWNA485TK3zd8Ry3OhGofB8dRz7fiGupjK7b0yPDnUBAbZjk6PcIvYeoeAyZsyDN5y2Cj+1QtRQcXLBBxI9TeM1h6eYvJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863888; c=relaxed/simple;
	bh=khdJffv/7S+fJo+T1ERSS/3kzh8tOaLDJIGVkc4xP/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lPgw6Gej7bAyqbLqprBbJQGjm+6yUahbRv3SF2wC/VeGnIYVTafEijK/0zjjTYUrPoJNr0Y3SejgoDbSbrzKp+mVTz3V6ivWCMgJTZ6c2QgFy6WmaJARwnjdiUG3dCxNIEthjfz0tfCMzOcxhuju2iRXTXR8x0L0hiGHrZvZauU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qIO5CXwX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0335450936so6061324276.1
        for <stable@vger.kernel.org>; Mon, 01 Jul 2024 12:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719863886; x=1720468686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dnwRRitprzkm9CFQnXP8vP+tPUkvyuIbgLz5w5FglfM=;
        b=qIO5CXwX4Z+q/un3+dPyJov/IdHdVx3LxX+SGM9FiLY+99fm56R2ImcDK740w4NTrF
         K+Z69e2Yj3jGl4iMLPLy4hjI3lU9gcjpYf8HQl/wAy1QDKBmlmqSuy+dwCN1w3o4W+G1
         jqV58ovnVaTdR4QuhILoUV84ZsklDZyJe3zqs0eMxuSxXZy2jmivULhPXQdHfJLQDAM+
         WP3h7fLrscPHtsqrxRwnZ38x9JVv3ULdg8CspvAsLrR3h4k+cO8JUBvcUBbXcqT0Mh9/
         ou8fsxZRGuoVjCUke4YeevXw5LySEiRPUS7lDpthxh2yNu5fyftZTCZmvWNKiwNCvgf7
         xV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863886; x=1720468686;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dnwRRitprzkm9CFQnXP8vP+tPUkvyuIbgLz5w5FglfM=;
        b=J+HiHZr/u9ZAq+Wr5xfGJDKRJ2dD4dgT7ZOUaaTtpTgcR++0SqXOz7uLdHPvnBq5xo
         1CHkQLhvhKdm0/ZvyAgn+hUGZtufkb9pzQsEqt7svy2ifwdBP6vdoC2q0SJGOat8rK4/
         Nr1ZfoX16zDVlEroJLB0eb6wK9OzqMH8K7yG/b/tcyw2PM+k69ur5lYDx1+h9CUDWdk2
         aLbfJIGv9p5Tuq2Fn8zas9XY7nZmVuwxVJ3B6SMUofVj9yMfTg0gST5oI4OGkGIh8nlU
         167An5TSaCJylpFvK0DNhBvMj/NrNNl4wdUvp0DtKW+w16qKAwCK+0Tc2DLYOLH2GUZm
         9Z6g==
X-Forwarded-Encrypted: i=1; AJvYcCUdls+8VEPGS40l38L2gokOf8D2jImlyT6xXUcs3KJwWAMrE1cDzRBwEnXWgor8sWnjZu8D+4DAkXTzlcRwsHN5aPPli8bd
X-Gm-Message-State: AOJu0YwuZeeFQ7niQMnADDeFucNiZtLNuPyDElyWuhWNDKoeqUU+NSqh
	YoEo0iwF4f/UzAxmhO2PDJidlchS7YhIQ/RSMwQh7ANVt0LYJvYY/1VEZB5xtLH+h6l/n5Ti/D9
	VNnKerwGGgg==
X-Google-Smtp-Source: AGHT+IGzMEpQQ0h2vrhesUkCvW4udpb8us0XQRrchEc3aCPHfOQhX6iByBHH4rABuctrZO5NmeW5fAelZsUPQA==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1009:b0:df4:d6ca:fed0 with SMTP
 id 3f1490d57ef6-e036eaf6cbemr16573276.4.1719863886049; Mon, 01 Jul 2024
 12:58:06 -0700 (PDT)
Date: Mon,  1 Jul 2024 19:57:51 +0000
In-Reply-To: <20240701195758.1045917-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240701195758.1045917-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701195758.1045917-2-ipylypiv@google.com>
Subject: [PATCH v4 1/8] ata: libata-scsi: Fix offsets for the fixed format
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


