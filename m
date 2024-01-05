Return-Path: <stable+bounces-9798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B345182557A
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 15:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD7A284D59
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 14:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530642BD12;
	Fri,  5 Jan 2024 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bg2akAoo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1673F2E3EF;
	Fri,  5 Jan 2024 14:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F66C433C8;
	Fri,  5 Jan 2024 14:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704465552;
	bh=Hqe63noenKbUilW7AwyFkqQKqfdD6Z2lhLGzswhJjLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bg2akAooeP9R9nnZWXxf386HfNc0NEJZYAMi/XWxHAkgQLmA8lYFVxmvQYrk9iAXE
	 ztgwP1vgYK71dAldeNi6Lk2EGOsvwoaYFevvjrVq1/LLIOfYW5+BelIfiu0dLaEefY
	 bti5Et9QLews/zHsNQP1GmRaDUZlHd6tfBM9NGvM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kunwu Chan <chentao@kylinos.cn>,
	Tony Lindgren <tony@atomide.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 01/21] ARM: OMAP2+: Fix null pointer dereference and memory leak in omap_soc_device_init
Date: Fri,  5 Jan 2024 15:38:48 +0100
Message-ID: <20240105143811.605322683@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105143811.536282337@linuxfoundation.org>
References: <20240105143811.536282337@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit c72b9c33ef9695ad7ce7a6eb39a9df8a01b70796 ]

kasprintf() returns a pointer to dynamically allocated memory which can
be NULL upon failure. When 'soc_dev_attr->family' is NULL,it'll trigger
the null pointer dereference issue, such as in 'soc_info_show'.

And when 'soc_device_register' fails, it's necessary to release
'soc_dev_attr->family' to avoid memory leaks.

Fixes: 6770b2114325 ("ARM: OMAP2+: Export SoC information to userspace")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Message-ID: <20231123145237.609442-1-chentao@kylinos.cn>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap2/id.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 79d71b1eae594..1bc17fd49e488 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -784,10 +784,15 @@ void __init omap_soc_device_init(void)
 
 	soc_dev_attr->machine  = soc_name;
 	soc_dev_attr->family   = omap_get_family();
+	if (!soc_dev_attr->family) {
+		kfree(soc_dev_attr);
+		return;
+	}
 	soc_dev_attr->revision = soc_rev;
 
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->family);
 		kfree(soc_dev_attr);
 		return;
 	}
-- 
2.43.0




