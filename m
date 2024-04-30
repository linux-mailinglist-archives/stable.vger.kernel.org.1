Return-Path: <stable+bounces-42169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5648B71B6
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51391F21150
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D1712C476;
	Tue, 30 Apr 2024 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YEk96hip"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B757464;
	Tue, 30 Apr 2024 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474790; cv=none; b=QN8H75UiQHP9cTfJd79sSS9uo17w0uPukp7UleNSfTsAJUD3D7vydAfc4TmM3UWaqCgpaCrbhiMP1MR5olC6/V67G5QEsZrBgMf3XgIsZzVZ8thKaKsRcXfZ07nlrxJMXUUQkDF+T+3FTee8yD+GMKZp/gtPEcN5bEDASB386KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474790; c=relaxed/simple;
	bh=HtNmzvynLCxq5xKdbFT3KlL+LkgWnK6dKS/wRjeND5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCl8wzyb4wFtALPxkn74rcT8UXB2Qb4N9OO9OGcFASEa/l/t8hmdlb2up9Wu41vGoe7RBMSZhg0hwNPxNLSknJLln22DKHr8VNCTA/wD0ioBu5E+w+93Ra98SEz5qZwdE6tGIdVZ9cv8bz3wDYdjVz3tb0rS+7bTF0LyR21wwzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YEk96hip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B1AC2BBFC;
	Tue, 30 Apr 2024 10:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474790;
	bh=HtNmzvynLCxq5xKdbFT3KlL+LkgWnK6dKS/wRjeND5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YEk96hipKT5oL62cwZNt1w8RoCiMeO2DGz/UayEgekJe8Yr7ELFTWbJyKVv1mgdZo
	 HI8EeUO9vaW6Hm9qcHNov7LKDxQfAdWUdvCbJytu6vcftrOBzGKIDqBY5r9HmZ0Bu1
	 bpnw6p+246G/ex0LNT4aSKi2BoYYSkOayD9cRLW4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Siddh Raman Pant <siddh.raman.pant@oracle.com>,
	stable@kernel.org
Subject: [PATCH 5.10 035/138] Revert "tracing/trigger: Fix to return error if failed to alloc snapshot"
Date: Tue, 30 Apr 2024 12:38:40 +0200
Message-ID: <20240430103050.464958146@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103049.422035273@linuxfoundation.org>
References: <20240430103049.422035273@linuxfoundation.org>
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

From: Siddh Raman Pant <siddh.raman.pant@oracle.com>

This reverts commit 56cfbe60710772916a5ba092c99542332b48e870 which is
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



