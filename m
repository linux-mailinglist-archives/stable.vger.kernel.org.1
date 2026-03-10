Return-Path: <stable+bounces-224089-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKC0HqX+r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224089-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:21:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C3024A768
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37C5630BD57C
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AE03876A6;
	Tue, 10 Mar 2026 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lA1yOsR/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED98D387574;
	Tue, 10 Mar 2026 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141223; cv=none; b=ScWKQ709Ddx6NOuLSnB39/1MwS1CfTRIklt+FLjZ+AwWS4UA2IoUOMlawNWq5BSgM0WJAEmn/rnMEPGNLPz2hxwMnfkYGh4rpviaGUN5g+ivRdscqLJ6M25xgFU2gm5IM/I/pgs0PNHbFXJAS/vAu6uWE/L7RjYqsIj0iGxg70s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141223; c=relaxed/simple;
	bh=0uaDaDwrnVM8kvc4E/n2ecf1jsvPMV7qNqRELQhuLAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdNCsQKt09EpsjZCpweZKzIa/Npz7nGqg+Svt1ChxMOq2BcB/+UiLLjBLTMCnZGwSdDLlawXOzGXt2DU2ovvRo2NO9cz8o671hF4oL6GZyAPfK0phO4GBJtBeAz9AfuPjeWROPAZV6UB6wPLovJqeBk48p7LzpIA5tASvK/4RMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lA1yOsR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FE2C2BCB4;
	Tue, 10 Mar 2026 11:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141222;
	bh=0uaDaDwrnVM8kvc4E/n2ecf1jsvPMV7qNqRELQhuLAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lA1yOsR/fqGYMZH8nAEDvOgc8UqqjnIn+5CozRDo0D9ZsR8mJAdwenN1BOaMe+4JF
	 vR3ghYI+ofpTwjit4e4YacE6jBRH5lJNadSVYFtgLGrOBxGrRLfUwFYzT16iFQcrb6
	 KT+HdXY6NwZdznwiYHcpRlFPZcADTiX/7zIT/yhKtF+NH0jOdcyuwlurKrJvXtEgKt
	 RDj5f3ag1d/whGVDxGx8da7Qq18gyjHbHsPZ//ppnRAAAkEt8d0r2ZIN3nC1Ei0P+A
	 XaGFcadTMrXgpwzkD+V2d0CsQAcw5CjERZVBTi1AtUbjyIrOdp5gVWs4peApwGFcz4
	 1npmo5vHegq+g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	Nitin Gote <nitin.r.gote@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 224/311] drm/xe/configfs: Free ctx_restore_mid_bb in release
Date: Tue, 10 Mar 2026 07:04:31 -0400
Message-ID: <7f0ba7c980fee4dc691f5872cf54a09d3745b767.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 26C3024A768
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224089-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Action: no action

From: Shuicheng Lin <shuicheng.lin@intel.com>

[ Upstream commit e377182f0266f46f02d01838e6bde67b9dac0d66 ]

ctx_restore_mid_bb memory is allocated in wa_bb_store(), but
xe_config_device_release() only frees ctx_restore_post_bb.

Free ctx_restore_mid_bb[0].cs as well to avoid leaking the allocation
when the configfs device is removed.

Fixes: b30d5de3d40c ("drm/xe/configfs: Add mid context restore bb")
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
Reviewed-by: Nitin Gote <nitin.r.gote@intel.com>
Link: https://patch.msgid.link/20260225013448.3547687-2-shuicheng.lin@intel.com
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
(cherry picked from commit a235e7d0098337c3f2d1e8f3610c719a589e115f)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_configfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_configfs.c b/drivers/gpu/drm/xe/xe_configfs.c
index 82edd04660055..4afdfd69899aa 100644
--- a/drivers/gpu/drm/xe/xe_configfs.c
+++ b/drivers/gpu/drm/xe/xe_configfs.c
@@ -830,6 +830,7 @@ static void xe_config_device_release(struct config_item *item)
 
 	mutex_destroy(&dev->lock);
 
+	kfree(dev->config.ctx_restore_mid_bb[0].cs);
 	kfree(dev->config.ctx_restore_post_bb[0].cs);
 	kfree(dev);
 }
-- 
2.51.0


