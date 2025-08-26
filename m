Return-Path: <stable+bounces-175239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E344B367F8
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0006A8E1813
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4D4352071;
	Tue, 26 Aug 2025 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tGrzekZF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E86350838;
	Tue, 26 Aug 2025 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216510; cv=none; b=lPEDHpdRY8D5oqLwbzZROJpQPQ0XaU6NejbYWPiUhz0GU3xgbB+tuwyDOld8WK9Jid4T5KnWAT2EscnYIYN5dW0qBHZnohyI779Ikaqa6O+wjzHryY55b7W9nWx0uOwOOMEE8KwJOafcJYj9/SB2ujlsRp+mbI5OCKZ3gwi5WgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216510; c=relaxed/simple;
	bh=MrF3xe6+BYtDFLLut41tIrEGRlVZo++caH/J80l5+RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ewzi2HXeI5LJ73o6THFodAKpa8Iy7EJpbLxSsUDnPFcB4jOvklUzV/XG+0Wt6B6xCyxsQwSCKUsDJ0wFSVKAURsVhm4AICVaKEGl8vi/W7S8q0PreAKyLh3Ux+qw1CETZVdJOadcxTqKcVlJiYruo7VWcVXRCaVb8eIOYvoFn2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tGrzekZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E993EC2BC87;
	Tue, 26 Aug 2025 13:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216510;
	bh=MrF3xe6+BYtDFLLut41tIrEGRlVZo++caH/J80l5+RU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tGrzekZFQY5VB4CS6BuyBUg+7q4Apg93H+5teMRnVQqPyqPEDXW4johF42/ygpQbl
	 qVPj6a1jxRLsRcQuuMQA9d0q6gLt/dLBOe+m+vL67gDaYG3SJbMGcDvuy92hmWlbpe
	 75I6wt/A9NYvbfiqXGoqbPDoJJnINhXnB+px8CuU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Tee <justin.tee@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 401/644] scsi: lpfc: Check for hdwq null ptr when cleaning up lpfc_vport structure
Date: Tue, 26 Aug 2025 13:08:12 +0200
Message-ID: <20250826110956.388387449@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit 6698796282e828733cde3329c887b4ae9e5545e9 ]

If a call to lpfc_sli4_read_rev() from lpfc_sli4_hba_setup() fails, the
resultant cleanup routine lpfc_sli4_vport_delete_fcp_xri_aborted() may
occur before sli4_hba.hdwqs are allocated.  This may result in a null
pointer dereference when attempting to take the abts_io_buf_list_lock for
the first hardware queue.  Fix by adding a null ptr check on
phba->sli4_hba.hdwq and early return because this situation means there
must have been an error during port initialization.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20250618192138.124116-4-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_scsi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index d9fb5e09fb53..520491a8b56e 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -454,6 +454,10 @@ lpfc_sli4_vport_delete_fcp_xri_aborted(struct lpfc_vport *vport)
 	if (!(vport->cfg_enable_fc4_type & LPFC_ENABLE_FCP))
 		return;
 
+	/* may be called before queues established if hba_setup fails */
+	if (!phba->sli4_hba.hdwq)
+		return;
+
 	spin_lock_irqsave(&phba->hbalock, iflag);
 	for (idx = 0; idx < phba->cfg_hdw_queue; idx++) {
 		qp = &phba->sli4_hba.hdwq[idx];
-- 
2.39.5




