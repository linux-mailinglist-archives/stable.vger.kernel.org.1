Return-Path: <stable+bounces-67882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94D1952F90
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B691F213E3
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325751A2C11;
	Thu, 15 Aug 2024 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vWFW0xJG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB37B1A00F1;
	Thu, 15 Aug 2024 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728818; cv=none; b=DmE3+YKc7iHDrqz+aHf+hqC4TS+iz0WNqMlD3kQLaon98TRaeLlLH41dPdBVeZQVqZuABWCDfkMv+G22ht05zB3Krj9SSVykUUBIOPFRNjwZKAgNpupEBeF8ZPVI7MPXF9S2S3z0opcK6Z8jPliBP1SHZAgDgQLDbhc4ccQZxcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728818; c=relaxed/simple;
	bh=QZTaewZ6tE+lztpDoLuCehM26bciG6mgYmokH82t55s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmmCD83OEG4KtzU073aYF8w5Y4ysaPEh3S4LnG3044K9Gg1C1w5kQoeVsqf9uK4Q8W/I6ZkgcnzHSRjmV4N3IKYX9i8Ek75WFu86u4COHuR2yr5Br1TeksgODwu2Du6PM1fp0uvRKN6bButJ44nleOL7Gk4fKOJivEQuhKSoO3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vWFW0xJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6F9C4AF0C;
	Thu, 15 Aug 2024 13:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723728817;
	bh=QZTaewZ6tE+lztpDoLuCehM26bciG6mgYmokH82t55s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vWFW0xJGbkdV2JIEmsJyjR1WxQamegOrpZSQJHuS8jwqO0nTFHTj46209AwoqLVRo
	 QIMOvtRzedX6/nJcroFgNsG0C4Msi5raZb4TUigByHhIXCwmO2I5h8ymZe+VtUQe8v
	 Ivua7fDVvgNfJL0fzJfYONXC7gLrwB47P3rmh3lI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 120/196] remoteproc: imx_rproc: ignore mapping vdev regions
Date: Thu, 15 Aug 2024 15:23:57 +0200
Message-ID: <20240815131856.668072553@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131852.063866671@linuxfoundation.org>
References: <20240815131852.063866671@linuxfoundation.org>
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

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit 8f2d8961640f0346cbe892273c3260a0d30c1931 ]

vdev regions are vdev0vring0, vdev0vring1, vdevbuffer and similar.
They are handled by remoteproc common code, no need to map in imx
rproc driver.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Link: https://lore.kernel.org/r/1615029865-23312-10-git-send-email-peng.fan@oss.nxp.com
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Stable-dep-of: 2fa26ca8b786 ("remoteproc: imx_rproc: Skip over memory region when node value is NULL")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/imx_rproc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 54c07fd3f2042..99d1a90ea084a 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -289,6 +289,9 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
 		struct resource res;
 
 		node = of_parse_phandle(np, "memory-region", a);
+		/* Not map vdev region */
+		if (!strcmp(node->name, "vdev"))
+			continue;
 		err = of_address_to_resource(node, 0, &res);
 		if (err) {
 			dev_err(dev, "unable to resolve memory region\n");
-- 
2.43.0




