Return-Path: <stable+bounces-75689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC895973F7B
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 347B3B24D44
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4D91B4C21;
	Tue, 10 Sep 2024 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQ7ZHGsK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9415D1B29D7;
	Tue, 10 Sep 2024 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988971; cv=none; b=jtmJmH5mGFY6b+85aQLCO4KrTVImIql23IXelfZRNG02rrB6tjQyTzUK7kDxcNRSSo0D1nRjp8BB5ZWwiUPO4R0oRFPXRTXOMajg5kO0dNjgmgfiEx4VMQOsHD0f4tcIlM60v4WIasSi3zrTULisnJoEz6ZKvbzUdHIu45nMWZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988971; c=relaxed/simple;
	bh=sNGmr6Rjb8eG19IlJY/6kr9fpoWWNjecehlatSX3v6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WxQMNOLGrFy76NsO6Bt23WAT49KYVTukAbqAU/AqubavHBKwIXepzzXv+5abWrEdO7LybZTJM2uUahf4Wm7bHPm56fQtKhFtmjftz+aE8Z8GQK5og0REA3kNn2zIJftXkgvw+4VAJWRkZeq7Up3fpsjJnvtNUgYhSJw0GGqZ5oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQ7ZHGsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A81C4CECC;
	Tue, 10 Sep 2024 17:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988971;
	bh=sNGmr6Rjb8eG19IlJY/6kr9fpoWWNjecehlatSX3v6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQ7ZHGsKY6PaW2xnReVjQTAcAzU7hzBeCoFdVSmGh8QNAp4Xd/sAfgCcBapWZU/Ia
	 FebyYEXF0HNdeB92a4U36Kd9Hd+msVMn9ldVx5UqxVsN1lMMgmK2I00qKvWoomkaoy
	 WFBvb7y+ZKsmq6LegDI6CuhHO+/ojb2gQEoS/49D/UO+2rMdvGM4r5+yRgwlRt6h5v
	 guvxKSP4oIPMCw3mtMe+FVeFnI0T+pCVTin77HJDXi0FyIMONzMq1HQPxm1Uy1lf2v
	 St8llt80faZEVYgvQUkKzvdIRCy/yuOCcI906aNmgthPV9YRCtc1UUNQU1B2Yue50S
	 hRHgmUbHMDqIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Luke D. Jones" <luke@ljones.dev>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Shyam-sundar.S-k@amd.com,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 17/18] platform/x86/amd: pmf: Make ASUS GA403 quirk generic
Date: Tue, 10 Sep 2024 13:22:02 -0400
Message-ID: <20240910172214.2415568-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172214.2415568-1-sashal@kernel.org>
References: <20240910172214.2415568-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.9
Content-Transfer-Encoding: 8bit

From: "Luke D. Jones" <luke@ljones.dev>

[ Upstream commit d34af755a533271f39cc7d86e49c0e74fde63a37 ]

The original quirk should match to GA403U so that the full
range of GA403U models can benefit.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
Link: https://lore.kernel.org/r/20240831003905.1060977-1-luke@ljones.dev
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmf/pmf-quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmf/pmf-quirks.c b/drivers/platform/x86/amd/pmf/pmf-quirks.c
index 460444cda1b2..48870ca52b41 100644
--- a/drivers/platform/x86/amd/pmf/pmf-quirks.c
+++ b/drivers/platform/x86/amd/pmf/pmf-quirks.c
@@ -25,7 +25,7 @@ static const struct dmi_system_id fwbug_list[] = {
 		.ident = "ROG Zephyrus G14",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "GA403UV"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "GA403U"),
 		},
 		.driver_data = &quirk_no_sps_bug,
 	},
-- 
2.43.0


