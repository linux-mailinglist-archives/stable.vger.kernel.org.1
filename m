Return-Path: <stable+bounces-173580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7115B35D63
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C2A77C5F7F
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A562BF002;
	Tue, 26 Aug 2025 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t+UBRd//"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC4529D292;
	Tue, 26 Aug 2025 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208618; cv=none; b=pzQxbpiwqew8xUMWvdfStWi8B4kPkp29JUEks4vjtvEOYgcbtcUhfj9vQ0CW4p90OFJ3CvQrDEHkCNFYouZqHrr2ZyhaIX0zbmb6u6r+ZQ57qz5ficV3TCzQl1ih0FcRt+CDfrXpNa9C3OMjgZAH69NAXYjLPsPqR27oTqxo3Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208618; c=relaxed/simple;
	bh=NUlXEDyqFyC2Ywmf9Guvb8Fv32YoPdods81lQRDR5Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZ8S1i6Xxezy2ki39JxXUKIctXUQaBlmbiAxAEfZAnmCcGOdFmEexIC8LJsa901X4YxCgC7B9lolI5CDrlFUJOt9g4nW/tS3M69g/8URkIf+Ok0Nu9/L1nB0BbVsXOZnEmEzy3h2XvUtjGtRciw4rK5QLBc9sCCgXAyvUhRxwnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t+UBRd//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A093DC4CEF1;
	Tue, 26 Aug 2025 11:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208618;
	bh=NUlXEDyqFyC2Ywmf9Guvb8Fv32YoPdods81lQRDR5Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t+UBRd//Y08vTwchUDxL+FvJOyeTot/x8xeBMYDwGh6mnM3hU1dp9ESPiemrFvBPm
	 yKGMGGigEcRfXPb9r7ktXfylGo8twc8jO5RM/VwbnhSeZ/ymfkS6uUk1elXNmVpN6Y
	 GCPdLr3M2ve1GzsLUY+IS1L1U2lXffmsiRpEXTeM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.12 181/322] drm/amd/display: Avoid a NULL pointer dereference
Date: Tue, 26 Aug 2025 13:09:56 +0200
Message-ID: <20250826110920.333537296@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit 07b93a5704b0b72002f0c4bd1076214af67dc661 upstream.

[WHY]
Although unlikely drm_atomic_get_new_connector_state() or
drm_atomic_get_old_connector_state() can return NULL.

[HOW]
Check returns before dereference.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 1e5e8d672fec9f2ab352be121be971877bff2af9)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7583,6 +7583,9 @@ amdgpu_dm_connector_atomic_check(struct
 	struct amdgpu_dm_connector *aconn = to_amdgpu_dm_connector(conn);
 	int ret;
 
+	if (WARN_ON(unlikely(!old_con_state || !new_con_state)))
+		return -EINVAL;
+
 	trace_amdgpu_dm_connector_atomic_check(new_con_state);
 
 	if (conn->connector_type == DRM_MODE_CONNECTOR_DisplayPort) {



