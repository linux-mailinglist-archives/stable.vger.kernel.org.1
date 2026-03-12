Return-Path: <stable+bounces-224963-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHgXBFIes2l/SQAAu9opvQ
	(envelope-from <stable+bounces-224963-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:13:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 926212789A2
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DE4330215A8
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4257401A06;
	Thu, 12 Mar 2026 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0vcWw8Dg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EA9346FB3;
	Thu, 12 Mar 2026 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346383; cv=none; b=GSD2MBGZw2Icl8FfYcpvLT/HuDcINYmg5tp5KuO95CqLUI8MXN2RDdbzxBUSVNOMyQZax7wxLELFBjMSPh29oKtkHg+I/Jiz2Q4jkP6zUrbqqsuSYKUGJpTFUV/qavmHOprK0Zy/kqhCEIPgM3mTYbsFuy2Ny48NTKPU/juIxBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346383; c=relaxed/simple;
	bh=WFJ4giYAufJ7Okow15SzLflyyR4P0fjlEI4VFVxC1c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLbUY8lurqYsarJ0LDq/3jzZ0RpRgdTpyyXjPNoHJp/IUpPv6yEIpSlo8aLVN4VxQya9NL5e5hE0gN6LrtjU835tGID2B1vbkuTSnaMBoSyWxZxKRehFfw31JoPInxn3SuF07ErUI4AkEPaGf9HGgyfJspXHN5n9S4jqoSqYdtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0vcWw8Dg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A2CC4CEF7;
	Thu, 12 Mar 2026 20:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346383;
	bh=WFJ4giYAufJ7Okow15SzLflyyR4P0fjlEI4VFVxC1c0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0vcWw8DgJghJ658MVaBxY6WGQpgqXkBPfOxQnxbm58FF6SvhnRXUA/PYy4LdqNmkm
	 Wm468wabfa5GJqePBWuUzk665+E19hA1Q5LJni8OS/0oOZ9uMlIT3UBheK2iC8kjzW
	 wXStE8ONwTvTquLr8ebqylYtSyls8pEMhQ8psK9U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	YiPeng Chai <YiPeng.Chai@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Bart Van Assche <bvanassche@acm.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 030/265] drm/amdgpu: Fix locking bugs in error paths
Date: Thu, 12 Mar 2026 21:06:57 +0100
Message-ID: <20260312201019.276365357@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224963-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.freedesktop.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,amd.com:email]
X-Rspamd-Queue-Id: 926212789A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 480ad5f6ead4a47b969aab6618573cd6822bb6a4 ]

Do not unlock psp->ras_context.mutex if it has not been locked. This has
been detected by the Clang thread-safety analyzer.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: YiPeng Chai <YiPeng.Chai@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Fixes: b3fb79cda568 ("drm/amdgpu: add mutex to protect ras shared memory")
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 6fa01b4335978051d2cd80841728fd63cc597970)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index 6e8aad91bcd30..0d3c18f04ac36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -332,13 +332,13 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
 	if (!context || !context->initialized) {
 		dev_err(adev->dev, "TA is not initialized\n");
 		ret = -EINVAL;
-		goto err_free_shared_buf;
+		goto free_shared_buf;
 	}
 
 	if (!psp->ta_funcs || !psp->ta_funcs->fn_ta_invoke) {
 		dev_err(adev->dev, "Unsupported function to invoke TA\n");
 		ret = -EOPNOTSUPP;
-		goto err_free_shared_buf;
+		goto free_shared_buf;
 	}
 
 	context->session_id = ta_id;
@@ -346,7 +346,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
 	mutex_lock(&psp->ras_context.mutex);
 	ret = prep_ta_mem_context(&context->mem_context, shared_buf, shared_buf_len);
 	if (ret)
-		goto err_free_shared_buf;
+		goto unlock;
 
 	ret = psp_fn_ta_invoke(psp, cmd_id);
 	if (ret || context->resp_status) {
@@ -354,15 +354,17 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
 			ret, context->resp_status);
 		if (!ret) {
 			ret = -EINVAL;
-			goto err_free_shared_buf;
+			goto unlock;
 		}
 	}
 
 	if (copy_to_user((char *)&buf[copy_pos], context->mem_context.shared_buf, shared_buf_len))
 		ret = -EFAULT;
 
-err_free_shared_buf:
+unlock:
 	mutex_unlock(&psp->ras_context.mutex);
+
+free_shared_buf:
 	kfree(shared_buf);
 
 	return ret;
-- 
2.51.0




