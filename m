Return-Path: <stable+bounces-71763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5329677A3
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DDB2281FCF
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735232C1B4;
	Sun,  1 Sep 2024 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QQoCb2ql"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301B8364AB;
	Sun,  1 Sep 2024 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725207734; cv=none; b=Jh6/n3s1e1YS1kxvEHPI0j5eObC0hosaOrJFkVvSQAO9P5528J6Z5gNOUlESXd6g+4EDyXI6tzB59w8fSsBgg7ooBD2o51L2o9YqphJhN3E9n4ddWKRG4LwqzyI7NGnXs6DnKNuVt9eQ/nQtkMVZOocF6eqWGvpAjyHgQfeff4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725207734; c=relaxed/simple;
	bh=OptLJJ3lhI4G94b4N1wK1yd0O12UHrB1nxIZ0cDGrbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zz+GPXgynnKALFa5vuDz1DRByFcBwpI6A2IzUDKqWzSvPU1UdB0HDcxDfm6RnLs8qJFJy1mfL804vyOg/JnNAYcsOtUtcSZhM0SOilwXYb+D32AyF/wgGZvfQ2P3uWf9qQo7HyiAxtoMgAGQm+jXCSFxscjl3RFRdZ5btVxTofo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QQoCb2ql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6805C4CEC3;
	Sun,  1 Sep 2024 16:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725207734;
	bh=OptLJJ3lhI4G94b4N1wK1yd0O12UHrB1nxIZ0cDGrbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QQoCb2qlgDIRVo1SSssZ/zySrvH8W1Pk8ehxPqYgCkkFZgUGb368BGm66fRPPgCW/
	 8LI5vrS/4CjHA2vZNbKE/qALrFLUWRcxCJVOf4e9eY5TgKPE9OWrPKPyJp7PIux1NJ
	 4NvzGZrP9Ns3Csz4EJEEarhOQ8epFf9EnZyYrQ4U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Tee <justin.tee@broadcom.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 30/98] scsi: lpfc: Initialize status local variable in lpfc_sli4_repost_sgl_list()
Date: Sun,  1 Sep 2024 18:16:00 +0200
Message-ID: <20240901160804.832492848@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160803.673617007@linuxfoundation.org>
References: <20240901160803.673617007@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index e72fc88aeb40e..9da9d5ee0b8ef 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -6597,7 +6597,7 @@ lpfc_sli4_repost_sgl_list(struct lpfc_hba *phba,
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




