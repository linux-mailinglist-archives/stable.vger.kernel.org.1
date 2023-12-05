Return-Path: <stable+bounces-4403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE51804755
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB3F1C20DF4
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D250E8BF8;
	Tue,  5 Dec 2023 03:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y3AC904V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FF36FB1;
	Tue,  5 Dec 2023 03:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14634C433C7;
	Tue,  5 Dec 2023 03:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747449;
	bh=rzNAc5jMsHSwdW++0/Y71amW6UhMkHqcWSv4PHhmVy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y3AC904VX1bLi/vi5mK3xTIc242EQgy3PHeYtK155UFFvbE3mTAUD2DF766duJ/iG
	 +6Fn8+686VZudy7J9ZYzbAQLb+wx1xkyExP2Y6MnIHVdAWeNNld0cbNyohrglY3QNd
	 L3pRH+YjMbPO8i/xCrEDLe60jH+YcDQZaVzS9LQk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Abdul Halim, Mohd Syazwan" <mohd.syazwan.abdul.halim@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <jroedel@suse.de>,
	Abdul@web.codeaurora.org, Halim@web.codeaurora.org
Subject: [PATCH 5.10 080/135] iommu/vt-d: Add MTL to quirk list to skip TE disabling
Date: Tue,  5 Dec 2023 12:16:41 +0900
Message-ID: <20231205031535.539830151@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031530.557782248@linuxfoundation.org>
References: <20231205031530.557782248@linuxfoundation.org>
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

From: Abdul Halim, Mohd Syazwan <mohd.syazwan.abdul.halim@intel.com>

commit 85b80fdffa867d75dfb9084a839e7949e29064e8 upstream.

The VT-d spec requires (10.4.4 Global Command Register, TE field) that:

Hardware implementations supporting DMA draining must drain any in-flight
DMA read/write requests queued within the Root-Complex before switching
address translation on or off and reflecting the status of the command
through the TES field in the Global Status register.

Unfortunately, some integrated graphic devices fail to do so after some
kind of power state transition. As the result, the system might stuck in
iommu_disable_translation(), waiting for the completion of TE transition.

Add MTL to the quirk list for those devices and skips TE disabling if the
qurik hits.

Fixes: b1012ca8dc4f ("iommu/vt-d: Skip TE disabling on quirky gfx dedicated iommu")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Halim, Mohd Syazwan <mohd.syazwan.abdul.halim@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20231116022324.30120-1-baolu.lu@linux.intel.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/intel/iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -6325,7 +6325,7 @@ static void quirk_igfx_skip_te_disable(s
 	ver = (dev->device >> 8) & 0xff;
 	if (ver != 0x45 && ver != 0x46 && ver != 0x4c &&
 	    ver != 0x4e && ver != 0x8a && ver != 0x98 &&
-	    ver != 0x9a && ver != 0xa7)
+	    ver != 0x9a && ver != 0xa7 && ver != 0x7d)
 		return;
 
 	if (risky_device(dev))



