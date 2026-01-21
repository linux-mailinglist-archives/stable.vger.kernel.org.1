Return-Path: <stable+bounces-210928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CEFKBkecWmodQAAu9opvQ
	(envelope-from <stable+bounces-210928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:42:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0B55B6DA
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFB6C5CC818
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614D236997C;
	Wed, 21 Jan 2026 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ozf6rut3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0018D315D28;
	Wed, 21 Jan 2026 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019859; cv=none; b=b62ZFjTmIOhI5iNHEJgrCtoGED7nlBoNP6L1gI0d58IozhrPl4OIfOY/NqZuDSFDXBMVHlaBBm2i8lJhrrJ6TYyup6TwIkxYv+GIirBTsD7f0jRLTL0Z9IQ5PJBYN+yR2SDO0veuAIN/MxpuF2f6dRHezi9j2WEjIUAy35cYURA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019859; c=relaxed/simple;
	bh=FEmnwnZkrz1c4TgTWrW/4pGpaQ31od6TnO3UWrXNkMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lB/7BVMuMDb1n5pjFJ7uYOIBgyhlvIDi9HvWAUtE7Z/zFfcIJ01BSoyqn8E0CS490aF4b2RRoJoKLx4V9KxfUp1yS2jPsX4fuw8Cux2eKTdVHeS8nzXkcSui+lmKgB8dbjNDXQSuBGbuBRDUc9DRg0Z8btiXD46RxzCWrdnSdrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ozf6rut3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645AFC4CEF1;
	Wed, 21 Jan 2026 18:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019858;
	bh=FEmnwnZkrz1c4TgTWrW/4pGpaQ31od6TnO3UWrXNkMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ozf6rut3QPnmN4nn3e5zp0SSMYP/011J1HY1k/63L5MgHCigpYkYDqttGXTfE1DYq
	 6RXYSrBZJ2IIOoc6djooBBLiQk8pD0xMwPjT5/sdeOWfV6LXFi5tSHho+qnakVGdv9
	 SJe5ElePpvHflVT/XiEXPuHvaVKe60H/xWK3KkUY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	chongjiapeng <jiapeng.chong@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12 096/139] mm/damon/sysfs: cleanup attrs subdirs on context dir setup failure
Date: Wed, 21 Jan 2026 19:15:44 +0100
Message-ID: <20260121181414.907455162@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210928-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0C0B55B6DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SeongJae Park <sj@kernel.org>

commit 9814cc832b88bd040fc2a1817c2b5469d0f7e862 upstream.

When a context DAMON sysfs directory setup is failed after setup of attrs/
directory, subdirectories of attrs/ directory are not cleaned up.  As a
result, DAMON sysfs interface is nearly broken until the system reboots,
and the memory for the unremoved directory is leaked.

Cleanup the directories under such failures.

Link: https://lkml.kernel.org/r/20251225023043.18579-3-sj@kernel.org
Fixes: c951cd3b8901 ("mm/damon: implement a minimal stub for sysfs-based DAMON interface")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: chongjiapeng <jiapeng.chong@linux.alibaba.com>
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/damon/sysfs.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -716,7 +716,7 @@ static int damon_sysfs_context_add_dirs(
 
 	err = damon_sysfs_context_set_targets(context);
 	if (err)
-		goto put_attrs_out;
+		goto rmdir_put_attrs_out;
 
 	err = damon_sysfs_context_set_schemes(context);
 	if (err)
@@ -726,7 +726,8 @@ static int damon_sysfs_context_add_dirs(
 put_targets_attrs_out:
 	kobject_put(&context->targets->kobj);
 	context->targets = NULL;
-put_attrs_out:
+rmdir_put_attrs_out:
+	damon_sysfs_attrs_rm_dirs(context->attrs);
 	kobject_put(&context->attrs->kobj);
 	context->attrs = NULL;
 	return err;



