Return-Path: <stable+bounces-69543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C16AF9567CE
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 12:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4992835EC
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 10:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E233B15ECC4;
	Mon, 19 Aug 2024 10:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xrm3UdGc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3D915E5BD
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 10:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061944; cv=none; b=YwIFUsWKG/C3Qb9LtG67QS6NOUdMw0kWq/57q4wyCYRpS7AKJnkURrX1zXDasalDhUcZw1GuStxVIhrWLs2kpiA8u3vayQV3+7OBPfZF+DjJJIywbb00Rr1GgUG88j3egjPkUguj0H6K7AJgMLk4E6ovLQvrXNC4hbKnb0Ba2Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061944; c=relaxed/simple;
	bh=uta6YpLTnBJcrdy2SwRD4v9tuC5Fe5yRzIELAz02ETQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NsPA6LgsoyVIDHAMUV6sHG+Mh1DSLHX8h004lHl0NXVdayGc8/KQHS5mcRM4/YsmuLyOqLw6shKeIVmg5oNnKkLXqdWOniu8MqXMBttIGLTlFm/JE+js1zvdPVu3G+/lzJZMKZsUUklS8j4M4S+aw0rYV7l2yMzxdkcc1toNAjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xrm3UdGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9164C32782;
	Mon, 19 Aug 2024 10:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724061944;
	bh=uta6YpLTnBJcrdy2SwRD4v9tuC5Fe5yRzIELAz02ETQ=;
	h=Subject:To:Cc:From:Date:From;
	b=xrm3UdGcDwkx1PRL8jz6KU2lezXlUbd5TmwPZImMQ8IbjmbftdVfIK45wZe3j8Qhu
	 q+ZBsHeUUxG7dU3cbQvMmgr898EqLm5z1rJIG1U6HbZkgr6MaoS5H2myXNyXRLCB6g
	 Gd7KTNpRKsOlbbJChClYgLduzSSj7e99pbv0TSXY=
Subject: FAILED: patch "[PATCH] selinux: add the processing of the failure of" failed to apply to 5.10-stable tree
To: thunder.leizhen@huawei.com,paul@paul-moore.com,stephen.smalley.work@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 12:05:34 +0200
Message-ID: <2024081933-audience-hedging-fac5@gregkh>
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
git cherry-pick -x 6dd1e4c045afa6a4ba5d46f044c83bd357c593c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081933-audience-hedging-fac5@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


