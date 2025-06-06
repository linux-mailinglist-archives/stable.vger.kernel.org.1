Return-Path: <stable+bounces-151624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D98C4AD052C
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 17:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8161898D8B
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF253288C3A;
	Fri,  6 Jun 2025 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pbmecGN1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA203276048
	for <stable@vger.kernel.org>; Fri,  6 Jun 2025 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749223795; cv=none; b=mG1Du0iedS3o+BwETgETnYH1KcTT/D3fc93GASPD5lUY/wUpJcYfvW5AI+TRmbOB3Ck1ZCREmsLyEm97QrTwDPkaFLfrsVH10NBufHKHC2JcL+D0CVoCTyL0hysaglTSPF6s4EAUiwq30djSHdFQdQgu8q45uuBR+vf34pMuAbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749223795; c=relaxed/simple;
	bh=v7Au4C4CPsHEk+3y2XJCnvtIlU+mBidFXKTov4cpvRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mSOEWWW4dGlDYI7RR88WekRijjPX6Nr/jk5F+DKLQ97Hs5j9MjAdjLLhTPDnHeVYQ51RzVpMqAUI8Mza8KOyYEUw1+GaJVyovcqO05Jiost37cTaw7e/J/pDk+a/JJ+5pgRoV0pqTAy01puaCN0VTcRZYgjxhRZITdLTEeJ/Hvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pbmecGN1; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ade30256175so86156666b.1
        for <stable@vger.kernel.org>; Fri, 06 Jun 2025 08:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749223792; x=1749828592; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pHKg9aReCBIhycPzMljP890R0nKClsGn0j0TZZruLEs=;
        b=pbmecGN1OqgEPpflLsZ6dogyEF3lkXEgtGQaxQLFjznGg7x3l/xQPaFD7/z6uaPZHa
         RlVxeE0SbmVxT8ACQ+xtW3FvCZQE8+YntL3kCqoBmtGcqg5pb51BSS0RNpEsarjnAGVK
         mLCDx3HjHR2QrM+NAKgq6JrGMWeJsylP13ZwGbpzWZow0/cP/9pVqZnyI07L/aPlU/Bx
         IWXvTJDPKkLo+s4fXRqNIMyUTzyF7EwcyG7moiM4NrZy+BXcqJmKpX4z9qYgDHlsHcvo
         /ik0BQ3ArHKyWkBqepM79Nv54AxgyZJbe4sa8ZXzrj4d0X8348ld/Ddn7v5ujqMO84Fg
         RY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749223792; x=1749828592;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHKg9aReCBIhycPzMljP890R0nKClsGn0j0TZZruLEs=;
        b=aIUsradhCsH0+NPkWRRy9IrqvzpaQdfhlIQY46sw6v0jqmKhRh+ZsM4mhh3zwsdxqE
         Nez1IeobzoeI3PyBt93Oy+q70TkPpslqTPGmym5z5IRFSs5ndR8dhb8DMUTMzAyLDfJx
         zDedf1NXzkAzEhdiwgu05PUXA5+blonDZERwcgL1pGjxLE6UK47QYWHKPTA/kIt0Uvug
         /fhJ3F1gQlCZH0Lu/jkaPBF1SGggTiL04jC4ZSwqGhcq2jUpS0gP6mUKRimXxfMRxNAI
         Rj/Kb0RSKpaiIbIsfQ1W7DjNvMqFtnvqs6umoaw221k3Vr+9AxOv7TiWCBwJk1on/BCK
         c0Xw==
X-Forwarded-Encrypted: i=1; AJvYcCW/rFxe4wzD4HiouUN6M/jQ6UY4QxZ/Fyk5PuInoPfNJzYunEqJQvL2gY28d0tPT1RRN/QRoNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVUv0Fp2tYL8AcAj9PLR18OUAb8kLW6/+hV5enq81UoyFZmcYe
	2cu0FWwNZslRejGmfWC05XdjaR/Uzz9roeT6uBWLzJGb90ivIUT8LbkbsbFHLNG1les=
