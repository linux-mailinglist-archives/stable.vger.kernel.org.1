Return-Path: <stable+bounces-16129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF7383F0E7
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421771F21719
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E5E1EB47;
	Sat, 27 Jan 2024 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QqrxZWV/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FE51EA66
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706395061; cv=none; b=KnxAIux8gXYyXzjq8kfLRBLIfoqklWENoxTXMDuZh6qvnR+vvtvqgZ9CkRKPGrO0vtiKITzgaRgIMsSBoYkfvGp/UgFxfeb3eaJdVabs0ssQocywMBKBvzFJDYK6km3KlIJYRARlH96eJn9L/RMVGsq+gbL5md112E7QZxHXx00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706395061; c=relaxed/simple;
	bh=OcTqSyg0uk/ykh1RFLqmbK6uG6SCdZfeEodTwtQCYUI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ixtK121vvDn18hqJ1TG/Q3Q+monfil3sW5Zy1ceqf7M+17LWneR9MdIPeAHQxaFtWRpds3ixiWJqkiRmu8ka0t2ehAMYt0xF7Khu/zm0tvP7ydD3Y/GKIhOZXC6Cqptnl5Nd/2nY7MNWBFZZioNU9BOLicw+3LvopQKnrUWV1iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QqrxZWV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BD9C433C7;
	Sat, 27 Jan 2024 22:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706395061;
	bh=OcTqSyg0uk/ykh1RFLqmbK6uG6SCdZfeEodTwtQCYUI=;
	h=Subject:To:Cc:From:Date:From;
	b=QqrxZWV/QW8DbDvvNi6DB/NKWfe2o0Ned1uQ3XidoHOgdeR0ZQnsW5Fql6Js10os8
	 FTj8SZdc3fgrRlUJIZ1HB4Y0V370zrVopTk+HjXxj/evyGvLOuTsZsKFFa6w7YuxCn
	 dUBfnrUDg1ccz2SV9FbAD3BSD6KQNNkqbmmGsld4=
Subject: FAILED: patch "[PATCH] drm/amd/display: Disable PSR-SU on Parade 0803 TCON again" failed to apply to 6.6-stable tree
To: mario.limonciello@amd.com,Hamza.Mahfooz@amd.com,Marc.Rossi@amd.com,alexander.deucher@amd.com,harry.wentland@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:37:40 -0800
Message-ID: <2024012739-anchor-unflawed-5e21@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 571c2fa26aa654946447c282a09d40a56c7ff128
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012739-anchor-unflawed-5e21@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

571c2fa26aa6 ("drm/amd/display: Disable PSR-SU on Parade 0803 TCON again")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 571c2fa26aa654946447c282a09d40a56c7ff128 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Mon, 19 Jun 2023 15:04:24 -0500
Subject: [PATCH] drm/amd/display: Disable PSR-SU on Parade 0803 TCON again

When screen brightness is rapidly changed and PSR-SU is enabled the
display hangs on panels with this TCON even on the latest DCN 3.1.4
microcode (0x8002a81 at this time).

This was disabled previously as commit 072030b17830 ("drm/amd: Disable
PSR-SU on Parade 0803 TCON") but reverted as commit 1e66a17ce546 ("Revert
"drm/amd: Disable PSR-SU on Parade 0803 TCON"") in favor of testing for
a new enough microcode (commit cd2e31a9ab93 ("drm/amd/display: Set minimum
requirement for using PSR-SU on Phoenix")).

As hangs are still happening specifically with this TCON, disable PSR-SU
again for it until it can be root caused.

Cc: stable@vger.kernel.org
Cc: aaron.ma@canonical.com
Cc: binli@gnome.org
Cc: Marc Rossi <Marc.Rossi@amd.com>
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2046131
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index a522a7c02911..1675314a3ff2 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -839,6 +839,8 @@ bool is_psr_su_specific_panel(struct dc_link *link)
 				((dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x08) ||
 				(dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x07)))
 				isPSRSUSupported = false;
+			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x03)
+				isPSRSUSupported = false;
 			else if (dpcd_caps->psr_info.force_psrsu_cap == 0x1)
 				isPSRSUSupported = true;
 		}


