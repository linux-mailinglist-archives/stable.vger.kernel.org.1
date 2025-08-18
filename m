Return-Path: <stable+bounces-170079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43011B2A223
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4E6D7A64A2
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A302831CA50;
	Mon, 18 Aug 2025 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qTJJAf9p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9F421ABAA;
	Mon, 18 Aug 2025 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521447; cv=none; b=KpQlnco43zn5LgiiOe9M+N2PRmH51Cj1Pg8qRJU2gihyIiJGQTIeqZDwCvNjDIXN12H/erONER781t5sAfNv4Y3RMKAXPvYiAvTqWapulT7IDGgUlfTahVWiWsIpAUrOdQizAiJ05GDqd2dsvu6BYh0kacF2AD/VwumuUQ7vdkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521447; c=relaxed/simple;
	bh=UIci06kRJj8rmwtY9qshhdnpc4RUJiOpF8briYntGz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaOTo0z3b8Zx1UirBsythxD4dODxQX8LSGkJ0UMfhTM9eGEo05dd2Xs1wICQ6xQZTe1jrLFuDf9JqH5SqqNCDn1NtCn+oBY0rLSAN66yYlEv0Y0uGOwIWoUaeooyGj8xw+wzDKDAezHMQLBuBI7SR5yQ7Eut89nM1AQVLvNnFNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qTJJAf9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B92CC4CEEB;
	Mon, 18 Aug 2025 12:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755521446;
	bh=UIci06kRJj8rmwtY9qshhdnpc4RUJiOpF8briYntGz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qTJJAf9pwoZZSA/Mo3Sgyf+DL63TWH9yVfmJYRkTH4lLwNtSIidEtDRSvp0j4KAaJ
	 FCK00n08VXVaPlMtHyAe9ISinL67bO0exssFRxEMZfwNGYkJNZCXR2Nwto9SypYJyh
	 nW9tCsQ74YoTM3razAK7w7UzLQY2fJwsHu/c/XBg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christopher Eby <kreed@kreed.org>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.12 005/444] ALSA: hda/realtek: Add Framework Laptop 13 (AMD Ryzen AI 300) to quirks
Date: Mon, 18 Aug 2025 14:40:31 +0200
Message-ID: <20250818124449.101176636@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
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

From: Christopher Eby <kreed@kreed.org>

commit 0db77eccd964b11ab2b757031d1354fcc5a025ea upstream.

Framework Laptop 13 (AMD Ryzen AI 300) requires the same quirk for
headset detection as other Framework 13 models.

Signed-off-by: Christopher Eby <kreed@kreed.org>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20250810030006.9060-1-kreed@kreed.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11348,6 +11348,7 @@ static const struct hda_quirk alc269_fix
 	SND_PCI_QUIRK(0xf111, 0x0001, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0xf111, 0x0006, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0xf111, 0x0009, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0xf111, 0x000b, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0xf111, 0x000c, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 
 #if 0



