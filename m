Return-Path: <stable+bounces-92734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCD69C55D1
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6AE4284D1A
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EA221A4BB;
	Tue, 12 Nov 2024 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1bIcbVIs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7B32144B5;
	Tue, 12 Nov 2024 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408416; cv=none; b=cal/2TILuDxux3M5kpyQd5ks0Go1IldJif3/oPtmOPqpyH8MUPqcYCuUvfxsl3qepRm55jFJB9tWxE/jFjRSstfLPDKnvfE3/mDCCN1Hj6iDagRprspFqZvLbE2TJfMievJxTZGbBBUvhnnG+XCcV+6F9vSLYr8miFRp7N8RgoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408416; c=relaxed/simple;
	bh=eUKFzTgnxP8vLNhC87EdDuOP51IhbQU+IBoiQicne5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIMilmUFr08tTttJs+1VyVdFnwFNHD1NguhocdpN+dbhqLUpa2QSGppgsqJ9cHESxtx1ChyNojux2xulgvzcL6TDy4Dc0duqYNnOHS4fAsdV7CPcAUIxTuq1rDmWkdmVYnvA38hvBQCuPAUtLkWa+HNGaaBPyivnuRXjIyMmyAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1bIcbVIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE681C4CECD;
	Tue, 12 Nov 2024 10:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731408416;
	bh=eUKFzTgnxP8vLNhC87EdDuOP51IhbQU+IBoiQicne5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1bIcbVIsWk9y99v8kVyRNM6EZT1x3kYNnje5smcjPpy3qqyj5gRXmRcC4WyJXTCaT
	 +ElplzzZ307zUkl2oCWyFBOpah5a8ADmHuPuHnwHEkr5KVJ9NzaIN/EzLf3k+Sjs2N
	 mSDDjwgwnT+GNUKz1tnd9xSRvrdj4lmh04yYeASE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	AceLan Kao <acelan.kao@canonical.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 6.11 155/184] thunderbolt: Add only on-board retimers when !CONFIG_USB4_DEBUGFS_MARGINING
Date: Tue, 12 Nov 2024 11:21:53 +0100
Message-ID: <20241112101906.821572830@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
References: <20241112101900.865487674@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit bf791751162ac875a9439426d13f8d4d18151549 upstream.

Normally there is no need to enumerate retimers on the other side of the
cable. This is only needed in special cases where user wants to run
receiver lane margining against the downstream facing port of a retimer.
Furthermore this might confuse the userspace tools such as fwupd because
it cannot read the information it expects from these retimers.

Fix this by changing the retimer enumeration code to add only on-board
retimers when CONFIG_USB4_DEBUGFS_MARGINING is not enabled.

Reported-by: AceLan Kao <acelan.kao@canonical.com>
Tested-by: AceLan Kao <acelan.kao@canonical.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219420
Cc: stable@vger.kernel.org
Fixes: ff6ab055e070 ("thunderbolt: Add receiver lane margining support for retimers")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/retimer.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -532,6 +532,8 @@ int tb_retimer_scan(struct tb_port *port
 	}
 
 	ret = 0;
+	if (!IS_ENABLED(CONFIG_USB4_DEBUGFS_MARGINING))
+		max = min(last_idx, max);
 
 	/* Add retimers if they do not exist already */
 	for (i = 1; i <= max; i++) {



