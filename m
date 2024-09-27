Return-Path: <stable+bounces-78033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E26649884C7
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB891C221EE
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DCB18CC07;
	Fri, 27 Sep 2024 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fyB4hV8C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AD4187331;
	Fri, 27 Sep 2024 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440237; cv=none; b=lOJyRrHj6HO+UHqNWQaJRl107KLSM8W8cr5sMaR79irNkfEYvjFyU00vxXlXxoAz92P7EuIElH6Ctc0Hus0r9XQqJS40Xw3WaQrQo94ojWEX6WwUFPlR1ye+AOWQGNU+H7HUlAlXb3DN2zu97kE/hIYncVx2Y1Am5e0wn3VdXWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440237; c=relaxed/simple;
	bh=Hk6szu5hhGLlfgd+qx89/WDS+jmw+0YCAmZrFEKuV0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKKhfexOV0MbRxpIkEe/TiVZGyvbEbcT7IS7qKE8kfAcuMjobzQxF6uiP/qbauvx1PL7QCxFKXCJC7LRUcGGGzYVJLLJKLtxDP35IKsY32deDT6CsOI510qd54hlSWcmWUh4EURhq0NZfosPkaagKG5fJy+RXqRxg9ysC/jFjtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fyB4hV8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF2CC4CEC6;
	Fri, 27 Sep 2024 12:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727440236;
	bh=Hk6szu5hhGLlfgd+qx89/WDS+jmw+0YCAmZrFEKuV0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fyB4hV8Cd5Fw+GUfwvT7fq/FMcOjYAjOr9eha3uCcIpUmlyzdA8ga+NpF/8Ej3rHE
	 7h8wCqyP62MiX1vTCMFW5nxdjpQVDaW20+Q8Gq49xAVpzPU1bBnM/VrXVVCGE2daFf
	 Xd2A6SaTloLHjS7Vc5/a2GgcETPBw4CLEbAA7R0Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hongbo Li <lihongbo22@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 02/73] ASoC: allow module autoloading for table db1200_pids
Date: Fri, 27 Sep 2024 14:23:13 +0200
Message-ID: <20240927121719.992577089@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927121719.897851549@linuxfoundation.org>
References: <20240927121719.897851549@linuxfoundation.org>
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

From: Hongbo Li <lihongbo22@huawei.com>

[ Upstream commit 0e9fdab1e8df490354562187cdbb8dec643eae2c ]

Add MODULE_DEVICE_TABLE(), so modules could be properly
autoloaded based on the alias from platform_device_id table.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Link: https://patch.msgid.link/20240821061955.2273782-2-lihongbo22@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/au1x/db1200.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 400eaf9f8b140..f185711180cb4 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -44,6 +44,7 @@ static const struct platform_device_id db1200_pids[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(platform, db1200_pids);
 
 /*-------------------------  AC97 PART  ---------------------------*/
 
-- 
2.43.0




