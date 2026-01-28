Return-Path: <stable+bounces-211919-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPfgAw+BeWmexQEAu9opvQ
	(envelope-from <stable+bounces-211919-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 04:22:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A954D9C9EE
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 04:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0E0130160CB
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 03:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A083D32D42D;
	Wed, 28 Jan 2026 03:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="pEd2UG4h"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC8F2836A6;
	Wed, 28 Jan 2026 03:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769570571; cv=none; b=lEwhAGGPyGg7qX3IKON02O7LJHwYZJxk3z+a81/WsUt5wG8SWS+VbU5DV/dUWL7Zd29oSnVZcJSWWD5a++oGuvOy+GDRUxJuhRAH9YYbiUeHtykkHeRil05CKBRhTc5QVETXQyKhrADeVlVFdINlGPt6gWNYs/djsyVIoyoDnFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769570571; c=relaxed/simple;
	bh=q4KwC2J1vNyWejVK5AxlJvSLAQ4jjbRSDDVSCNk/CP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NltoVe1h5otQNNExxvv3hH0sLPJqw5ZH0/QOt7di3L7eR16hF1TU05PQIIyxPpQM1p5B3cpsJ3HpG7oMCZgTi8UlJztMEK8GJWSGCMQy0pCpEhiq9LYqqA7VqkoXqnj4VwXzapUVavCO1fe4s1Bpk4Fw3eY8D3cOSHh8uCZR8Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=pEd2UG4h; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=pEd2UG4htaufbvPFt6xP7qEKi8GuVG10Zg1K19c53cveBNCZzuupCv9wqWytun46MjPgDs4/Sq4U9
	 wizEOTgWocCTycLmrIy3uB+DiiyKHJQvj93cTwvcWJWXj+co2GOezEoRpSfHjf2Fq5dxO92hZyUmLJ
	 81E2Iem0gE4swKsQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-09-12087 (RichMail) with SMTP id 2f3769798109d6b-02da6;
	Wed, 28 Jan 2026 11:22:53 +0800 (CST)
X-RM-TRANSID:2f3769798109d6b-02da6
From: Li hongliang <1468888505@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y] drm/amdgpu: csa unmap use uninterruptible lock
Date: Wed, 28 Jan 2026 11:22:38 +0800
Message-Id: <20260128032238.1182576-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211919-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[139.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1468888505@139.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[139.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,139.com:mid,139.com:email]
X-Rspamd-Queue-Id: A954D9C9EE
X-Rspamd-Action: no action

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit a0fa7873f2f869087b1e7793f7fac3713a1e3afe ]

After process exit to unmap csa and free GPU vm, if signal is accepted
and then waiting to take vm lock is interrupted and return, it causes
memory leaking and below warning backtrace.

Change to use uninterruptible wait lock fix the issue.

WARNING: CPU: 69 PID: 167800 at amd/amdgpu/amdgpu_kms.c:1525
 amdgpu_driver_postclose_kms+0x294/0x2a0 [amdgpu]
 Call Trace:
  <TASK>
  drm_file_free.part.0+0x1da/0x230 [drm]
  drm_close_helper.isra.0+0x65/0x70 [drm]
  drm_release+0x6a/0x120 [drm]
  amdgpu_drm_release+0x51/0x60 [amdgpu]
  __fput+0x9f/0x280
  ____fput+0xe/0x20
  task_work_run+0x67/0xa0
  do_exit+0x217/0x3c0
  do_group_exit+0x3b/0xb0
  get_signal+0x14a/0x8d0
  arch_do_signal_or_restart+0xde/0x100
  exit_to_user_mode_loop+0xc1/0x1a0
  exit_to_user_mode_prepare+0xf4/0x100
  syscall_exit_to_user_mode+0x17/0x40
  do_syscall_64+0x69/0xc0

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 7dbbfb3c171a6f63b01165958629c9c26abf38ab)
Cc: stable@vger.kernel.org
[The third parameter of drm_exec_init() was introduced by commit
 05d249352f1a ("drm/exec: Pass in initial # of objects") after Linux 6.8.
 This code targets linux 6.6, so the current implementation is used
 and the third parameter is not needed.]
Signed-off-by: Li hongliang <1468888505@139.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index 720011019741..bff44fc21e8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -110,7 +110,7 @@ int amdgpu_unmap_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct drm_exec exec;
 	int r;
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
+	drm_exec_init(&exec, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = amdgpu_vm_lock_pd(vm, &exec, 0);
 		if (likely(!r))
-- 
2.34.1



