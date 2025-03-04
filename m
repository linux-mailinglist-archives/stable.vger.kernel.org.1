Return-Path: <stable+bounces-120286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C717A4E715
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06B8F7A5742
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAAB25FA28;
	Tue,  4 Mar 2025 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="peahWptq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B75F25DCEC
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105921; cv=none; b=Nnuut6YED2jTV02IYlfV1GypI3H74jXRh0vhgfXrwxK0IXEnVL+DnqGwtGyoHAs+rJhS2VpvGfahJlEWisJOq6dzyzIoivFfZAJE17O1wayLCy4IYSZCWhatkQ3+9/bjqQG18zK4LvqXMI5lf8kFwTKsDM7v/kMb1nZJwk2JhOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105921; c=relaxed/simple;
	bh=Y6S5VpXN4Lqmul/DIt8seW3/agnraLdrHbaG3vgXplo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ch2tWWNftaJwtLsbyR5uKrLM7rU4GtSrtsTTliHo1sb7nhn6lozXUA0U8rKTzvrrTlPEa3tFfNnDkSRKokWDh1NzDCnLmZJk+yaJoTz6LPEhfz/gzJAXq1o1TU2odzJgf8lj47p8neHLj9/od8UQsdKgTTra8XH6R481Aocd5bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=peahWptq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC5DC4CEE5;
	Tue,  4 Mar 2025 16:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741105921;
	bh=Y6S5VpXN4Lqmul/DIt8seW3/agnraLdrHbaG3vgXplo=;
	h=Subject:To:Cc:From:Date:From;
	b=peahWptqVVnkQAmF+bFxm8u+mIGUC+aqcm9OYzQSKkqZRwUkpp17rx4p2OnFYsvER
	 cr/W8k2INIzooGj1ZNK1Ekpsf8NPQD5DAGatv6m/ofCthW92IqabfAbT3ayfBNT9Ao
	 eJPt3jJMI/Iieu+bQuprUA1y9yYh0MXyt6H8hipc=
Subject: FAILED: patch "[PATCH] drm/amdgpu: disable BAR resize on Dell G5 SE" failed to apply to 5.4-stable tree
To: alexander.deucher@amd.com,lijo.lazar@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:31:43 +0100
Message-ID: <2025030443-removing-stegosaur-941a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 099bffc7cadff40bfab1517c3461c53a7a38a0d7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030443-removing-stegosaur-941a@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 099bffc7cadff40bfab1517c3461c53a7a38a0d7 Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Mon, 17 Feb 2025 10:55:05 -0500
Subject: [PATCH] drm/amdgpu: disable BAR resize on Dell G5 SE

There was a quirk added to add a workaround for a Sapphire
RX 5600 XT Pulse that didn't allow BAR resizing.  However,
the quirk caused a regression with runtime pm on Dell laptops
using those chips, rather than narrowing the scope of the
resizing quirk, add a quirk to prevent amdgpu from resizing
the BAR on those Dell platforms unless runtime pm is disabled.

v2: update commit message, add runpm check

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707
Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT Pulse")
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 5235053f443cef4210606e5fb71f99b915a9723d)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d100bb7a137c..018dfccd771b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1638,6 +1638,13 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
+	/* resizing on Dell G5 SE platforms causes problems with runtime pm */
+	if ((amdgpu_runtime_pm != 0) &&
+	    adev->pdev->vendor == PCI_VENDOR_ID_ATI &&
+	    adev->pdev->device == 0x731f &&
+	    adev->pdev->subsystem_vendor == PCI_VENDOR_ID_DELL)
+		return 0;
+
 	/* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 */
 	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
 		DRM_WARN("System can't access extended configuration space, please check!!\n");


