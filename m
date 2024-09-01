Return-Path: <stable+bounces-72509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4C1967AEB
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 19:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59EDC1C21520
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 17:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BB8376EC;
	Sun,  1 Sep 2024 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gCz0sixs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F79A17B50B;
	Sun,  1 Sep 2024 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725210156; cv=none; b=DJ5Rq077uCmIn+6VOUm6UwHXzgCaSBe10IZ6s2SHS0gmM0a0jvy9XRtNhyyofBMDVhxElMw5wR8QDbibDlyI1vDeqxpzAY76FG0A1GhSNHO+LO1GM3gLIG7np4Bxnq0Mj61shAp2FMfyCwuZ0pPp6LPEJ8h80zVACLeRLHVJw78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725210156; c=relaxed/simple;
	bh=1HHSLjbvoZEW8AxHaPCjiIkj3pheG2oL/1EZaecGoaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pm6kwcV2QuMTn7aA0PnK52iTmtyTCZ0cfuilT4bCQGRZ0dPh7Km7vPxvyAZZAAW9JfStYojaz7cQAr535+d4OoFPYWYD3Vxyz1oQ7hyopNUlwUvvKCX/DQ5CUh9yGe2s9i78RbwzsjO0V543qI3yy3m2LdcTtYWkn314ZmU5IgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gCz0sixs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1ADEC4CEC3;
	Sun,  1 Sep 2024 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725210156;
	bh=1HHSLjbvoZEW8AxHaPCjiIkj3pheG2oL/1EZaecGoaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gCz0sixs4Gxh7uTxGFuNn7IK3YGQHdMNxjRJG5gW/lTltNd+nilADh/v6d884Ayuk
	 6n5cvwj5CNnvwVXnTg7V+H0A1F+K810yvOWl2HPmc4p/3H+qua85qTag/QfslsGzmT
	 vCaF5N7fpxsr8ygAAHvjAyP9Gw6DVsxhK+pDI2vs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Tee <justin.tee@broadcom.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 074/215] scsi: lpfc: Initialize status local variable in lpfc_sli4_repost_sgl_list()
Date: Sun,  1 Sep 2024 18:16:26 +0200
Message-ID: <20240901160826.149932580@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160823.230213148@linuxfoundation.org>
References: <20240901160823.230213148@linuxfoundation.org>
User-Agent: quilt/0.67
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

[ Upstream commit 3d0f9342ae200aa1ddc4d6e7a573c6f8f068d994 ]

A static code analyzer tool indicates that the local variable called status
in the lpfc_sli4_repost_sgl_list() routine could be used to print garbage
uninitialized values in the routine's log message.

Fix by initializing to zero.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20240131185112.149731-2-justintee8345@gmail.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_sli.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 30bc72324f068..68b015bb6d157 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -7490,7 +7490,7 @@ lpfc_sli4_repost_sgl_list(struct lpfc_hba *phba,
 	struct lpfc_sglq *sglq_entry = NULL;
 	struct lpfc_sglq *sglq_entry_next = NULL;
 	struct lpfc_sglq *sglq_entry_first = NULL;
-	int status, total_cnt;
+	int status = 0, total_cnt;
 	int post_cnt = 0, num_posted = 0, block_cnt = 0;
 	int last_xritag = NO_XRI;
 	LIST_HEAD(prep_sgl_list);
-- 
2.43.0




