Return-Path: <stable+bounces-174218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F84AB361E9
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487C01889088
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46839264A83;
	Tue, 26 Aug 2025 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UgtR2PNJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5A3223DE5;
	Tue, 26 Aug 2025 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213807; cv=none; b=J/374X8bQXvydnNsm/+TYlSEbyJtz8DtcyU12LJRVU8rsuT9ImsVKEJp7UioX3rZX2/yVl0NX2C2waLaRG6CHzZvCZ5PDPFX2waWwIlCqrvZeV9bMP2mh6jzs4A4xAc2tW7VXAB6MHoR2Qh9HlShxKlYXkjGEyYTroH0yZkghkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213807; c=relaxed/simple;
	bh=1kkH+Cj7AppLZHnH+QVl6up7BIt6l3XsUfSAlklXnk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6j4kq+aa1vthbY2ls5iuydRDV2vEjrt6ZIFs9Bzp9/eBtVkdKB8SU68ChW3BOuU4gCQG4eWEL+BAvdfmfdb1RftPYi3axpNcVlpmG1AujXOcwo+iovFisHgTO0hkN9g36uWZmG8TvWJDpwtrSM1FGoaAfmFJs9JAoZcOQCxwTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UgtR2PNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CED0C4CEF1;
	Tue, 26 Aug 2025 13:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213806;
	bh=1kkH+Cj7AppLZHnH+QVl6up7BIt6l3XsUfSAlklXnk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UgtR2PNJIlN88gg+irzic9uPsW6fK4ZpoSPj1SUY8Irotat006iIIT6mTkkqbklbz
	 zxSSEAM+4+9/H4NLpwOcB0lawDME5RaD7SBOhlOHfZgfvVNQKvQtmWz+eTKOV9aift
	 WMoG7xFp1JZrCKZMD8db26MLtV05bFLOMwBLDnzE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.6 487/587] drm/amd/display: Avoid a NULL pointer dereference
Date: Tue, 26 Aug 2025 13:10:36 +0200
Message-ID: <20250826111005.361462205@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6779,6 +6779,9 @@ amdgpu_dm_connector_atomic_check(struct
 	struct amdgpu_dm_connector *aconn = to_amdgpu_dm_connector(conn);
 	int ret;
 
+	if (WARN_ON(unlikely(!old_con_state || !new_con_state)))
+		return -EINVAL;
+
 	trace_amdgpu_dm_connector_atomic_check(new_con_state);
 
 	if (conn->connector_type == DRM_MODE_CONNECTOR_DisplayPort) {



