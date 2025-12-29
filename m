Return-Path: <stable+bounces-203969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A00CE7A29
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD00831413CB
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EEF32FA3C;
	Mon, 29 Dec 2025 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="paStVDuR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E992EDD52;
	Mon, 29 Dec 2025 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767025681; cv=none; b=tMAW7sKt1tAXJfQEubPaFy9JuWX0ICjJuXH6Bqi8mgu3nCdYGigtMPtpKGIFM4xTuaQ1WsfBVcZ6X2T6lQP3HZSWrlCzaV37n+0TQ3LmsK8R5jhHEkLApQrhGWgBW/Lk5Fbo6aCneh5xucFuwJgbaVxE9yL0OmSIcDsT28R2jkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767025681; c=relaxed/simple;
	bh=ivnR1iQinN/gDw3MFIV/6nm9zgbDn8zeoPMHWwQ0iY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7/CUIKM19YpIbMOALSHFR8USxjjx2UUcYZzskj3APZABqT9UEdoQFwcdYCrQQt/SZuesmzNlVumpUasBHnohWN7iqZQRHqkAC6utFzHL3Ooe0XtMRJpMHJmwPxdB1HYRsq7KX/kFT4C8h5rp1t+DGPVc60WRStOj3RgCv8zciI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=paStVDuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51060C4CEF7;
	Mon, 29 Dec 2025 16:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767025681;
	bh=ivnR1iQinN/gDw3MFIV/6nm9zgbDn8zeoPMHWwQ0iY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=paStVDuR8lBxBvJjG8FRkz0lX0RJR/3jpP/Z1VTYHXZzBmD5hWVpJYrBlVfrVKovw
	 32KMynw3Y0fKP7Pk8nmYdV3pN3djaqa33PFQeZwjjlxrPfbDuxVphvHkhCTDOwZtC9
	 Pga5tFKb34zIKkgqO48l7w2rY4RONommJzuX0g2I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Baoli Zhang <baoli.zhang@intel.com>,
	Junxiao Chang <junxiao.chang@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH 6.18 299/430] mei: gsc: add dependency on Xe driver
Date: Mon, 29 Dec 2025 17:11:41 +0100
Message-ID: <20251229160735.341360228@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
References: <20251229160724.139406961@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junxiao Chang <junxiao.chang@intel.com>

commit 5d92c3b41f0bddfa416130c6e1b424414f3d2acf upstream.

INTEL_MEI_GSC depends on either i915 or Xe
and can be present when either of above is present.

Cc: stable <stable@kernel.org>
Fixes: 87a4c85d3a3e ("drm/xe/gsc: add gsc device support")
Tested-by: Baoli Zhang <baoli.zhang@intel.com>
Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Link: https://patch.msgid.link/20251109153533.3179787-1-alexander.usyskin@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mei/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/misc/mei/Kconfig
+++ b/drivers/misc/mei/Kconfig
@@ -49,7 +49,7 @@ config INTEL_MEI_TXE
 config INTEL_MEI_GSC
 	tristate "Intel MEI GSC embedded device"
 	depends on INTEL_MEI_ME
-	depends on DRM_I915
+	depends on DRM_I915 || DRM_XE
 	help
 	  Intel auxiliary driver for GSC devices embedded in Intel graphics devices.
 



