Return-Path: <stable+bounces-102950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C119EF65A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7181892862
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ABD222D63;
	Thu, 12 Dec 2024 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SjL7p+w/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA32F20969B;
	Thu, 12 Dec 2024 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023084; cv=none; b=n3WuF7nLzl5YocjTlhToe+Juh/8Ta5cJG+R3jeFlXSn68l7OUltpcA+FW/hNc17X1LCPYoVgCZL7teAsaR0yD2Y6uC53xrxsHRcB76JJv5BgZedxjYh3lkx64vFoHSaSIvQdlOSldacledJ/+frgT+7zhbd/LjvRHQSxbUESU6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023084; c=relaxed/simple;
	bh=WPDD3y29gjW0qaUXWdwSL/zI4AwJnLXZwBbAu5clcTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvR7R4D07Nu5Ed6XyE6Cdhciijah+6gXVZFzADEu/BBLpKETUJFtIjZPhD7DBKyWaMVCSnGLWaBn916gBtIh1poyIyr5FLlBSb6r6nVBkrKIZaTF4zYhkSSz36gxM4lDJ3Dl1gP9yCwcPHSLswZr2oBli33O4wyH3X24H7x3hVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SjL7p+w/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3415BC4CECE;
	Thu, 12 Dec 2024 17:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023084;
	bh=WPDD3y29gjW0qaUXWdwSL/zI4AwJnLXZwBbAu5clcTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SjL7p+w/TnVTOp+rrJ2t5PnpgNRODioGJ7nq6JpgdwLEv1xcF3L3oIUgAoCBQzvAW
	 1OS/62Nim263ZlblI5DQOjG1YwvWCsdbTf9KdrtJSegVtDfroWBLgwsvsfpE4qzO7j
	 tN8NVwryCN7z0itvEUZO9ttnjJjYcW2LqmmT3MVc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuan Can <yuancan@huawei.com>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 5.15 389/565] dm thin: Add missing destroy_work_on_stack()
Date: Thu, 12 Dec 2024 15:59:44 +0100
Message-ID: <20241212144327.019968226@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuan Can <yuancan@huawei.com>

commit e74fa2447bf9ed03d085b6d91f0256cc1b53f1a8 upstream.

This commit add missed destroy_work_on_stack() operations for pw->worker in
pool_work_wait().

Fixes: e7a3e871d895 ("dm thin: cleanup noflush_work to use a proper completion")
Cc: stable@vger.kernel.org
Signed-off-by: Yuan Can <yuancan@huawei.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-thin.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -2468,6 +2468,7 @@ static void pool_work_wait(struct pool_w
 	init_completion(&pw->complete);
 	queue_work(pool->wq, &pw->worker);
 	wait_for_completion(&pw->complete);
+	destroy_work_on_stack(&pw->worker);
 }
 
 /*----------------------------------------------------------------*/



