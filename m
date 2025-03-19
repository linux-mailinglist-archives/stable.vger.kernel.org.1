Return-Path: <stable+bounces-125030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A7AA68F91
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327EE88440E
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BDF1D5CD1;
	Wed, 19 Mar 2025 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H5Ka0v2e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D571B2194;
	Wed, 19 Mar 2025 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394902; cv=none; b=A8JV3eRZNM28AiFq3fAmFKDzoDkrTVAn0NI6LHT74zO8y41/g75gUC3K58gQ3N04DT+bBGAT17/dfalpOXG3gdfAORk856wWne8IGJzKBGFZkrf3K3wrqZA5w3dE7/JGyclVlsrVAeWF64+be0udMtjP4oSmyJpvH7eNLtqOQ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394902; c=relaxed/simple;
	bh=HfWHcHsmSFwI8RcMxy7DTkSQQ29N9dpiO9OA7Yg/6E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=it5XaHhE+Zanlhxwud+Kxsbc8QFHhwKrtmOc1/pqvG7yzxj43tMbbdHXLkd1uB3+la6Pcp1DLkZkDv2XQyH7mg91ocMkBl6G2axdE+31DCxezQtss+LwSmnEp1ydNvKvx+md9rL2hLRSpbqOHOaToU7qAbvZrMwvnCPYrl27qLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H5Ka0v2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B73C4CEE4;
	Wed, 19 Mar 2025 14:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742394902;
	bh=HfWHcHsmSFwI8RcMxy7DTkSQQ29N9dpiO9OA7Yg/6E4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H5Ka0v2e+kxk1Ev//5xqZFNCvBLgilEDvGVtwYLtA5m0iG2wvZeryN1+LTvCEoLdw
	 AoPyIYj+DdKygZJEBvMWE5HJGUE+bKfzDwl3UILVBuPrNjij0ey484lxINm6/2JX8r
	 G3pzaqXZReuWxWNdEtiO3b0HbmZT70fIo3XXGOfA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gannon Kolding <gannon.kolding@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 071/241] ACPI: resource: IRQ override for Eluktronics MECH-17
Date: Wed, 19 Mar 2025 07:29:01 -0700
Message-ID: <20250319143029.481737249@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
References: <20250319143027.685727358@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gannon Kolding <gannon.kolding@gmail.com>

[ Upstream commit 607ab6f85f4194b644ea95ac5fe660ef575db3b4 ]

The Eluktronics MECH-17 (GM7RG7N) needs IRQ overriding for the
keyboard to work.

Adding a DMI_MATCH entry for this laptop model makes the internal
keyboard function normally.

Signed-off-by: Gannon Kolding <gannon.kolding@gmail.com>
Link: https://patch.msgid.link/20250127093902.328361-1-gannon.kolding@gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 90aaec923889c..b4cd14e7fa76c 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -563,6 +563,12 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "RP-15"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Eluktronics Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "MECH-17"),
+		},
+	},
 	{
 		/* TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD */
 		.matches = {
-- 
2.39.5




