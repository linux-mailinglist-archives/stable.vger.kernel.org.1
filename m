Return-Path: <stable+bounces-136115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883B6A99213
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E4E188B05E
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B102820B3;
	Wed, 23 Apr 2025 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MfzxYiC9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3136D1A08A4;
	Wed, 23 Apr 2025 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421695; cv=none; b=bm/kHvkgpQV9cRMfuRe7fsr7ph3M11tas4mGMWTKLtmuzD0caGNUe+fdIpxIrFkAo0P34c/xPjAtrKsCE7fvL4xWVHJ+YN67wKgdaux9M+ovcM5M8lVchhjmiLfRLM9T7v4i1ThvzYL3bkmaRHiqTeUJBX5GhCljzalKwQePeNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421695; c=relaxed/simple;
	bh=R1MQPtGiRz5F3W13Z6wTVq7wBdLxDIwxSzux3iGCBoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5Lyhe0irkAQAJwTLQ4N1jMahKDgveEqrnJzaCaJo4D01Rfq+wWTr7PcII7BGSZndlVbUG2wYq/jmgNxM+xwyjVWG80yEpYo4+49pAZ4aR2jtvqOkcqVJRgxROJN6EbdAthNxeuv5bYxbVey9pFlb6YFEU5nvcRt+oyzNOHFTaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MfzxYiC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8510C4CEE2;
	Wed, 23 Apr 2025 15:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421695;
	bh=R1MQPtGiRz5F3W13Z6wTVq7wBdLxDIwxSzux3iGCBoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MfzxYiC9lbFI4iCBz5j8rds60e3IimOIauBOAIirjqlYFo2qRucI7PQeSuhiNl2lw
	 1MTVJ12CDMpVKt3L9k7lHE+9Wh78DmsQM0vT5MbfSmd7FiMNSkCGk7b7RJRvtWfD80
	 sbgHOT1egbtRkp1B31QXUuFWIlrHrnQMpiyLQ9XI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 6.6 209/393] dm-ebs: fix prefetch-vs-suspend race
Date: Wed, 23 Apr 2025 16:41:45 +0200
Message-ID: <20250423142652.016029671@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 9c565428788fb9b49066f94ab7b10efc686a0a4c upstream.

There's a possible race condition in dm-ebs - dm bufio prefetch may be in
progress while the device is suspended. Fix this by calling
dm_bufio_client_reset in the postsuspend hook.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-ebs-target.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/md/dm-ebs-target.c
+++ b/drivers/md/dm-ebs-target.c
@@ -390,6 +390,12 @@ static int ebs_map(struct dm_target *ti,
 	return DM_MAPIO_REMAPPED;
 }
 
+static void ebs_postsuspend(struct dm_target *ti)
+{
+	struct ebs_c *ec = ti->private;
+	dm_bufio_client_reset(ec->bufio);
+}
+
 static void ebs_status(struct dm_target *ti, status_type_t type,
 		       unsigned int status_flags, char *result, unsigned int maxlen)
 {
@@ -447,6 +453,7 @@ static struct target_type ebs_target = {
 	.ctr		 = ebs_ctr,
 	.dtr		 = ebs_dtr,
 	.map		 = ebs_map,
+	.postsuspend	 = ebs_postsuspend,
 	.status		 = ebs_status,
 	.io_hints	 = ebs_io_hints,
 	.prepare_ioctl	 = ebs_prepare_ioctl,



