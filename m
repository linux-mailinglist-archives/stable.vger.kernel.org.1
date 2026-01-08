Return-Path: <stable+bounces-206249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 617DDD01485
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 07:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1A81307739D
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 06:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5C733D514;
	Thu,  8 Jan 2026 06:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X/qFFU1e"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB15B33C19C
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 06:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767854617; cv=none; b=Ish8iahNgQ4Oo+BCxr7r+peoUVdWlkFz8zK+y8E/zML9UKUQJFi/8t9froP80o2Bt0H8XFnqZnMCElniSdiHEq6d8G0bOqtW0IMIcrL6ApCk2hBBHKjhbXnn/kYv2QDQtWFP4jGgib3EjicuSmL2j705PCyGKSfC/eLE5S33mJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767854617; c=relaxed/simple;
	bh=5mic/q6vuxQbS8YXyfZUjqQArn9vFbNhUdp2DnF4O0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uoZvuJwXI/vXHo2ZuVSVYTZoER52aNwP4uswj8EfnY3Deq1pmA0Gw+vVCtipv10njAGPyK0eZjR16aohHn7WGbYfbN9tNUNIvIr5fnbtrqWMUpvGc8OQb1L2ReaQHHRYcdsRL7nciV9DUKfBP9xIVas1ej3jKuD5WMwxVoG6h6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=X/qFFU1e; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a0a95200e8so18149505ad.0
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 22:43:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767854610; x=1768459410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RXr5VPevjUOPqn3fRQwqWW7ZEAc2kKpuQcOkyGsfGno=;
        b=kf4PRcIOYNVRQjywzTLID+sxJKCcC6L0ksTxcoafzTcwY6PgEl2ltnSyPMkvu5h8um
         pbSBJU3bVbP8+33ZRQ2TbFdjM2I7eHNyrUN2ogi2bb6baKhth4syr4YWf+1QN5y3U7se
         nrc5nFLYVqToC+XSjusDFn4kuwnwSnv2cU1S2JKqM10OgHOmCU787vRHvWDjwT3FUMpP
         BYnftYy+pFVNOw3f8fv81U1Rqt7mQfdgFt51idFT/0WacC0Tq5zV8kd5vqkHV922uJ4i
         lMaWlLgwVdtrw9Ek27wPHDdLCsX9W4bb0SLePzSgM0dPHuhQocXvqEb/5grTbkurRj42
         SN9w==
X-Gm-Message-State: AOJu0YytyBVZq7IRPEM0BdcB7+tmUQMRhAsjrcBpSRh3D4Qsksy0IPIv
	FNZoUPbuuSv5O4YiFck+fSoGZTwezQ/aHjGg8J1btiBu2q2cTvnwkrzIBotX+dDywjHIA2GytDP
	loVdA7Rdra/hvf9ZhgI1BYrgAcus5W0aKobC62jYXmzfh178SfoqUNYj7bgSXmkrmDqppvn6qJ/
	9v21rYwy/+0zBZBpcJHsmAILafslGVYBvaw6Olc5uaTXNmu5yqRx9YjJfiLgpehcKYnSZnVXNeY
	0UMdE20rXUwgk3bnw==
X-Gm-Gg: AY/fxX6R7bpJWX/4OsxPJBDWvws5X4yNTjjTZFGDRbuTc7gSPuSWrysZk/Ld8nYPZf2
	P43GajvrwfdM1/oj+QL9yJ91Bv4wy31wzIA4KAurnmi0otpJZpGdevPTF8v8e1CazSZonOdbE4Z
	uc8KopKX8ipIh1+Y60oWgchBIRHiJgL5SgfTU41xQ4IwsM9Cd0pZ0M5bPG/DRZ/DV2UUlLPGTWb
	RDfj8hG2EWNffISCf5v+5kpMLQJRPNuGlVzYRlbLqMCBwGkpBnc2ZTJ0UQPP+/782rSBO/Yq1sQ
	/3eAXA/VBbcOjSV9ajVf9m6re7gO1W98XJ1iRqv1Uy0GcXiGdfiKXeKJ/TcJUQDPC2r0d7ziW82
	wSO/dQJ0ILYN9HUe/NA5k+zPJz8m6mR0DgNhylLecBi6uHaidvV2fvGxS7sKZFu6iTQ4afRi21u
	qyoohkLQf4974temnzV+KuyH+LPN3eAodxrCZbi7OpFdsGlg==
X-Google-Smtp-Source: AGHT+IFX81exkeLSC1JKOojVVbidCHK8NyBgO9OTC6J9Jri7cCn9jzo6L7l1/xncOhe7DJcW2FnozTUsO/fJ
X-Received: by 2002:a05:6a20:3d92:b0:35d:f625:7e87 with SMTP id adf61e73a8af0-3898f91d821mr4337661637.22.1767854609593;
        Wed, 07 Jan 2026 22:43:29 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c4cc7fac222sm655171a12.9.2026.01.07.22.43.29
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jan 2026 22:43:29 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b0531e07e3so2204807eec.1
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 22:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767854607; x=1768459407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXr5VPevjUOPqn3fRQwqWW7ZEAc2kKpuQcOkyGsfGno=;
        b=X/qFFU1epwDz+O9K6wN8ilUkSsPuGpAF0QNELYXjzcmCMmYJ0BeXEYZcbiN4Rj4YS0
         c6jZoYmOVQEBFm0QMrgRlIlYn/C+RRHxMkqDcwX3lh0LaFEXJFhECxuJl7XhZweBKBU6
         hMNRZGQG+QBXgNIKdLYl4hAvCiuFE08Uo7Wr0=
X-Received: by 2002:a05:7022:6889:b0:11b:9386:a38b with SMTP id a92af1059eb24-121f8b9cf51mr4645231c88.46.1767854607447;
        Wed, 07 Jan 2026 22:43:27 -0800 (PST)
X-Received: by 2002:a05:7022:6889:b0:11b:9386:a38b with SMTP id a92af1059eb24-121f8b9cf51mr4645201c88.46.1767854606766;
        Wed, 07 Jan 2026 22:43:26 -0800 (PST)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243421esm13193731c88.2.2026.01.07.22.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 22:43:26 -0800 (PST)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: lduncan@suse.com,
	cleech@redhat.com,
	michael.christie@oracle.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	open-iscsi@googlegroups.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 1/2 v5.10] scsi: iscsi: Move pool freeing
Date: Wed,  7 Jan 2026 22:22:21 -0800
Message-Id: <20260108062222.670715-2-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260108062222.670715-1-shivani.agarwal@broadcom.com>
References: <20260108062222.670715-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Mike Christie <michael.christie@oracle.com>

[ Upstream commit a1f3486b3b095ed2259d7a1fc021a8b6e72a5365 ]

This doesn't fix any bugs, but it makes more sense to free the pool after
we have removed the session. At that time we know nothing is touching any
of the session fields, because all devices have been removed and scans are
stopped.

Link: https://lore.kernel.org/r/20210525181821.7617-19-michael.christie@oracle.com
Reviewed-by: Lee Duncan <lduncan@suse.com>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/scsi/libiscsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index bad5730bf7ab..59da5cc280a4 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -2902,10 +2902,9 @@ void iscsi_session_teardown(struct iscsi_cls_session *cls_session)
 	struct module *owner = cls_session->transport->owner;
 	struct Scsi_Host *shost = session->host;
 
-	iscsi_pool_free(&session->cmdpool);
-
 	iscsi_remove_session(cls_session);
 
+	iscsi_pool_free(&session->cmdpool);
 	kfree(session->password);
 	kfree(session->password_in);
 	kfree(session->username);
-- 
2.43.7


