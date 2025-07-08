Return-Path: <stable+bounces-161231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69254AFD401
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E3E17FE64
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE262E62AD;
	Tue,  8 Jul 2025 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L0DKlPQK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F432E5B09;
	Tue,  8 Jul 2025 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993975; cv=none; b=AoUGqnq/UUmUW9mbAKM9//blLATY04VwiRLyWA1cjsd2tlUiWEmtyD8pF3CfQ9TBzkfO9QavW5y4tBx7j4MRo9uDlt8UdfSFNRBrdZYRrpKtY0/66HRuhPZfPtItl30/5LfV8GP4eW/21JE6slFDwdl8crLiD6f63tVdbW3Z6tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993975; c=relaxed/simple;
	bh=fw6X2TlMemsczCOsNDZPixRUmknJmQc5zVkXTMsAQAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLwh5tnq/flHUx4dwYpIfy4HsA3xoLF1Mldj8Mo/dPdHdEFYBgZetX+eHbpr+962V3cBpBLhDv2stUwDCDvVtoOTHE9zqwxhXfL5UkxwbUaYjQk9ZTk8zSsFqGWR8wHGgI5e9SMA5MdBcac47TAEx224hhZfDQsm55h8Ufv7JMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L0DKlPQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215BDC4CEED;
	Tue,  8 Jul 2025 16:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993975;
	bh=fw6X2TlMemsczCOsNDZPixRUmknJmQc5zVkXTMsAQAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L0DKlPQKs1jK2X4WcBPQuHJYyNF60nACssLlaOT+Qhhtjw2pOW0KgBpEAggjm5os+
	 +B2Uacg6tyzVrEneFCZ0x5KeuJbs2WA35Jb5JlJJBC+BTZtmaJpX22cubiH0cCuk2q
	 8lmpawkHKdcX/AcJwBl8O6AMzZ8tvtEK9omm37tg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jay Cornwall <jay.cornwall@amd.com>,
	Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15 083/160] drm/amdkfd: Fix race in GWS queue scheduling
Date: Tue,  8 Jul 2025 18:22:00 +0200
Message-ID: <20250708162233.828574970@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162231.503362020@linuxfoundation.org>
References: <20250708162231.503362020@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -195,7 +195,7 @@ static int pm_map_queues_v9(struct packe
 
 	packet->bitfields2.engine_sel =
 		engine_sel__mes_map_queues__compute_vi;
-	packet->bitfields2.gws_control_queue = q->gws ? 1 : 0;
+	packet->bitfields2.gws_control_queue = q->properties.is_gws ? 1 : 0;
 	packet->bitfields2.extended_engine_sel =
 		extended_engine_sel__mes_map_queues__legacy_engine_sel;
 	packet->bitfields2.queue_type =



