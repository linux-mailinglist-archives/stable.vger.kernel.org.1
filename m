Return-Path: <stable+bounces-19153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4991E84D450
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 22:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75DBD1C22EB7
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 21:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3961414FF95;
	Wed,  7 Feb 2024 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6wtpatH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC49014FF8B;
	Wed,  7 Feb 2024 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341058; cv=none; b=HmgLBZk6W9vQxL1h016L1TqNLWU1LWldQzINHkeJjPCfutY5H2vX33BHtMIY/Ocbtxr8dHEc5TNHxstOUX1hsHiv+v0FFpMtkGNkkG6f3UDiKP1NJ5v/gnXnBip+yr30YrIgz6aQNGaPo2EDDGaViMG4OfDwljIqEHd7Y41pdpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341058; c=relaxed/simple;
	bh=iRmMvfCdMNSvbGxyO9wNi/xoe4+RBnCWHEuawGQAhkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBc5QbvIVvYGlIKWpvxkILwhQG5ELSws4bNXXWRz42SPSfSG8I7ZsICqrbhmsPovmzIjRgEsbxYhxdAkeLtuVMl/QABbTTn5t6meVkaI/LN8DSDhYn1MFm1fpnjMJNKi54/tE8ujRZojKC3VP7llpPc3Q4kdo8+bEiuZaplSktA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6wtpatH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930E5C43399;
	Wed,  7 Feb 2024 21:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341057;
	bh=iRmMvfCdMNSvbGxyO9wNi/xoe4+RBnCWHEuawGQAhkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s6wtpatHeD1jzncytUGtT0Jm6iKF5v76JgHnUFmSUVsBItaoCa9gc5liCQqa/eYYu
	 2DHfCiliJIBXMYRJuAhH1g2ZeJ4yOmc/ZWhghJr35x9qYpPJLgddT2wrU4TNbyiPqv
	 CgPEDTF0a9sorqzcEaWoXy9J9B71Ogbjy27GZiipyHw09ohadmVst/5ELJrKIAaMMO
	 3ubGzSRj7qyrQcunF+jeZNYJe8L92uOXiaZpmDTqWl3tb4nRpqrzDmclupFBqWYJCx
	 BkuY6Ucq3fQFmaeSYQopLuyY4sl9/OqiQ/0bcOiUvHW2VyiZ3PJ/9R+oOIs4XxTYyP
	 CD1Cczmjh8OUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	David Brazdil <dbrazdil@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 20/38] misc: open-dice: Fix spurious lockdep warning
Date: Wed,  7 Feb 2024 16:23:06 -0500
Message-ID: <20240207212337.2351-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Will Deacon <will@kernel.org>

[ Upstream commit ac9762a74c7ca7cbfcb4c65f5871373653a046ac ]

When probing the open-dice driver with PROVE_LOCKING=y, lockdep
complains that the mutex in 'drvdata->lock' has a non-static key:

 | INFO: trying to register non-static key.
 | The code is fine but needs lockdep annotation, or maybe
 | you didn't initialize this object before use?
 | turning off the locking correctness validator.

Fix the problem by initialising the mutex memory with mutex_init()
instead of __MUTEX_INITIALIZER().

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Brazdil <dbrazdil@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20240126152410.10148-1-will@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/open-dice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/open-dice.c b/drivers/misc/open-dice.c
index 8aea2d070a40..d279a4f195e2 100644
--- a/drivers/misc/open-dice.c
+++ b/drivers/misc/open-dice.c
@@ -140,7 +140,6 @@ static int __init open_dice_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	*drvdata = (struct open_dice_drvdata){
-		.lock = __MUTEX_INITIALIZER(drvdata->lock),
 		.rmem = rmem,
 		.misc = (struct miscdevice){
 			.parent	= dev,
@@ -150,6 +149,7 @@ static int __init open_dice_probe(struct platform_device *pdev)
 			.mode	= 0600,
 		},
 	};
+	mutex_init(&drvdata->lock);
 
 	/* Index overflow check not needed, misc_register() will fail. */
 	snprintf(drvdata->name, sizeof(drvdata->name), DRIVER_NAME"%u", dev_idx++);
-- 
2.43.0


