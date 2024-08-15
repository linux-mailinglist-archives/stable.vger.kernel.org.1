Return-Path: <stable+bounces-69207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BFA95360B
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6157F282C01
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491C91AC893;
	Thu, 15 Aug 2024 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0WnhD5yL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AD617C995;
	Thu, 15 Aug 2024 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733015; cv=none; b=FF/BQLlXxFfXjqG8gAWJLu9vQW3PQQR+AEIPkqZt3TpUa95RUHZd3yCIg10n6Tm7cpUxPpnWMqv2JU5Zz9aEjXkWC9XlN/y7wPK838BX01OYXGnvYfsRA68POE46QM2olfB43akWrtLqyJGIDDug88g2VuFAoAatcwn8Kg2htjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733015; c=relaxed/simple;
	bh=GFde3IDjYJ7KwEuM9LyY8JLGav+Hx2cKw8f/V4fVptA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfjXaiKl0XZiB/LAyrdhFYr0qlNzWdsIdRexz9I9QOzfw2dPxSmES6I79AKl2ze/5V1B1ZHGFIMIjDsAdRBhgvO9pmdzzakv4R2DOkHlQD64Ksa1xvXt4OG008GS/0yAQWG6IrBY6sL29I2ueukypUJm/wk86UMrIbisp9LNiaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0WnhD5yL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAD6C32786;
	Thu, 15 Aug 2024 14:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723733014;
	bh=GFde3IDjYJ7KwEuM9LyY8JLGav+Hx2cKw8f/V4fVptA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0WnhD5yLEA+YH8sWj5M5+T6tJGTD+tPmwVRPRi2kN5/e9zkPYuSpdHv0IfjKdbYm/
	 BbF7miIu3+MvoiEdFv9zbiYoVHTY5EGklDB1PWm8j0hpFZ3EWAo8oRLCND6aNlOT90
	 DZmm/TC/22oMpVd9H9fapXOoOSQ9DnVdBzgckoLk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Waiman Long <longman@redhat.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10 324/352] padata: Fix possible divide-by-0 panic in padata_mt_helper()
Date: Thu, 15 Aug 2024 15:26:30 +0200
Message-ID: <20240815131931.976294445@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
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

From: Waiman Long <longman@redhat.com>

commit 6d45e1c948a8b7ed6ceddb14319af69424db730c upstream.

We are hit with a not easily reproducible divide-by-0 panic in padata.c at
bootup time.

  [   10.017908] Oops: divide error: 0000 1 PREEMPT SMP NOPTI
  [   10.017908] CPU: 26 PID: 2627 Comm: kworker/u1666:1 Not tainted 6.10.0-15.el10.x86_64 #1
  [   10.017908] Hardware name: Lenovo ThinkSystem SR950 [7X12CTO1WW]/[7X12CTO1WW], BIOS [PSE140J-2.30] 07/20/2021
  [   10.017908] Workqueue: events_unbound padata_mt_helper
  [   10.017908] RIP: 0010:padata_mt_helper+0x39/0xb0
    :
  [   10.017963] Call Trace:
  [   10.017968]  <TASK>
  [   10.018004]  ? padata_mt_helper+0x39/0xb0
  [   10.018084]  process_one_work+0x174/0x330
  [   10.018093]  worker_thread+0x266/0x3a0
  [   10.018111]  kthread+0xcf/0x100
  [   10.018124]  ret_from_fork+0x31/0x50
  [   10.018138]  ret_from_fork_asm+0x1a/0x30
  [   10.018147]  </TASK>

Looking at the padata_mt_helper() function, the only way a divide-by-0
panic can happen is when ps->chunk_size is 0.  The way that chunk_size is
initialized in padata_do_multithreaded(), chunk_size can be 0 when the
min_chunk in the passed-in padata_mt_job structure is 0.

Fix this divide-by-0 panic by making sure that chunk_size will be at least
1 no matter what the input parameters are.

Link: https://lkml.kernel.org/r/20240806174647.1050398-1-longman@redhat.com
Fixes: 004ed42638f4 ("padata: add basic support for multithreaded jobs")
Signed-off-by: Waiman Long <longman@redhat.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Waiman Long <longman@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/padata.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -521,6 +521,13 @@ void __init padata_do_multithreaded(stru
 	ps.chunk_size = max(ps.chunk_size, job->min_chunk);
 	ps.chunk_size = roundup(ps.chunk_size, job->align);
 
+	/*
+	 * chunk_size can be 0 if the caller sets min_chunk to 0. So force it
+	 * to at least 1 to prevent divide-by-0 panic in padata_mt_helper().`
+	 */
+	if (!ps.chunk_size)
+		ps.chunk_size = 1U;
+
 	list_for_each_entry(pw, &works, pw_list)
 		queue_work(system_unbound_wq, &pw->pw_work);
 



