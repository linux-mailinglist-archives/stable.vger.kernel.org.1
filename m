Return-Path: <stable+bounces-105583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3539FAD2F
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 11:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2CC188512B
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 10:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B3E19340B;
	Mon, 23 Dec 2024 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AkcbDjQM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515B718F2DA
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734950071; cv=none; b=i3sHNo7AFvxT6SzIpfEWpzXjXeG4+D+JMKk9DSnFgyVjeGywDmPd3Vgqp/8j5Wf7+2U1vQIKVGv6ooihqNRTDiSPfFe1VgbDAuIAx/oUa030TvXIW4JJwa7lwn9Sw6WYfOAxFjpcqiRpJhMWAGg4WIg0F8KnmXTLzak/ZQiPzVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734950071; c=relaxed/simple;
	bh=bT8T9IIJRKOCermZD7wT6vUk8Q/ek4vBkS5/T9HaXL8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dMGgPJjORjr/unnlfXWyh6aR/Q59N7jol3yS9wCJvLnu3muEY65uAWt7rtW/3ZA46URY/gpxfVkOhstzXyZJjJmpzyM0oXPjETkakTRgJB0pSu66G8AfEmh8J/A0XeU3pRJKv00hdS9sYpRwcRn5O46W1lsn/QlPQcauhZg9kg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AkcbDjQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FC1C4CED3;
	Mon, 23 Dec 2024 10:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734950071;
	bh=bT8T9IIJRKOCermZD7wT6vUk8Q/ek4vBkS5/T9HaXL8=;
	h=Subject:To:Cc:From:Date:From;
	b=AkcbDjQMejjFcyxYNvdXOcr08aEAQgQN7cOfz886+LiVvVVnMB1mcXehGXkxdNVGn
	 /5ZV9klCFTBS4wEarBMEL+nxf6RcKPQ1cF1cLxD1vuoclO0yMSN4VDxyjQQViOKXQ1
	 jZMLYEYPlBmJ3kDim5W+fh503jBcNr2935aSvLik=
Subject: FAILED: patch "[PATCH] selinux: ignore unknown extended permissions" failed to apply to 6.6-stable tree
To: tweek@google.com,paul@paul-moore.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Dec 2024 11:34:20 +0100
Message-ID: <2024122320-ripening-browsing-fdaa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 900f83cf376bdaf798b6f5dcb2eae0c822e908b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122320-ripening-browsing-fdaa@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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
 


