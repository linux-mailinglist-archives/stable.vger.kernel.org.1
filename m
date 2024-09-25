Return-Path: <stable+bounces-77492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1DD985DC2
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDC41C25154
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1228F1C9B92;
	Wed, 25 Sep 2024 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBP2WvmK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F401C9B86;
	Wed, 25 Sep 2024 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266006; cv=none; b=MtevSwf0qHSlY329hH0dT95FVxjbvvTzmwgE82UC9D3X2rnBUa98LsNQMfIQ3pOE5r7o2foxexNejWasAQF5kSq4VIxXjrRb7V5DXzXmCupl6JpoZ2PQgRyKLQIUmaCpM7OjftdWPVAFsOkQCiKeoqRHfXkdwaXkvf8Wzm3wFPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266006; c=relaxed/simple;
	bh=4dCBbyefiLS69gwJ6zh2z6CnqOHxb725Ds9gYOFAIpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0AAVLB+iuCkQXF9mQK4rh2e6uD2wIhTUBiDzhb5gqahrxSpdqVxXxKXbrV5kmS3Glx02MzCna/KmTg2N1DTejZIhr39KH5y8h+GAZP3SnJK2YzSi6/zafykIX1KIs6VTscqz/AtV1MJXPjJsb3aG7l3QH6IxI4ueaZeyRuKpOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBP2WvmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44164C4CEC3;
	Wed, 25 Sep 2024 12:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266006;
	bh=4dCBbyefiLS69gwJ6zh2z6CnqOHxb725Ds9gYOFAIpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KBP2WvmKJ6oyuj58zi77Cd3OYSum+UFudlt8sechkigH6hMMgaIqaUUuDABqMpHz2
	 1+p8+7i1AyUiFb8gTY2Z5DAHj3Gc6dheffWG0sbRCcri6FJBkmnIqt4NVG4WaGJmdk
	 jtriH90KI656HMfDK/ZHw7xUYDzaG+H2l5E16wO3tIAB45MQz2pvZvMIuCUXbpt5as
	 JcsJtHhsNEPR1oe8t0xuSOGS0mQrjOeIy9WVxxIJ0foOhWvxqhj2JJ7nuRjo0dGR7w
	 CIa9ECJmEEf1t4Zzu8utJ8PKtBXv6prRjFSp11INcsl7KTOTiBrbUc3M5ppA4vMb7Y
	 OqW2YUh/2npDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: aln8 <aln8un@gmail.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 147/197] platform/x86/amd: pmf: Add quirk for TUF Gaming A14
Date: Wed, 25 Sep 2024 07:52:46 -0400
Message-ID: <20240925115823.1303019-147-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: aln8 <aln8un@gmail.com>

[ Upstream commit 06369503d644068abd9e90918c6611274d94c126 ]

The ASUS TUF Gaming A14 has the same issue as the ROG Zephyrus G14
where it advertises SPS support but doesn't use it.

Signed-off-by: aln8 <aln8un@gmail.com>
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Link: https://lore.kernel.org/r/20240912073601.65656-1-aln8un@gmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmf/pmf-quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/amd/pmf/pmf-quirks.c b/drivers/platform/x86/amd/pmf/pmf-quirks.c
index 460444cda1b29..6ee219a81537d 100644
--- a/drivers/platform/x86/amd/pmf/pmf-quirks.c
+++ b/drivers/platform/x86/amd/pmf/pmf-quirks.c
@@ -37,6 +37,14 @@ static const struct dmi_system_id fwbug_list[] = {
 		},
 		.driver_data = &quirk_no_sps_bug,
 	},
+	{
+		.ident = "ASUS TUF Gaming A14",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FA401W"),
+		},
+		.driver_data = &quirk_no_sps_bug,
+	},
 	{}
 };
 
-- 
2.43.0


