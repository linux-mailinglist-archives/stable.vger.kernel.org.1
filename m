Return-Path: <stable+bounces-13700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44749837E11
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7B1FB25831
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD1A59B4F;
	Tue, 23 Jan 2024 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n5FTYqxl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA41758AD8;
	Tue, 23 Jan 2024 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969971; cv=none; b=T5SYl1LvjpMXse8fKUnQSQuqi6T0J9CD6s5OAHEpmsrAztR+KgFKNXav4PwrT959ZUesJ8G+wgT1jTIEbL2alONvPo5t7z4yIeyD2oq3YGudOlFXyDFL/dUl4NM10JXg6osq5KIgry/TTNJkWQBpDHq0E012rvbzduAqXSB2WVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969971; c=relaxed/simple;
	bh=iFkvGjZ331CD6TaUmXR5mMFBD+aBzM9Kr2Q2eCBcMMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKTUqkxcTdH8EEzwByUNwI7Bl9o/ePHeKXSDrfDi9JWpCSZgLWVsMz6yE42jK9JrYYCM2W6nA8/qxzggRmfTYlIMdvIGYqpc5zx12J1uh9oPS/8JuGPQTZTPbovQ0zNS49OT8bYT76NWenHyqxHtfeDKnNGhAKTxRfQvRhpwK6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n5FTYqxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAF4C433C7;
	Tue, 23 Jan 2024 00:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969971;
	bh=iFkvGjZ331CD6TaUmXR5mMFBD+aBzM9Kr2Q2eCBcMMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n5FTYqxlYL9eKvQkB76n+fPMvuvIyMT9ra3KuyA9vpdZ1t7CPCbX/4nOphW01Fkw4
	 Y4r7deh0ipcaEW30k89DBzM1bO/zyRDUL+OQEgZb5iHBz8MQU2Rb+L66mmfX37uTSk
	 gg+9MdtBv5Bkj9a/zEojaP/KHC8E97z+kDBul4Vc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rob Herring <robh@kernel.org>,
	Nikhil Agarwal <Nikhil.agarwal@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 544/641] cdx: Explicitly include correct DT includes, again
Date: Mon, 22 Jan 2024 15:57:28 -0800
Message-ID: <20240122235835.165671685@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring <robh@kernel.org>

[ Upstream commit aaee477e3e2c7305a95ffc528bf831a13da3dacb ]

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it was merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

CDX was fixed once, but commit ("cdx: Remove cdx controller list from cdx
bus system") added another occurrence.

Fixes: 54b406e10f03 ("cdx: Remove cdx controller list from cdx bus system")
Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Nikhil Agarwal <Nikhil.agarwal@amd.com>
Link: https://lore.kernel.org/r/20231207163128.2707993-2-robh@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cdx/cdx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 4461c6c9313f..d84d153078d7 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -57,7 +57,10 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/idr.h>
-- 
2.43.0




