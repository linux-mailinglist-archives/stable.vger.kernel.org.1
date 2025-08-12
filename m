Return-Path: <stable+bounces-168596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5F6B235D9
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A778018978EA
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6641474CC;
	Tue, 12 Aug 2025 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bu4TQzlg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEA26BB5B;
	Tue, 12 Aug 2025 18:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024697; cv=none; b=oCQ/MWNrcSPiT0oCkk8G6RgZBtUP7DjJ+QVscVEovJSMWGmlD/l15n93mqP8/048T01I7eqgeU2L7RBIXnImEpV/SzmLJOMlpFpNW5mrYGhfp3gko0l9HEgy0e3HIdr++gUiCKVcg0wZP7yGBzC5FEzr7siMg5zqlfw88/BapEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024697; c=relaxed/simple;
	bh=k1D7CZxTbfjD+LdzxSTMgLdmVMHDrz/a/X2+9VeOlk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0jHQxUjmrgle11EmlIAY9e4taAa+TCS32KwXlvH8Dbo56lVqc1sPNYtJor1vDQHZYk3QPMy1OsLHyu3/haXbegtLfqnf+Pt+tp06Jn+NvCp5M5rj8f5io1QbZLmqu3dRGjn934WiMaAgdG+VNWUOcF4FZY+j6n91JjpoFIHBCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bu4TQzlg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D676C4CEF0;
	Tue, 12 Aug 2025 18:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755024697;
	bh=k1D7CZxTbfjD+LdzxSTMgLdmVMHDrz/a/X2+9VeOlk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bu4TQzlgg7vJtNMJkrz2qW3FtpYf8bqW1o0wyb+1S79kf84CNWt2Nx1JFRI5krlz2
	 A4qI9kFTpTio6EVrn3J+MFns+uaK5/dGWz9tA8iE1ODDyhzHysQiRUXXw4DrVuX1Ej
	 oF8f9VYbb3kOkhhyrjx1TBhbZQ+igA72/iy/5+FA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anders Roxell <anders.roxell@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 449/627] vdpa: Fix IDR memory leak in VDUSE module exit
Date: Tue, 12 Aug 2025 19:32:24 +0200
Message-ID: <20250812173436.850798612@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anders Roxell <anders.roxell@linaro.org>

[ Upstream commit d9ea58b5dc6b4b50fbb6a10c73f840e8b10442b7 ]

Add missing idr_destroy() call in vduse_exit() to properly free the
vduse_idr radix tree nodes. Without this, module load/unload cycles leak
576-byte radix tree node allocations, detectable by kmemleak as:

unreferenced object (size 576):
  backtrace:
    [<ffffffff81234567>] radix_tree_node_alloc+0xa0/0xf0
    [<ffffffff81234568>] idr_get_free+0x128/0x280

The vduse_idr is initialized via DEFINE_IDR() at line 136 and used throughout
the VDUSE (vDPA Device in Userspace) driver for device ID management. The fix
follows the documented pattern in lib/idr.c and matches the cleanup approach
used by other drivers.

This leak was discovered through comprehensive module testing with cumulative
kmemleak detection across 10 load/unload iterations per module.

Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Message-Id: <20250704125335.1084649-1-anders.roxell@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 6a9a37351310..04620bb77203 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2216,6 +2216,7 @@ static void vduse_exit(void)
 	cdev_del(&vduse_ctrl_cdev);
 	unregister_chrdev_region(vduse_major, VDUSE_DEV_MAX);
 	class_unregister(&vduse_class);
+	idr_destroy(&vduse_idr);
 }
 module_exit(vduse_exit);
 
-- 
2.39.5




