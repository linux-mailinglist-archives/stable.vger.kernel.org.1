Return-Path: <stable+bounces-231901-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDrWIjX9y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231901-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:58:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3585836D8EE
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 940063191986
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86145426D19;
	Tue, 31 Mar 2026 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cEAvIOtZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D19426698;
	Tue, 31 Mar 2026 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975360; cv=none; b=J6le8ZNHZTchcCgd7nrlaZGK1xbgSl2jq63XXVKCaK7xBkQSAMjcw9DuG9sDmRCOZ1R9GYGr7MYIPcZCixb5fS0KcnIznFLyLWAWS3D3CBPnJp2cqBDulmIHKwrt0OO8XsTLp3lZWfD9tuQSJLf/ZCdkd7/+5ynlwVGNWGca6q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975360; c=relaxed/simple;
	bh=eLKgfffF/jc1ZVzkl2a4FvvFfRXYJ8/3Y11yCvr8pWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBCiQtYuYYenBEOl5mPO6CmeOMv7JRuoDMLH5Jc+4WFAbA+kPHeHz47QWTgGvIMXBRr30VMDfN+8uUEl9yEkAKT3P1wiSKnDQ5zZCh6/Tj/JPPXKNLZtFniF1BqtPEJZq6pfJIHy9ap3iVlO50EtaMWgiZFt1uFlLiDOD7fu88w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cEAvIOtZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0ADC19423;
	Tue, 31 Mar 2026 16:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975360;
	bh=eLKgfffF/jc1ZVzkl2a4FvvFfRXYJ8/3Y11yCvr8pWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cEAvIOtZKnwlGodoOTTnBjpnhU2RKo9MENvktHT9FhDCwiVkYH9uWEeEqPQ7wH/5M
	 CKGqLk5qH0EHC55i4jLAHkvclWw4o4ABHzwE91VRyWC4lbER20+lBiS4XRNpAikr2+
	 i0iRjLztkzb6oUuPg69MNoO4Bmb3PHHcZUsjh688=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Ruijing Dong <ruijing.dong@amd.com>
Subject: [PATCH 6.19 263/342] drm/amdgpu: fix strsep() corrupting lockup_timeout on multi-GPU (v3)
Date: Tue, 31 Mar 2026 18:21:36 +0200
Message-ID: <20260331161808.629336391@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231901-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 3585836D8EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ruijing Dong <ruijing.dong@amd.com>

commit 2d300ebfc411205fa31ba7741c5821d381912381 upstream.

amdgpu_device_get_job_timeout_settings() passes a pointer directly
to the global amdgpu_lockup_timeout[] buffer into strsep().
strsep() destructively replaces delimiter characters with '\0'
in-place.

On multi-GPU systems, this function is called once per device.
When a multi-value setting like "0,0,0,-1" is used, the first
GPU's call transforms the global buffer into "0\00\00\0-1". The
second GPU then sees only "0" (terminated at the first '\0'),
parses a single value, hits the single-value fallthrough
(index == 1), and applies timeout=0 to all rings — causing
immediate false job timeouts.

Fix this by copying into a stack-local array before calling
strsep(), so the global module parameter buffer remains intact
across calls. The buffer is AMDGPU_MAX_TIMEOUT_PARAM_LENGTH
(256) bytes, which is safe for the stack.

v2: wrap commit message to 72 columns, add Assisted-by tag.
v3: use stack array with strscpy() instead of kstrdup()/kfree()
    to avoid unnecessary heap allocation (Christian).

This patch was developed with assistance from Claude (claude-opus-4-6).

Assisted-by: Claude:claude-opus-4-6
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 94d79f51efecb74be1d88dde66bdc8bfcca17935)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4361,7 +4361,8 @@ fail:
 
 static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 {
-	char *input = amdgpu_lockup_timeout;
+	char buf[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
+	char *input = buf;
 	char *timeout_setting = NULL;
 	int index = 0;
 	long timeout;
@@ -4371,9 +4372,17 @@ static int amdgpu_device_get_job_timeout
 	adev->gfx_timeout = adev->compute_timeout = adev->sdma_timeout =
 		adev->video_timeout = msecs_to_jiffies(2000);
 
-	if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
+	if (!strnlen(amdgpu_lockup_timeout, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
 		return 0;
 
+	/*
+	 * strsep() destructively modifies its input by replacing delimiters
+	 * with '\0'. Use a stack copy so the global module parameter buffer
+	 * remains intact for multi-GPU systems where this function is called
+	 * once per device.
+	 */
+	strscpy(buf, amdgpu_lockup_timeout, sizeof(buf));
+
 	while ((timeout_setting = strsep(&input, ",")) &&
 	       strnlen(timeout_setting, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
 		ret = kstrtol(timeout_setting, 0, &timeout);



