Return-Path: <stable+bounces-101945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEEA9EEFDC
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB2E1895009
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFDB223331;
	Thu, 12 Dec 2024 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YYRFQF3u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB91614A82;
	Thu, 12 Dec 2024 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019377; cv=none; b=Xq63Ynxdr8jMjyT44TWsy7esp6jwGFNro/bvVh4Z489ySe8sdRoD2D3r97gHXIRXQ93jK+IXjvehjFeo7pLd01D9IhNli9Oqf5HRBBnItWBtvugtBFKi/M7SyTzxFs2fVMJlhlEexGVKoNV7EJktW16hilpXjXAlG8eIiZ6wZjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019377; c=relaxed/simple;
	bh=DMF1cQzZLTv3SEe7L2ehDYqaLb+zhI5EGkp6KlpSjOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9OKiDcidlKlq5QLk5qjUK7J1t3O69WWHqkQAHrC8RMnlx01b6TjNepzkmuPhOEf44JPlkdwIV+Ura8f0nMIr+6ac9jML2zaTVvmHvNtDeNNEGj5iAFacvDdlgbeiZNE/b8qRIuCg6L/PJ4QutuQSftbwwdB/VYwm5SM6GIcBqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YYRFQF3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D09C4CECE;
	Thu, 12 Dec 2024 16:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734019377;
	bh=DMF1cQzZLTv3SEe7L2ehDYqaLb+zhI5EGkp6KlpSjOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YYRFQF3uCiBRCdZi1K5FiLhkXZ3IxMyceHLWr7JpopW1zPN0ZQLoZlJXpMFsv9CC0
	 ncuuQmG5ONRsFFzeEK/ItrRxMLl5JxejHiBeCgcneNQuhp8l7aOAvyt7FA0WljB65C
	 0xqGjJQqTxAQqZsrw86QPPdHI2dCJhqmQ26V86u0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dipendra Khadka <kdipendra88@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 161/772] octeontx2-pf: handle otx2_mbox_get_rsp errors in cn10k.c
Date: Thu, 12 Dec 2024 15:51:46 +0100
Message-ID: <20241212144356.588052109@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dipendra Khadka <kdipendra88@gmail.com>

[ Upstream commit ac9183023b6a9c09467516abd8aab04f9a2f9564 ]

Add error pointer check after calling otx2_mbox_get_rsp().

Fixes: 2ca89a2c3752 ("octeontx2-pf: TC_MATCHALL ingress ratelimiting offload")
Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
index 59d8d1ba15c28..8663bdf014d85 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
@@ -201,6 +201,11 @@ int cn10k_alloc_leaf_profile(struct otx2_nic *pfvf, u16 *leaf)
 
 	rsp = (struct  nix_bandprof_alloc_rsp *)
 	       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
+	if (IS_ERR(rsp)) {
+		rc = PTR_ERR(rsp);
+		goto out;
+	}
+
 	if (!rsp->prof_count[BAND_PROF_LEAF_LAYER]) {
 		rc = -EIO;
 		goto out;
-- 
2.43.0




