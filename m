Return-Path: <stable+bounces-140045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A9CAAA453
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72BF1886E5F
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751C42FE0B4;
	Mon,  5 May 2025 22:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buGsau6X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A602FE0AD;
	Mon,  5 May 2025 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483971; cv=none; b=b/VuNzhq6DX5mkdz67aaJjDEDfiJh6CKgPdv7LV1JvM2gfmwFHcX3oOMcBQ9hJF5jrj+PaGFBBiWQbS+wdz/52CtINJOV7sbJ970/e0kgsu2p74Ur23JSInY+CmHIu4FreZ2VbhjoHOujdAJmnswIpNDiZQkkEyVNWfliIFtprw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483971; c=relaxed/simple;
	bh=jIhSum4+a6VmsFbYcJTxe1fbt8iNZlAUy3+yev6QYro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uH9BW2mqKV9WbiK68c1qDLXSHN9eFI509CaXYnd+hJLK5M/VVyuJawhUVXoU5Xpl9LGylnf91Op7+5q/rG8rer87ACqK3e4SelWW6dklTyypXoZ8voUsz+IYe0fr8x3wdnKLeY4iJGBvStTx1N0x6A1Uq4083IsqaAFQe/IreuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buGsau6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB60C4CEE4;
	Mon,  5 May 2025 22:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483970;
	bh=jIhSum4+a6VmsFbYcJTxe1fbt8iNZlAUy3+yev6QYro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=buGsau6XEQLaiJ89ByJz+QDl8Q1SDHmP16n6mzSkU9KIG0CkPVmlCYp70/MXKGzsz
	 DSz0zPKtbLLFl3/NgcqnQDBS7ZPaEQqDUpNsOo+ZRyS/Y7Ychu9Jar7F7kmvwDZZ1p
	 70rKH8y0PzNbZnCtB2quMzuU6FS6Ifel1lUeqeo72dXFi+2HkqczntpQqfLUVfrpo+
	 z7nk+9Vd2HnVaWwsJeaTIhLZ3vkG2BinCQlB+xkcpqvxoNmzPVwyPWzK7FIn+B8xVW
	 kO2uoovS77wpe4dfYHkXAew3J3tJOYLOJPze8xWm5NY8FwMuJyxjJJxrmshj538VF1
	 +FNDWMdIyKyOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>,
	=?UTF-8?q?Micha=C5=82=20Wajdeczko?= <michal.wajdeczko@intel.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	=?UTF-8?q?Piotr=20Pi=C3=B3rkowski?= <piotr.piorkowski@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 298/642] drm/xe/pf: Create a link between PF and VF devices
Date: Mon,  5 May 2025 18:08:34 -0400
Message-Id: <20250505221419.2672473-298-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>

[ Upstream commit 8c0aff7d92e2be25717669eb65a81a89740a24f2 ]

When both PF and VF devices are enabled on the host, they
resume simultaneously during system resume.

However, the PF must finish provisioning the VF before any
VFs can successfully resume.

Establish a parent-child device link between the PF and VF
devices to ensure the correct order of resumption.

V4 -> V5:
- Added missing break in the error condition.
V3 -> V4:
- Made xe_pci_pf_get_vf_dev() as a static function and updated
  input parameter types.
- Updated xe_sriov_warn() to xe_sriov_abort() when VF device
  cannot be found.
V2 -> V3:
- Added function documentation for xe_pci_pf_get_vf_dev().
- Added assertion if not called from PF.
V1 -> V2:
- Added a helper function to get VF pci_dev.
- Updated xe_sriov_notice() to xe_sriov_warn() if vf pci_dev
  is not found.

Signed-off-by: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
Cc: Michał Wajdeczko <michal.wajdeczko@intel.com>
Cc: Michał Winiarski <michal.winiarski@intel.com>
Cc: Piotr Piórkowski <piotr.piorkowski@intel.com>
Reviewed-by: Piotr Piorkowski <piotr.piorkowski@intel.com>
Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250224102807.11065-2-satyanarayana.k.v.p@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_pci_sriov.c | 51 +++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_pci_sriov.c b/drivers/gpu/drm/xe/xe_pci_sriov.c
index aaceee748287e..09ee8a06fe2ed 100644
--- a/drivers/gpu/drm/xe/xe_pci_sriov.c
+++ b/drivers/gpu/drm/xe/xe_pci_sriov.c
@@ -62,6 +62,55 @@ static void pf_reset_vfs(struct xe_device *xe, unsigned int num_vfs)
 			xe_gt_sriov_pf_control_trigger_flr(gt, n);
 }
 
+static struct pci_dev *xe_pci_pf_get_vf_dev(struct xe_device *xe, unsigned int vf_id)
+{
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
+
+	xe_assert(xe, IS_SRIOV_PF(xe));
+
+	/* caller must use pci_dev_put() */
+	return pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
+			pdev->bus->number,
+			pci_iov_virtfn_devfn(pdev, vf_id));
+}
+
+static void pf_link_vfs(struct xe_device *xe, int num_vfs)
+{
+	struct pci_dev *pdev_pf = to_pci_dev(xe->drm.dev);
+	struct device_link *link;
+	struct pci_dev *pdev_vf;
+	unsigned int n;
+
+	/*
+	 * When both PF and VF devices are enabled on the host, during system
+	 * resume they are resuming in parallel.
+	 *
+	 * But PF has to complete the provision of VF first to allow any VFs to
+	 * successfully resume.
+	 *
+	 * Create a parent-child device link between PF and VF devices that will
+	 * enforce correct resume order.
+	 */
+	for (n = 1; n <= num_vfs; n++) {
+		pdev_vf = xe_pci_pf_get_vf_dev(xe, n - 1);
+
+		/* unlikely, something weird is happening, abort */
+		if (!pdev_vf) {
+			xe_sriov_err(xe, "Cannot find VF%u device, aborting link%s creation!\n",
+				     n, str_plural(num_vfs));
+			break;
+		}
+
+		link = device_link_add(&pdev_vf->dev, &pdev_pf->dev,
+				       DL_FLAG_AUTOREMOVE_CONSUMER);
+		/* unlikely and harmless, continue with other VFs */
+		if (!link)
+			xe_sriov_notice(xe, "Failed linking VF%u\n", n);
+
+		pci_dev_put(pdev_vf);
+	}
+}
+
 static int pf_enable_vfs(struct xe_device *xe, int num_vfs)
 {
 	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
@@ -92,6 +141,8 @@ static int pf_enable_vfs(struct xe_device *xe, int num_vfs)
 	if (err < 0)
 		goto failed;
 
+	pf_link_vfs(xe, num_vfs);
+
 	xe_sriov_info(xe, "Enabled %u of %u VF%s\n",
 		      num_vfs, total_vfs, str_plural(total_vfs));
 	return num_vfs;
-- 
2.39.5


