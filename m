Return-Path: <stable+bounces-217755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIL0LuJKnGmODAQAu9opvQ
	(envelope-from <stable+bounces-217755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 13:41:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A85417643C
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 13:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B36D308C764
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F095366DB1;
	Mon, 23 Feb 2026 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4oQ17KT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59015366547;
	Mon, 23 Feb 2026 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850283; cv=none; b=pNuP6tsgQXdHKGaoG4F4+Gnmv66bTneV09NobVon8JFRBU/m/HONuv2bhzQMlbyBMNxILhCclqH+tHWj3vmZhVDGVoHdr8JPuVO6nu7GbjZ0pMGEHi97ocvnEBzSka+hinOQHGWRr0Cm5B5Xa0qcmFJ7Ryn7RMYlYK318aSTjDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850283; c=relaxed/simple;
	bh=WNyuENrrxG7HBgEwA9Fl7HdeUKdw6mxjKUOn97BYSzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHvAdGHoxp/5vyzw1fXk+Rpl/UtIZ/oUYGtQbDqATgegIQH1uiC6SLY7OiNYJb+IVXu3aUpdrGSkVoLtzqKS7+GavKO7DBOfyHXDzv++swH0N360IP+RWbupfPmgB2V0xa3FxGibiDpmKUtEQtw3Sb1wHOT1Tq8HaICB35fvXV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4oQ17KT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3068C2BC87;
	Mon, 23 Feb 2026 12:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771850283;
	bh=WNyuENrrxG7HBgEwA9Fl7HdeUKdw6mxjKUOn97BYSzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I4oQ17KTbtkAOXIE5XzuilsjfLAK7L8FQU89Z5T9fYe2rMgwDedLZ9i2ePwA0ETwD
	 ua3dR/aa95u+cw/QkppcHy0j/Z2ia2qRxMRQuERirIlfLgE7MsoLiGnkhksKsxF8jR
	 JViqBfPOkl7DhEeSmIOqr9jOLxGj+wglQ76eEaHwFkNjh6f5he3S5E7N3x8/KPrIgY
	 2CouynS2tRt3x8x9F4fm8R24vJiR53Yb7xcFKcwBVm3eIt0AsUwxMO+YGOmL1uHW+k
	 tdsxJsWlSzqfIWuECAHX8fp5/H3c4qSGbrfDQG1XFSoTiSfrzzV4vB6Xbr4f58vjS2
	 vg3nesWTut5Tw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ce Sun <cesun102@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.15] drm/amdgpu: Adjust usleep_range in fence wait
Date: Mon, 23 Feb 2026 07:37:21 -0500
Message-ID: <20260223123738.1532940-16-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223123738.1532940-1-sashal@kernel.org>
References: <20260223123738.1532940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,kernel.org,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-217755-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A85417643C
X-Rspamd-Action: no action

From: Ce Sun <cesun102@amd.com>

[ Upstream commit 3ee1c72606bd2842f0f377fd4b118362af0323ae ]

Tune the sleep interval in the PSP fence wait loop from 10-100us to
60-100us.This adjustment results in an overall wait window of 1.2s
(60us * 20000 iterations) to 2 seconds (100us * 20000 iterations),
which guarantees that we can retrieve the correct fence value

Signed-off-by: Ce Sun <cesun102@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have all the key information. Let me analyze this commit:

## Analysis

### What the commit does
This is a one-line change that increases the minimum sleep time in the
PSP (Platform Security Processor) fence wait loop from `usleep_range(10,
100)` to `usleep_range(60, 100)`.

### Context
The `psp_cmd_submit_buf()` function submits a command to AMD's Platform
Security Processor and waits for completion by polling a fence buffer.
The loop runs up to `psp_timeout = 20000` iterations.

**Previous behavior:** With `usleep_range(10, 100)`, the total wait
window was approximately:
- Minimum: 10us * 20000 = 200ms
- Maximum: 100us * 20000 = 2000ms (2s)

**New behavior:** With `usleep_range(60, 100)`, the total wait window
is:
- Minimum: 60us * 20000 = 1200ms (1.2s)
- Maximum: 100us * 20000 = 2000ms (2s)

### Bug Analysis
The commit message says this "guarantees that we can retrieve the
correct fence value." This implies that with the 10us minimum, the
kernel scheduler could wake up after approximately 10us each iteration,
causing the 20000 iterations to complete in as little as ~200ms —
**before the PSP hardware has finished its work**. The fix increases the
minimum wait to ensure the total poll window is at least 1.2s.

This is fixing a **real bug**: a timeout that is too short, causing
legitimate PSP commands to fail spuriously. When PSP fence wait fails,
line 762-764 shows it returns `-EINVAL`, which causes firmware load
failures and GPU initialization failures. This can make the GPU non-
functional.

### Stable criteria evaluation
1. **Fixes a real bug**: Yes — PSP commands can time out prematurely,
   causing GPU initialization failures.
2. **Obviously correct**: Yes — it's a one-line change to a sleep range,
   reviewed by AMD engineer Lijo Lazar.
3. **Small and contained**: Yes — single line change in one file.
4. **No new features**: Correct — only adjusts a timing parameter.
5. **Risk**: Very low. The maximum sleep time (100us) is unchanged. The
   only effect is that the minimum sleep per iteration increases, making
   the total wait time longer and more reliable. This cannot cause
   regressions — it only makes the timeout more generous.

### Concerns
- The change is a timing adjustment, which can sometimes be considered a
  "tuning" change rather than a bug fix. However, the commit message
  explicitly states it fixes a correctness problem (failing to retrieve
  the correct fence value), and the consequence of the bug is GPU
  initialization failure.
- No explicit `Fixes:` tag, but that is expected for autosel candidates.

### User Impact
PSP fence wait failures manifest as GPU initialization failures. Users
affected would see their AMD GPU fail to initialize, making it unusable.
This is a high-severity issue for affected users.

## Verification
- Confirmed `psp_timeout = 20000` at line 268 of `amdgpu_psp.c` —
  verified the iteration count claim in the commit message.
- Confirmed the wait loop structure at lines 718-731 — the loop polls
  with `usleep_range` and breaks on timeout.
- Confirmed that timeout failure leads to `-EINVAL` return at line 763,
  causing command failure.
- Confirmed the change is a single-line edit from `usleep_range(10,
  100)` to `usleep_range(60, 100)`.
- Verified the commit is reviewed by Lijo Lazar (AMD PSP engineer) and
  signed off by Alex Deucher (AMD GPU maintainer).
- The math checks out: 10us * 20000 = 200ms (too short), 60us * 20000 =
  1.2s (sufficient per commit message).

This is a small, obvious, low-risk fix for a real bug that causes GPU
initialization failures. It meets all stable kernel criteria.

**YES**

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0b10497d487c3..81bdd6aaad2a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -726,7 +726,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 		ras_intr = amdgpu_ras_intr_triggered();
 		if (ras_intr)
 			break;
-		usleep_range(10, 100);
+		usleep_range(60, 100);
 		amdgpu_device_invalidate_hdp(psp->adev, NULL);
 	}
 
-- 
2.51.0


