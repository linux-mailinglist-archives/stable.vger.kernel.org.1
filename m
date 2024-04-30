Return-Path: <stable+bounces-42562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E788B7398
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E6E1C2328F
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA48612CDAE;
	Tue, 30 Apr 2024 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TvcviwnB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781828801;
	Tue, 30 Apr 2024 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476063; cv=none; b=SRhEufQXIaMDxENAbkP9cfgtoF8M9hN+XOvTZNV/3GWO1zHQIXXgn5N05RrrFS5vMnCzSPfn3spzn/vrVbOxt3+5ceaQTMcgJDWmtLMWOqC8RXtJURJfUgEotCgUrcfXitnZtL0s1fyaIY6CMepShlpxGXOi5WOh1JB7FvSx048=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476063; c=relaxed/simple;
	bh=hN9YjX1EzSJxV4g7M6i4NNUaR5oRh3sB3ITcMAGAfoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzHlV6ZDEEtOB+QyQFtL9MsdbJQpXyedUkJDnbkDZNr6lHa9TJjLicrc3p3qnuO0toRwDAZhge4y+pkN/LXdIGcfX3iuhEt7daf/yb5M9QH3YKPy+E0x/7OMrRljLUSXnbZ7ZwvFg/VbZIeTkAInUa5VVLIqJ84sjhQginCrgRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TvcviwnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90423C2BBFC;
	Tue, 30 Apr 2024 11:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714476063;
	bh=hN9YjX1EzSJxV4g7M6i4NNUaR5oRh3sB3ITcMAGAfoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TvcviwnBRjSHEZ67E3ZONKL5IOFfrhiL4oJZuR/9CExdj+XG/7Ofq0oHrtwo8F1/x
	 UJCFp3tveILjiFlYjdHm3FfE3zKLew0SGdfvw2f5YtsXz6oqEAIi9bxzvkjU1xJ9L/
	 vMXnm8/3ixC733+06RKO5KiX8Ry7NlhU9nEAFJWI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Siddh Raman Pant <siddh.raman.pant@oracle.com>,
	stable@kernel.org
Subject: [PATCH 5.4 022/107] Revert "tracing/trigger: Fix to return error if failed to alloc snapshot"
Date: Tue, 30 Apr 2024 12:39:42 +0200
Message-ID: <20240430103045.319042265@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103044.655968143@linuxfoundation.org>
References: <20240430103044.655968143@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Siddh Raman Pant <siddh.raman.pant@oracle.com>

This reverts commit 8ffd5590f4d6ef5460acbeac7fbdff7025f9b419 which is
commit 0958b33ef5a04ed91f61cef4760ac412080c4e08 upstream.

The change has an incorrect assumption about the return value because
in the current stable trees for versions 5.15 and before, the following
commit responsible for making 0 a success value is not present:
b8cc44a4d3c1 ("tracing: Remove logic for registering multiple event triggers at a time")

The return value should be 0 on failure in the current tree, because in
the functions event_trigger_callback() and event_enable_trigger_func(),
we have:

	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
	/*
	 * The above returns on success the # of functions enabled,
	 * but if it didn't find any functions it returns zero.
	 * Consider no functions a failure too.
	 */
	if (!ret) {
		ret = -ENOENT;

Cc: stable@kernel.org # 5.15, 5.10, 5.4, 4.19
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_events_trigger.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1140,10 +1140,8 @@ register_snapshot_trigger(char *glob, st
 			  struct event_trigger_data *data,
 			  struct trace_event_file *file)
 {
-	int ret = tracing_alloc_snapshot_instance(file->tr);
-
-	if (ret < 0)
-		return ret;
+	if (tracing_alloc_snapshot_instance(file->tr) != 0)
+		return 0;
 
 	return register_trigger(glob, ops, data, file);
 }



