Return-Path: <stable+bounces-124402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE53A60786
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 03:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985F019C4495
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 02:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E582D05E;
	Fri, 14 Mar 2025 02:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXELSffC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6542E3364
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 02:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741919669; cv=none; b=ZzFoYvj4spuci9kEoPyWlCSOmgQFmIRIgGG1k2ujTYOIRVMGUrGUSnlAnFG5yPtrlWH9H1RyIm2ZxtT7vYItvvH0mzzyw7H+5ORDC8HUdwK9LNWhX6IEonbgfw0HzVqmzMk+QUcpBUpNLFWUR2JnUyU1UYoo2EEB/15u79Et5Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741919669; c=relaxed/simple;
	bh=T6dvFeO348xbK0TlWceor8OFr8A7f/6odeHw0b6DUPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1Kr9CaPHVtWjmTvaYuGu/Zj95aGncz/++kvQ34Y9VmkR2tDIkwFMyx4SjgQZCspCIfu0q4RuzbtdHMl50o0oKA8jOXSIKyWTlZal1rF1/IT10KM6Jcd3CM2tok71AyLZ2o8fK3Bf51Dg3vvBJQ2mxvIf8wlZG2Ik7UBP0d+5J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXELSffC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1FCC4CEDD;
	Fri, 14 Mar 2025 02:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741919668;
	bh=T6dvFeO348xbK0TlWceor8OFr8A7f/6odeHw0b6DUPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CXELSffCfkfqDTcImEOJ5hVae3FlWIoGrxoqsCyi1ZYBjsLy+jI0Kq9f74QxrR5gO
	 QjcY//Kglt4Ks2P6ekNMOaBN8W0EHXKu6MGXPXkKMuqvJH7C3GhpA5pTCtUSh7PGWn
	 GKR4GKOyzr4nVlSjHH7jlRq9ABq3tvZlR69wdn7fL0VFbCtXxj77KFWMVU4Hi+ApHo
	 KkU0OelkbTNU0nCnizJr1/2AeoluLJTxNmjxapEvw/I1O+fWrzdZgGyxShUeIv5kXt
	 X+QIlvBxY5LUnF9zbFEBRXJJgGaD2i7VgcOO8DYWoMS60A+1oGPLugrV1ETLtbLZ0s
	 IMt62mTFYpACQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kareemem@amazon.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 5.15.y] ptp: Ensure info->enable callback is always set
Date: Thu, 13 Mar 2025 22:34:26 -0400
Message-Id: <20250313132833-d96fe5c97d6404da@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250313161702.74223-1-kareemem@amazon.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
❌ Build failures detected

The upstream commit SHA1 provided is correct: fd53aa40e65f518453115b6f56183b0c201db26b

WARNING: Author mismatch between patch and upstream commit:
Backport author: Abdelkareem Abdelsaamad<kareemem@amazon.com>
Commit author: Thomas Weißschuh<linux@weissschuh.net>

Status in newer kernel trees:
6.13.y | Present (different SHA1: 755caf4ee1c6)
6.12.y | Present (different SHA1: 8441aea46445)
6.6.y | Present (different SHA1: 81846070cba1)
6.1.y | Present (different SHA1: 5d1041c76de6)
5.15.y | Present (different SHA1: fd80c97b94f0)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |

Build Errors:
Patch failed to apply on stable/linux-5.10.y. Reject:

diff a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c	(rejected hunks)
@@ -188,6 +188,11 @@ static void ptp_clock_release(struct device *dev)
 	kfree(ptp);
 }
 
+static int ptp_enable(struct ptp_clock_info *ptp, struct ptp_clock_request *request, int on)
+{
+	return -EOPNOTSUPP;
+}
+
 static void ptp_aux_kworker(struct kthread_work *work)
 {
 	struct ptp_clock *ptp = container_of(work, struct ptp_clock,
@@ -233,6 +238,9 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	mutex_init(&ptp->pincfg_mux);
 	init_waitqueue_head(&ptp->tsev_wq);
 
+	if (!ptp->info->enable)
+		ptp->info->enable = ptp_enable;
+
 	if (ptp->info->do_aux_work) {
 		kthread_init_delayed_work(&ptp->aux_work, ptp_aux_kworker);
 		ptp->kworker = kthread_create_worker(0, "ptp%d", ptp->index);

Patch failed to apply on stable/linux-5.15.y. Reject:

diff a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c	(rejected hunks)
@@ -188,6 +188,11 @@ static void ptp_clock_release(struct device *dev)
 	kfree(ptp);
 }
 
+static int ptp_enable(struct ptp_clock_info *ptp, struct ptp_clock_request *request, int on)
+{
+	return -EOPNOTSUPP;
+}
+
 static void ptp_aux_kworker(struct kthread_work *work)
 {
 	struct ptp_clock *ptp = container_of(work, struct ptp_clock,
@@ -233,6 +238,9 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	mutex_init(&ptp->pincfg_mux);
 	init_waitqueue_head(&ptp->tsev_wq);
 
+	if (!ptp->info->enable)
+		ptp->info->enable = ptp_enable;
+
 	if (ptp->info->do_aux_work) {
 		kthread_init_delayed_work(&ptp->aux_work, ptp_aux_kworker);
 		ptp->kworker = kthread_create_worker(0, "ptp%d", ptp->index);

