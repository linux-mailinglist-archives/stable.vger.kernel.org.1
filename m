Return-Path: <stable+bounces-193714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D93C4AB32
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F043AF10B
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A032C303A1C;
	Tue, 11 Nov 2025 01:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NT11L+21"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B9C301707;
	Tue, 11 Nov 2025 01:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823835; cv=none; b=KPAsT71KxiE5kEAQ7pw8m4m2M6A2gxr6R1Q5JHG5XH0CugTQiI3VJdULzNvUm7sYvJD/UTBJdjY3I5OAPzpq/vmm1DELkLKF+GQfQVsCa5B0LQJXgIMH+cbKSvO7pyoBIMBAq4fqgEfcuRZsZ/ZiMuaNdbEMQ2wKq/b/xLL4ygo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823835; c=relaxed/simple;
	bh=6+8+DQoNA9JShTUn71/sTUcgqIXGkz77uQZRGwoDeys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnQQMV3CoxNDBM4mAiiPuzbzJO1HslMjL3HZJCwv3uKkaYogNDTzK9LLMuhGhlOldIIpJcMG/fCAFRnpc/C1LUks6GXjM8i18CituPOfdVHp0u8EZBXkXwqDQlRMrt+X4uhbuepObYFObNd5/gRiVGHOy06FnmHDcuNoZaLKXlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NT11L+21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A4CC2BC86;
	Tue, 11 Nov 2025 01:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762823835;
	bh=6+8+DQoNA9JShTUn71/sTUcgqIXGkz77uQZRGwoDeys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NT11L+21QDsZXcaAwSsoDQdRyTjG2z8XVtBqTPiNWTu5FiTKgGiBoonbrAj0PmIbu
	 5Wy0GmDg5IJGrCuidPiVkpxLRcXaSgz/J85EWB4uuQmavaHHjKeNTt6fMvYjAba/FR
	 /MxGXln4Bw1cXRT8HGeFllWw3rYt+tzw2Fh++s14=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 381/849] eth: fbnic: Reset hw stats upon PCI error
Date: Tue, 11 Nov 2025 09:39:11 +0900
Message-ID: <20251111004545.643047387@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mohsin Bashir <mohsin.bashr@gmail.com>

[ Upstream commit b1161b1863c5f3d592adba5accd6e5c79741720f ]

Upon experiencing a PCI error, fbnic reset the device to recover from
the failure. Reset the hardware stats as part of the device reset to
ensure accurate stats reporting.

Note that the reset is not really resetting the aggregate value to 0,
which may result in a spike for a system collecting deltas in stats.
Rather, the reset re-latches the current value as previous, in case HW
got reset.

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20250825200206.2357713-3-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 28e23e3ffca88..c4d51490140eb 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -489,6 +489,8 @@ static void __fbnic_pm_attach(struct device *dev)
 	struct net_device *netdev = fbd->netdev;
 	struct fbnic_net *fbn;
 
+	fbnic_reset_hw_stats(fbd);
+
 	if (fbnic_init_failure(fbd))
 		return;
 
-- 
2.51.0




