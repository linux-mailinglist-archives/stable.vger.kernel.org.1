Return-Path: <stable+bounces-192122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2315CC29BCC
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 01:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2433A5F92
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 00:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD2C215F42;
	Mon,  3 Nov 2025 00:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JiFdufYf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA46213E6D
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 00:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762131058; cv=none; b=gabMGLnKkyLG8zmU//9zFZewNINEW815JZK8ezafZRfCZO/jmXFo9ELwTU2Fg2PN32ceJXi6fQ3k+XhjGPx2Tdax1shPw0nlu+LEheiO+mLlsHlMruK9a4L3e5cNmxOdj84qy0Hy06qig1s/M3DHnJm7JCcf5x/U1KDKxot8Cdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762131058; c=relaxed/simple;
	bh=Mg2J/l/nvJQSW/vY5bso0XOxGl3Qsp7yO8YPXMviitc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CozS20EMrwlThNK2axqXFyaGvFf1wcQRWT4jO/JU7b7m97B1qoGeqlHxQYzBKct/U3suGM41EGkpiFx728Kw15CePbQzjgg8aDEiAVDjYejUDNhkLwR30bigh/II+jyyLaiDphmw3/wovIj1gON6UuzBbvfyoWvJOCh/ocryD10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JiFdufYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08096C4CEF7;
	Mon,  3 Nov 2025 00:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762131058;
	bh=Mg2J/l/nvJQSW/vY5bso0XOxGl3Qsp7yO8YPXMviitc=;
	h=Subject:To:Cc:From:Date:From;
	b=JiFdufYfCkYrVlbhA2TMFBHMqGzXSQ1OIf/nEXte/YvGGKP/ueRGeRzrq37RtqQBU
	 2gFCF0njoF1yiJ43gX7gEioFEa9wa7JNEA3m2ErW/dL+KXYqihs59Z3FXmtCTVAau0
	 rNuFE5/ev1ubbIHscxj0QBV6MIBmlGn3dz39CaBk=
Subject: FAILED: patch "[PATCH] drm/sched: Fix race in drm_sched_entity_select_rq()" failed to apply to 5.15-stable tree
To: phasta@kernel.org,tvrtko.ursulin@igalia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 03 Nov 2025 09:50:44 +0900
Message-ID: <2025110344-huntress-jittery-3aee@gregkh>
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
git cherry-pick -x d25e3a610bae03bffc5c14b5d944a5d0cd844678
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110344-huntress-jittery-3aee@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d25e3a610bae03bffc5c14b5d944a5d0cd844678 Mon Sep 17 00:00:00 2001
From: Philipp Stanner <phasta@kernel.org>
Date: Wed, 22 Oct 2025 08:34:03 +0200
Subject: [PATCH] drm/sched: Fix race in drm_sched_entity_select_rq()

In a past bug fix it was forgotten that entity access must be protected
by the entity lock. That's a data race and potentially UB.

Move the spin_unlock() to the appropriate position.

Cc: stable@vger.kernel.org # v5.13+
Fixes: ac4eb83ab255 ("drm/sched: select new rq even if there is only one v3")
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Philipp Stanner <phasta@kernel.org>
Link: https://patch.msgid.link/20251022063402.87318-2-phasta@kernel.org

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 5a4697f636f2..aa222166de58 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -552,10 +552,11 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 		drm_sched_rq_remove_entity(entity->rq, entity);
 		entity->rq = rq;
 	}
-	spin_unlock(&entity->lock);
 
 	if (entity->num_sched_list == 1)
 		entity->sched_list = NULL;
+
+	spin_unlock(&entity->lock);
 }
 
 /**


