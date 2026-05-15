Return-Path: <stable+bounces-248844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAbIE5JLB2pZwwIAu9opvQ
	(envelope-from <stable+bounces-248844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:36:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1EF553913
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 109EF301D830
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB8932ABC0;
	Fri, 15 May 2026 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NRnXS3SN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1391E56A;
	Fri, 15 May 2026 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862773; cv=none; b=U/U4ERfIvjZKYf4bJ6Nz375ZtneOgPNJcQurKXEwpkjxyuOsHPtqHjwEvAVPcZvhp/nPZYDs9/hM+Mip0bNcBXNJbaazwuLlggYqmUfGQyM8rH4Q5jfBZIFGVwwnqZMzaRLhljfj7WMbqJG+aZw329WWLTyTyW7zXvyFE6dRKKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862773; c=relaxed/simple;
	bh=VTZ1mWtD7EOi+tDORE6fQmTXMiPgzg0xhPxHfrWkfRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSi/e5bViwxnKMxKhULe6eqKyjYpziKTgjGmyoQdnmqPLgE8+gTvf79w4raBJCfsQQmgbZdPojxrAT9zXOIOvSoz9OW/zM6f50ilxyQpYewcIodZwj6ima4tUTkMo80N03PgP8KEAoKJopvTP+17rwynJLqaqptnDVGEF+5Pxtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NRnXS3SN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CF3C2BCB0;
	Fri, 15 May 2026 16:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862772;
	bh=VTZ1mWtD7EOi+tDORE6fQmTXMiPgzg0xhPxHfrWkfRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NRnXS3SNwRwuuUxPUSLe/InY7SnPTlZwrAeUa+MF0HawBgoY2Hn460QxMV3It2L2L
	 ITe+biqYdvtVv0B26Bf6nEYNGuuYKrdu5gZpo1Izg2lrE4JrWuf8c85yL6j8mLCloz
	 ZHtx4Vaoxhph2A4AkegJeMLIiWy2RD9FNrtIGkbs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chenglei Xie <Chenglei.Xie@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7.0 135/201] drm/amdgpu: gate VM CPU HDP flush on reset lock
Date: Fri, 15 May 2026 17:49:13 +0200
Message-ID: <20260515154701.491741955@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4E1EF553913
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248844-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chenglei Xie <Chenglei.Xie@amd.com>

commit ddda81c4d7e71e41b1be91d921fd85747eddbd12 upstream.

During GPU reset, the application could still run CPU page table updates. Each commit called
amdgpu_device_flush_hdp(), which on SR-IOV sends work through the KIQ ring.
That can advance sync_seq while the GPU is being reset,
leaving fence writeback out of sync and causing amdgpu_fence_emit_polling()
to time out on later KIQ use.

Fix:
amdgpu_vm_cpu_commit():
  Reset will flush HDP anyway, the HDP flush in amdgpu_vm_cpu_commit() can be skipped
  when a reset is ongoging.
  Take reset_domain->sem with down_read_trylock() before amdgpu_device_flush_hdp().
  If the reset path holds the write lock, skip the HDP flush so no HDP-related HW
  access (including KIQ) runs during reset; state is re-established after reset.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -21,6 +21,8 @@
  */
 
 #include "amdgpu_vm.h"
+#include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_object.h"
 #include "amdgpu_trace.h"
 
@@ -108,11 +110,19 @@ static int amdgpu_vm_cpu_update(struct a
 static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
 				struct dma_fence **fence)
 {
+	struct amdgpu_device *adev = p->adev;
+
 	if (p->needs_flush)
 		atomic64_inc(&p->vm->tlb_seq);
 
 	mb();
-	amdgpu_device_flush_hdp(p->adev, NULL);
+	/* A reset flushed the HDP anyway, so that here can be skipped when a reset is ongoing */
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return 0;
+
+	amdgpu_device_flush_hdp(adev, NULL);
+	up_read(&adev->reset_domain->sem);
+
 	return 0;
 }
 



