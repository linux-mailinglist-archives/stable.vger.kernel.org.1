Return-Path: <stable+bounces-105584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB2B9FAD30
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 11:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A8F16424B
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 10:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3554B1946B9;
	Mon, 23 Dec 2024 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VK0Y1rcX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA90F18DF6D
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734950075; cv=none; b=DkdYlyGyfUBr8elEdUy/583oPFZCFNCQsBl+l2oL3cXQ2JrPZsZUolthKcXv6HqiNAYUD4jhn6c03XLH7iOCoUvnkjP5IoB5VTD2v6SJTUK0meYdXIpcAalDUcfJOkJYBSGx4voll/jxpXqK8H4L4cDcaRkH63nuY8peLDVqzxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734950075; c=relaxed/simple;
	bh=NcAxtWWDEuUMZ8nkDWhrjLYUnfN6Ec6GYt9YA1rc5v4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E1/pZll+4/N4lEZRSv34+a7Am3OfPw2a/BwQgXoHr4FmrbsE8Sf77aw+nDXE86bWHx9WmjNy6L8C0g5vcJO9sEgIizdvoJ4mzwUZJAdqt5/In0Z2DGOg9Y9ij/ZsdpBPZEzKtqDzH54EshEZUXJlcZBMWlIM5hRHUnvg8BBMGxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VK0Y1rcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25BAC4CED3;
	Mon, 23 Dec 2024 10:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734950074;
	bh=NcAxtWWDEuUMZ8nkDWhrjLYUnfN6Ec6GYt9YA1rc5v4=;
	h=Subject:To:Cc:From:Date:From;
	b=VK0Y1rcXYodxJ34kbT4jxMA0jw5skYAmwAn+XcMzin+ROuQb0U1dBOQfqW7k2ne1g
	 KjHMaa1hd2qU214r1BUp7zOPeyZRHyTLgfyfB1TDYACK0OqJfJghgtr+8I7NLRpeNc
	 CbtCvC27R7Dbj9HlSjyWxZ9iGAw+BqezmU6vhXZg=
Subject: FAILED: patch "[PATCH] selinux: ignore unknown extended permissions" failed to apply to 5.15-stable tree
To: tweek@google.com,paul@paul-moore.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Dec 2024 11:34:21 +0100
Message-ID: <2024122321-atlas-upcoming-427e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 900f83cf376bdaf798b6f5dcb2eae0c822e908b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122321-atlas-upcoming-427e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 900f83cf376bdaf798b6f5dcb2eae0c822e908b6 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>
Date: Thu, 5 Dec 2024 12:09:19 +1100
Subject: [PATCH] selinux: ignore unknown extended permissions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When evaluating extended permissions, ignore unknown permissions instead
of calling BUG(). This commit ensures that future permissions can be
added without interfering with older kernels.

Cc: stable@vger.kernel.org
Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
Signed-off-by: Thiébaud Weksteen <tweek@google.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 971c45d576ba..3d5c563cfc4c 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -979,7 +979,10 @@ void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
 			return;
 		break;
 	default:
-		BUG();
+		pr_warn_once(
+			"SELinux: unknown extended permission (%u) will be ignored\n",
+			node->datum.u.xperms->specified);
+		return;
 	}
 
 	if (node->key.specified == AVTAB_XPERMS_ALLOWED) {
@@ -998,7 +1001,8 @@ void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
 					    &node->datum.u.xperms->perms,
 					    xpermd->dontaudit);
 	} else {
-		BUG();
+		pr_warn_once("SELinux: unknown specified key (%u)\n",
+			     node->key.specified);
 	}
 }
 


