Return-Path: <stable+bounces-47289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD47F8D0D63
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697E1280D31
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C6116079A;
	Mon, 27 May 2024 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nvolhgX/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0C1262BE;
	Mon, 27 May 2024 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838157; cv=none; b=Z9Qn4NT9ey1vs09kCKbK2LNc55W0Dg8gVPRQUTSzVggIyezlxtt55QFfmBZHtHE30Ycuz/wVX/2vZqSLDBmo4axo5JKwyhsNVAajdT+pkFHiL3N+ssx68Iw72dozLF9cNX+pzljYJ+O89wc0S3lBnIOmo7qz1vCHoixZCG6E7rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838157; c=relaxed/simple;
	bh=GH25DuIXRs1EwL4uTVmTDb7CwPgak/nK+wIbHf0OejA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mykvNJIspAF/YB+G/R29X1X3Pa03QCqI0wi/2LrokwDteXLdrevZLrZnK5zuyehNioC10nmQZ+oDMn1uCyNU6hugYcfauquDNTOq24aWfOMf/yVhbwCWA4i/Q12Eq30KvvvZ5MYcICiUlx++STWMXhe6taXxcdxNNCa3jiVmSRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nvolhgX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1478FC2BBFC;
	Mon, 27 May 2024 19:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716838157;
	bh=GH25DuIXRs1EwL4uTVmTDb7CwPgak/nK+wIbHf0OejA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nvolhgX/1IZAe8P8MfxPZpC+mgbtzvbDUgJtVM4k51Tpq5XCxOVnfrVUZknrgL4P1
	 4ic8DpzToyOXPE947lPDwY55wQ9QBloeWUyvZkFz+x3DlKftbmACeq4WbwrxLj0JML
	 Z+PvqGwnj8bUWIXlzazpAQ15Qlpqb4/wfOPwEHnw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 288/493] scsi: qla2xxx: Fix debugfs output for fw_resource_count
Date: Mon, 27 May 2024 20:54:50 +0200
Message-ID: <20240527185639.737957307@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Himanshu Madhani <himanshu.madhani@oracle.com>

[ Upstream commit 998d09c5ef6183bd8137d1a892ba255b15978bb4 ]

DebugFS output for fw_resource_count shows:

estimate exchange used[0] high water limit [1945] n        estimate iocb2 used [0] high water limit [5141]
        estimate exchange2 used[0] high water limit [1945]

Which shows incorrect display due to missing newline in seq_print().

[mkp: fix checkpatch warning about space before newline]

Fixes: 5f63a163ed2f ("scsi: qla2xxx: Fix exchange oversubscription for management commands")
Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Link: https://lore.kernel.org/r/20240426020056.3639406-1-himanshu.madhani@oracle.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_dfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_dfs.c b/drivers/scsi/qla2xxx/qla_dfs.c
index 55ff3d7482b3e..a1545dad0c0ce 100644
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -274,7 +274,7 @@ qla_dfs_fw_resource_cnt_show(struct seq_file *s, void *unused)
 		seq_printf(s, "Driver: estimate iocb used [%d] high water limit [%d]\n",
 			   iocbs_used, ha->base_qpair->fwres.iocbs_limit);
 
-		seq_printf(s, "estimate exchange used[%d] high water limit [%d] n",
+		seq_printf(s, "estimate exchange used[%d] high water limit [%d]\n",
 			   exch_used, ha->base_qpair->fwres.exch_limit);
 
 		if (ql2xenforce_iocb_limit == 2) {
-- 
2.43.0




