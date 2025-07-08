Return-Path: <stable+bounces-160460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67110AFC618
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 10:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BEAD189EF60
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 08:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753B7221F26;
	Tue,  8 Jul 2025 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jDSr/e9F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15305203706
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964590; cv=none; b=cLup4c2It8mr0TwiNv97+tnsTJWiWvDBV0CCNEetJ+IwhEp2/Erq+gLg/zyMqX9XVNLbQ48mqw1oOsirQ7yJTZ+Oi2b6wgFkWkMVDiCxHEHb32hCWIMpytUyDzNBcZzMMnabrQlXoKY+jggzOmJJPpUHWP4sw9/ztJkMS1ZYhRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964590; c=relaxed/simple;
	bh=td+OIsvZ4YU6Sn9El0dD6jhCfkX7JJHM9YHbHoJXy1Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=g9n7lI6mDHgpCRZ8s2WwDOMMEO+xm+BDAw1QvgED0m/+FFLtwulmdnh3hhYgNik6kWBDjUarj973aiW7qftNw20TF2KlsbamY2yYQyxY8d64z8NZu6ezoS5DUpDMxGddRn456/Zf0KegWcEmkaRiNTkl2QrVgxVWTbo1QUbhUsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jDSr/e9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB00C4CEED;
	Tue,  8 Jul 2025 08:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751964589;
	bh=td+OIsvZ4YU6Sn9El0dD6jhCfkX7JJHM9YHbHoJXy1Q=;
	h=Subject:To:Cc:From:Date:From;
	b=jDSr/e9FUT+q8z41ZU8MYSHRVTgZIl5eMCQ5T7K580wDHDjMBFbE8k+7m4OnGU/ML
	 cOnc5AWV6LSbuvdnBhW9Gl1UUKR0hxNYurE2jDF+mlN2VTK2EshliXd0hOrWoWEgEW
	 5Bgsl8OoXUQtXfYrFDp+dih3ktxIAUdKpY9PQYEk=
Subject: FAILED: patch "[PATCH] xhci: dbc: Flush queued requests before stopping dbc" failed to apply to 5.4-stable tree
To: mathias.nyman@linux.intel.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Jul 2025 10:49:47 +0200
Message-ID: <2025070847-wooing-headway-a75d@gregkh>
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
git cherry-pick -x efe3e3ae5a66cb38ef29c909e951b4039044bae9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025070847-wooing-headway-a75d@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From efe3e3ae5a66cb38ef29c909e951b4039044bae9 Mon Sep 17 00:00:00 2001
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Date: Fri, 27 Jun 2025 17:41:22 +0300
Subject: [PATCH] xhci: dbc: Flush queued requests before stopping dbc

Flush dbc requests when dbc is stopped and transfer rings are freed.
Failure to flush them lead to leaking memory and dbc completing odd
requests after resuming from suspend, leading to error messages such as:

[   95.344392] xhci_hcd 0000:00:0d.0: no matched request

Cc: stable <stable@kernel.org>
Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250627144127.3889714-5-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 0d4ce5734165..06a2edb9e86e 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -652,6 +652,10 @@ static void xhci_dbc_stop(struct xhci_dbc *dbc)
 	case DS_DISABLED:
 		return;
 	case DS_CONFIGURED:
+		spin_lock(&dbc->lock);
+		xhci_dbc_flush_requests(dbc);
+		spin_unlock(&dbc->lock);
+
 		if (dbc->driver->disconnect)
 			dbc->driver->disconnect(dbc);
 		break;


