Return-Path: <stable+bounces-69541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 788AA9567CC
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 12:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE7D2835C1
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 10:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEEB15ECC0;
	Mon, 19 Aug 2024 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="stKfP9gK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC74533C0
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061938; cv=none; b=H4OeEkGdiIpEMONknbS7ozq9HhL7OiozqdP4W2fpnszdy7oSqEazZDu6Z/NYgBtPsUKEJegIJ5Rf3p5Ve+wBIGA+rcmWaKN8pZ2OQZRnLw1IaRDzhOMI86GVASvPbNV80iAXkVuNWeVFugKBMIpy/Eg/X6QQ7/4zz107faYUqBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061938; c=relaxed/simple;
	bh=dpEGAUxeU59gqdutgdB288Va5t1EwD/jID+KMl0TT2g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QrBdQ6vB6zvUntUNwkMyHGezymd69OYpF8p+CCZyYYk5UV6Ze/VO9zsyr9WWam8+aXlYhnZwVc496UA6Ec0ZwVMPHoey0Rm67DzXI/YdTBH19ttx51d0g+M2yWwcaLPIP4QMVaYBycZFD0PsN/W1cpoVqM2S8yfiE21cPoazX40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=stKfP9gK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFFCC4AF0E;
	Mon, 19 Aug 2024 10:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724061938;
	bh=dpEGAUxeU59gqdutgdB288Va5t1EwD/jID+KMl0TT2g=;
	h=Subject:To:Cc:From:Date:From;
	b=stKfP9gKrqmfzo0Rme/nEuzKz9IPwWC/rT5kihHpT1sTsrs0/YTg/hc0Z3SaEQfsy
	 kDekGNrIisV2sLDRijqgCXn9EtW6N/7DTsz2lvPOV8xYWsU/U2lzmPGP8zs0foK6l5
	 qoFljvHr2MhfHsF574tXarWW7P5IA1u7INklPYp8=
Subject: FAILED: patch "[PATCH] selinux: add the processing of the failure of" failed to apply to 5.15-stable tree
To: thunder.leizhen@huawei.com,paul@paul-moore.com,stephen.smalley.work@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 12:05:33 +0200
Message-ID: <2024081933-sulphuric-enamel-7da6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6dd1e4c045afa6a4ba5d46f044c83bd357c593c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081933-sulphuric-enamel-7da6@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


