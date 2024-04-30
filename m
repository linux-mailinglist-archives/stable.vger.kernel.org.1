Return-Path: <stable+bounces-42221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E908B71F9
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055AF1C223B5
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF1212C54B;
	Tue, 30 Apr 2024 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RbZHnpiK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2B912C487;
	Tue, 30 Apr 2024 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474959; cv=none; b=XyedkCt6KA7B5C9r/ZteetiUIMWMip48bur08wyZK/e2JKXVYNCNxkvasItK+dyKGXUpZDFEs+WaT/+SftkrT48+hMOBKxnlR1uD1kMbsKLj6BrmNumcRnEGiRN1CoXQd2AWqeourTAoLIYGm5z7hPmYFXRvCPd2QAg8bYNWUm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474959; c=relaxed/simple;
	bh=Hz+64iiwa2xGMdUUB88CPLws4b0lYSiYAs+ffxtMsJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bP3FlMmeBTRJgH2+EHJqUKYFpuD9YN6re3uDEJVY966W1MgrI8vv9aM5MgOjO9T1vKWEj8g6+W3JwKTS23BU5b03+4lTMH9DuwfgGdbLFBL0WZRJz8EBgiHuBlnzoeUkTJQ99GllfS6GvKecGRN+bmZlKugvK5drkmdFjbN3/o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RbZHnpiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4D6C2BBFC;
	Tue, 30 Apr 2024 11:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474959;
	bh=Hz+64iiwa2xGMdUUB88CPLws4b0lYSiYAs+ffxtMsJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RbZHnpiKQbipBiVeH5NMBabxPkN3SUk3RDLB+DJxo9xS1QEAwJpehoYdpTOcRN/dC
	 WIH4q7FPBzzdMnJ9e1J08UtI02n+OAU8OiL9O6aY9lGU56xL/Laj7neprkIkiWHnn+
	 gJfysyPnA+C00enWP9LAV9ctgxRO14tHPyDs4Fco=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Yanjun.Zhu" <yanjun.zhu@linux.dev>,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 039/138] RDMA/rxe: Fix the problem "mutex_destroy missing"
Date: Tue, 30 Apr 2024 12:38:44 +0200
Message-ID: <20240430103050.583799263@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103049.422035273@linuxfoundation.org>
References: <20240430103049.422035273@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yanjun.Zhu <yanjun.zhu@linux.dev>

[ Upstream commit 481047d7e8391d3842ae59025806531cdad710d9 ]

When a mutex lock is not used any more, the function mutex_destroy
should be called to mark the mutex lock uninitialized.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Yanjun.Zhu <yanjun.zhu@linux.dev>
Link: https://lore.kernel.org/r/20240314065140.27468-1-yanjun.zhu@linux.dev
Reviewed-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 95f0de0c8b49c..0505c81aa8d04 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -35,6 +35,8 @@ void rxe_dealloc(struct ib_device *ib_dev)
 
 	if (rxe->tfm)
 		crypto_free_shash(rxe->tfm);
+
+	mutex_destroy(&rxe->usdev_lock);
 }
 
 /* initialize rxe device parameters */
-- 
2.43.0




