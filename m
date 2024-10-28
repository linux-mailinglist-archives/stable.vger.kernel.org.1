Return-Path: <stable+bounces-88793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1421E9B2783
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459451C20329
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF7218DF7D;
	Mon, 28 Oct 2024 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1pMsQr/N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576A62AF07;
	Mon, 28 Oct 2024 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098135; cv=none; b=UuuIHb3efMq+f1VoxX3CKr2GaqanbeOjwd7s5N3wVxqChVF2IzJ5q+gT7mavJaqj85vFw1pY51NVyqAAyzUv2zgZDZJ/OdKAIwIsuXZuICPW8HWYmcR8J+oxiZY0L9NmqLwpkatWBcopdQ6LW1ncUV9Ufp+Z53ArYySbWI/bF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098135; c=relaxed/simple;
	bh=gtDe07mVPVWrtbh1RtV5CQAidQ863Oxsd+l3H9sJCdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqxU6hX+EAo9ms7Hdr7oQA/0G1wPYIz6rfAgxVYfgQc02S9/YahUpWaEOOKYdWrLSPdhWBgGC4fwzzWzoEgMh/XX90x4iWo7KjrW5TVqQtLfIEAianI2Qvs/N2c8pR1qF9/I4fM9w9fht298V8oQ1yPKc1BkSo9WXIdpuixGs8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1pMsQr/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0780C4CEC3;
	Mon, 28 Oct 2024 06:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730098135;
	bh=gtDe07mVPVWrtbh1RtV5CQAidQ863Oxsd+l3H9sJCdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1pMsQr/NDcHAaAea/Q+/+JEhQO+x/NoMVUR5OKXAnYJEXLvDUQQxas1IeD/CFr2r2
	 KI4gFXW8VcFPsSShhSIkeqv5J7+55AifcLv0NE3MLTo2+xiX5FZj8KLLkAGeqyB3La
	 PHUzUN1EyvOx9j1AjoZM1zjN3cJcWpM5U0aGwzuU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 091/261] drm/xe: Take job list lock in xe_sched_add_pending_job
Date: Mon, 28 Oct 2024 07:23:53 +0100
Message-ID: <20241028062314.312750708@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062312.001273460@linuxfoundation.org>
References: <20241028062312.001273460@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Brost <matthew.brost@intel.com>

[ Upstream commit ed931fb40e353586f26c3327813d142f782f5f78 ]

A fragile micro optimization in xe_sched_add_pending_job relied on both
the GPU scheduler being stopped and fence signaling stopped to safely
add a job to the pending list without the job list lock in
xe_sched_add_pending_job. Remove this optimization and just take the job
list lock.

Fixes: 7ddb9403dd74 ("drm/xe: Sample ctx timestamp to determine if jobs have timed out")
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241003001657.3517883-2-matthew.brost@intel.com
(cherry picked from commit 90521df5fc43980e4575bd8c5b1cb62afe1a9f5f)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gpu_scheduler.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler.h b/drivers/gpu/drm/xe/xe_gpu_scheduler.h
index 6aac7fe686735..6bdd0a5b36122 100644
--- a/drivers/gpu/drm/xe/xe_gpu_scheduler.h
+++ b/drivers/gpu/drm/xe/xe_gpu_scheduler.h
@@ -51,7 +51,9 @@ xe_sched_invalidate_job(struct xe_sched_job *job, int threshold)
 static inline void xe_sched_add_pending_job(struct xe_gpu_scheduler *sched,
 					    struct xe_sched_job *job)
 {
+	spin_lock(&sched->base.job_list_lock);
 	list_add(&job->drm.list, &sched->base.pending_list);
+	spin_unlock(&sched->base.job_list_lock);
 }
 
 static inline
-- 
2.43.0




