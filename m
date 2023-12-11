Return-Path: <stable+bounces-5555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAB280D55B
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02B31C213FC
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1055101B;
	Mon, 11 Dec 2023 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yVr6uCqn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D950D4F212;
	Mon, 11 Dec 2023 18:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EF5C433C7;
	Mon, 11 Dec 2023 18:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319033;
	bh=vGnghQTw0j2hVZyYsKrA6LFrH/NlvmdVcdIa7VWk/6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yVr6uCqn5qcLMAEufNfXO6FqwvUQqGwYIWIP6Tk5qrv5IzLb4WXSpQq5FnlUiK84y
	 4CW/bgmH/ISBG9g4Y/ArIdEqQiH2j89fOKay5dc3CXfREdKDMEw1YPLFDJ5Sa8GoIl
	 fzZEpzIx7xyGl5QZD1NSre7P9LGv3DcMyzOczUxg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Michael Kelley <mikelley@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 14/55] hv_netvsc: rndis_filter needs to select NLS
Date: Mon, 11 Dec 2023 19:21:24 +0100
Message-ID: <20231211182012.738136767@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182012.263036284@linuxfoundation.org>
References: <20231211182012.263036284@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 6c89f49964375c904cea33c0247467873f4daf2c ]

rndis_filter uses utf8s_to_utf16s() which is provided by setting
NLS, so select NLS to fix the build error:

ERROR: modpost: "utf8s_to_utf16s" [drivers/net/hyperv/hv_netvsc.ko] undefined!

Fixes: 1ce09e899d28 ("hyperv: Add support for setting MAC from within guests")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/20231130055853.19069-1-rdunlap@infradead.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/hyperv/Kconfig b/drivers/net/hyperv/Kconfig
index 0765d5f61714e..386658ce1297a 100644
--- a/drivers/net/hyperv/Kconfig
+++ b/drivers/net/hyperv/Kconfig
@@ -2,5 +2,6 @@ config HYPERV_NET
 	tristate "Microsoft Hyper-V virtual network driver"
 	depends on HYPERV
 	select UCS2_STRING
+	select NLS
 	help
 	  Select this option to enable the Hyper-V virtual network driver.
-- 
2.42.0




