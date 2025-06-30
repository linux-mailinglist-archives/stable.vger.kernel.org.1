Return-Path: <stable+bounces-158933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 385A3AEDB36
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 13:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9EB178D26
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD9225F780;
	Mon, 30 Jun 2025 11:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bazfT99n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD50425D21A
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283331; cv=none; b=dzDw6wfnYWV0CSGzsRCeqORToBzIVbonKxmG5gZuya7r5Y3apy8jaQtum08i556ymgc1TLols/JqshLb7xexw4nIQ6nmbumdlBvdI/y0Ae+lRso8JQj9lXLwqip3PBU9vtqxZfJ66Dhghuo3uXoNWDuudlBBYrOw+FcLv6aff4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283331; c=relaxed/simple;
	bh=P819Ip2ZTZd1FHh9x9io678l10+e6RVICuFVSEHI/Jc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a81ujG6/GhOPHlm7AQYQHA5UbQxghjQJ22X8Efzx5FgfRYiU65P1OKwNTIKzxhPhEJuOOx9i5MK/UhJsxdIgJ/qM3DW+QIJlzxQp3SrxgUfu8Iee1PJot+upIpUHI+ayGUusGyplyDGBHvGng9ErfrrwYDsHpkhNALg/9DieNO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bazfT99n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA479C4CEE3;
	Mon, 30 Jun 2025 11:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751283331;
	bh=P819Ip2ZTZd1FHh9x9io678l10+e6RVICuFVSEHI/Jc=;
	h=Subject:To:Cc:From:Date:From;
	b=bazfT99nY5EZg9zvYJxtE16nQkE2zGpUL+nLDnCSGXWkDLrGfu0PPdcmkHEYRvJNi
	 GD9bNu8zIHQrwZ8pXBJoupmPbr8SC+B4qVSYifjJg2rGmHmGqbCuHGnS5TNuTrZuMy
	 FoaB3wMhOB9vqz8J9sMRy45IMFKJnpvrHM5yG2RE=
Subject: FAILED: patch "[PATCH] drm/amd/display: Add null pointer check for" failed to apply to 5.10-stable tree
To: vulab@iscas.ac.cn,alex.hung@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 13:35:28 +0200
Message-ID: <2025063028-crayon-registry-8ae0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c3e9826a22027a21d998d3e64882fa377b613006
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063028-crayon-registry-8ae0@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c3e9826a22027a21d998d3e64882fa377b613006 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Mon, 26 May 2025 10:37:31 +0800
Subject: [PATCH] drm/amd/display: Add null pointer check for
 get_first_active_display()

The function mod_hdcp_hdcp1_enable_encryption() calls the function
get_first_active_display(), but does not check its return value.
The return value is a null pointer if the display list is empty.
This will lead to a null pointer dereference in
mod_hdcp_hdcp2_enable_encryption().

Add a null pointer check for get_first_active_display() and return
MOD_HDCP_STATUS_DISPLAY_NOT_FOUND if the function return null.

Fixes: 2deade5ede56 ("drm/amd/display: Remove hdcp display state with mst fix")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # v5.8

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 8c137d7c032e..e58e7b93810b 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -368,6 +368,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable_encryption(struct mod_hdcp *hdcp)
 	struct mod_hdcp_display *display = get_first_active_display(hdcp);
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
+	if (!display)
+		return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
+
 	mutex_lock(&psp->hdcp_context.mutex);
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));


