Return-Path: <stable+bounces-201658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67894CC26C5
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C84A30802EE
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2E434D3BD;
	Tue, 16 Dec 2025 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjAIUoJG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE4034D3B8
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885362; cv=none; b=WNhhotpwuyzIc7tbMrOVhYFQUkVCJZewuUDNkOFrwmY7pa6ng3ESt87Je0E6WxmiO7PmvMtqNO3Qusk2qUXayib58KYCTciH10xnonXtWm7NnwGT/eMsI1Ktc3WFgQ229I7TFdIAtU3okPTZxc6ihpEbzgPybP3IbkCaZP112nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885362; c=relaxed/simple;
	bh=iy4h/Tf+/VjIuNTw7lJBpYp/C7Ehs1Npp/gB4Ei9YKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K379cuWqhhiB6QL/+7JrqpiSM6Tf3UARTQr7uo0RJHDOcIF54phsTIIn/muwg20mwm97DnXKQG3p4u9xIQpXGmW6MeWKSujnUD+awGpA0WJk/mwVsZlRMG6PbVVhv29V12oBc4zgeI5ALI694vRIp4OaP5eEs7XdkGR+VSb+iCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjAIUoJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C20C4CEF1;
	Tue, 16 Dec 2025 11:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765885362;
	bh=iy4h/Tf+/VjIuNTw7lJBpYp/C7Ehs1Npp/gB4Ei9YKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kjAIUoJGOtdgWF7ilnmrokqR50iXmy+JYE55AUrphlxrP1vP4QMQGqXSS8+R0PHt+
	 8HCRJVqIPVcxXjltm7y39i+pTotLARJE42XJilR3j24yMHiIwn0zSMhRGAJydwnqjA
	 Da8agQYgtPmYVzJB0rL5Dqz612Uf24GtCYgZL1MYMLN7l3pgF3UM2zu1cNSBghr52P
	 6R2MlZEJ6Y1LQDk62t2/1RgSfhIW73N28EScvajwBmhWP6VJFGZ1mMAqcnCbgI0Bv4
	 yZf9SPLxeXFtY+GmLxza+i4NCB/mqYWxivCY+nuLNqpxSAo54y0oKTXoMR0GhExhU9
	 sLeVFv28+NwIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Denis Arefev <arefev@swemel.ru>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ALSA: hda: cs35l41: Fix NULL pointer dereference in cs35l41_hda_read_acpi()
Date: Tue, 16 Dec 2025 06:42:26 -0500
Message-ID: <20251216114226.2766048-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025121643-crust-motocross-9384@gregkh>
References: <2025121643-crust-motocross-9384@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis Arefev <arefev@swemel.ru>

[ Upstream commit c34b04cc6178f33c08331568c7fd25c5b9a39f66 ]

The acpi_get_first_physical_node() function can return NULL, in which
case the get_device() function also returns NULL, but this value is
then dereferenced without checking,so add a check to prevent a crash.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 7b2f3eb492da ("ALSA: hda: cs35l41: Add support for CS35L41 in HDA systems")
Cc: stable@vger.kernel.org
Signed-off-by: Denis Arefev <arefev@swemel.ru>
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20251202101338.11437-1-arefev@swemel.ru
[ NULL check right after acpi_dev_put(adev) cleanup call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l41_hda.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index b437beae9b516..cbc350ec03cc4 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1432,6 +1432,8 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 
 	physdev = get_device(acpi_get_first_physical_node(adev));
 	acpi_dev_put(adev);
+	if (!physdev)
+		return -ENODEV;
 
 	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
 	if (IS_ERR(sub))
-- 
2.51.0


