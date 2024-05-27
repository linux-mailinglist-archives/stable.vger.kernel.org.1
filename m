Return-Path: <stable+bounces-46795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 625C98D0B4D
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C959283EA7
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D2217E90E;
	Mon, 27 May 2024 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IUFlajIw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3E215FD04;
	Mon, 27 May 2024 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836875; cv=none; b=j3RVHDzgnlvpIhFff+Sxlt9TElOWkyevbaX8gn76dHZO0btMQqENTrLXSPAUWXB+tIQ26+jSTULX7SJPqpZRjZ86wtylEEra4hOLZDX2tGilAN3TSdKx+0wIbJfQfBCFPE9wXcJKDE9mvY05RhC/LYP3VUSlUDt1gnuS37cFSZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836875; c=relaxed/simple;
	bh=WDj2G4CvoyyJNd7QF78dcu5rt/tK2M1AGJhHMfonP5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwCjG6LOiwkIp4MIXDjWHAAI9Y0gG8GpTKvn4DtL2cCAfXjLgo3qSHIeSFujTME95z1a3BI+lPJnDnmwwvX22Wb9oe2rDccjIlmgKaLu5bzzcaC0WAUhUZT8Z9n+vm3HPbLj2tdT5jYSeDZezcxowjr9XxPjeHwSx9X98Ejnqzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IUFlajIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63ABC2BBFC;
	Mon, 27 May 2024 19:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716836875;
	bh=WDj2G4CvoyyJNd7QF78dcu5rt/tK2M1AGJhHMfonP5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IUFlajIwcyHVGvzXGAbWclD1l7V2uP8HT4DoKD5DwHqkF7nOWQv4xDLveSOtxR1mp
	 iqqnXfa1W1DJYOg/itvr1YsZRakxEiTfAnGFBklKfilI0J8hhsCcyQgaVj4IcgJ0TQ
	 5doRyk85+VLMwO/Mp5DjG26QlKravLhmcEFXXMV4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 220/427] scsi: qla2xxx: Fix debugfs output for fw_resource_count
Date: Mon, 27 May 2024 20:54:27 +0200
Message-ID: <20240527185623.099579454@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

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




