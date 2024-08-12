Return-Path: <stable+bounces-66612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 252D394F05C
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50351F23635
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6E6183CBF;
	Mon, 12 Aug 2024 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lf9fhFRW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F635183CB7
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474151; cv=none; b=cbHldu6JGh3UO4Dxcg01jMzfwwz4P8o4C+g3sIy2PgMNRtVSIUz8RkC4SxrAzHT+3G+Wjaad/lMohbEDJs+cS3QlDvW0n1x1ip8Z3zagt4mVxejztrF6teEti1xvmJsSzI40iqp0JQ1K627iVUwV8KCAe2ihvotoXLlwnEP/62k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474151; c=relaxed/simple;
	bh=WlaVIE/QuPqvMjGeC2XXZz0YvRiJxJu7MMwqjBJnylg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MuEBOlyk6vVvyd06J9kAwffLhDReJyLec8/jV5l4z9X4lzLsdAbsMdchvsksvTcEIDmZ3ngUsesxZseS5vCUr0fQKAEobDcUDHEFbu8tpDRw5M7xiCz/PjEQLitzIHlZOqNgUFMo5YiLw8Ij5iPvnUZGSE0Ryrf7TKp6iIQVjD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lf9fhFRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA74C32782;
	Mon, 12 Aug 2024 14:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474151;
	bh=WlaVIE/QuPqvMjGeC2XXZz0YvRiJxJu7MMwqjBJnylg=;
	h=Subject:To:Cc:From:Date:From;
	b=Lf9fhFRW00r9XDsoKNaN3R0X2PzDO25TRb7egnvAvlT0DT34QI53yHU079ie5gpZD
	 g/NytGCUepcl8B0hfEOkz/Ofo8uUq1pZwwTTyl+yasZ9SuVmu7YA7RfSk8yXf6+6Ni
	 P35llFpRynAywNVdUCipPWTYYEdJSn2qQdWANT6E=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix cursor size issues" failed to apply to 6.10-stable tree
To: nevenko.stupar@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,sridevi.arvindekar@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:48:14 +0200
Message-ID: <2024081214-remote-glove-1abe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 51dbe0239b1fc7c435867ce28e5eb4394b6641e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081214-remote-glove-1abe@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

51dbe0239b1f ("drm/amd/display: Fix cursor size issues")
70839da63605 ("drm/amd/display: Add new DCN401 sources")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 51dbe0239b1fc7c435867ce28e5eb4394b6641e1 Mon Sep 17 00:00:00 2001
From: Nevenko Stupar <nevenko.stupar@amd.com>
Date: Tue, 11 Jun 2024 12:31:38 -0400
Subject: [PATCH] drm/amd/display: Fix cursor size issues

[WHY & HOW]
Fix the cursor size between ODM slices.

Reviewed-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nevenko Stupar <nevenko.stupar@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 0cf55f557c3c..42753f56d31d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1169,6 +1169,20 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		x_pos -= (prev_odm_width + prev_odm_offset);
 	}
 
+	/* If the position is negative then we need to add to the hotspot
+	 * to fix cursor size between ODM slices
+	 */
+
+	if (x_pos < 0) {
+		pos_cpy.x_hotspot -= x_pos;
+		x_pos = 0;
+	}
+
+	if (y_pos < 0) {
+		pos_cpy.y_hotspot -= y_pos;
+		y_pos = 0;
+	}
+
 	pos_cpy.x = (uint32_t)x_pos;
 	pos_cpy.y = (uint32_t)y_pos;
 


