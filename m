Return-Path: <stable+bounces-105587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E099FAD33
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 11:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C31616425A
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 10:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFDB1946B1;
	Mon, 23 Dec 2024 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="02YGQiG1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699FE18F2DA
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734950084; cv=none; b=tHpPsZT/CzPlraNvFA+alvfCrz8KcJdZWrO9jbQuzfg1o4bFEMI6FVIphUy39f7XqT4n1u3AUhHd5mnog/8Bz6hvzwcybJqyQqFHX4D6+awzNcerYZYUcu+ZNtGjEgUBQPp8QzLdjuET0OGD/p+ogF7Xkc9UID2O8SI5lD5q9js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734950084; c=relaxed/simple;
	bh=qDYB1a6jQ8mRGU16WffIiHSbFoynRROffbtNPKoxGBg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UOFrzX1JvJXfnOWFpLhWv4m7iSN5dgBiuv5qQxO7HsMZ9Ljr14MFvPsZpAG7Xo4Lc+wUikyXhIdzBwQYKhJ7/XZAUdtcaw0zTZKRFFRzvnFbdPI3OLvRXG/n/AZSb9AlNJrrsKKZ+fw0ANvzuWqcrADNaVfFZrU/+VSbsWOq7kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=02YGQiG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB518C4CED3;
	Mon, 23 Dec 2024 10:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734950084;
	bh=qDYB1a6jQ8mRGU16WffIiHSbFoynRROffbtNPKoxGBg=;
	h=Subject:To:Cc:From:Date:From;
	b=02YGQiG1/NzGgiiIX//6Hchh6kJZ5QBnMdvRlg/eHXgknlYfhw8+JcIx0dzRtVgIY
	 YiEU18G7MD45P8KJSqzDAIK2Zqz7y8NJen0TqPuQ8cI4go0bKNBHudeV86Ki6LrSfw
	 leNUlc2NTMTgRJTE8QOIPlhCHWVzmK7hDhsMMbO4=
Subject: FAILED: patch "[PATCH] selinux: ignore unknown extended permissions" failed to apply to 5.10-stable tree
To: tweek@google.com,paul@paul-moore.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Dec 2024 11:34:22 +0100
Message-ID: <2024122322-bamboo-diffuser-35cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 900f83cf376bdaf798b6f5dcb2eae0c822e908b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122322-bamboo-diffuser-35cc@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


