Return-Path: <stable+bounces-92528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834DA9C54C0
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4749E2815E8
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE332229C1;
	Tue, 12 Nov 2024 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8LOuxrE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0397821500F;
	Tue, 12 Nov 2024 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407845; cv=none; b=fzLvLkqy/f0bcITWVQjpLml2kxXAQ/6Q8fFHnZeyv+Sc25TH1xwM9KlCV418qUS5HCklUvO4FI0V0ct9LLbRFPpA2uAFWHjqbR1Gxs2AdqerSCifurlK5Vq+CSrox2aAwseI8a75YhyboUfiL66YjNp94bRqxxIiJK5jBL6UeHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407845; c=relaxed/simple;
	bh=GvF7nkVv8o/M22CjS96TnPNxa4CZogBko2MirNKgpY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzYKG9UpekUaCqSdEwXYKC5tnErE3tmytPLzFgASmhdzxhW6oww2BPPRXc0XX7wN1qEh4fT8DdcbJdjAswcylomBgYbs3Mv17W0l0mnF8DBllkxyyBghhM9V8oDgye9Ndw77Yu8HX/kZwyVEOO7otE3n4bEBzHY8lcL1HR+xtAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8LOuxrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884B0C4CED6;
	Tue, 12 Nov 2024 10:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407844;
	bh=GvF7nkVv8o/M22CjS96TnPNxa4CZogBko2MirNKgpY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m8LOuxrESkpI+NcfoGumKpFpk5x7d6DaBeT2/WY/0X2qbN88ry6nF+Rzo/MqmTkVu
	 ei6wtkZ9mDOl1Dh4tw4FqOLoHTDwrJbXZlNfi4P8ugokDsC/2uZjQlxtIfI7XGM4eU
	 7g/z0JDoBwwpcCf+yt8jY2bSIutCs9tpsHIKDtSTlgJO6LkcnktJZQ6u6POaWqvQ5i
	 mZBEccbLrU65pVMoTL33ywHHRa2ijgtUjIojSro+fBMcEekIPMkPiZsOY5GEXWsWpf
	 qB9YC2nzz3bQJ6lDKB31P1eoq+18hS8IFcNLs8KsG5n8gQdc4wGGqIHyQyQfL6TJpa
	 OXrV4387egZig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kurt Borja <kuurtb@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	ilpo.jarvinen@linux.intel.com,
	lsanche@lyndeno.ca,
	W_Armin@gmx.de,
	amishin@t-argos.ru,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 03/12] platform/x86: dell-smbios-base: Extends support to Alienware products
Date: Tue, 12 Nov 2024 05:37:05 -0500
Message-ID: <20241112103718.1653723-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103718.1653723-1-sashal@kernel.org>
References: <20241112103718.1653723-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.116
Content-Transfer-Encoding: 8bit

From: Kurt Borja <kuurtb@gmail.com>

[ Upstream commit a36b8b84ac4327b90ef5a22bc97cc96a92073330 ]

Fixes the following error:

dell_smbios: Unable to run on non-Dell system

Which is triggered after dell-wmi driver fails to initialize on
Alienware systems, as it depends on dell-smbios.

This effectively extends dell-wmi, dell-smbios and dcdbas support to
Alienware devices, that might share some features of the SMBIOS intereface
calling interface with other Dell products.

Tested on an Alienware X15 R1.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Pali Rohár <pali@kernel.org>
Link: https://lore.kernel.org/r/20241031154023.6149-2-kuurtb@gmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/dell/dell-smbios-base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
index 6fb538a138689..9a9b9feac4166 100644
--- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -544,6 +544,7 @@ static int __init dell_smbios_init(void)
 	int ret, wmi, smm;
 
 	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
+	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Alienware", NULL) &&
 	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
 		pr_err("Unable to run on non-Dell system\n");
 		return -ENODEV;
-- 
2.43.0


