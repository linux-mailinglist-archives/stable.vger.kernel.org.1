Return-Path: <stable+bounces-159473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56973AF78E4
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 16:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E19188DF41
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287882EF9A6;
	Thu,  3 Jul 2025 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XRQqNcs4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92882EAB95;
	Thu,  3 Jul 2025 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554342; cv=none; b=sIkLQqUMOejANl1lZyH+3IH8o2Xr9QlAtX+184fiXekzNlN8mm0KSxFLmCv26TF9RirE/LpbtQZtaN4TmzkpTxmBWVrbvVX6qthQdc9M0jr6hvMfHgHpI290gpSuf05stKMXCVrZx9giJ30lKR7dHwQdfbr15InWIZe0O/KK8ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554342; c=relaxed/simple;
	bh=9MzS7ys9mTfEbkwOpp3kSy0KgmiAu17Z3lAooB1jLmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8pdGFvYVWPfJOeNhUuPgRh/77cggbXeSKmx20wQ5ZjN2E+ZZxycchA08PZbtdGUFoTEv/FUrjFS4zZ7QmPDlE2F6Q+lamXeml+8QUyGclezeOird2JptQG9tu/OcKO+84kOCLlkIf4JjvgX6Yr9UntD/Bk5dNtOuFLLNq8ksVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XRQqNcs4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E222C4CEE3;
	Thu,  3 Jul 2025 14:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554342;
	bh=9MzS7ys9mTfEbkwOpp3kSy0KgmiAu17Z3lAooB1jLmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XRQqNcs4ljiO2IW5Eoa/6Z06+HZT1i5SpEkEL0MXkBFGqfomu9U1I2rvCeoxIQ5qp
	 O0UNoaUxLHS3fEjFkgCZU5o4Iv141d67PzCaWDY3Of0jiXEDAVz27KzOVbnUNpcSU0
	 Zbp0iE0ZuHv0SgsGi8Dy8Xaup9BTc34wRmBBQpHM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jay Cornwall <jay.cornwall@amd.com>,
	Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 155/218] drm/amdkfd: Fix race in GWS queue scheduling
Date: Thu,  3 Jul 2025 16:41:43 +0200
Message-ID: <20250703144002.348597118@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143955.956569535@linuxfoundation.org>
References: <20250703143955.956569535@linuxfoundation.org>
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

From: Jay Cornwall <jay.cornwall@amd.com>

commit cfb05257ae168a0496c7637e1d9e3ab8a25cbffe upstream.

q->gws is not updated atomically with qpd->mapped_gws_queue. If a
runlist is created between pqm_set_gws and update_queue it will
contain a queue which uses GWS in a process with no GWS allocated.
This will result in a scheduler hang.

Use q->properties.is_gws which is changed while holding the DQM lock.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit b98370220eb3110e82248e3354e16a489a492cfb)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -237,7 +237,7 @@ static int pm_map_queues_v9(struct packe
 
 	packet->bitfields2.engine_sel =
 		engine_sel__mes_map_queues__compute_vi;
-	packet->bitfields2.gws_control_queue = q->gws ? 1 : 0;
+	packet->bitfields2.gws_control_queue = q->properties.is_gws ? 1 : 0;
 	packet->bitfields2.extended_engine_sel =
 		extended_engine_sel__mes_map_queues__legacy_engine_sel;
 	packet->bitfields2.queue_type =



