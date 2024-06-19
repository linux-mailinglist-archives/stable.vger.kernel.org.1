Return-Path: <stable+bounces-53741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FA490E5F7
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25221F24107
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBACA7F47F;
	Wed, 19 Jun 2024 08:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jukIkMEh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5CB7E761
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786316; cv=none; b=u/isATK5iQsl2ciWyW7j7pIgJRHM3eaUqEa71BIPQo5XQ4ySWjHoC0t28EJs4zQ2+mLyZu7IlaKLxKgkxkaKTJ0fBQMl/1iT4EpKiNpIRmJi0RtzwXzxWrXspnJj2AIIAW22tKB4HDELY6oW83j8Spfb8jEnk/4JK810yT+gT1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786316; c=relaxed/simple;
	bh=oSiUmTDFmyOEsuEX1zEksJEd+gBu9C01vBl+7vMxgPo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pSOg9aMSXVN0wtXoCb6QN6pDuO2u6Z2CA+wQmFZiPsODJMbRpBLZtCdtkDq8nCe84sNXyuIucmQaTDYXYb15mZIJUluyxT4ijIiFx1GxtCr+G/etCzZ5nT+iUwrGF9hkHLHY2+LXat8qndYpSvQWDJaG/9ZFYQDpnzcMWK4ccBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jukIkMEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC16C32786;
	Wed, 19 Jun 2024 08:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786316;
	bh=oSiUmTDFmyOEsuEX1zEksJEd+gBu9C01vBl+7vMxgPo=;
	h=Subject:To:Cc:From:Date:From;
	b=jukIkMEhOGD8278PvzQkN0OLBxICh/TAX46XpccG2+DHdarfh51qqgh3aOXywh2Bi
	 3vqYCc4pNa3+Six85iPpkiWYhF5MI4fkCYzTeFozp8eI4PgmpeHPrYJpd3oF1Jk4B7
	 5qsOb+ViCaE2vTKEjK5/7NPLr52Y5eGIJXQWDTuQ=
Subject: FAILED: patch "[PATCH] drm/amd/display: always reset ODM mode in context when adding" failed to apply to 5.15-stable tree
To: wenjing.liu@amd.com,alexander.deucher@amd.com,alvin.lee2@amd.com,hamza.mahfooz@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:38:24 +0200
Message-ID: <2024061924-exposure-switch-47ef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4a5b171299e59d51322f4c6bd376c5acbeca0a4a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061924-exposure-switch-47ef@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

4a5b171299e5 ("drm/amd/display: always reset ODM mode in context when adding first plane")
09a4ec5da92c ("drm/amd/display: Refactor dc_state interface")
abd26a3252cb ("drm/amd/display: Add dml2 copy functions")
ed6e2782e974 ("drm/amd/display: For cursor P-State allow for SubVP")
f583db812bc9 ("drm/amd/display: Update FAMS sequence for DCN30 & DCN32")
ddd5298c63e4 ("drm/amd/display: Update cursor limits based on SW cursor fallback limits")
7966f319c66d ("drm/amd/display: Introduce DML2")
6e2c4941ce0c ("drm/amd/display: Move dml code under CONFIG_DRM_AMD_DC_FP guard")
13c0e836316a ("drm/amd/display: Adjust code style for hw_sequencer.h")
1288d7020809 ("drm/amd/display: Improve x86 and dmub ips handshake")
ad3b63a0d298 ("drm/amd/display: add new windowed mpo odm minimal transition sequence")
177ea58bef72 ("drm/amd/display: reset stream slice count for new ODM policy")
c0f8b83188c7 ("drm/amd/display: disable IPS")
93a66cef607c ("drm/amd/display: Add IPS control flag")
dc01c4b79bfe ("drm/amd/display: Update driver and IPS interop")
83b5b7bb8673 ("drm/amd/display: minior logging improvements")
15c6798ae26d ("drm/amd/display: add seamless pipe topology transition check")
c06ef68a7946 ("drm/amd/display: Add check for vrr_active_fixed")
c51d87202d1f ("drm/amd/display: do not attempt ODM power optimization if minimal transition doesn't exist")
a4246c635166 ("drm/amd/display: fix the white screen issue when >= 64GB DRAM")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4a5b171299e59d51322f4c6bd376c5acbeca0a4a Mon Sep 17 00:00:00 2001
From: Wenjing Liu <wenjing.liu@amd.com>
Date: Fri, 22 Mar 2024 15:02:45 -0400
Subject: [PATCH] drm/amd/display: always reset ODM mode in context when adding
 first plane

[why]
In current implemenation ODM mode is only reset when the last plane is
removed from dc state. For any dc validate we will always remove all
current planes and add new planes. However when switching from no planes
to 1 plane, ODM mode is not reset because no planes get removed. This
has caused an issue where we kept ODM combine when it should have been
remove when a plane is added. The change is to reset ODM mode when
adding the first plane.

Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index d1d326e9b9b6..4f9ef07d29ec 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -458,6 +458,15 @@ bool dc_state_add_plane(
 		goto out;
 	}
 
+	if (stream_status->plane_count == 0 && dc->config.enable_windowed_mpo_odm)
+		/* ODM combine could prevent us from supporting more planes
+		 * we will reset ODM slice count back to 1 when all planes have
+		 * been removed to maximize the amount of planes supported when
+		 * new planes are added.
+		 */
+		resource_update_pipes_for_stream_with_slice_count(
+				state, dc->current_state, dc->res_pool, stream, 1);
+
 	otg_master_pipe = resource_get_otg_master_for_stream(
 			&state->res_ctx, stream);
 	if (otg_master_pipe)


