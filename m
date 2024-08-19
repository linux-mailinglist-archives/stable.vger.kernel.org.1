Return-Path: <stable+bounces-69539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F08C59567C8
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 12:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9962F1F22A21
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 10:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222961553A6;
	Mon, 19 Aug 2024 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WhQhJTTQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65DB1537DE
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061935; cv=none; b=f+sHKiOLqRjOiD2PTJgcKlzA5YLbSdi8LFy07rtvYJaCosM87iY+wCz1PKPhy60Dcaqrm9i5bejFyaqtYb01G7Ocl0p8YdNMNvL/d9bHLvVko/7dTgvnVs2upDgGwQKSDNsDmn3MFKsUw3Kilj84OHQZV8glKHf0mSRftVTU9Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061935; c=relaxed/simple;
	bh=XGZygzfFCtB7eIkWlxDQnflKry6S4TRze+fUpoPwpPA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SNBf9+FG1R56nul+byMIFNLUG/db1/eag3QqVKvGsymatOUT6tiPVka+kTi27+0e6HuDJrGnkxfi07Jt7An/fLi1s5UQ6dspKNkmkjR39nk+whRgf6HJA7VCKqHAJF74NJHmY8GGU+lJygLxjyzgX7z1UInkEm7D6yQ20V3kNv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WhQhJTTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148ECC4AF09;
	Mon, 19 Aug 2024 10:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724061935;
	bh=XGZygzfFCtB7eIkWlxDQnflKry6S4TRze+fUpoPwpPA=;
	h=Subject:To:Cc:From:Date:From;
	b=WhQhJTTQX3rVzZBzlSw+C7NJ+I+riIFLvZMrV5T+TGNPez1k/SIveiXws0I+oLwBV
	 5EQy+yOo73Xa9YjDGCEjCbReZsJQaiS/M+0Xiezs1MnE9YiSm3RUUwh7l/JY6HTCMS
	 MgyJ+69KqBoiT8cIGe3kibYef6RpdC4x6iGzNcf4=
Subject: FAILED: patch "[PATCH] selinux: add the processing of the failure of" failed to apply to 6.1-stable tree
To: thunder.leizhen@huawei.com,paul@paul-moore.com,stephen.smalley.work@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 12:05:32 +0200
Message-ID: <2024081932-idealism-parabola-3435@gregkh>
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
git cherry-pick -x 6dd1e4c045afa6a4ba5d46f044c83bd357c593c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081932-idealism-parabola-3435@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

6dd1e4c045af ("selinux: add the processing of the failure of avc_add_xperms_decision()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6dd1e4c045afa6a4ba5d46f044c83bd357c593c2 Mon Sep 17 00:00:00 2001
From: Zhen Lei <thunder.leizhen@huawei.com>
Date: Wed, 7 Aug 2024 17:00:56 +0800
Subject: [PATCH] selinux: add the processing of the failure of
 avc_add_xperms_decision()

When avc_add_xperms_decision() fails, the information recorded by the new
avc node is incomplete. In this case, the new avc node should be released
instead of replacing the old avc node.

Cc: stable@vger.kernel.org
Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 7087cd2b802d..b49c44869dc4 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -907,7 +907,11 @@ static int avc_update_node(u32 event, u32 perms, u8 driver, u8 xperm, u32 ssid,
 		node->ae.avd.auditdeny &= ~perms;
 		break;
 	case AVC_CALLBACK_ADD_XPERMS:
-		avc_add_xperms_decision(node, xpd);
+		rc = avc_add_xperms_decision(node, xpd);
+		if (rc) {
+			avc_node_kill(node);
+			goto out_unlock;
+		}
 		break;
 	}
 	avc_node_replace(node, orig);


