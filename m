Return-Path: <stable+bounces-157875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ECCAE5608
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95ED169F5C
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F09223DFF;
	Mon, 23 Jun 2025 22:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bvWhUxNj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E501F7580;
	Mon, 23 Jun 2025 22:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716933; cv=none; b=pZaWvNxM5pFu6dozIe5jO2DnFPP6yeITfpy01tNxXKqdRYW88OAbLNtjfqp48dflUjz9LAPt6mZX8F0YodUsP2dMYvV2DzGmcLfsk9chR710+Qmm18O5b+nffRM4ABE35q8eqoDVfzZvDs+fAkegw0LH6t0ebWZ6tyLoM+l+WoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716933; c=relaxed/simple;
	bh=gAjbOeANzQ5Mo/U+k9zcPSaJMzPZ9IQDjdfu4vuGQuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKtdfXgg8/ONsoJeBLmuSNFV4cmTik/8zDe/zjS3mSBWNHCpDPLz7YTDxfNPnfuDBVxSRgb1IG651jHRiP9oFAWOBAWEBcB2dUl69zs4RPEBszU82Fg4ZLnmGPd3c/OqqV7r8KArbvK0Hk7Dmwyw8VKdpd5obpwaiftv0FRUBbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bvWhUxNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DA2C4CEEA;
	Mon, 23 Jun 2025 22:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716933;
	bh=gAjbOeANzQ5Mo/U+k9zcPSaJMzPZ9IQDjdfu4vuGQuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bvWhUxNj7tqs0ak7iS8XXZmfrsxDl0EikAPWaB3Zsu1yGGLPYcVQ2eQvcy3+LXzCj
	 rrlIw26ahJdKCpvueHmq8ZuPkxAqmrp1WR1Bwyt8GukebuZRZPXVHRSWD19Rt6kAAf
	 EmIUEvVnhd3P6/v168tR4tRRal8gTeqIAPGa08kw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yao Zi <ziyao@disroot.org>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.12 299/414] platform/loongarch: laptop: Unregister generic_sub_drivers on exit
Date: Mon, 23 Jun 2025 15:07:16 +0200
Message-ID: <20250623130649.481820971@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yao Zi <ziyao@disroot.org>

commit f78fb2576f22b0ba5297412a9aa7691920666c41 upstream.

Without correct unregisteration, ACPI notify handlers and the platform
drivers installed by generic_subdriver_init() will become dangling
references after removing the loongson_laptop module, triggering various
kernel faults when a hotkey is sent or at kernel shutdown.

Cc: stable@vger.kernel.org
Fixes: 6246ed09111f ("LoongArch: Add ACPI-based generic laptop driver")
Signed-off-by: Yao Zi <ziyao@disroot.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/loongarch/loongson-laptop.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/platform/loongarch/loongson-laptop.c
+++ b/drivers/platform/loongarch/loongson-laptop.c
@@ -611,11 +611,17 @@ static int __init generic_acpi_laptop_in
 
 static void __exit generic_acpi_laptop_exit(void)
 {
+	int i;
+
 	if (generic_inputdev) {
-		if (input_device_registered)
-			input_unregister_device(generic_inputdev);
-		else
+		if (!input_device_registered) {
 			input_free_device(generic_inputdev);
+		} else {
+			input_unregister_device(generic_inputdev);
+
+			for (i = 0; i < ARRAY_SIZE(generic_sub_drivers); i++)
+				generic_subdriver_exit(&generic_sub_drivers[i]);
+		}
 	}
 }
 



