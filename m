Return-Path: <stable+bounces-56301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A9F91ED14
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 04:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11106B229F4
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 02:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F2B376E5;
	Tue,  2 Jul 2024 02:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E/y/Zik2"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EBF2B9D8
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 02:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719888467; cv=none; b=OtX9Lvi+L+1CZYfnHcq/Onma9B4T8gEMc5r4K0SG0KfFv8NBtXd4ZA8kB1UUDbxw63F9Wkh6qMOEC/XzfQOxfkk706FnIZS7RM4b3TZ1CG5rQvKPpFhH000tPfzY8CmeYwhzyURpn5qvum3zJC3L2WptZX7WMdqzSt+nbV8mcU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719888467; c=relaxed/simple;
	bh=UQZTNgxuo/nQ4A40i4CKkg/R6rQqJGLMQemrM+QDYEI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=koWYU5OZ3i05ftXYcYU8Bqf06ymu5eio2o81rkZ5R7aGNcCAQbZ5wmfMvYF0Vp4WPQRNJhi3lM6kSmtdM+FBLEIE1DcbT8pN5xEh4FphDRRAWFSwFp6S+xvYYgUcysOU/epuDd/2SWP0ToYKDKbOVyukGNuU9rffd83VTxQyjYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E/y/Zik2; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0360f8d773so6101989276.3
        for <stable@vger.kernel.org>; Mon, 01 Jul 2024 19:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719888465; x=1720493265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w00QSz187T1KSvOH92zkWn3h1qrakV8FNdVfs8AN5w0=;
        b=E/y/Zik2Y4fQQm2Xc+17rXiBV52nI6BWL3bE2wodmL6A1SnHxUTMAnDhCsdta9/Z+0
         gtcF+zEmEe5DHYRcTR3iayRrwdTQLUm7sHYeCMFsOsYjUQ0qzLLpArqxJTzfFpBdPt0c
         VXryAc162Y1wmcsEg73UP48XQq8E40HkbYIZJm2qjEi8yXVvQb/jLvngKeCoxCHr19M/
         20mxqtxEX+6yogcMVoI0fbIYhky2v+6VltyJFTBNov5pxdXnK6F8H9oel6D4Be/zPtYt
         pRcVxppH63gMfpsf0STrMdG/mS/oG/fjXXErZ5+LAKwX0sX4fLFd7QGXRozrve17W7Kc
         IFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719888465; x=1720493265;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w00QSz187T1KSvOH92zkWn3h1qrakV8FNdVfs8AN5w0=;
        b=n/qb1bT5ZYkOjXl2U+9RxWEI96hsNrLb1Rha3Ic0Ue4e+JGgrcDgM4KQp30kfWCa/y
         sirP9QS4VbrJfItmeMq6VQYsmPFVtk+no1sL/Ne8x0y2WnTBIeVzBWVR4nQxC6M/lp4l
         q7BW39Fgrg4N/fpU8DzcWbkgcoGdUSETrhPZB9omNpruvzJTpLUGCFIFDlHlw787ndmV
         fek8II8RIkv3gKZpJ8CgCe4l1xKiUN2uc05nANw1CLfJd/o37ZacN+QbnBPFp2ZmTnyS
         2w4slSqyDIYZMgHKO62NdHlQ3KHi3p0/kTs6PiOxDSX74/vcifEgmqfN95darhIwWfLH
         ixrw==
X-Forwarded-Encrypted: i=1; AJvYcCV0aE6ejPWPCFkyBlalVC98wSixiXCJ6z0j3F50nib731X5b/z9Yir5llRme+3sNSDrqd0YSW8KoBXFKt9c6lJQ57zp4Tci
X-Gm-Message-State: AOJu0YzWFHqq2sh95Ky6ahtMRciUxuadvct36BtVb2UgiY9VucpocXk3
	mboBSpbofx7EuMlT/2f8H32U26Q7Uja/nSWesdUcKPIvuw2H//0a1ymSidlJZetcaXKDLCnlsFz
	KwAhUmdOxzQ==
X-Google-Smtp-Source: AGHT+IEvUTFIgKCzrTE5ovL08iBb/D3RskDQu4+yIlR5yKTtxFavno3Ikw8Oljg6ZVkQd+fpyujDnQ6yQRlZtg==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a25:9206:0:b0:e03:4d2d:b0df with SMTP id
 3f1490d57ef6-e036eb573b9mr201128276.6.1719888464966; Mon, 01 Jul 2024
 19:47:44 -0700 (PDT)
Date: Tue,  2 Jul 2024 02:47:31 +0000
In-Reply-To: <20240702024735.1152293-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240702024735.1152293-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240702024735.1152293-4-ipylypiv@google.com>
Subject: [PATCH v5 3/7] ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1
 and no error
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

SAT-5 revision 8 specification removed the text about the ANSI INCITS
431-2007 compliance which was requiring SCSI/ATA Translation (SAT) to
return descriptor format sense data for the ATA PASS-THROUGH commands
regardless of the setting of the D_SENSE bit.

Let's honor the D_SENSE bit for ATA PASS-THROUGH commands while
generating the "ATA PASS-THROUGH INFORMATION AVAILABLE" sense data.

SAT-5 revision 7
================

12.2.2.8 Fixed format sense data

Table 212 shows the fields returned in the fixed format sense data
(see SPC-5) for ATA PASS-THROUGH commands. SATLs compliant with ANSI
INCITS 431-2007, SCSI/ATA Translation (SAT) return descriptor format
sense data for the ATA PASS-THROUGH commands regardless of the setting
of the D_SENSE bit.

SAT-5 revision 8
================

12.2.2.8 Fixed format sense data

Table 211 shows the fields returned in the fixed format sense data
(see SPC-5) for ATA PASS-THROUGH commands.

Cc: stable@vger.kernel.org # 4.19+
Reported-by: Niklas Cassel <cassel@kernel.org>
Closes: https://lore.kernel.org/linux-ide/Zn1WUhmLglM4iais@ryzen.lan
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b59cbb5ce5a6..076fbeadce01 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -941,11 +941,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
 	} else {
-		/*
-		 * ATA PASS-THROUGH INFORMATION AVAILABLE
-		 * Always in descriptor format sense.
-		 */
-		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
+		/* ATA PASS-THROUGH INFORMATION AVAILABLE */
+		ata_scsi_set_sense(qc->dev, cmd, RECOVERED_ERROR, 0, 0x1D);
 	}
 }
 
-- 
2.45.2.803.g4e1b14247a-goog


