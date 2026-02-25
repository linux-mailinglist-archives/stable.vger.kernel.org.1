Return-Path: <stable+bounces-219010-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NKBBC5XnmkKUwQAu9opvQ
	(envelope-from <stable+bounces-219010-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:58:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 828FC1904BA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F8D330E9DA6
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E412E277026;
	Wed, 25 Feb 2026 01:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vy6Yvadz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76F2275AE8;
	Wed, 25 Feb 2026 01:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983921; cv=none; b=RPFw1urjmciKZTTz3p5+NYPH7m5iYPKfqgCQSXxX1EkSCQNZtU/o01efB3PcIPPjKi522IFES6ON/MZkZAjjdDzE8fdMBGHM7PPHMfOCPsmVnjkzY+lD2pz8fZEvVrx+HSmVTXk10xlbj3Z4SSUv2LOcjlEjrj8jjmBFlwmqUFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983921; c=relaxed/simple;
	bh=rssE1CQCBWOd8Dea1f8j4eZw0ZBy5ADmNxswJehFTjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ow85KLOnHaf/b0ZFRUHUt3Y6uxn2hPl5mQwKksZlhVGPxDBpSbGLpsxlVTf7ah3Vg06VJ4zveG1SfMuCZmiKplyT1lPj+G4DtUSja60I1Z9f3tutQTwkbJsJe+iid2ihANvlgZ/P2DFOZTounGiwgSmEd2UukNeFK9U1n0yZmNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vy6Yvadz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7041CC116D0;
	Wed, 25 Feb 2026 01:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983921;
	bh=rssE1CQCBWOd8Dea1f8j4eZw0ZBy5ADmNxswJehFTjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vy6Yvadz2tbLRmYoV+lzvBAYc/woQQBtdjQvWn2CU/KJpRWbwmhZrCBstv4N1842S
	 RDwBXjavbIS5ABqHL11qWHXVfgdeP84jgnZ7p9hAygi8f051KcJBXToUKv5jPDkw1s
	 etEw07LJpKD/S58cZg3KC67J/9r13c6aJc6ponzk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philip Yang <Philip.Yang@amd.com>,
	Gang BA <Gang.Ba@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 189/641] drm/amdkfd: Fix signal_eviction_fence() bool return value
Date: Tue, 24 Feb 2026 17:18:35 -0800
Message-ID: <20260225012353.582743362@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219010-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 828FC1904BA
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 31dc58adda9874420ab8fa5a2f9c43377745753a ]

signal_eviction_fence() is declared to return bool, but returns -EINVAL
when no eviction fence is present.  This makes the "no fence" or "the
NULL-fence" path evaluate to true and triggers a Smatch warning.

v2: Return true instead to explicitly indicate that there is no eviction
fence to signal and that eviction is already complete. This matches the
existing caller logic where a NULL fence means "nothing to do" and
allows restore handling to proceed normally. (Christian)

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:2099 signal_eviction_fence()
warn: '(-22)' is not bool

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c
    2090 static bool signal_eviction_fence(struct kfd_process *p)
                ^^^^

    2091 {
    2092         struct dma_fence *ef;
    2093         bool ret;
    2094
    2095         rcu_read_lock();
    2096         ef = dma_fence_get_rcu_safe(&p->ef);
    2097         rcu_read_unlock();
    2098         if (!ef)
--> 2099                 return -EINVAL;

		This should be either true or false.
		Probably true because presumably
		it has been tested?

    2100
    2101         ret = dma_fence_check_and_signal(ef);
    2102         dma_fence_put(ef);
    2103
    2104         return ret;
    2105 }

Fixes: 37865e02e6cc ("drm/amdkfd: Fix eviction fence handling")
Reported by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Philip Yang <Philip.Yang@amd.com>
Cc: Gang BA <Gang.Ba@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index ddfe30c13e9d6..8ed513a77d38f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1992,7 +1992,7 @@ static int signal_eviction_fence(struct kfd_process *p)
 	ef = dma_fence_get_rcu_safe(&p->ef);
 	rcu_read_unlock();
 	if (!ef)
-		return -EINVAL;
+		return true;
 
 	ret = dma_fence_signal(ef);
 	dma_fence_put(ef);
-- 
2.51.0




