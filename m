Return-Path: <stable+bounces-81056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0235990E55
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830661F25AD2
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BFC223ACD;
	Fri,  4 Oct 2024 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnsQx1Dl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A21D223AC5;
	Fri,  4 Oct 2024 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066585; cv=none; b=jVi/xjuVZKZx/X9GXRSfDelkZQyRm+7AlY+34srS8eywdLbfEKeFc0/sSz4372kM/koEcppVC8RKbU5DPP7nuB+N5XktToBM2Ec02QnjTEIwmrEjyIR2m0XL2ZkyyHuyd4BIvjkfQ6QLTbI5NWdAvH8gL/iKfqBbgsJmV5jbz5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066585; c=relaxed/simple;
	bh=P876oxltcMeXccoXJErueYpeYbM2POhf6pGC6bV7Ark=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHh6w0rOueanVfpKK8wulVdocg/s8EZefIyStS8ZBNofnetA3RKA2o4JX+qIm8blsLqUMkX744EVNdZ8JmMpQ5lHuR6n27qNchIAOeRNAcGopmUxjsdNujZ3/yccktLZI8GkzeSO/CMLPoYxR/RnT20R29/MNki45mTtjkHyQcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnsQx1Dl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DB3C4CEC6;
	Fri,  4 Oct 2024 18:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066585;
	bh=P876oxltcMeXccoXJErueYpeYbM2POhf6pGC6bV7Ark=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AnsQx1DlrCnRd4BTJ4Qews7tjFQyJqDrj3d4VDZV9hVCj4CBByPEbbL4cYj3IrPmz
	 4QPN9ahsUQDGgmHmcDhhaV9HEi4CR+5cKLpsWvD3kCSPKL0Efsrwur3zvyZcbccxIi
	 0Wkc9u8io1i2Js4LA/SXM8Y62YB4Fx7aQlvvWCJzTeU1Jrt9PskYGL8ns+fHxWRXw6
	 vO6fQgcXY2GeYcWB/Lp0nIjHHT+G1k0VJLdn9BET6KQt7s2Tou+FycUmZzYLymWgSo
	 AUIb24UXvc4qnPccMj7EWB/+wKfnwvTQ33GmqeVGPLyXeM4jXjdT28KRefHvFGCgqc
	 1CLzU4PAlOTPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 29/31] driver core: bus: Return -EIO instead of 0 when show/store invalid bus attribute
Date: Fri,  4 Oct 2024 14:28:37 -0400
Message-ID: <20241004182854.3674661-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182854.3674661-1-sashal@kernel.org>
References: <20241004182854.3674661-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
Content-Transfer-Encoding: 8bit

From: Zijun Hu <quic_zijuhu@quicinc.com>

[ Upstream commit c0fd973c108cdc22a384854bc4b3e288a9717bb2 ]

Return -EIO instead of 0 for below erroneous bus attribute operations:
 - read a bus attribute without show().
 - write a bus attribute without store().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/20240724-bus_fix-v2-1-5adbafc698fb@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index d171535fc18f5..548291d15c290 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -104,7 +104,8 @@ static ssize_t bus_attr_show(struct kobject *kobj, struct attribute *attr,
 {
 	struct bus_attribute *bus_attr = to_bus_attr(attr);
 	struct subsys_private *subsys_priv = to_subsys_private(kobj);
-	ssize_t ret = 0;
+	/* return -EIO for reading a bus attribute without show() */
+	ssize_t ret = -EIO;
 
 	if (bus_attr->show)
 		ret = bus_attr->show(subsys_priv->bus, buf);
@@ -116,7 +117,8 @@ static ssize_t bus_attr_store(struct kobject *kobj, struct attribute *attr,
 {
 	struct bus_attribute *bus_attr = to_bus_attr(attr);
 	struct subsys_private *subsys_priv = to_subsys_private(kobj);
-	ssize_t ret = 0;
+	/* return -EIO for writing a bus attribute without store() */
+	ssize_t ret = -EIO;
 
 	if (bus_attr->store)
 		ret = bus_attr->store(subsys_priv->bus, buf, count);
-- 
2.43.0


