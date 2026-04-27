Return-Path: <stable+bounces-241232-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Id4NzAJ72n14QAAu9opvQ
	(envelope-from <stable+bounces-241232-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:58:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4576A46DF22
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 270F030038D0
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 06:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C13038F648;
	Mon, 27 Apr 2026 06:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Mh7+Ohn4"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D338386C18;
	Mon, 27 Apr 2026 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777272883; cv=none; b=VPhOxtEg7Q7OGwO1lMyb/jIPPA0kq+wfDPAvt4otqY73S3YQNzVwgiqL2wQfb5/Qgwla9ZYdYtznsOyaLCAXzGJ0EPjgeMtL51GUb/toUx6Zp8wOY3k3l8FnTdNV+JwQYygw5ip9tO/gcaD4g0M6OLxmrAMcqNTDhbVGU2P4zaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777272883; c=relaxed/simple;
	bh=L61c8QQkhO8Lxyw8n/0q2qGuuiQUAHeIs5XKKE1zp5Q=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=fsdiWnCCE2ITVPHzEQbIAqrgYqzyTDx1Sifk9dNvhcNZtkIihwS4fS+Gu4CdYHhnOjEdYFKDLi8WRR7j+FC8pXDJzc0G6S6SQ76A0vIod0Fmbu4jV04Z8Ui1WUHRgutpYxWiFGJPeRA7SOU6H9ArKDfh4j9uRIkFSAZIhjkwKog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Mh7+Ohn4; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777272879; bh=YAf/LrZfGLPBHgeXFYTRaJADqAAirwQb1U8glIUJrVQ=;
	h=From:To:Cc:Subject:Date;
	b=Mh7+Ohn4coSTVl2TCCqykuYULvxOwZWIwYlF4AhpzPYpmQ/5ZgxKcLqJelbQSu07+
	 nXJilrGhlWY3nI2QlxZ345SLthEe8/ByhLpml3M1CG685dV3ROFMhYZpFlKprmntsU
	 Q7VejewWxAhYl7VSo+4+g7JGcK1ktOfi3Ni/ruBU=
Received: from NTT-kernel-dev ([60.247.85.88])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id DA406ACD; Mon, 27 Apr 2026 14:54:36 +0800
X-QQ-mid: xmsmtpt1777272876t4whu3acg
Message-ID: <tencent_899C611CFFBE8DE17F1DE7896C968F47DF0A@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJFxO5Mr92P2c3o2Wm6PFcJfY62DYcKfwndIjHB320O1n8Hq8GXD
	 eVEo88eEEcagnd6V8Xnnjhj70WKYH4BdFBzC1aZC4D+2mydkE8Gs8QT7MOT6xN9BCCgXUBvO7HPH
	 +ASCA95OLvJ+KaTqRg6Kfp+bxa+2xDwyc7CovkiRLHAPxTLMK/DPwNtA+lG/qNnenBlx0C5/XCS8
	 XYOehxeEJ/AeQ9yCev/eQscUdS0vnHnWYoIGO/XDvDxat87ZXi4oEMgA8wt0RiM5Z/6OU1LuWiK3
	 TmCPqiQQVMzSPFUa2lBeqCU2sFgLPTemsjXpKf7TxyyU6UpwpJUdS7eSg8kr0GUVjAk91HirPL4X
	 ZOEmgmcHsdwLMQp6e19kyCESM2Q+68ZpLM5WN/EwMJgIa/8HaPAT1FQjrTR1UEqO3Qf4hArQdWQd
	 t0DTzvBPTqM7D62GhCQJfM7Mdung91Nfa/Leo/+zd/yrxAMclHOta7ZTr2BMNzy498p8RgH/e07Q
	 JCleUCaG7bAWLb+bjarOPVHyEBrHTVSma/EU/qDggiyJOZL4IQ+fUHi0ORvV+vFJde0FensJLcle
	 fnTPqRXJCCPlX+rOO61Lz+pI5jiyEufk9zAS0E+hLy6J1AmCNWnUj+aiWuWZBjwdGYcL3tLGH1+e
	 RIKo5SRsyLCO1M1IudVO+RBqwSJg4drbfkRnnbwk69AlXCUxplgjlV/AmnP0gvwD4gYBC8k2PhEL
	 oxQ990yJY7ZBVRPKWsD7tp7endP4UHd99Qn/LyvMRD7xLsXfLui49tAcaqnmtRO5bN1EroCM8GVr
	 9xbd4lYC8XYT+zIQjuUd7QoJFheMFmTEsz8s/0nTJH4k6oLlkhXiN+BcTjdB7uzjQ3+ovCiNJe3Y
	 IAD1A13qrK2rVpazLVEt6PIOvuNIgxgmvhqx201V+pisAzwd2+i/Vb6j+/ik7HtBghAQ717RCt/u
	 B1AFxOXe7gv87xLXKl0Y6JI/ueZBOW0Rv+AsRwBQ9Re88GrnOFYNdGcQJwa8nVNCmTl0LMhkUCvL
	 SDwMIeRvQUw2KYDyTDLMVrGLRxAHM9AU9zEKfe+XJGg3RYOmuZLB6/9c/W/i6QeWfBmunAkLJPo8
	 xODDYVjtV9kkw8VQU=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Fang Wang <32840572@qq.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	tvrtko.ursulin@igalia.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Jesse.Zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 6.1.y 2/2] drm/amdgpu: Limit BO list entry count to prevent resource exhaustion
Date: Mon, 27 Apr 2026 14:54:35 +0800
X-OQ-MSGID: <20260427065435.4120232-1-32840572@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4576A46DF22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241232-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,amd.com,gmail.com,ffwll.ch,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[32840572@qq.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,qq.com:dkim,qq.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]

From: "Jesse.Zhang" <Jesse.Zhang@amd.com>

[ Upstream commit 6270b1a5dab94665d7adce3dc78bc9066ed28bdd ]

Userspace can pass an arbitrary number of BO list entries via the
bo_number field. Although the previous multiplication overflow check
prevents out-of-bounds allocation, a large number of entries could still
cause excessive memory allocation (up to potentially gigabytes) and
unnecessarily long list processing times.

Introduce a hard limit of 128k entries per BO list, which is more than
sufficient for any realistic use case (e.g., a single list containing all
buffers in a large scene). This prevents memory exhaustion attacks and
ensures predictable performance.

Return -EINVAL if the requested entry count exceeds the limit

Reviewed-by: Christian König <christian.koenig@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 688b87d39e0aa8135105b40dc167d74b5ada5332)
Cc: stable@vger.kernel.org
Signed-off-by: Fang Wang <32840572@qq.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 79e43896eddd..28a5b54a3aae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -35,6 +35,7 @@
 
 #define AMDGPU_BO_LIST_MAX_PRIORITY	32u
 #define AMDGPU_BO_LIST_NUM_BUCKETS	(AMDGPU_BO_LIST_MAX_PRIORITY + 1)
+#define AMDGPU_BO_LIST_MAX_ENTRIES	(128 * 1024)
 
 static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
 {
@@ -232,6 +233,9 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 	const uint32_t bo_number = in->bo_number;
 	struct drm_amdgpu_bo_list_entry *info;
 
+	if (bo_number > AMDGPU_BO_LIST_MAX_ENTRIES)
+		return -EINVAL;
+
 	/* copy the handle array from userspace to a kernel buffer */
 	if (likely(info_size == bo_info_size)) {
 		info = vmemdup_array_user(uptr, bo_number, info_size);
-- 
2.34.1


