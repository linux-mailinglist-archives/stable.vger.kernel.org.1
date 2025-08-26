Return-Path: <stable+bounces-176209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2846EB36AC9
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A6EA4E236F
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6973335CEBB;
	Tue, 26 Aug 2025 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E7Yw6kVi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258622FC89C;
	Tue, 26 Aug 2025 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219063; cv=none; b=SMG4gH7E5rt21v7XGrKRycb8Nb8syfmhV290Fubk35cV8epGzzpz/BrZWxsIjVUJmKlsqRlnN1JC7uJUhHta7FzUzwFD1/gpBbWVK6t6ntvQESYeznGEZOqOxhvFkGHsMisqhfQTOxO/bysacy4SQHsd+ybBWLNqoB/S7usPE3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219063; c=relaxed/simple;
	bh=+N8TTiyzbvBN21cRR2sg/RUKXPNmUJyXMqe9JNkzPTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfJIripSq3XDD3Nh+KrVfk2WEZX4X832FhLQtFNMBWaHholaAStwSuc6cd/io1ZdtMyu56f3xDF078ifWhmtZGPj/YEPOPJu0rnjeVD98Kyv4449QIoJ8xcTeq4/CmZWLr85QXHsNL7vcXuSgKTRGz7y9JNAY0rCmkjOvhdIHPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E7Yw6kVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1CBC113CF;
	Tue, 26 Aug 2025 14:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756219063;
	bh=+N8TTiyzbvBN21cRR2sg/RUKXPNmUJyXMqe9JNkzPTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E7Yw6kVi+z6DTlqggm4ZJo0DWTs6RXtwYPnH+yeU3IDoKkzWJzp058lMcKtbprLZf
	 2QXXm/Ak14J706q7p1OnPJItAol+Q0Abh0JVzNev6pSotRFQqWA7+J+j1RaDZh6kL6
	 cxCIgIb2Tbut7AlGTTwp7Fl34xw9zk7QlGdt2X3w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	jackysliu <1972843537@qq.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 238/403] scsi: bfa: Double-free fix
Date: Tue, 26 Aug 2025 13:09:24 +0200
Message-ID: <20250826110913.409457595@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: jackysliu <1972843537@qq.com>

[ Upstream commit add4c4850363d7c1b72e8fce9ccb21fdd2cf5dc9 ]

When the bfad_im_probe() function fails during initialization, the memory
pointed to by bfad->im is freed without setting bfad->im to NULL.

Subsequently, during driver uninstallation, when the state machine enters
the bfad_sm_stopping state and calls the bfad_im_probe_undo() function,
it attempts to free the memory pointed to by bfad->im again, thereby
triggering a double-free vulnerability.

Set bfad->im to NULL if probing fails.

Signed-off-by: jackysliu <1972843537@qq.com>
Link: https://lore.kernel.org/r/tencent_3BB950D6D2D470976F55FC879206DE0B9A09@qq.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/bfa/bfad_im.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/bfa/bfad_im.c b/drivers/scsi/bfa/bfad_im.c
index 22f06be2606f..6dcf1094e01b 100644
--- a/drivers/scsi/bfa/bfad_im.c
+++ b/drivers/scsi/bfa/bfad_im.c
@@ -707,6 +707,7 @@ bfad_im_probe(struct bfad_s *bfad)
 
 	if (bfad_thread_workq(bfad) != BFA_STATUS_OK) {
 		kfree(im);
+		bfad->im = NULL;
 		return BFA_STATUS_FAILED;
 	}
 
-- 
2.39.5




