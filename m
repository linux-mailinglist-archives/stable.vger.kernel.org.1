Return-Path: <stable+bounces-16199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9968783F1A2
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55504283E56
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C442200BD;
	Sat, 27 Jan 2024 23:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RibBzMfi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E42C1B80B
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397157; cv=none; b=KotHBSktPbD1myvJZbGObNle7JatjFfdkjUPgFmajbnVlfWp69Yt633Eji0ZoS4bDAFVpG6hIeK6ekjEYHAtw42o/SRj7hviylX1lVfFLuQYLwJWk40uFhHGL/HS3PDN8iVZLw0MH8DFSBu7AGziVi7TO20Yfi6B7WSZy2LgyO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397157; c=relaxed/simple;
	bh=rVtN6yl2e37dnk0lAxFqVmmZ252+ylBFHo0JXvYHSVk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=blCwIutsB7Qw/TZpLSy3y2WYI8ks9OLjLLBrOpBfuOUInz+0HO2BJvlqhrQbazvM5LJZ7Lvi7x3InI6T/IqhGdlvgQOFKw3cUh8fSvUlyFB3pNJhwxRgt82nfw3lBZ3tdpyXK4ywrl/Cldk5zSBxBl8z3qxkfaeN9/dBaH/Bpew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RibBzMfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D57C433C7;
	Sat, 27 Jan 2024 23:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397157;
	bh=rVtN6yl2e37dnk0lAxFqVmmZ252+ylBFHo0JXvYHSVk=;
	h=Subject:To:Cc:From:Date:From;
	b=RibBzMfi0KgXDev3wWktjLgObxMyhxD5E5lZXQ6SrGWSuOn6OmtZmBO6/cU8Wup0I
	 7MV22L2DdVpz95bxpC0+dcja8IYRCDdMODY5OuPprKSGnln8sqanfrykUQHJ4O7hGk
	 zmeeAO/1T3+bhM5CFUQWFPxPcZvPV9TDjUyaBbvc=
Subject: FAILED: patch "[PATCH] drm/amd/display: Include udelay when waiting for INBOX0 ACK" failed to apply to 6.1-stable tree
To: alvin.lee2@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,samson.tam@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:12:36 -0800
Message-ID: <2024012735-vaguely-choking-d13a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1c22d6ce53280763bcb4cb24d4f71111fff4a526
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012735-vaguely-choking-d13a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

1c22d6ce5328 ("drm/amd/display: Include udelay when waiting for INBOX0 ACK")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1c22d6ce53280763bcb4cb24d4f71111fff4a526 Mon Sep 17 00:00:00 2001
From: Alvin Lee <alvin.lee2@amd.com>
Date: Mon, 6 Nov 2023 11:20:15 -0500
Subject: [PATCH] drm/amd/display: Include udelay when waiting for INBOX0 ACK

When waiting for the ACK for INBOX0 message,
we have to ensure to include the udelay
for proper wait time

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 22fc4ba96def..38360adc53d9 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -1077,6 +1077,7 @@ enum dmub_status dmub_srv_wait_for_inbox0_ack(struct dmub_srv *dmub, uint32_t ti
 		ack = dmub->hw_funcs.read_inbox0_ack_register(dmub);
 		if (ack)
 			return DMUB_STATUS_OK;
+		udelay(1);
 	}
 	return DMUB_STATUS_TIMEOUT;
 }