X-Gm-Gg: ASbGncsHDgRPWR8aGwD8R9mZQinYaLaEumBDy2QwMIDZzMAVgXlX8wjIeY3iwAfeHpc
	j/YXxJmtCiLeG0/Rizg1WhMByMje89nShmS8UyLbljtTJrufNwyDowXCGTwGR/UKHNjkskgeMZU
	rKVfB7zzUrHEVDfme/Ez/H83q8M6JfS9j2IHF8RVX16aCIUwFF4k5qxE4NYN7UwaAWRS38K1YTL
	Ww9VZdREfROj5VxgEzFORJA+JUpAMWhC7tgj0w6IxLxuH8EO3C7yWSnKSON6f3a7qUZjDvKLxrm
	ksycGr/HvJO4siMDCle345g3Zu+i8Fi3+VAAi0lHcTKKWkYx1uQpWOxzDn6CYfKq2adWzqolWt2
	wGFaXDboJJPnIEF83LM1zy0tc0gsd48xsX+OEqGAgtOiS/w==
X-Google-Smtp-Source: AGHT+IFIbqOwQmbDQEe3E/wlxCxAjm4JmZX9I8K8ar5M7fYX/U4wmJP0R3iG9BUeJ0Tu3p9r9nBSjg==
X-Received: by 2002:a17:906:9fc7:b0:ade:8df:5b4d with SMTP id a640c23a62f3a-ade1a9329dcmr347910366b.15.1749223792241;
        Fri, 06 Jun 2025 08:29:52 -0700 (PDT)
Received: from puffmais.c.googlers.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1d754913sm130801166b.4.2025.06.06.08.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 08:29:51 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 06 Jun 2025 16:29:43 +0100
Subject: [PATCH] scsi: mpt3sas: drop unused variable in
 mpt3sas_send_mctp_passthru_req()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250606-mpt3sas-v1-1-906ffe49fb6b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGYJQ2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMwMz3dyCEuPixGJdQ1NTM2MLA8s0cwNTJaDqgqLUtMwKsEnRsbW1AGY
 q/l5ZAAAA
X-Change-ID: 20250606-mpt3sas-15563809f705
To: Sathya Prakash <sathya.prakash@broadcom.com>, 
 Sreekanth Reddy <sreekanth.reddy@broadcom.com>, 
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, MPT-FusionLinux.pdl@broadcom.com, 
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

With W=1, gcc complains correctly:

    mpt3sas_ctl.c: In function ‘mpt3sas_send_mctp_passthru_req’:
    mpt3sas_ctl.c:2917:29: error: variable ‘mpi_reply’ set but not used [-Werror=unused-but-set-variable]
     2917 |         MPI2DefaultReply_t *mpi_reply;
          |                             ^~~~~~~~~

Drop the unused assignment and variable.

Fixes: c72be4b5bb7c ("scsi: mpt3sas: Add support for MCTP Passthrough commands")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index 02fc204b9bf7b276115bf6db52746155381799fd..3b951589feeb6c13094ea44b494ca3050a309b15 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -2914,7 +2914,6 @@ int mpt3sas_send_mctp_passthru_req(struct mpt3_passthru_command *command)
 {
 	struct MPT3SAS_ADAPTER *ioc;
 	MPI2RequestHeader_t *mpi_request = NULL, *request;
-	MPI2DefaultReply_t *mpi_reply;
 	Mpi26MctpPassthroughRequest_t *mctp_passthru_req;
 	u16 smid;
 	unsigned long timeout;
@@ -3022,8 +3021,6 @@ int mpt3sas_send_mctp_passthru_req(struct mpt3_passthru_command *command)
 		goto issue_host_reset;
 	}
 
-	mpi_reply = ioc->ctl_cmds.reply;
-
 	/* copy out xdata to user */
 	if (data_in_sz)
 		memcpy(command->data_in_buf_ptr, data_in, data_in_sz);

---
base-commit: a0bea9e39035edc56a994630e6048c8a191a99d8
change-id: 20250606-mpt3sas-15563809f705

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


