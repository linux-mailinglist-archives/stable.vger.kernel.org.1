Return-Path: <stable+bounces-216352-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEWPLDDKj2nMTgEAu9opvQ
	(envelope-from <stable+bounces-216352-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 02:04:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF9D13A598
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 02:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7624F3045A2C
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 01:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011003EBF2C;
	Sat, 14 Feb 2026 01:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsZY3NWG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FEB1D5ABA;
	Sat, 14 Feb 2026 01:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771031004; cv=none; b=R42lk9k1yjHtG/xzaMEeTkFtPOzTCF+vxidIJv/rDiiw3nNKlRS09sIzBFPe3s/wYNLOojrkFhkDyX5HbpUuP5szlIUMVI3IsmwaMfFyF0WhqrjHSRT8w8OFwuWelpYbWOo958IUtuvZ5yrokbBi0xLaAq314OZqJ7wxAFftbCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771031004; c=relaxed/simple;
	bh=AR/ks+EExcFCXEVKH9ZVY6PQir3tvAdwscr5YVbCMK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNdiNO/gjfuC4SSkOrLNtzUXFz063YPnpZ2ShnDXXr61mfUaNw1UFP9AG4ogkhCx62enuHesdEKd6WCx4xBdvugDF/Uki8b89f5RGUzbo+dm2aDSGmMatEAygtPscf0JU9s17zuQ6jpBMtbf1McnzjJWI9DAyRbQgXrs2RySXs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsZY3NWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726E8C19425;
	Sat, 14 Feb 2026 01:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771031004;
	bh=AR/ks+EExcFCXEVKH9ZVY6PQir3tvAdwscr5YVbCMK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fsZY3NWG6No5WDjF4QKHs1yDBebHm6ld98I7JwnHB/RnYSOUfpZiI71nlBFOYeh0f
	 /0xsxs4QnlqKKY0/6bkyNdZn7TcILg9hQ+B/LQKH6o1fnJtEYwmIUfsWJ3Ahv5ME6P
	 X8I0VzFTO0JoGguwaYZ7StjtEF2SuQJXSVCDpHJFAnNudez/fSD/FWMQzxqem/FVh3
	 jDoaoAmOtSjmbFJxHCvzo9dejOwYx2pgUuDt/WxIwZKDvOCo/tLyB/RvHN8saxQO0X
	 aeCu4zYXagDeYgrDiiowG00/PPLCKqypEkT56dkKW/p072OThSybsp7+fn54UMMCfm
	 CO/aGxz+pPdZg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jinzhou Su <jinzhou.su@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	lijo.lazar@amd.com,
	mario.limonciello@amd.com,
	asad.kamal@amd.com,
	yelangyan@huaqin.corp-partner.google.com,
	kenneth.feng@amd.com,
	linux@treblig.org
Subject: [PATCH AUTOSEL 6.19] drm/amd/pm: Fix null pointer dereference issue
Date: Fri, 13 Feb 2026 19:58:21 -0500
Message-ID: <20260214010245.3671907-21-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214010245.3671907-1-sashal@kernel.org>
References: <20260214010245.3671907-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216352-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 4FF9D13A598
X-Rspamd-Action: no action

From: Jinzhou Su <jinzhou.su@amd.com>

[ Upstream commit 1197366cca89a4c44c541ddedb8ce8bf0757993d ]

If SMU is disabled, during RAS initialization,
there will be null pointer dereference issue here.

Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### Commit Message Analysis

The commit message is clear and direct: "Fix null pointer dereference
issue." It explicitly states the trigger condition — when SMU (System
Management Unit) is disabled, during RAS (Reliability, Availability,
Serviceability) initialization, a null pointer dereference occurs. This
is a crash-inducing bug with a well-understood trigger.

### Code Change Analysis

The fix is a **3-line addition** in a single file
(`drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c`):

```c
if (!smu)
    return ret;
```

This is added to `amdgpu_smu_ras_send_msg()`, which retrieves `smu` from
`adev->powerplay.pp_handle`. When SMU is disabled, `pp_handle` is NULL.
Without this check, the very next line dereferences `smu`:

```c
if (smu->ppt_funcs && smu->ppt_funcs->ras_send_msg)
```

This would cause a kernel oops/panic via null pointer dereference.

The return value in the NULL case is `-EOPNOTSUPP`, which is already the
initialized value of `ret` and is the appropriate error code for "SMU
not available."

### Classification

- **Bug type**: NULL pointer dereference (kernel crash)
- **Trigger**: SMU disabled + RAS initialization path
- **Fix type**: Defensive NULL check before dereference
- **Category**: Clear bug fix, one of the most common stable-worthy
  patterns

### Scope and Risk Assessment

- **Lines changed**: 3 (adding a NULL check + early return)
- **Files changed**: 1
- **Risk**: Extremely low — the function already returns `-EOPNOTSUPP`
  by default, so returning early with the same error code when `smu` is
  NULL is completely safe and changes no behavior for the non-NULL case
- **Side effects**: None — callers already handle `-EOPNOTSUPP`

### User Impact

- **Who is affected**: Users with AMD GPUs where SMU is disabled (this
  can happen in specific configurations or when SMU firmware fails to
  load)
- **Severity**: Kernel crash (null pointer dereference → oops/panic)
  during RAS initialization
- **Reproducibility**: Deterministic when SMU is disabled

### Stability Indicators

- **Reviewed-by**: Yang Wang (AMD engineer)
- **Signed-off-by**: Alex Deucher (AMD GPU subsystem maintainer)
- The fix is trivially correct — it's a standard NULL guard pattern

### Dependency Check

- No dependencies on other commits
- The `amdgpu_smu_ras_send_msg()` function exists in stable trees (it's
  part of the AMD PM subsystem)
- Clean backport expected — the fix is self-contained

### Summary

This is a textbook stable backport candidate:
1. **Obviously correct**: Simple NULL check before dereference
2. **Fixes a real bug**: Kernel crash (null pointer dereference)
3. **Important issue**: Kernel oops during initialization
4. **Small and contained**: 3 lines in one file
5. **No new features**: Pure defensive fix
6. **Low risk**: Cannot break anything — only adds an early return for a
   case that previously crashed

**YES**

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f51fa265230b3..2a0e826d0317d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -618,6 +618,9 @@ int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_type ms
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	int ret = -EOPNOTSUPP;
 
+	if (!smu)
+		return ret;
+
 	if (smu->ppt_funcs && smu->ppt_funcs->ras_send_msg)
 		ret = smu->ppt_funcs->ras_send_msg(smu, msg, param, read_arg);
 
-- 
2.51.0


