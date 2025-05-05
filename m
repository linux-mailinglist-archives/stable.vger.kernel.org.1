Return-Path: <stable+bounces-139880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B167BAAA186
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704AE1A84C66
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D322BEC38;
	Mon,  5 May 2025 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+LTiSyC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DF82BEC2A;
	Mon,  5 May 2025 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483594; cv=none; b=AuPGacu63vT1cBgDasBf8DY1h4zjj6u7p2MGj1Vt3pubFrlNaki63x3ehxYA60JrscgOzmJGFTrsgYZUH5297HexPT7BkOtHq/ChytEjPfrMsuSfFs64uyc52Ofj5T2dkIc8LTrQKGgJ1ZVtDuSwK6gOKNulAeLETj9VIEiODTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483594; c=relaxed/simple;
	bh=bLujnhfTIunbQHVmbq4ko2m/+miocLfsEpD1Mp5kBX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a8TMA4Q3MJ7jd3l4uA3G0xtCYzl76ns0GmAMffBGJbCqBB19NgKe1t+ANaqkp9jqDZOFQXY2CTKKpBIinN2+lrwSLmNNTTB7rnR/4LOagc2BESBb46K2oxjQrVARvOm233QiA6ubpGbnANFK2jlzte9m8syhAnLwHfKmaLfuUeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+LTiSyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3F6C4CEEF;
	Mon,  5 May 2025 22:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483594;
	bh=bLujnhfTIunbQHVmbq4ko2m/+miocLfsEpD1Mp5kBX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+LTiSyCETvSUuFtPN3khfCQk4VaTXnfv6Y6ChtwptzvePxc4XLzfliw5k9GTTkTU
	 0en4sjiVyFyM6WIgLrSUgAzMw+bNDckG/BEifyt/IZr5VlHxTPIqMlFrVpjKZW/btq
	 JBHBYdhWIOiic88XUBoietT4oYvCavzR8sEDMEAX2JGqezmj5NHTlGBsM0EVFIyhqX
	 BFolZX/b3DKA56CjpeVYDBYwAz0F/9urRtQhfkc52LYxcPl9WGnJWai5MVW0ARwtn7
	 uG8L0kWbb/X9THdc/+5FSIaGQJObKs13nQT0yBoHUTCMyMu8qZsUxfJ9YOJq2qsd/g
	 kmG030NlPHsDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	andreas.noever@gmail.com,
	michael.jamet@intel.com,
	westeri@kernel.org,
	YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 133/642] thunderbolt: Do not add non-active NVM if NVM upgrade is disabled for retimer
Date: Mon,  5 May 2025 18:05:49 -0400
Message-Id: <20250505221419.2672473-133-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit ad79c278e478ca8c1a3bf8e7a0afba8f862a48a1 ]

This is only used to write a new NVM in order to upgrade the retimer
firmware. It does not make sense to expose it if upgrade is disabled.
This also makes it consistent with the router NVM upgrade.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/retimer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index 1f25529fe05da..361fece3d8188 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -93,9 +93,11 @@ static int tb_retimer_nvm_add(struct tb_retimer *rt)
 	if (ret)
 		goto err_nvm;
 
-	ret = tb_nvm_add_non_active(nvm, nvm_write);
-	if (ret)
-		goto err_nvm;
+	if (!rt->no_nvm_upgrade) {
+		ret = tb_nvm_add_non_active(nvm, nvm_write);
+		if (ret)
+			goto err_nvm;
+	}
 
 	rt->nvm = nvm;
 	dev_dbg(&rt->dev, "NVM version %x.%x\n", nvm->major, nvm->minor);
-- 
2.39.5


