Return-Path: <stable+bounces-192120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D72AC29BF0
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 01:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 321D04EDB79
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 00:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0972116F4;
	Mon,  3 Nov 2025 00:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CfQxATP1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BC88479
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 00:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762131054; cv=none; b=jdPbos0eterYPyEPBVWVe+sWGifWIc0JnRUl5pSzDMq9FFRYM9cO2dj3728A9gNvZvEgSD4LJuYmT5Zg22+3rLvQFXqDw4iI7V/dAWj75N9MIZaYcRL0RC+TnKSWhTPklZ4N03ZD/5PWj54uieQyUzaPIh/p9Gbk2/ThwqFFRgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762131054; c=relaxed/simple;
	bh=BqktY+CgmrRJdrueniN8dKVOjengjG5mbMfA2o60lJ4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=klvKPPGINxUs3184AxzEFcWLMFY83ORY05EWnsCeLXnOVki48ajQLsCyY+fDPSh01HkfiS/6T0AeV+HDLiru/iXgR5CzKDW50EVHD0LXi2bzLgzXLJdHVv98gt5iRJTpq/9PRbGneOQXhBdlg/wT8WkFP20o4swheg2Xnvg9lvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CfQxATP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41682C4CEF7;
	Mon,  3 Nov 2025 00:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762131053;
	bh=BqktY+CgmrRJdrueniN8dKVOjengjG5mbMfA2o60lJ4=;
	h=Subject:To:Cc:From:Date:From;
	b=CfQxATP1m1H0ipyN9Z63CTDnS1H7uXxbHwY8auQOT6p4ZPnp5mjmG5txMaXM7cZWX
	 eLVlOT8bcG7e0JY1j7G53qzY9kTE4xVQsS0YCaund17B75BMHRJ2n96N5DZWB2zsWw
	 j9Mt2r99F/36uTNveFmXgLS+BlUAL1bUszHXqYzk=
Subject: FAILED: patch "[PATCH] drm/sched: Fix race in drm_sched_entity_select_rq()" failed to apply to 6.6-stable tree
To: phasta@kernel.org,tvrtko.ursulin@igalia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 03 Nov 2025 09:50:42 +0900
Message-ID: <2025110342-pristine-visibly-505b@gregkh>
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
git cherry-pick -x d25e3a610bae03bffc5c14b5d944a5d0cd844678
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110342-pristine-visibly-505b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


