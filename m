Return-Path: <stable+bounces-162405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F7DB05D69
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993B1165745
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA952EAB79;
	Tue, 15 Jul 2025 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vlknICqp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE762E54B7;
	Tue, 15 Jul 2025 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586470; cv=none; b=RV/ZWkM7Qb4TFyCdWrL8bLnt6P6YUPiGJgvdVSpIlUas/iur+9r6j73wmGmRDHtNPjGCa6Fxlc3yUSQd4XqKVIgAnmqLq1JLUkl2HdOF+6+wtTeDlSIxKidY0BkMJR7s1kt9FanhkQJqvmYb7eSOtAgh15+Z1F8ZE2PaPX9xWmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586470; c=relaxed/simple;
	bh=MgXbfIzUIzNaGcouThsfFenj1XUtoDulWABCesBIf7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J841M+xiZFrDyj11hcCXRxKRWAbfC7eN5r14UPH7zZqPTC7qKakGPany7Kzqil/VJ8yaOOlgI29IppVe3EKK1EEkmow01RYThYuTLBec+UunO4KgcTnFKYcmsmeGDr13XsgFva7UR+ZDDO0zGPWh4ivCPCa9IDeA1g+TZ1wu/Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vlknICqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECABC4CEE3;
	Tue, 15 Jul 2025 13:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586470;
	bh=MgXbfIzUIzNaGcouThsfFenj1XUtoDulWABCesBIf7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vlknICqp8CykK0GxHkJsuW8aCNqC3D4MKMNg63KsHyKY/rOjndzLwIUL8yhbwZUhm
	 W6JGiw0G0RZ8mbgaezUE/xgjvcRHOfuTXUMQqQ540+p6WmaRNwXR0x9O2YyLVsAxka
	 g0lUkIlh0j1WpGTf1SrT8bv2etnzzxhAHnhMSoZg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 078/148] rcu: Return early if callback is not specified
Date: Tue, 15 Jul 2025 15:13:20 +0200
Message-ID: <20250715130803.445522542@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130800.293690950@linuxfoundation.org>
References: <20250715130800.293690950@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uladzislau Rezki (Sony) <urezki@gmail.com>

[ Upstream commit 33b6a1f155d627f5bd80c7485c598ce45428f74f ]

Currently the call_rcu() API does not check whether a callback
pointer is NULL. If NULL is passed, rcu_core() will try to invoke
it, resulting in NULL pointer dereference and a kernel crash.

To prevent this and improve debuggability, this patch adds a check
for NULL and emits a kernel stack trace to help identify a faulty
caller.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 615283404d9dc..562c1ff452837 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2568,6 +2568,10 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func, bool lazy)
 	/* Misaligned rcu_head! */
 	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
 
+	/* Avoid NULL dereference if callback is NULL. */
+	if (WARN_ON_ONCE(!func))
+		return;
+
 	if (debug_rcu_head_queue(head)) {
 		/*
 		 * Probable double call_rcu(), so leak the callback.
-- 
2.39.5




