Return-Path: <stable+bounces-111623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6DBA23006
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2431F16473B
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A41B1E7C27;
	Thu, 30 Jan 2025 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M3RQ1k2T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A791E522;
	Thu, 30 Jan 2025 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738247277; cv=none; b=beTilNQlg3z7uFKXOkAH4gJ3kzJjIP2uj7z91clmwb89+L0kv3czP+J4c9b6/YfVe7KppVC/FGk9e7GsJQb8qP/kZ3OUaf817PQnDQWDSZccGMrxVD2wrOW3NhZnCP4f3VyuUkQXqocN01MUQGc7XmrBU/AAyy4J7FmU7tp5yOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738247277; c=relaxed/simple;
	bh=cUDlMng3Gv/icPqXyv2h3K5P80tE9JZJeN4lrY6R5eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9R9FAmKog7byZg0L1nHAOQ2//Wrj9CHoskAAMqipB7yndEjQLLcD/PYSCnQFdjwnfeMlnGLkuX4ozT1QRjIgXd+4YD3H8gat7fWm1HbEx9TT/A48DZ6Nr3gKjjaqYohiilo++UyaopiOZtsqtbk88XfQeVznXh+P6K/JlTXJQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M3RQ1k2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB59C4CED2;
	Thu, 30 Jan 2025 14:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738247276;
	bh=cUDlMng3Gv/icPqXyv2h3K5P80tE9JZJeN4lrY6R5eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M3RQ1k2Tp/Zw4Kggj0kgcFW6lC6DKDTbnaxJ0X8L9a74mbqJ3V9B8F0m/iw0b7OFo
	 3WypbH15wWOe+Um70Y6oEecQSXP/T0zn20eixhGJmU2bsLBofI/I/fBG0Z3I77zCXj
	 7JYtVrWetLvB+MqoesrWGssLdGjjy8ob4odfVArU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 01/24] ASoC: wm8994: Add depends on MFD core
Date: Thu, 30 Jan 2025 15:01:53 +0100
Message-ID: <20250130140127.355257134@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130140127.295114276@linuxfoundation.org>
References: <20250130140127.295114276@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 5ed01155cea69801f1f0c908954a56a5a3474bed ]

The ASoC driver should not be used without the MFD component. This was
causing randconfig issues with regmap IRQ which is selected by the MFD
part of the wm8994 driver.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501061337.R0DlBUoD-lkp@intel.com/
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://patch.msgid.link/20250106154639.3999553-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 1750cc888bbe8..5aeec2ef14b46 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1776,6 +1776,7 @@ config SND_SOC_WM8993
 
 config SND_SOC_WM8994
 	tristate
+	depends on MFD_WM8994
 
 config SND_SOC_WM8995
 	tristate
-- 
2.39.5




