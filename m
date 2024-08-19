Return-Path: <stable+bounces-69542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3D89567CD
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 12:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E682835CE
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 10:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128BC15DBD8;
	Mon, 19 Aug 2024 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OVXaIlAs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74B515ECC9
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061941; cv=none; b=iWOUi/jBuwW+EsN8cYbkFUmWe/URyrB0CcMXBzWThSx4aZFn7Na/pp5TyTQq9DPpJcmH1Eht/p+/YSlNkixGQecvIhFdzTkq4q1rhDj88xLK5AM3T+2SO14RMpbfsdUk55AQN3afzlzX0KYgQAGX5tN930xT8V09AKIeV6g7l/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061941; c=relaxed/simple;
	bh=4i7o4jCijZl5YZmVi12s4l7fri0a8KWL7NqtAEphJFE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lUK7dXM8IYd7Uq2CovqSR4xXfcvNd3JYLWJzoxdLQzGofkWF9SzRRK5PKAQG3l2CHJu2oqfpuOkLtKA8ur3O3HycuzO+F2hvwkC2jcxK667v0b/KusFB1w/KLTeWndhVHUdTOicHSFXtn+xC0NX9GNrWHdnVhWaBCGZIL5vo9bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OVXaIlAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE47BC32782;
	Mon, 19 Aug 2024 10:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724061941;
	bh=4i7o4jCijZl5YZmVi12s4l7fri0a8KWL7NqtAEphJFE=;
	h=Subject:To:Cc:From:Date:From;
	b=OVXaIlAse/dQQ3cR4pPiyoeIJhq3VfQW5e38+xs1ku/hwL+BLQ2R+n9uBkUMe/2hL
	 dMR3ndOhpMn+5ed4GdXmziGQyEVqbKj+ioC6cxXzclYuY77mKcvevoc73cUs1KJJWS
	 uqT5ExnrGNl3Ma/jTNcrjW4l2kZYNmtQY9ZJrfFo=
Subject: FAILED: patch "[PATCH] selinux: add the processing of the failure of" failed to apply to 5.4-stable tree
To: thunder.leizhen@huawei.com,paul@paul-moore.com,stephen.smalley.work@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 12:05:34 +0200
Message-ID: <2024081934-daffodil-dingy-d012@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 6dd1e4c045afa6a4ba5d46f044c83bd357c593c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081934-daffodil-dingy-d012@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


