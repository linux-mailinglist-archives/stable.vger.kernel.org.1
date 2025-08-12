Return-Path: <stable+bounces-167408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE785B22FF2
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3902C566252
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2832FDC58;
	Tue, 12 Aug 2025 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PYVXZxwp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526A81F09AD;
	Tue, 12 Aug 2025 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020719; cv=none; b=fvQ4ypQ4h7WMygrIA+/K3XEMca7Gh/0EGeMicRYB5JyKP4cXrPDQleahNHBo7Y+a+KUagQaKZC2Fkuu9M/eIWAnhwf9wKzj42S9YaOrkAzSJRMGQIEVq1V7RrIhayLRMW4SIyh35Usu+06YbK/sMHcXje/KA9ekKym+EYxafT+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020719; c=relaxed/simple;
	bh=CEJWJq6sl8EsfebfQ9jrh6c1QFXw53ZBcBQ6UVRdK6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkizXvWTUDii/QL6rVKTlrz9wKvJFyZFt9rpDtjC4neAqEFv5EYLN6njt493aRqMMxMna8vpQUK02YDGozCqS3S0oNuZ0BABSEQDuvOuLv4nNoTF4pDpCjr7F9Nk428VNadyHKSy1I3eB3WcRHNkNKtACeM31KSCJm9sb/LbK10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PYVXZxwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B378BC4CEF0;
	Tue, 12 Aug 2025 17:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755020719;
	bh=CEJWJq6sl8EsfebfQ9jrh6c1QFXw53ZBcBQ6UVRdK6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PYVXZxwp4m/YZQ5Fk/0wSrPXtU0Qc1/qUnBqHc+j4IBMwT90oHF7gij3ALj3pARRs
	 aIGoChaSSawCpdT/Lev6dW6ezwOflIJ698Ko0dZ8YD0dz+z6RABK1PTw+mOLM50yLh
	 aouIf/fnKmZzWLGA6Fwl7ytU24XQQPyHfYsdqIwg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adam Queler <queler+k@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 003/262] ASoC: amd: yc: Add DMI entries to support HP 15-fb1xxx
Date: Tue, 12 Aug 2025 19:26:31 +0200
Message-ID: <20250812172953.115252678@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172952.959106058@linuxfoundation.org>
References: <20250812172952.959106058@linuxfoundation.org>
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

From: Adam Queler <queler@gmail.com>

[ Upstream commit 949ddec3728f3a793a13c1c9003028b9b159aefc ]

This model requires an additional detection quirk to
enable the internal microphone.

Signed-off-by: Adam Queler <queler+k@gmail.com>
Link: https://patch.msgid.link/20250715031434.222062-1-queler+k@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 74f8e12aa710..1063a19b39aa 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -528,6 +528,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "OMEN by HP Gaming Laptop 16z-n000"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Victus by HP Gaming Laptop 15-fb1xxx"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.39.5




