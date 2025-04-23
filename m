Return-Path: <stable+bounces-135612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702F6A98F0D
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB74C441944
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68108281524;
	Wed, 23 Apr 2025 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gdzQSZT2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BAF1EFFB9;
	Wed, 23 Apr 2025 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420382; cv=none; b=LmCGWVP78uWp3rG/JvZ9ciAoAH33IKGcQGaASLhYgXf5MLNcnd6oj6NHGrNR5vUN6/xQeYfywC81izuM3To+VAkVZtWJIbH350DI18Es3SbBP1MIwD1IiVe/H2HFjzHM+C08k33SlSOWwpw7cq2gXiMFVCSwE6AsrAWzjO68dG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420382; c=relaxed/simple;
	bh=1BZTpMheOYrUVJc/o0s2PGtoln0RnELjtH9oii2TQgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAAFOyl/dIcp0g2ir6gO8hWwcVzFbTnooAwtSxibU0FnNbkFwPO8sTyc5hSvCSLtEzckEcoEKIWiR7PXglOP8Ms3uKq1KSYJifgQ7ajWuBrsbVNJnpij4q06LjyGd1fpR2vaCXMvx23Eonk4FimBvlgtpY49xQeRrlx7jvfTuEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gdzQSZT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE90DC4CEE2;
	Wed, 23 Apr 2025 14:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420382;
	bh=1BZTpMheOYrUVJc/o0s2PGtoln0RnELjtH9oii2TQgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gdzQSZT2YWggn4qJFYKHnKUZyZQUz1s0Vzc8SyoJSrTAflnVpdSVCOVT86AuR8HC+
	 ZDx7MBCQ4iBo2ITrT/o1I7On0TJmVAo07IgRaZcBLK49lYNzZdMr7+YKLbwrT5oMwG
	 7nq8HDzBw5qblR8tWCm/duHFKkpeHwW5IyVmjzpo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	keenplify <keenplify@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 064/393] ASoC: amd: Add DMI quirk for ACP6X mic support
Date: Wed, 23 Apr 2025 16:39:20 +0200
Message-ID: <20250423142645.950335287@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: keenplify <keenplify@gmail.com>

[ Upstream commit 309b367eafc8e162603cd29189da6db770411fea ]

Some AMD laptops with ACP6X do not expose the DMIC properly on Linux.
Adding a DMI quirk enables mic functionality.

Similar to Bugzilla #218402, this issue affects multiple users.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219853
Signed-off-by: keenplify <keenplify@gmail.com>
Link: https://patch.msgid.link/20250315111617.12194-1-keenplify@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 2981bd1c3530d..2536bd3d59464 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -584,6 +584,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "pang13"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 15 C7UCX"),
+		}
+	},
 	{}
 };
 
-- 
2.39.5




