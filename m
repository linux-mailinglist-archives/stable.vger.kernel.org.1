Return-Path: <stable+bounces-220621-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDL7HjE8o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220621-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:04:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4791C690D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 717D530EE495
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B60E3E557D;
	Sat, 28 Feb 2026 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r80BTX+z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D4835E95D;
	Sat, 28 Feb 2026 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300504; cv=none; b=mhgc/Eh5WicRjZ113fmBm7ecPxaRBfpHb/6Vdjipp71f4Kc6bUpfgdSlsvM5wo7YShncecAsneHIluadD3LGEj0WJ7HZfypkYucHtIsqZ4xiZZ/RS1Dzh2gK6VhxwoQ1XGpCuqGjUEF1rpQDAb9TPQCphrr7u/V1mrBKXmUcDsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300504; c=relaxed/simple;
	bh=urhlAVyJVrIQmbbWAZrRGMlFqaW3ozV6GJGeuHGKLvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=It4Rb5SGpBSO/Ug4VuRiLAo9hQzN+2hzJCH1FBcMqqcN/RceUj6NkQ0jix/CsI66w5iGAsG1K0LY16MLcbwAKLVIhN8uz7YP5bYaydKY4D4kTmVduKIhEw/qVP7RKViY7m0MJnNUgaw80j74jngX9Ewqn99E+pqtzq1Otz9FvcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r80BTX+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B846AC116D0;
	Sat, 28 Feb 2026 17:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300504;
	bh=urhlAVyJVrIQmbbWAZrRGMlFqaW3ozV6GJGeuHGKLvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r80BTX+zXv3bISyLRMR9e1hL/H1xjkgDWzp/FspdL/wgTg278CiomBLtJjNnCxTvM
	 /JkfCdehgGycEX7u8Ve1t+p5JmcSrpABVkQF5Hrc/hBtcenUGacCZElR2sfS3GjTfi
	 aDNMXzpIcKOrBNyzQFCSF2FSTpmxidtVdIpK0R8UL3QU+OmrLfwsK6WW8iuwlZ0S1H
	 0j7gC7zJh7zY6WCSW79b3cwgnwVQ0Z+yh4O79pVuwhsvRi61+NTZ7yNXzpwYRBLDPm
	 26vLgWrUHs+ADjPPYRVvG91PuuS3qJRyGa2dv+TMNgxemxbGOWqJ+k7uTc9ei5vKHV
	 W4GhuhZ4qmn4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xulin Sun <xulin.sun@windriver.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 542/844] media: chips-media: wave5: Fix PM runtime usage count underflow
Date: Sat, 28 Feb 2026 12:27:35 -0500
Message-ID: <20260228173244.1509663-543-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220621-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D4791C690D
X-Rspamd-Action: no action

From: Xulin Sun <xulin.sun@windriver.com>

[ Upstream commit 9cf4452e824c1e2d41c9c0b13cc8a32a0a7dec38 ]

Replace pm_runtime_put_sync() with pm_runtime_dont_use_autosuspend() in
the remove path to properly pair with pm_runtime_use_autosuspend() from
probe. This allows pm_runtime_disable() to handle reference count cleanup
correctly regardless of current suspend state.

The driver calls pm_runtime_put_sync() unconditionally in remove, but the
device may already be suspended due to autosuspend configured in probe.
When autosuspend has already suspended the device, the usage count is 0,
and pm_runtime_put_sync() decrements it to -1.

This causes the following warning on module unload:

  ------------[ cut here ]------------
  WARNING: CPU: 1 PID: 963 at kernel/kthread.c:1430
    kthread_destroy_worker+0x84/0x98
  ...
  vdec 30210000.video-codec: Runtime PM usage count underflow!

Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
Cc: stable@vger.kernel.org
Signed-off-by: Xulin Sun <xulin.sun@windriver.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/chips-media/wave5/wave5-vpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index e1715d3f43b0d..23aa3ab51a0ef 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -356,7 +356,7 @@ static void wave5_vpu_remove(struct platform_device *pdev)
 		hrtimer_cancel(&dev->hrtimer);
 	}
 
-	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	mutex_destroy(&dev->dev_lock);
-- 
2.51.0


