Return-Path: <stable+bounces-34713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B35B894080
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFF2DB218F7
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E20028DC0;
	Mon,  1 Apr 2024 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RB69kB51"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B81D1E525;
	Mon,  1 Apr 2024 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989047; cv=none; b=mfQCsKu+V7l76sDMy8oc3Ao6ZHtZPJs+VmGa+bckHtqvAQU8CX/hY8L+1xRq7HIjlsvUOqugQyGwcnmjeaCX/dutoFVicvpUAT5W8gjgKhWdvnfLh6YlIf6ApRVybqf6hjT14vwt2ps6AEztmsl93Q7X5GbtEukXOTZOduJWKDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989047; c=relaxed/simple;
	bh=0YzIoU7acrWtWEgX1j5QwasSozl/ybUCDFAHLwv3eWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMoLfLqu4xXLBARuFq5tKrGivOVQs30cmn+rV3l96znNaIhYePfcUAYyiXuGxHdcjv1fH32WzW/A22xShdEcQW0KcqTvESldU576cYqeVxKhc/aqOcGfOybCfUxfki7SnFk5k7amuax0A0YC7pUsyEzwcPK6dJ3G0mKyqMt2Qbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RB69kB51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8FEC43390;
	Mon,  1 Apr 2024 16:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989047;
	bh=0YzIoU7acrWtWEgX1j5QwasSozl/ybUCDFAHLwv3eWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RB69kB518fGX6vyo+NxFGuFT5WkTxQ7cUJG43dmexZ5v/l8oEJwHd5z1bBFitdv8e
	 7EG99g/8DOsxxiS49ttp/cZx1ZELkfZLeLdORLTbsFo4edtFRLE/sC4BuzUb5fTWqW
	 cvdawUuZlbKiP6uIr7MdL+1Gn8ICf81ydD3SJSc0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Huang <jinhuieric.huang@amd.com>,
	Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.7 366/432] drm/amdkfd: fix TLB flush after unmap for GFX9.4.2
Date: Mon,  1 Apr 2024 17:45:53 +0200
Message-ID: <20240401152604.185841235@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
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

From: Eric Huang <jinhuieric.huang@amd.com>

commit 1210e2f1033dc56b666c9f6dfb761a2d3f9f5d6c upstream.

TLB flush after unmap accidentially was removed on
gfx9.4.2. It is to add it back.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1466,7 +1466,7 @@ void kfd_flush_tlb(struct kfd_process_de
 
 static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
 {
-	return KFD_GC_VERSION(dev) > IP_VERSION(9, 4, 2) ||
+	return KFD_GC_VERSION(dev) >= IP_VERSION(9, 4, 2) ||
 	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) && dev->sdma_fw_version >= 18) ||
 	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
 }



