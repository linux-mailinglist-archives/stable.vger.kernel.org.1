Return-Path: <stable+bounces-66709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BE094F0D0
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5581C20897
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C709172773;
	Mon, 12 Aug 2024 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n7+HYToX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B254B5AE
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474487; cv=none; b=m0DIlZYxzOKMZuiKRX1wUf2CgiR3IzIVeWDQhOATZRQ5LYRGffbM/hDNpJXu3LBQOpDV9/cD+NXpB4KFbsg53B4geSnFPz2LUQbpvflf2VUtz2XHsIfuwPJaY3gRn7tQf3gm9/jTdtp1OZ/w4BBLt7mAMqfOfPotl5cgdNvNKkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474487; c=relaxed/simple;
	bh=EOLA/JbtBHf41O3yXXdnP+/UXW7KV+KrqIND3Y5UsIg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I4mBoZ1A02+f8QTZqqctBKj4mn74Et/sxiEeGczitothGdl/fAaCTRcdJHna08s+nFqvJYIabJUsRIo6ZH3ItDJm/T7MhmqXYABmqEUT8c7r/ieZpJUWxsGEHTDR1RASKZhWOrdR1ksClwSFj64JAwf4ahyAy6Q8Wuen1jUIIAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n7+HYToX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5FAC32782;
	Mon, 12 Aug 2024 14:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474486;
	bh=EOLA/JbtBHf41O3yXXdnP+/UXW7KV+KrqIND3Y5UsIg=;
	h=Subject:To:Cc:From:Date:From;
	b=n7+HYToXNF/0EpxRIlG3G6lcFWYYn8PpIFnJoekxG/zSq0JQIon9kZDV6bFWkXVMD
	 gdcqM/Tdzxkfvk7V/kmU24L9c7DtFdXW1RCXP4fpHFCHM/flLbB6HFGSNRv/HqlzNU
	 jmGmaJTS7uhTvSdi8Pt2FJes16btJrzQ4k5QTdLs=
Subject: FAILED: patch "[PATCH] drm/amd/display: Add null check in" failed to apply to 4.19-stable tree
To: natanel.roizenman@amd.com,alexander.deucher@amd.com,aurabindo.pillai@amd.com,daniel.wheeler@amd.com,nicholas.kazlauskas@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:52:00 +0200
Message-ID: <2024081259-embroider-washout-7794@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 899d92fd26fe780aad711322aa671f68058207a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081259-embroider-washout-7794@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

899d92fd26fe ("drm/amd/display: Add null check in resource_log_pipe_topology_update")
5db346c256bb ("drm/amd/display: update pipe topology log to support subvp")
012fe0674af0 ("drm/amd/display: Add logging resource checks")
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

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 899d92fd26fe780aad711322aa671f68058207a6 Mon Sep 17 00:00:00 2001
From: Natanel Roizenman <natanel.roizenman@amd.com>
Date: Wed, 3 Apr 2024 16:52:48 -0400
Subject: [PATCH] drm/amd/display: Add null check in
 resource_log_pipe_topology_update

[WHY]
When switching from "Extend" to "Second Display Only" we sometimes
call resource_get_otg_master_for_stream on a stream for the eDP,
which is disconnected. This leads to a null pointer dereference.

[HOW]
Added a null check in dc_resource.c/resource_log_pipe_topology_update.

CC: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Natanel Roizenman <natanel.roizenman@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 6831b0151705..bb43c62e959a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2302,6 +2302,10 @@ void resource_log_pipe_topology_update(struct dc *dc, struct dc_state *state)
 
 		otg_master = resource_get_otg_master_for_stream(
 				&state->res_ctx, state->streams[stream_idx]);
+
+		if (!otg_master)
+			continue;
+
 		resource_log_pipe_for_stream(dc, state, otg_master, stream_idx);
 	}
 	if (state->phantom_stream_count > 0) {


