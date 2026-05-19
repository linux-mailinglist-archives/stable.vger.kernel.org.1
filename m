Return-Path: <stable+bounces-249486-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJv7Fo0UDGoZVQUAu9opvQ
	(envelope-from <stable+bounces-249486-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:43:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F34595794E3
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A7A7302471A
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662413DA7E0;
	Tue, 19 May 2026 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="fcibrqSu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D540E3D967D
	for <stable@vger.kernel.org>; Tue, 19 May 2026 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779176585; cv=none; b=LmPcPGAhK3AAeZuydhInXQAXWc5zioD46xAahoeXA45wAFjwGHktJ//CDRbRCwNeqHkY3BRIbf/TS4Oyj+vz9EHWlJHNNeZVGooYVxXZtTJf0hvkZLvUfc7j4cr4PJbqfVRfA3C9PsAtVpl5u4pcRhFaYH2nzMH8m16hGqDQPGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779176585; c=relaxed/simple;
	bh=PqBOXKIcL2LFH254HZC8CVkLl+stNhZQ5ZbAKeES868=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XTRaDGizeykLkz9Qjtg0WvEx07iT4FnCgGMQmvHbOP/Q2fVubW37xd2ubW1oGss+viilXa3NuM6u+UsfapCpmhFsv5MSQLwAZYUazFf2jP7CH2FIgbKuTBwskisDiqr57sLmZ0DepHv3Yzo0u7sunNXE/1cREUiVxRaUydxnDeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=fcibrqSu; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-83d5bbef760so1346136b3a.1
        for <stable@vger.kernel.org>; Tue, 19 May 2026 00:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1779176582; x=1779781382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g/tERIhcgTY407JXDkFbxFgApJOVjg4hy+8W+lvT7Ww=;
        b=fcibrqSuE6qyEsDuG9FMrvdHztLMUk42O/jagA/vo8hLB09lWyKo6ljvNwpjWK2an9
         xKlTUlMlYADUKa6xCE+KFseSaCPvD8pZxO12gPo8lKY9qfKp5/yqdKaVFG2M6LNr+6d4
         9KgShMzZy8gcMk/2iDVERHM5MbsYnxnew9wwwt6HqqbSXcKq56ztT3+pjGWUeo1qyfXi
         RonPNy0l1157I5JgY/5NYAj5v0EjvPHqTwHGgVFNL5zKXU3AxkLzBnweAWgLPaeNCkIR
         IU1KfRxcHEyU0ZFX8uZauyqxq3OL/NAeHURmmF/aLQAE+ZcW3NBxpsZfJFNhLfUFFyTs
         Q1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779176582; x=1779781382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/tERIhcgTY407JXDkFbxFgApJOVjg4hy+8W+lvT7Ww=;
        b=lh0DoiFv7iSwMHsttDdH3Xm5Q89FTXTzgBMBDIpZFuoE64s9hIw/Mv+xwoi6Ja/9FP
         iKWL8vK4Jsi3e5sayCjqRCFMydGuf3Z3x/ClbNjHpYRoS8ed+whdGnNT5dbejEJe3rTy
         JWLhXML1w4g7iVE7QDsq1Zi+96d7ZXLRDtIOH12EE9PFptLwrLKL2cJnqGVQPV9oXZ2o
         jWRaSqBYXPPz10/b9u/rCMN31NqJLNyTiWOXo60aV9i5mlEeRCUn2m9/yOmW2+8Cbzph
         7zrtDF7Yf6AmDt8wbumGwptDyfRZ93e7bUn9IC1UHNVsuCXjt5Kmzx8BsZfFfmjLf/GT
         3RBA==
X-Forwarded-Encrypted: i=1; AFNElJ8/Zz+Bj2LxH4gWwvsSUdhdC0NBDsgr+M3ISBmdIVZnDUJZzUjP3llTkT3ZeqmWhWT9DSvmHxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6AzR0aQZFMN2vbAYXuhQ3LinoQKjkDI3o+8HOnFZY9sC9hdKY
	953T8qTWw1x/silNwEX4YKYGqZMdmmTF+Qljw5GesBlmzmjdedsBWTBDqEdIGM26Nz0=
X-Gm-Gg: Acq92OFIP9pwYBE1/N5SmqCfQvqFSUoUGSgYMYggb86vt6zHdUk49w9cYb97LTar5xo
	/st7zcEfp8wRuhXztEuLPdfJRAs7tQzioObeluchaNaMIkH78e0ApzXrfhGwSOGdz8SdCauK4f5
	nSsb5C9/+RqT3X2At3Vw3rIX79fQoMkRiu2wPHj/knk9L5CEthgE7Y90SVZYfJ8rVXtWvMTA5Tk
	jpc9NAcDvHe16SD9NfRWWkMGh3p04a52oGMK0hc09vjOsDiO+pwUhVS0pTRxLxPX69ZwEznv6Rc
	BzlQK8XD+ZPIIHhF3B6Rob5rI/sLC4ChNkj5yHhF/6n+ci1iP9IEM7Txgn0oBgELvbq81WV4LOf
	89FJB3RnnKMzJBLhKNkoMkNy+wI6vt7NukOrnnKR/6qMPz8Gt8uFBWfHDXP7ymNAoNAzQNVup1w
	91DyiKX329Sb+dg6ViEWpnpqJnLOV0S32MP1RvyYnUv4kShyRDaPec2MVUsZITdP+V75hW/Bvid
	eP+CYjZniGSeYyWs/TqltWT9kBxEWrmO5jHXGYQ3olPn0/2CN2HFj2YEQ==
X-Received: by 2002:a05:6a00:1908:b0:834:df57:9d67 with SMTP id d2e1a72fcca58-83f33cf0bddmr18987872b3a.32.1779176581994;
        Tue, 19 May 2026 00:43:01 -0700 (PDT)
Received: from localhost.localdomain ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-83f19f7cc9asm21029127b3a.53.2026.05.19.00.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 00:43:01 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: justin.tee@broadcom.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	paul.ely@broadcom.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jsmart2021@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] scsi: lpfc: fix potential memory leak in lpfc_read_object()
Date: Tue, 19 May 2026 13:12:28 +0530
Message-ID: <20260519074230.110624-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249486-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cse.iitm.ac.in,broadcom.com,HansenPartnership.com,oracle.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,cse.iitm.ac.in:mid]
X-Rspamd-Queue-Id: F34595794E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The memory allocated for sge_array inside lpfc_sli4_config() which is
attached to mbox, is not freed in one of the error path in
lpfc_read_object(). Fix that by calling lpfc_sli4_mbox_cmd_free()
instead of directly freeing the mbox.

Fixes: 72df8a452883 ("scsi: lpfc: Add support for cm enablement buffer")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/scsi/lpfc/lpfc_sli.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index d38fb374b379..fe7d9942ebd2 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -22302,7 +22302,7 @@ lpfc_read_object(struct lpfc_hba *phba, char *rdobject, uint32_t *datap,
 		pcmd->virt = lpfc_mbuf_alloc(phba, MEM_PRI, &pcmd->phys);
 	if (!pcmd || !pcmd->virt) {
 		kfree(pcmd);
-		mempool_free(mbox, phba->mbox_mem_pool);
+		lpfc_sli4_mbox_cmd_free(phba, mbox);
 		return -ENOMEM;
 	}
 	memset((void *)pcmd->virt, 0, LPFC_BPL_SIZE);
-- 
2.43.0


