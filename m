Return-Path: <stable+bounces-140408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94A1AAA891
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CF2A986B28
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7EC34CE65;
	Mon,  5 May 2025 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHER8cvf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AD934CE5C;
	Mon,  5 May 2025 22:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484793; cv=none; b=rwJscH1OpDjrhwYS4IgpnXGl3khzcvO7XHTHcRCVVezIjnb49Uw572ihn/6lE/VGsV0tYSHcmB5cZ2A0KCIQItn09MjcBOGjfJvqR7/B2SIjprbWKABvBDL7Y7qmM4+i9j2vrriKUVjhNJdHdVRw09nTz+lG/2dGXEiEvoH9+GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484793; c=relaxed/simple;
	bh=3NjjJic+KfXlHN5dzLwkv6OiL634PsPW6GB6dHVFi/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nhu1qjEpmJxW++SLmzc4tOsmvdKyZJwh505gpTr5gCx7zgQAL9qKVhqEfavRTjO8W4A0lcHHSpXmAa1jiDv8SGOSqhIk5oVPibcspw/0vNuNERDNwCLOioUtiU4TnRTmJlHw4VQFMiXLLiSkiq6CEWxDpIcOKvoq3mIVi9DKN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHER8cvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054EFC4CEE4;
	Mon,  5 May 2025 22:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484792;
	bh=3NjjJic+KfXlHN5dzLwkv6OiL634PsPW6GB6dHVFi/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHER8cvfdHcDO5meZsQjrcvRJ4VRSOauKrAVed6kOGYEpi9eIszvWltPbl4eOvx5H
	 boMAUF3t5T+pf63+IpxNl3Wwtk1QjxBpAuJ2wam0GOVRD08t109riWA4JaiIxYr6dO
	 CDo4L8KShyomQIsWXW/6ZRtWKfgqMRyfADqGpUpaQUN7TsJMkUoLL6myJO8D2mlnv0
	 pPiZ4Pq7TFSe1iNLwWtBe8KkVQFNdPAx4cevHjpk8mrt8AQG4sWpg3DZHFKDP6tDuY
	 RBy8QxDwWp5D2GbqsmGB1uH0bO/UXcSJZhj/FVC0tHelRwiunROF7hTOKLXFdB/fWD
	 ttZCB0+Mb42nA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 017/486] ACPI: PNP: Add Intel OC Watchdog IDs to non-PNP device list
Date: Mon,  5 May 2025 18:31:33 -0400
Message-Id: <20250505223922.2682012-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Diogo Ivo <diogo.ivo@siemens.com>

[ Upstream commit f06777cf2bbc21dd8c71d6e3906934e56b4e18e4 ]

Intel Over-Clocking Watchdogs are described in ACPI tables by both the
generic PNP0C02 _CID and their ACPI _HID. The presence of the _CID then
causes the PNP scan handler to attach to the watchdog, preventing the
actual watchdog driver from binding. Address this by adding the ACPI
_HIDs to the list of non-PNP devices, so that the PNP scan handler is
bypassed.

Note that these watchdogs can be described by multiple _HIDs for what
seems to be identical hardware. This commit is not a complete list of
all the possible watchdog ACPI _HIDs.

Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
Link: https://patch.msgid.link/20250317-ivo-intel_oc_wdt-v3-2-32c396f4eefd@siemens.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_pnp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index 01abf26764b00..3f5a1840f5733 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -355,8 +355,10 @@ static bool acpi_pnp_match(const char *idstr, const struct acpi_device_id **matc
  * device represented by it.
  */
 static const struct acpi_device_id acpi_nonpnp_device_ids[] = {
+	{"INT3F0D"},
 	{"INTC1080"},
 	{"INTC1081"},
+	{"INTC1099"},
 	{""},
 };
 
-- 
2.39.5


