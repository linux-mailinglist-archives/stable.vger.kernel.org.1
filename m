Return-Path: <stable+bounces-192121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA60C29BDE
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 01:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87951892289
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 00:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798A9212FAA;
	Mon,  3 Nov 2025 00:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tLhVZiwA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36696210F59
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 00:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762131056; cv=none; b=W7giOGdQ2XQ3WqIsX5/PlcOH0kimiRwCcheZKx190sQCy9uFBNjNbh2sztIyrugbVgygTecaiDcz5MjlSnRtmt/a8N3OxQu/3iEFeKr4GF0vIIz1NiZZp6UTKuUqaDg/WMQSqQwwS1DLDjaN/czeO5svma1ZhuUUZ0LWtIwqBkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762131056; c=relaxed/simple;
	bh=7ZtX4+3wtkLm1dAJhYt/15J/4DG0/+e0vGZuvA/Abco=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jwyECUw5BSCgEc7sYiSG5U8Eo+2UllQwGRDLoy3cXAZKv4NggW5DCDXQnGAkYcqTNXA4xhao1U1x0H1OzKSEebWuLN05iyOwO72oKno51GUwnKALbj6ha3OSwIhf7PnaaL9GAftbXQ3MfJu1Toj7fvS4HwTrVoubHHxi/0oZQeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tLhVZiwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F636C4CEF7;
	Mon,  3 Nov 2025 00:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762131055;
	bh=7ZtX4+3wtkLm1dAJhYt/15J/4DG0/+e0vGZuvA/Abco=;
	h=Subject:To:Cc:From:Date:From;
	b=tLhVZiwAf9V+KfKBnm2AozBWpVl719xAy2AmqBAndGghI+zp7tRkXgYlnTErlP6/Z
	 JIByb3B2qo8O34N4uB3EjuIrZxtmzrr2ATkjYe98m2mcS+Qt84h7YcAn7YfFqUqcDp
	 Yvqim9K5vbgjOHMHIcAI1F0YpIA5Avt1ZR93X/yM=
Subject: FAILED: patch "[PATCH] drm/sched: Fix race in drm_sched_entity_select_rq()" failed to apply to 6.1-stable tree
To: phasta@kernel.org,tvrtko.ursulin@igalia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 03 Nov 2025 09:50:43 +0900
Message-ID: <2025110343-daffodil-target-5d2b@gregkh>
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
git cherry-pick -x d25e3a610bae03bffc5c14b5d944a5d0cd844678
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110343-daffodil-target-5d2b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


