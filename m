Return-Path: <stable+bounces-80978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D323B990D74
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95AFE282106
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A65C20B79F;
	Fri,  4 Oct 2024 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3CZKrss"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079D220B796;
	Fri,  4 Oct 2024 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066399; cv=none; b=mUOMd4dq7Yfc079V5z7vs6DI31oJMs0cgkqDicAXxgeDQ3kyteWe+ZJUfO7Nz8McTg72Si0GeHqleBeOlCfs7SlFhelNpt0i5JhSNFK1VeN9OgZWc4rRAR/iVcQZ5N2/2m7u0J3ZPwH+3n0by1zRa8V/CKqu6OfKQ9rSdbbsN8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066399; c=relaxed/simple;
	bh=0omj2jhAxARHC/xf8pfKnlUhTs36jKh14Id5SNMfCpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NsOpwk04ERK+SGr6EMVK3hNnGHyO4BKMOAYQa1Kp7pg40owogLKarJdX0pU1c1nnWddm+kEdgj+OWQRnY8dMxssAz5RIoGUK4NJO4tlNOXtFa057QQsaymbp6S4t4vgxuwsct8xMcjQW7qEjG/RbynJHIMZHSR5U4bFV0uC5Ghw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3CZKrss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A90C4CEC6;
	Fri,  4 Oct 2024 18:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066398;
	bh=0omj2jhAxARHC/xf8pfKnlUhTs36jKh14Id5SNMfCpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t3CZKrssDYjNJ2c208g2+BMYQn968e/V31QPqnSmxdKlsOF8QSjNh+dzeEGzM30rc
	 I3yjIGXfAWtJQBWKPsZyGl5JnkDpclae4T4HiFuKrabIDYTJP8Pr5htr0EYry6rnWs
	 jvSrjxrhePNNHZpNdZzBVrpWy23PhPKnOyKjxO5xLEn+HHuDF/ptRD91gHS4U2vojO
	 wKZmJE9RbW5rRXhbbSRSMUSgOl55FpEeslbaE0WNXmD2j6gixWyFpz15Cd+KIlhZyc
	 imAczILv8F5pCjMTWy7hhj3TK4HbGT/feDmMT+J6pcDULo4oNPkDXzbU2cuQOqfhJl
	 871EElCIIN/cg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 52/58] driver core: bus: Return -EIO instead of 0 when show/store invalid bus attribute
Date: Fri,  4 Oct 2024 14:24:25 -0400
Message-ID: <20241004182503.3672477-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index e7761e0ef5a55..d4361ad3b433f 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -152,7 +152,8 @@ static ssize_t bus_attr_show(struct kobject *kobj, struct attribute *attr,
 {
 	struct bus_attribute *bus_attr = to_bus_attr(attr);
 	struct subsys_private *subsys_priv = to_subsys_private(kobj);
-	ssize_t ret = 0;
+	/* return -EIO for reading a bus attribute without show() */
+	ssize_t ret = -EIO;
 
 	if (bus_attr->show)
 		ret = bus_attr->show(subsys_priv->bus, buf);
@@ -164,7 +165,8 @@ static ssize_t bus_attr_store(struct kobject *kobj, struct attribute *attr,
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


