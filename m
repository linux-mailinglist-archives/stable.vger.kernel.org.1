Return-Path: <stable+bounces-137783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF26FAA14FD
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212931BA2CB0
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524312512D7;
	Tue, 29 Apr 2025 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ku7VJiOw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F77921ABDB;
	Tue, 29 Apr 2025 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947115; cv=none; b=jrog+CFe08/bOdcHbuQICASRDkO/OaATa3c7wGIukGzpzijo59SFGvBW94j7wTl2HtBwLHDcWi730Z57jcaVYiv/5ZQMemCcTYT4S/51Pcso+zNdJIkUTzuo3aDgFfVmm1aQ/GLDrCVG4qlMr7rAGIlh1aXl/gpFYRUljYsyYIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947115; c=relaxed/simple;
	bh=Ge4kmdqfT5QjOf8EFair+b8bAofH51j1T67RDX9N32o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqi0nYsXfEVsxCrCA8nSU/jK0XylDOwv1gkjGREhTZ59N92QXHCqzrjRzOc16agVaOJ8Xoa0ECxS8rkApm3D1b895fWoZ4m8tAJQa27dLOHmFSUO93kgNnVY88aNSV/P8grdke77YfdXbLKMl8QeNwENktRat5tkGW3//YYcTHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ku7VJiOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7222CC4CEEE;
	Tue, 29 Apr 2025 17:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947114;
	bh=Ge4kmdqfT5QjOf8EFair+b8bAofH51j1T67RDX9N32o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ku7VJiOw/MwESOG3apuwKHYVTu0K0x/TW+0xrnbRA3yfqZCq/SynQAm06/Hx2b1bJ
	 GrTaXmfn5CTZOTyM+FiukUvlnCrth0oRpJlRPipMwxWIm1i1iIXLMFgKMC7KzcyTFK
	 zmvzE5r3UfKJY4x2T5pnYgJvWtZaxtqZ0HKQyJm8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	BassCheck <bass@buaa.edu.cn>,
	Tuo Li <islituo@gmail.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bin Lan <bin.lan.cn@windriver.com>,
	He Zhe <zhe.he@windriver.com>
Subject: [PATCH 5.10 177/286] scsi: lpfc: Fix a possible data race in lpfc_unregister_fcf_rescan()
Date: Tue, 29 Apr 2025 18:41:21 +0200
Message-ID: <20250429161115.179634974@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tuo Li <islituo@gmail.com>

commit 0e881c0a4b6146b7e856735226208f48251facd8 upstream.

The variable phba->fcf.fcf_flag is often protected by the lock
phba->hbalock() when is accessed. Here is an example in
lpfc_unregister_fcf_rescan():

  spin_lock_irq(&phba->hbalock);
  phba->fcf.fcf_flag |= FCF_INIT_DISC;
  spin_unlock_irq(&phba->hbalock);

However, in the same function, phba->fcf.fcf_flag is assigned with 0
without holding the lock, and thus can cause a data race:

  phba->fcf.fcf_flag = 0;

To fix this possible data race, a lock and unlock pair is added when
accessing the variable phba->fcf.fcf_flag.

Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
Link: https://lore.kernel.org/r/20230630024748.1035993-1-islituo@gmail.com
Reviewed-by: Justin Tee <justin.tee@broadcom.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_hbadisc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -6790,7 +6790,9 @@ lpfc_unregister_fcf_rescan(struct lpfc_h
 	if (rc)
 		return;
 	/* Reset HBA FCF states after successful unregister FCF */
+	spin_lock_irq(&phba->hbalock);
 	phba->fcf.fcf_flag = 0;
+	spin_unlock_irq(&phba->hbalock);
 	phba->fcf.current_rec.flag = 0;
 
 	/*



