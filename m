Return-Path: <stable+bounces-99855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA4B9E73DF
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459231885ECE
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7E3207E10;
	Fri,  6 Dec 2024 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qOqtlnj7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4643B2BB;
	Fri,  6 Dec 2024 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498579; cv=none; b=i+UrrQa/wwLwyUN+GVQMXmIi3LV0Q5/+OIiGIDUYoJSjZAgM6RX+/4SdXxNzWyRLu5T9J9vDAdOTZJM/A70whjQkBpURELUSUHr0DiScwqZ3w1YJ8l3Y6iSlCYUym3QTIxEus6VusIEmxzCJNDrYG9Q1ceWC5np24kqRJYBUZ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498579; c=relaxed/simple;
	bh=S7g0MwAbTpmlsIvUNU34unIOKvYO8SPeIv+XH1vLZys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUCRwtadToET9ZeHiBsjiwA7D/NrVgljTEIgTwh96YaFSMtWNT3lo/Qh7jSRCsKCtjRe6iyiKF8DkZ9lDSXmMD9K1NQZ22NPaoR1UdPRvcbF1vVipkSijD7O3B0fSF6nsfDoOvrvph1Bljgp1GY/pdhp2zaiyZsMqar9PoJqp+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qOqtlnj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659E2C4CED1;
	Fri,  6 Dec 2024 15:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733498578;
	bh=S7g0MwAbTpmlsIvUNU34unIOKvYO8SPeIv+XH1vLZys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qOqtlnj7dEVAOSCZELeyVqwG4pt8giAb6M1uXLaYTwWO/PEfUZASlTzZGL2ap3Ev9
	 ux34M5xSBFdHSSgCbueAqZROMCvNJ1/fnsc5Vtm9Fma5rWSYQuSEXZ1Z2Cu+XVg5fU
	 p1Pqed/CEI69EMNYk0iLZ6j3x6dc8MErhW/GKoF8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 585/676] modpost: use ALL_INIT_SECTIONS for the section check from DATA_SECTIONS
Date: Fri,  6 Dec 2024 15:36:44 +0100
Message-ID: <20241206143716.220740360@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit e578e4e3110635b20786e442baa3aeff9bb65f95 ]

ALL_INIT_SECTIONS is defined as follows:

  #define ALL_INIT_SECTIONS INIT_SECTIONS, ALL_XXXINIT_SECTIONS

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Stable-dep-of: bb43a59944f4 ("Rename .data.unlikely to .data..unlikely")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/mod/modpost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index c4c09e28dc902..413da4c93b78e 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -864,7 +864,7 @@ static const struct sectioncheck sectioncheck[] = {
 },
 {
 	.fromsec = { DATA_SECTIONS, NULL },
-	.bad_tosec = { ALL_XXXINIT_SECTIONS, INIT_SECTIONS, NULL },
+	.bad_tosec = { ALL_INIT_SECTIONS, NULL },
 	.mismatch = DATA_TO_ANY_INIT,
 },
 {
-- 
2.43.0




