Return-Path: <stable+bounces-196304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CD0C7A0B6
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A04583502E
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26D034A3CD;
	Fri, 21 Nov 2025 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sBxHMmOb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE7E266584;
	Fri, 21 Nov 2025 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763733126; cv=none; b=gKSCErEfvp+dkpPid1/77qSbzDz9l8KhCQblLoFf/DrB2X3CSOeRADgkejimuUUB5NKCNMGacPW24OGkKw5o3y0SwkVPXMcf1ojVXmc5ZF3NZBW7Qf9b/2wm3+4pdodrfkKED4fUPgUwfpryEidphGQ65tes4D4NQnX5imfRCb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763733126; c=relaxed/simple;
	bh=tQtizmxJCW21F2zJesTQwAQSkkru1oRW/DjoFaq3LkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmQABAQxgYJJTIFJsT/SMdsvk/Kj5GjI9sTB6GyEwUKPnOqpH2NTfbuDP2L+noxq6CQBOhHWtu8hTNDxQwYU9JYcqzeOeEdMUJTcMA99TMivTibpOuzf17JpgFzRnDzzk8fbLqfAKDgBDZn3cYxgicU8+KVQEdwFQxazn/mAPns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sBxHMmOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0381C116C6;
	Fri, 21 Nov 2025 13:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763733126;
	bh=tQtizmxJCW21F2zJesTQwAQSkkru1oRW/DjoFaq3LkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sBxHMmObpFcnTjXlNR0jXpvknQnt+gyhxD84hmavLvfbe+HDe5/tOsCisrNKR02cG
	 MQsuvOlXzu0DNaDzC+08zTes9JpuBDqx1WjjiIlCK5MpV6wMCmRCpwucOYbXdQ5O0I
	 zX/pS81rT17xvwNGruqxl+p4NL05flw/cJju+/5k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zilin Guan <zilin@seu.edu.cn>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 361/529] tracing: Fix memory leaks in create_field_var()
Date: Fri, 21 Nov 2025 14:11:00 +0100
Message-ID: <20251121130243.872100194@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251121130230.985163914@linuxfoundation.org>
References: <20251121130230.985163914@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Zilin Guan <zilin@seu.edu.cn>

[ Upstream commit 80f0d631dcc76ee1b7755bfca1d8417d91d71414 ]

The function create_field_var() allocates memory for 'val' through
create_hist_field() inside parse_atom(), and for 'var' through
create_var(), which in turn allocates var->type and var->var.name
internally. Simply calling kfree() to release these structures will
result in memory leaks.

Use destroy_hist_field() to properly free 'val', and explicitly release
the memory of var->type and var->var.name before freeing 'var' itself.

Link: https://patch.msgid.link/20251106120132.3639920-1-zilin@seu.edu.cn
Fixes: 02205a6752f22 ("tracing: Add support for 'field variables'")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_hist.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 88985aefb71ff..e6d2f2a94235f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3258,14 +3258,16 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
 	var = create_var(hist_data, file, field_name, val->size, val->type);
 	if (IS_ERR(var)) {
 		hist_err(tr, HIST_ERR_VAR_CREATE_FIND_FAIL, errpos(field_name));
-		kfree(val);
+		destroy_hist_field(val, 0);
 		ret = PTR_ERR(var);
 		goto err;
 	}
 
 	field_var = kzalloc(sizeof(struct field_var), GFP_KERNEL);
 	if (!field_var) {
-		kfree(val);
+		destroy_hist_field(val, 0);
+		kfree_const(var->type);
+		kfree(var->var.name);
 		kfree(var);
 		ret =  -ENOMEM;
 		goto err;
-- 
2.51.0




