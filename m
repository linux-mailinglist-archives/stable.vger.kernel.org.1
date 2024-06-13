Return-Path: <stable+bounces-51911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 975ED90722D
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436CA1F214E6
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F029256458;
	Thu, 13 Jun 2024 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z49EMn/q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6D420ED;
	Thu, 13 Jun 2024 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282678; cv=none; b=BzRLXik9icGTYkCct9hHq1wgMijfApCHq8xTd6VqcNTsk2bb8rJZRWX/DdWLcQ9z+uWI6sVu7NhwvpsLD7a8ytKO0mDu4p4elsZkX3xW6TWkNL1qShKGAedyu/7tkqBagFh0Y/PR0KZ+mGUwSvVY4ek4QmH3jT/i5xD6jxP0ByY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282678; c=relaxed/simple;
	bh=25QjV1/9B6sm26kfQospcgSc+ckRz41+Pbre0+cV5Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZEFDDR54JSexvXqGN5UTQNuiqQCj61vTNf9j+nNh828HOIGHlHSTEOZAGMrvy+1dDO8syJRPcU5wxvujlo4AOCVzbc1kau06wJTDV2t4cDB2fdgOU2fA0fctXVCvllpD//LP+ao0gNWVz30kA6PN/vQi37qR8MAJKW+0Fbo3Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z49EMn/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022C9C2BBFC;
	Thu, 13 Jun 2024 12:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282678;
	bh=25QjV1/9B6sm26kfQospcgSc+ckRz41+Pbre0+cV5Nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z49EMn/qBr1yA48MCXkh4e1JX592D0DBUWa1KPczwXJ6Hpz7lJisZUP38+5HTmkIn
	 GvAxNnDLgPVcd2a63ViXvk+xKilcCycOrKCTW8pUodV6jXfQsGic5WQivaesuOCoFK
	 B1UO0dHLXeYRUWa3xHKrtLKgza34jJxbOI3ojyw0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoffer Sandberg <cs@tuxedo.de>,
	Werner Sembach <wse@tuxedocomputers.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.15 359/402] ACPI: resource: Do IRQ override on TongFang GXxHRXx and GMxHGxx
Date: Thu, 13 Jun 2024 13:35:16 +0200
Message-ID: <20240613113316.139914683@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoffer Sandberg <cs@tuxedo.de>

commit c81bf14f9db68311c2e75428eea070d97d603975 upstream.

Listed devices need the override for the keyboard to work.

Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/resource.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -579,6 +579,18 @@ static const struct dmi_system_id lg_lap
 			DMI_MATCH(DMI_BOARD_NAME, "X577"),
 		},
 	},
+	{
+		/* TongFang GXxHRXx/TUXEDO InfinityBook Pro Gen9 AMD */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GXxHRXx"),
+		},
+	},
+	{
+		/* TongFang GMxHGxx/TUXEDO Stellaris Slim Gen1 AMD */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GMxHGxx"),
+		},
+	},
 	{ }
 };
 



