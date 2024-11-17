Return-Path: <stable+bounces-93671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF3A9D02E9
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 11:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BECBD1F22182
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 10:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AD87E105;
	Sun, 17 Nov 2024 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="awj33hk7"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6676438C;
	Sun, 17 Nov 2024 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731838843; cv=none; b=pB50ppxChFOEnHK3TfOYsaDZSW6PAy5m/NFwtxt/JLmGazOwKLwQi+EmY81iJkQJAeSVkc/xXx/vRFoGU3M2Rn94/5+WZf2w/hhHgiIpPPJhcPFZBQ6nbjEsiQeOVnd1YXjsgzYxyOuaFo2geKf2nSlVSabbStxvIFqIwVHFHPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731838843; c=relaxed/simple;
	bh=XnwVRnokFrmnC2nPBW2Pi8KvS5rKZccAQiigQhSs2FU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b5hDUFLZOMRzckeLINknIxuWMkvDTaxrrpzzoLvyLAXMwyZOmtF7t47PoAbVgvQ+LJohtw71VoM2ASvHEszcYUwZ8jAolTOFXXodzxTPObgU30iJCSRVm2KSENYk/a6Q2xhwP/SMYSWInQ+7LI1IH2IxaE7aYf0FmM8Y+eSLGCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=awj33hk7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731838830;
	bh=XnwVRnokFrmnC2nPBW2Pi8KvS5rKZccAQiigQhSs2FU=;
	h=From:Date:Subject:To:Cc:From;
	b=awj33hk7yn8l/H81ibggz6xMsjMLtTqqX2JhUJz7RMSZG1FRXkafY1cLjjA+rlVoM
	 lGZ16NyjVDl3L8AR9lAhneKCmxFnSnDDEX8OwPbA+E9C7cInejCO5wl5rsmbwXgczA
	 fHI8tHASIncJDxzmCheRBynpd8CZdN0pqILEZUxY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 17 Nov 2024 11:20:16 +0100
Subject: [PATCH] perf: arm-ni: Fix attribute_group definition syntax
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241117-arm-ni-syntax-v1-1-1894efca38ac@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAF/DOWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQ0Nz3cSiXN28TN3iyrySxApdI1ODRAtjA1MLUyNLJaCegqLUtMwKsHn
 RsbW1AKAERsxfAAAA
X-Change-ID: 20241117-arm-ni-syntax-250a83058529
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731838830; l=1098;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=XnwVRnokFrmnC2nPBW2Pi8KvS5rKZccAQiigQhSs2FU=;
 b=4vVy3arO72EZfxh5ovfjA9bszsEuseGV5JKPtX1fS44RPOS8gDEWaXZkeE7z0jby1AZj3JhIS
 f+1tpOskReICe/Vr7766JoBLqx/vIkoHgXdED1cLhG/bhK4rbGRrBv+
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sentinel NULL value does not make sense and is a syntax error in a
structure definition.
Remove it.

Fixes: 4d5a7680f2b4 ("perf: Add driver for Arm NI-700 interconnect PMU")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Cc stable because although this commit is not yet released, it most
likely will be by the time it hits mainline.
---
 drivers/perf/arm-ni.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
index 90fcfe693439ef3e18e23c6351433ac3c5ea78b5..fd7a5e60e96302fada29cd44e7bf9c582e93e4ce 100644
--- a/drivers/perf/arm-ni.c
+++ b/drivers/perf/arm-ni.c
@@ -247,7 +247,6 @@ static struct attribute *arm_ni_other_attrs[] = {
 
 static const struct attribute_group arm_ni_other_attr_group = {
 	.attrs = arm_ni_other_attrs,
-	NULL
 };
 
 static const struct attribute_group *arm_ni_attr_groups[] = {

---
base-commit: 4a5df37964673effcd9f84041f7423206a5ae5f2
change-id: 20241117-arm-ni-syntax-250a83058529

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


