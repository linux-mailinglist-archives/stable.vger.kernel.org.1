Return-Path: <stable+bounces-39030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0DB8A118C
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79D01B26337
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51D3146A71;
	Thu, 11 Apr 2024 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eCcyAFga"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946696BB29;
	Thu, 11 Apr 2024 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832310; cv=none; b=hXJniEDzzpaJL6xRe5G+5TqcraNGFUCQoHg7rIWAM/uCR3M07MDrrntbDaqgYCsvRxYF7u6qiSxeb2lw0zCaKWqRg3C16sDxnGktfc5NjynpcR1y1407wf2p2YoiggMjpEGx8b4h2JNqYDCRxtnT/Y1vTr2sVPj2DS3GMMFgNpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832310; c=relaxed/simple;
	bh=AF7aP4+pV3+UcW13AlhODCEq3YVbOyRj3FmeWUytuCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGlgnTYEEjmboBC646aFJ8DtFoaOGkPOu+YZ39TcAMZRnD+vegOH060VJqoQvZWaH8+9aGzM5xEov4jOjo4knE+cHqi6BRqEMPaMvDESe/SkZbsbRlgF5JCXBDlgdG4NBNQ1Eue2Cx0HYM+fQ5KUnTQ8d9hF+zjIS3Fkg3KMxzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eCcyAFga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E19C433C7;
	Thu, 11 Apr 2024 10:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712832310;
	bh=AF7aP4+pV3+UcW13AlhODCEq3YVbOyRj3FmeWUytuCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eCcyAFgaCFzFjkKxCsNmWNcMfc26GBglVbCO9oOomc3PvBkU72ELUdNiQ+7EkvfMt
	 11n0d10AZu2M5xdra4yulA4TJiSXj40TwQ68cm1BxSP50f+5liT9j4b0Z3FRfpPyH1
	 1q49LyEqS/knPT/Kh9A62eSvM7tIRWbZ+A97xBKU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linke li <lilinke99@qq.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 275/294] ring-buffer: use READ_ONCE() to read cpu_buffer->commit_page in concurrent environment
Date: Thu, 11 Apr 2024 11:57:18 +0200
Message-ID: <20240411095443.824177487@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
References: <20240411095435.633465671@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: linke li <lilinke99@qq.com>

[ Upstream commit f1e30cb6369251c03f63c564006f96a54197dcc4 ]

In function ring_buffer_iter_empty(), cpu_buffer->commit_page is read
while other threads may change it. It may cause the time_stamp that read
in the next line come from a different page. Use READ_ONCE() to avoid
having to reason about compiler optimizations now and in future.

Link: https://lore.kernel.org/linux-trace-kernel/tencent_DFF7D3561A0686B5E8FC079150A02505180A@qq.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: linke li <lilinke99@qq.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index fb87def73a3a4..2df8e13a29e57 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4211,7 +4211,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter)
 	cpu_buffer = iter->cpu_buffer;
 	reader = cpu_buffer->reader_page;
 	head_page = cpu_buffer->head_page;
-	commit_page = cpu_buffer->commit_page;
+	commit_page = READ_ONCE(cpu_buffer->commit_page);
 	commit_ts = commit_page->page->time_stamp;
 
 	/*
-- 
2.43.0




