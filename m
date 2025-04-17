Return-Path: <stable+bounces-133762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D271FA92752
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231FD3AC2CB
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA7025F79E;
	Thu, 17 Apr 2025 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n0ZKMjfE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27DF2571D5;
	Thu, 17 Apr 2025 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914064; cv=none; b=hgKeBIRlLJAhAKD8NRdNijel5noMie/16GHhNpzCdDm4Es4/WHa+TMtpMfdxEJ0/0nk2bu0tdnejzFWd1QnP7MkHZyTztqa5m9z2c7obyF5CB46h1aotNvwu5Y/Ee6jfTvSHHewZQNC9yyMB7TfFBK7e9lOolTS5FFMhLmaSVmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914064; c=relaxed/simple;
	bh=uP3HDRBPdow2G091PCKx41Nlda//iRV+o1wunAfdm3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJcP38HKsPXRY+tzXZr/eZnK+FHCi8FvW75025OVB7yOF4seDzEhjxFLwpxjGhrqPN1W0bIjJCFYXxvFSLwLIApwtz2HSxtTZJ111dk6k17KOCMGyHuUm9kLaQrCPtVBU6nmnubomKTKw4mQ+bxEA+RX17D01LCkeOstbQPQRw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n0ZKMjfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD77C4CEE7;
	Thu, 17 Apr 2025 18:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914063;
	bh=uP3HDRBPdow2G091PCKx41Nlda//iRV+o1wunAfdm3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n0ZKMjfEGtP3TdpKY5yCIwZ0mBXSYVj6fEun5PX3KE5DEbFjOgYVM0LJBanNqMSKM
	 q2fzD+KtYdM486lrll8snaRsmQc/Xgnx+n2ONEWzVFt4hFfNDBLyY+7UEPbhNlo5a/
	 dk9PUNT6gj0AAmDxdwOrFS6+W8usXneZAqEzRZFM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chaohai Chen <wdhh66@163.com>,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 094/414] scsi: target: spc: Fix RSOC parameter data header size
Date: Thu, 17 Apr 2025 19:47:32 +0200
Message-ID: <20250417175115.222282248@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chaohai Chen <wdhh66@163.com>

[ Upstream commit b50532318793d28a7628c1ffc129a2226e83e495 ]

The SPC document states that "The COMMAND DATA LENGTH field indicates the
length in bytes of the command descriptor list".

The length should be subtracted by 4 to represent the length of the
description list, not 3.

Signed-off-by: Chaohai Chen <wdhh66@163.com>
Link: https://lore.kernel.org/r/20250115070739.216154-1-wdhh66@163.com
Reviewed-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_spc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/target_core_spc.c b/drivers/target/target_core_spc.c
index ea14a38356814..61c065702350e 100644
--- a/drivers/target/target_core_spc.c
+++ b/drivers/target/target_core_spc.c
@@ -2243,7 +2243,7 @@ spc_emulate_report_supp_op_codes(struct se_cmd *cmd)
 			response_length += spc_rsoc_encode_command_descriptor(
 					&buf[response_length], rctd, descr);
 		}
-		put_unaligned_be32(response_length - 3, buf);
+		put_unaligned_be32(response_length - 4, buf);
 	} else {
 		response_length = spc_rsoc_encode_one_command_descriptor(
 				&buf[response_length], rctd, descr,
-- 
2.39.5




