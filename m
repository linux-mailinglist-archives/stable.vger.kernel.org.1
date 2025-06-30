Return-Path: <stable+bounces-158922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE5DAED96B
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 12:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25192176DAA
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 10:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FD825290E;
	Mon, 30 Jun 2025 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gXXsg0ET"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6343023F27B
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278175; cv=none; b=rKMpn3dCIQKMnN8zy54o9FbycQfJnzCLEmIHShi1O75EhcI68n5fcg+huqlLBv5BtcwYtmXseBIXuVjJnBFTQCvnANrl3d4/4LBrWgC78OeRxLXCM5CPBt0w+PZLryHxr1K1pZq93NNsDzSH4LuCHzK64mjM5V4uPh6D8vCe7PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278175; c=relaxed/simple;
	bh=kWWLzCH76V6dp2LJmNZqLDnI5BLbJlj49v33LkyRgFw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y8tQH+V6lr0ZxRi6m/oka4sjyD7R56/WOuXmXGhb481FlvWFhiZZ8xqmo/u3WmfDPX40jw6hqusckjpc/bQg8u3mfCyYYPZai6Vc4dNSQ0dbwW7CMskccebXNuZDVbE7QyinuYIpY7Zx1HvcBh83msSxRbRHABGN9Cfkf+BS58s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gXXsg0ET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C647EC4CEE3;
	Mon, 30 Jun 2025 10:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751278175;
	bh=kWWLzCH76V6dp2LJmNZqLDnI5BLbJlj49v33LkyRgFw=;
	h=Subject:To:Cc:From:Date:From;
	b=gXXsg0ETjVRJsqNygCXlAJt5y4zakHW3wMsI0O90wSsi+ttL9YzM7S6NDJvMNhs1E
	 H7cvBXZThgDupXLon7Xl4yWt4YZY74eyGvMitgZf2iYC+hHLJC/rFHqvfW/ThzMZp9
	 62TPvpXkeslmSfKI+UA8c3Cj2wpf07Y+agsUDdaQ=
Subject: FAILED: patch "[PATCH] selinux: change security_compute_sid to return the ssid or" failed to apply to 6.12-stable tree
To: stephen.smalley.work@gmail.com,guido@trentalancia.com,paul@paul-moore.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 12:07:04 +0200
Message-ID: <2025063004-landslide-grinning-5ff4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x fde46f60f6c5138ee422087addbc5bf5b4968bf1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063004-landslide-grinning-5ff4@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fde46f60f6c5138ee422087addbc5bf5b4968bf1 Mon Sep 17 00:00:00 2001
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 10 Jun 2025 15:48:27 -0400
Subject: [PATCH] selinux: change security_compute_sid to return the ssid or
 tsid on match

If the end result of a security_compute_sid() computation matches the
ssid or tsid, return that SID rather than looking it up again. This
avoids the problem of multiple initial SIDs that map to the same
context.

Cc: stable@vger.kernel.org
Reported-by: Guido Trentalancia <guido@trentalancia.com>
Fixes: ae254858ce07 ("selinux: introduce an initial SID for early boot processes")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Guido Trentalancia <guido@trentalancia.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 7becf3808818..d185754c2786 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1909,11 +1909,17 @@ static int security_compute_sid(u32 ssid,
 			goto out_unlock;
 	}
 	/* Obtain the sid for the context. */
-	rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
-	if (rc == -ESTALE) {
-		rcu_read_unlock();
-		context_destroy(&newcontext);
-		goto retry;
+	if (context_equal(scontext, &newcontext))
+		*out_sid = ssid;
+	else if (context_equal(tcontext, &newcontext))
+		*out_sid = tsid;
+	else {
+		rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
+		if (rc == -ESTALE) {
+			rcu_read_unlock();
+			context_destroy(&newcontext);
+			goto retry;
+		}
 	}
 out_unlock:
 	rcu_read_unlock();


