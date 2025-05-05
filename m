Return-Path: <stable+bounces-140128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E1FAAA567
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094803A3A8C
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EE928F00E;
	Mon,  5 May 2025 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4DVXrb8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F013328F00A;
	Mon,  5 May 2025 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484159; cv=none; b=mONNm9MhU/VQCB73q952R1WvYVroCIxaxkuZDL3A6BelvytwqLMYVtXyDVXPcFGurF+JcGrzLk0gDnhnhLNegubbUjTgAoUlH8IKACEqNdHb9HGfPZSnj5sTbUsJ3u1ovU05OSQLkUdQZ5PgRrdrSBF4WRUkI7wwSYt1M6zYiCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484159; c=relaxed/simple;
	bh=0rY6USwdH/BbMFJeP4DFM3Cbs9aUeKCtF98Za21TGq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lb0FQBzBoOr5nYcMPgqCwUPB4ZAF5S7oaNgUegi7feDpASWXwlowi/WWBEEdvRR6GlqiqtW9CLuFC3BTRDM2Co2/G/jhS8dGeg0gyFrJ6P90N5AO/KInsi9rFm6rJii7tqYqrJK0XXHfPMCW81NmZLq7cteqcW4RhzDRCNxiX3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4DVXrb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA31C4CEEE;
	Mon,  5 May 2025 22:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484158;
	bh=0rY6USwdH/BbMFJeP4DFM3Cbs9aUeKCtF98Za21TGq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G4DVXrb8fMMegn6uH7SzHtL4s6Qnmcr34TTV2YwOnUWsSmR4RhW8dcM1d6JkBYXm7
	 nTgpas9KwBMPbduU/57VjjO/1eQvExgAw0Xx0pzLxTM+CqJW7MXKRV5kEwMjampcqD
	 KgcMFJVqyV7rqAovmUC8Tx5+D3MgpOvYhsxS3h3LxXFfUWw3Hdmx+siq+sWkjDay6F
	 +gaenyNTTGjQBqR2evYwNAOYpVOntJ8v9j8jWgzeksFIoxv1rdfGiH0uSCWMfMdMFr
	 N9gy6d63xjIvBAiBp6JJr+PZSR5mPya/BTykZR+fSVdlPHn8TNfi7h9ZvM1tXq3zp3
	 kA9EotkVpwznA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marcin Bernatowicz <marcin.bernatowicz@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	Satyanarayana K V P <satyanarayana.k.v.p@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 381/642] drm/xe/client: Skip show_run_ticks if unable to read timestamp
Date: Mon,  5 May 2025 18:09:57 -0400
Message-Id: <20250505221419.2672473-381-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Marcin Bernatowicz <marcin.bernatowicz@linux.intel.com>

[ Upstream commit 94030a1d3283251778411cf74553607a65260f78 ]

RING_TIMESTAMP registers are inaccessible in VF mode.
Without drm-total-cycles-*, other keys provide little value.
Skip all optional "run_ticks" keys in this case.

Signed-off-by: Marcin Bernatowicz <marcin.bernatowicz@linux.intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Michał Winiarski <michal.winiarski@intel.com>
Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Reviewed-by: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250205191644.2550879-3-marcin.bernatowicz@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_drm_client.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
index 2d4874d2b9225..31f688e953d7b 100644
--- a/drivers/gpu/drm/xe/xe_drm_client.c
+++ b/drivers/gpu/drm/xe/xe_drm_client.c
@@ -324,6 +324,14 @@ static void show_run_ticks(struct drm_printer *p, struct drm_file *file)
 	u64 gpu_timestamp;
 	unsigned int fw_ref;
 
+	/*
+	 * RING_TIMESTAMP registers are inaccessible in VF mode.
+	 * Without drm-total-cycles-*, other keys provide little value.
+	 * Show all or none of the optional "run_ticks" keys in this case.
+	 */
+	if (IS_SRIOV_VF(xe))
+		return;
+
 	/*
 	 * Wait for any exec queue going away: their cycles will get updated on
 	 * context switch out, so wait for that to happen
-- 
2.39.5


