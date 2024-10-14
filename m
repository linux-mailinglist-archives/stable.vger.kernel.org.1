Return-Path: <stable+bounces-84326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22AD99CFA3
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E7C2875B5
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D04D1AAE0C;
	Mon, 14 Oct 2024 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hVjL5ahT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2511B4F1E;
	Mon, 14 Oct 2024 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917627; cv=none; b=Ph65aKrgEJ7eLrnS/PIbWEXDx1KGro4qFp9skSiXXJv5/0Hb+IpPZwVRiJFr+WoIXpjsC/9D8N5wcwa6Ux4fNwqC2AFyy4r4eM5/QvhVJITH6BqIwE2GM++VFWn3sGDmiKzdhclXA8D3yiMTB7VdG3ySpy3pvpw3oicQLiLS1Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917627; c=relaxed/simple;
	bh=h48pcK26r+vFHugYUlPyDJeNLMKHm8C4yU9BTiEzazU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9cix5TSl7CsQ+NtZbyLxjKOBIhqIKL2oWXUhwPHXbaPusEAnANTwB7cHX2iEIz7W5rxJQ6dhUBIatK+k1QA1yZiqXv7kiZ3mg3h0x3JJwiV0LIA4sxZDSsH62sr6jyQE+fpg0mO8XCU8fagPnY6hyP5CJLyOLF7m8bwYOn51uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hVjL5ahT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C021C4CEC3;
	Mon, 14 Oct 2024 14:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728917627;
	bh=h48pcK26r+vFHugYUlPyDJeNLMKHm8C4yU9BTiEzazU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hVjL5ahTsQdTH8gJReBTyhoomr/Ero1s/ApzvKzGIoWWgcwngthDhcpmdvQMHSxch
	 8Jotat6CNQT76wyibpEOTshF6khHBw5pv12UD/GtMkhX1H8rE0hJS4PBCEtIR948us
	 pTKbDFql4aDzF58tXW5kOFjKL2DmUFcG7xIPOAss=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuntao Liu <liuyuntao12@huawei.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 085/798] ALSA: hda: cs35l41: fix module autoloading
Date: Mon, 14 Oct 2024 16:10:39 +0200
Message-ID: <20241014141221.273094787@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuntao Liu <liuyuntao12@huawei.com>

[ Upstream commit 48f1434a4632c7da1a6a94e159512ebddbe13392 ]

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from spi_device_id table.

Fixes: 7b2f3eb492da ("ALSA: hda: cs35l41: Add support for CS35L41 in HDA systems")
Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
Link: https://patch.msgid.link/20240815091312.757139-1-liuyuntao12@huawei.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l41_hda_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/cs35l41_hda_spi.c b/sound/pci/hda/cs35l41_hda_spi.c
index 71979cfb4d7ed..ac01b15f8fc2b 100644
--- a/sound/pci/hda/cs35l41_hda_spi.c
+++ b/sound/pci/hda/cs35l41_hda_spi.c
@@ -38,6 +38,7 @@ static const struct spi_device_id cs35l41_hda_spi_id[] = {
 	{ "cs35l41-hda", 0 },
 	{}
 };
+MODULE_DEVICE_TABLE(spi, cs35l41_hda_spi_id);
 
 static const struct acpi_device_id cs35l41_acpi_hda_match[] = {
 	{ "CSC3551", 0 },
-- 
2.43.0




