Return-Path: <stable+bounces-9489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2D282329E
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6C11F24DBD
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7791C2AF;
	Wed,  3 Jan 2024 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TbHsYJEg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EB81BDF1;
	Wed,  3 Jan 2024 17:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCD6C433C8;
	Wed,  3 Jan 2024 17:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301759;
	bh=/2470QHDFwEmrRiI+GQUrXcTU5h2Pjj/F0umj2cacm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TbHsYJEgY8N78NPBnThH2kB+JcdzFxBxqxtMa/oB6yvYNmAhA3oi7ETMZL6WPAoze
	 Vmv/Xi4LFIPDTjJTve3JZcICHf8U6v66N3ut66wAYuzXyXmaQPHGNLaP4Vjbj5PPo7
	 lSz88IgwrxJWNJ0nmN2GSeDCDLOgDI49OBaEmok0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kunwu Chan <chentao@kylinos.cn>,
	Tony Lindgren <tony@atomide.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 03/75] ARM: OMAP2+: Fix null pointer dereference and memory leak in omap_soc_device_init
Date: Wed,  3 Jan 2024 17:54:44 +0100
Message-ID: <20240103164843.483332011@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164842.953224409@linuxfoundation.org>
References: <20240103164842.953224409@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 59755b5a1ad7a..75091aa7269ae 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -793,11 +793,16 @@ void __init omap_soc_device_init(void)
 
 	soc_dev_attr->machine  = soc_name;
 	soc_dev_attr->family   = omap_get_family();
+	if (!soc_dev_attr->family) {
+		kfree(soc_dev_attr);
+		return;
+	}
 	soc_dev_attr->revision = soc_rev;
 	soc_dev_attr->custom_attr_group = omap_soc_groups[0];
 
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->family);
 		kfree(soc_dev_attr);
 		return;
 	}
-- 
2.43.0




