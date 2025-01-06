Return-Path: <stable+bounces-106868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 329CAA02904
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241C116232D
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE8113635E;
	Mon,  6 Jan 2025 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0EryIRYO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C357081C;
	Mon,  6 Jan 2025 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176750; cv=none; b=W/2s/VfUu7OGVTYJT+Ziifi2WkGKuqFC1c75v4LGMcuWQeYGa27cjkEOuMwzq1POQiSN5OzaRWPhtRmOeb3gQBIniM2b5TJQ2JCbtygMj9WnLFZJS5o4xZ0hCTXxfB6sLbVuwbbPHHrFZapokDUVeXcvyH04OFZhPPB4v2DmprQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176750; c=relaxed/simple;
	bh=0zMKgYVJjDbBKzL3Xs4FsRXzxPtcH7QJE8djsVTax+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSuDDEwkjduvfa/Yjl+R6YlBaCA5UdGAbr/Oi/AULYD5bgxUXmerBwc94pjEnG8ilV2PuMqtZJsB8COowFnzYgyW9l6X+R5vKoXUrm9FsFiwzxmTXcMBoRnVULgorEptPMfELM2j96pBWte9POg4JyDpKE7L5SEpaJOhrqNvVWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0EryIRYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AF1C4CED2;
	Mon,  6 Jan 2025 15:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736176749;
	bh=0zMKgYVJjDbBKzL3Xs4FsRXzxPtcH7QJE8djsVTax+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0EryIRYOlI7tt5MftFMurZgHLF865ahv8YqNtSCocXVJFE2xljXnsfyAB9dQqr2QD
	 U3fwkayFxm1UKWNxUVVpflT6Dg62OubpDnvjdR4csMbEWCF7ZWZW1klg/4wdlAnKXW
	 WrTFZLOv7P0nWEa1JfoXXzsjT2aczipZpLqyHM4c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH 6.1 02/81] selinux: ignore unknown extended permissions
Date: Mon,  6 Jan 2025 16:15:34 +0100
Message-ID: <20250106151129.529385090@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151129.433047073@linuxfoundation.org>
References: <20250106151129.433047073@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thiébaud Weksteen <tweek@google.com>

commit 900f83cf376bdaf798b6f5dcb2eae0c822e908b6 upstream.

When evaluating extended permissions, ignore unknown permissions instead
of calling BUG(). This commit ensures that future permissions can be
added without interfering with older kernels.

Cc: stable@vger.kernel.org
Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
Signed-off-by: Thiébaud Weksteen <tweek@google.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/selinux/ss/services.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -969,7 +969,10 @@ void services_compute_xperms_decision(st
 					xpermd->driver))
 			return;
 	} else {
-		BUG();
+		pr_warn_once(
+			"SELinux: unknown extended permission (%u) will be ignored\n",
+			node->datum.u.xperms->specified);
+		return;
 	}
 
 	if (node->key.specified == AVTAB_XPERMS_ALLOWED) {
@@ -1006,7 +1009,8 @@ void services_compute_xperms_decision(st
 					node->datum.u.xperms->perms.p[i];
 		}
 	} else {
-		BUG();
+		pr_warn_once("SELinux: unknown specified key (%u)\n",
+			     node->key.specified);
 	}
 }
 



