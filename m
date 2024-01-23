Return-Path: <stable+bounces-15416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42598838525
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3FA28A7CA
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E27A7E57C;
	Tue, 23 Jan 2024 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mqo3dGen"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E357380;
	Tue, 23 Jan 2024 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975751; cv=none; b=sW+Dt0M8YJk/LCYAHel062n1E2EOCg2rhy0/TeommivvY448b5xLf2B6SmA5xETRrybXNaD26VOtnII+iDEcRjO/pC+1Etp+iEwP6sxZ4oi0FC8s+zJpXbHcS9NVo6MmzFoa5vNhykUFDp4ELBw4r23Y3FtOnJ3UeJIK7CCukaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975751; c=relaxed/simple;
	bh=q+RA+63soFugkpE4RuTTwsyUrlXv7Nszlo0bkyzTaHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FitSXrsc1bPybSRvAWPb+WDtO47iB/Y2uSfGHGON5LxKUl5ZznZUCOTaT/xD1ElRB6ZcQafq9t6d+WDQX2Lj61dIorRgeIZF4LVgLjAvxNLK1tkQmmBSnFnZUFNuiYqcZThsx27HZkyF9xSAV4AV79lbpspVuqexBn/gkNXZnek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mqo3dGen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11558C433C7;
	Tue, 23 Jan 2024 02:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975751;
	bh=q+RA+63soFugkpE4RuTTwsyUrlXv7Nszlo0bkyzTaHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mqo3dGenjDE4FcEHmlfuW30zK1KRlW+ycoKesyg1JbIjKbVxuIRcyjgATenkr4n76
	 DPvHpZTK5i5PqLn+TKo78bwzKkzrQXb26lIqtqjTY1BFimVp/WgeI9wrYgBy21gjJG
	 4cV4bTWVY2iVziU/kbCrD0zijeFgUY5kxPkC0JjE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 518/583] nvme: trace: avoid memcpy overflow warning
Date: Mon, 22 Jan 2024 15:59:29 -0800
Message-ID: <20240122235827.928667686@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit a7de1dea76cd6a3707707af4ea2f8bc3cdeaeb11 ]

A previous patch introduced a struct_group() in nvme_common_command to help
stringop fortification figure out the length of the fields, but one function
is not currently using them:

In file included from drivers/nvme/target/core.c:7:
In file included from include/linux/string.h:254:
include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
                        __read_overflow2_field(q_size_field, size);
                        ^

Change this one to use the correct field name to avoid the warning.

Fixes: 5c629dc9609dc ("nvme: use struct group for generic command dwords")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
index 155334ddc13f..974d99d47f51 100644
--- a/drivers/nvme/target/trace.h
+++ b/drivers/nvme/target/trace.h
@@ -84,7 +84,7 @@ TRACE_EVENT(nvmet_req_init,
 		__entry->flags = cmd->common.flags;
 		__entry->nsid = le32_to_cpu(cmd->common.nsid);
 		__entry->metadata = le64_to_cpu(cmd->common.metadata);
-		memcpy(__entry->cdw10, &cmd->common.cdw10,
+		memcpy(__entry->cdw10, &cmd->common.cdws,
 			sizeof(__entry->cdw10));
 	),
 	TP_printk("nvmet%s: %sqid=%d, cmdid=%u, nsid=%u, flags=%#x, "
-- 
2.43.0




