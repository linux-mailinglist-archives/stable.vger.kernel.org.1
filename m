Return-Path: <stable+bounces-71837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216F79677F9
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C5D1C20BDF
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42CF183CD1;
	Sun,  1 Sep 2024 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CmihIDJr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739A5183CC5;
	Sun,  1 Sep 2024 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725207979; cv=none; b=FwUSJWRaCHq4emgKSqyroe/tORqZz8h3yZrNyC7u13U2a4fQfOTMFk7DHcHxWjkbR4vpxuVq4+OyHf8ozyzBtajgL7shFKkTeE2cNi0LV33ijGvx5HSJ/iJGeaBNjld1Q25huzxMUQzj50JLAdylg73TOMPBiIFkmQ4sl7R9Du8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725207979; c=relaxed/simple;
	bh=t8Qe1VwJgDRlxmlATvfxGDbo8byP+PskZ3nopylJ934=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dev9Lyd6ZVJyGu0eqRoAs8bL8QOi7KmmF8AvRYIshsgdekEdoTSdHvQ+3vQdQ6oq0e4jjgEUgqFOw6GBUbn68U1Qsku5v1L0G/y+XPR8FB+nK/NZJmQUPzJFE0umt2Qd5Kn7u+3vny9NKAnZivmW23976Cv6T0mR99gjYf27psc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CmihIDJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E595AC4CEC8;
	Sun,  1 Sep 2024 16:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725207979;
	bh=t8Qe1VwJgDRlxmlATvfxGDbo8byP+PskZ3nopylJ934=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CmihIDJrnFNOuu5dZOoWNL5c/rrcyOvnmgaFOzSMh6S/j5e2UGW2y5G9pazu4eedv
	 I2rLTSfoKaEalD/511m9hkAR3U+1x2G8DjeRpyb4sDsX5tWhvk4ttov2jfHk6S3bWo
	 rOhptXMCX6TDoXZYmqMTlRD/N9+0LaOzi6oRYXuA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Rob Herring <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 29/93] of: Introduce for_each_*_child_of_node_scoped() to automate of_node_put() handling
Date: Sun,  1 Sep 2024 18:16:16 +0200
Message-ID: <20240901160808.456595942@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160807.346406833@linuxfoundation.org>
References: <20240901160807.346406833@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[ Upstream commit 34af4554fb0ce164e2c4876683619eb1e23848d4 ]

To avoid issues with out of order cleanup, or ambiguity about when the
auto freed data is first instantiated, do it within the for loop definition.

The disadvantage is that the struct device_node *child variable creation
is not immediately obvious where this is used.
However, in many cases, if there is another definition of
struct device_node *child; the compiler / static analysers will notify us
that it is unused, or uninitialized.

Note that, in the vast majority of cases, the _available_ form should be
used and as code is converted to these scoped handers, we should confirm
that any cases that do not check for available have a good reason not
to.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20240225142714.286440-3-jic23@kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Stable-dep-of: afc954fd223d ("thermal: of: Fix OF node leak in thermal_of_trips_init() error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/of.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 50e882ee91da7..024dda54b9c77 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1430,10 +1430,23 @@ static inline int of_property_read_s32(const struct device_node *np,
 #define for_each_child_of_node(parent, child) \
 	for (child = of_get_next_child(parent, NULL); child != NULL; \
 	     child = of_get_next_child(parent, child))
+
+#define for_each_child_of_node_scoped(parent, child) \
+	for (struct device_node *child __free(device_node) =		\
+	     of_get_next_child(parent, NULL);				\
+	     child != NULL;						\
+	     child = of_get_next_child(parent, child))
+
 #define for_each_available_child_of_node(parent, child) \
 	for (child = of_get_next_available_child(parent, NULL); child != NULL; \
 	     child = of_get_next_available_child(parent, child))
 
+#define for_each_available_child_of_node_scoped(parent, child) \
+	for (struct device_node *child __free(device_node) =		\
+	     of_get_next_available_child(parent, NULL);			\
+	     child != NULL;						\
+	     child = of_get_next_available_child(parent, child))
+
 #define for_each_of_cpu_node(cpu) \
 	for (cpu = of_get_next_cpu_node(NULL); cpu != NULL; \
 	     cpu = of_get_next_cpu_node(cpu))
-- 
2.43.0




