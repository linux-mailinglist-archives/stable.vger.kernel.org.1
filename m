Return-Path: <stable+bounces-158804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D25AEC063
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 21:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C181748F0
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 19:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AB72D97BF;
	Fri, 27 Jun 2025 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z70HelxP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FEA1C6FE1
	for <stable@vger.kernel.org>; Fri, 27 Jun 2025 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751053855; cv=none; b=tkds5ee1N9C7YMDQ7oEC3WDV7u6x1QjF36DWfINB49QhtAisFIu9j8zpswY9/VzsoNFkqZmvW+PKD/xwjh242mZoRru4hNHnnmfgZ83s2Cav5awqQxsdY5TxqMwPPpdZPHnbOVJq2EeZKHAI6YUt+G654Qfwq/vFGKfNJ8gtBUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751053855; c=relaxed/simple;
	bh=7scot/otsCZWfhionpx+oiUHlFeRZLTEHjzJBT1mbDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eJ6U/0aB4bn8ElCR/9et4LB0+fXvK+XCtHuc1ub+ZKMtqCQddQ7lbqWzk/9YNO9SKlhaqIYxxi//AGRUUPCeaA6v2GPLu3/egEvdrve6mlsjDUjSJCLnn2Tp10f/dReqNdtsc+bhRkRGYgwhov5O2wojO5UjOY9UB4eQoozlB9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z70HelxP; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b3226307787so395507a12.1
        for <stable@vger.kernel.org>; Fri, 27 Jun 2025 12:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751053853; x=1751658653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrAr7GxdF6AOrkM/hv3ArFP9XhZfc+XhzG/M9Z6/0SY=;
        b=Z70HelxPj1NbxP5R/A0gzu85I55V8V8wUHQrhRo2D8eYADkX7bvJeSSGI2CQQqsOJ8
         eceL+YPtaKEkcOhlpEOAOm6AdqFkkp8hqyVse6T1N1+MsOECldQ6rVVlhFRZfX6k+Nix
         5Ch01XYRJgK7iOnfIX6mQBbCfptMd0v4WVAD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751053853; x=1751658653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrAr7GxdF6AOrkM/hv3ArFP9XhZfc+XhzG/M9Z6/0SY=;
        b=mJuhCyoVHA6RXbxrFXgHH1zMbt4NXG1EGiXL0tuflgVMzmpV/fplteo6HlBQiDVOep
         8JjRmNTCVJyy5nl0iZr/+2zZe8FsboPFjSBQZPUv1Yw3s38wLhDSCgPXyLiy+1Bj9lgg
         X/YbZ+lInuUkv3Vmsy/j7dbwml1HFGxqaAiBtn38sM6FLjrljL1l7NZg+bFhO6POTzty
         33VlKFIu2O3J7zgjAMDVmSXSf/U/l/IKMu+42fuopLSYDszZINZisVeA1RgFy1ECJJdl
         cyjUgEcfyEkULaD8HBxYucEuTRubtqG1FV8WidhIj1FSOx7sUh7qeLdmSdkBDMlXcyva
         u0wA==
X-Forwarded-Encrypted: i=1; AJvYcCWjYrXS87A2b52IW9Zor6xlvhhYhhEsK/iSow3j/usyGEN7Ez0MLOneVTyokGgs6ScbXmbgZEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV3j/HCsypz0acJ7XD+pW6KlwuYf7Dl+jcZG8ZgGMBOSmKTKa+
	VNap1IZgB6bhAM1omrCGo0htk2zo41RZ0NhoGlcLbKRspUnsH29KLwyAW358lCBF4A==
X-Gm-Gg: ASbGncuzgLXuborninT8ehXm2s5721P/0z9VBM6LlNGnY51J/zS1DTWUiSv4uQg6h2e
	k9+Mui2cDHMNoekVpAkNlgnE6J+KyPHs+SLA3aFKCQh8CyzteicNBzU/4J5+ZZhWIZ6yCcVHeT/
	Ma7BicxUkCfoBwZcmCcyVEYJe3W6JDvOYpaPR5L9ZJbIAJjbaSxbmd+7i85RSTiy5nt/4BHccHm
	CHlqgJY7MNinqXP1KKczDBCYL+E6qYzDZIeVyFSguwvxLDaLxxpHn3N1NzuxaG4OGBputjG/zfX
	1XEOKDNSdwEycCsf8EtKTihFdfxjid6wUfU/WyYO2DHm1e/4p4IVihJn8YYUZq/X/AG8y+pxPyK
	YyFVKrxE0Vwd24yILYKBSUt/X+9qHJgo=
X-Google-Smtp-Source: AGHT+IFA9T5q2PuUq6ThjccrtRNDleV+A/eLjWeXBPzrH7ODaHqabMYPpLpcKYeRv1116D0Or1OgFg==
X-Received: by 2002:a17:90b:3b47:b0:311:d670:a10d with SMTP id 98e67ed59e1d1-318c92ee549mr5632581a91.26.1751053853339;
        Fri, 27 Jun 2025 12:50:53 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f247csm23485175ad.79.2025.06.27.12.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 12:50:52 -0700 (PDT)
From: Ranjan Kumar <ranjan.kumar@broadcom.com>
To: linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com
Cc: rajsekhar.chundru@broadcom.com,
	sathya.prakash@broadcom.com,
	sumit.saxena@broadcom.com,
	chandrakanth.patil@broadcom.com,
	prayas.patel@broadcom.com,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/4] mpi3mr: Fix race between config read submit and interrupt completion
Date: Sat, 28 Jun 2025 01:15:36 +0530
Message-Id: <20250627194539.48851-2-ranjan.kumar@broadcom.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250627194539.48851-1-ranjan.kumar@broadcom.com>
References: <20250627194539.48851-1-ranjan.kumar@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "is_waiting" flag was updated after calling complete(), which could
lead to a race where the waiting thread wakes up before the flag is
cleared, may cause a missed wakeup or stale state check.

Reorder the operations to update "is_waiting" before signaling completion
to ensure consistent state.

Fixes: 824a156633df ("scsi: mpi3mr: Base driver code")
Cc: stable@vger.kernel.org
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 1d7901a8f0e4..0186676698d4 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -428,8 +428,8 @@ static void mpi3mr_process_admin_reply_desc(struct mpi3mr_ioc *mrioc,
 				       MPI3MR_SENSE_BUF_SZ);
 			}
 			if (cmdptr->is_waiting) {
-				complete(&cmdptr->done);
 				cmdptr->is_waiting = 0;
+				complete(&cmdptr->done);
 			} else if (cmdptr->callback)
 				cmdptr->callback(mrioc, cmdptr);
 		}
-- 
2.31.1


