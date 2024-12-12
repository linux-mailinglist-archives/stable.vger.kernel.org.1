Return-Path: <stable+bounces-103843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DBD9EF9E5
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C33517A55A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B59022332D;
	Thu, 12 Dec 2024 17:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l2oLAi7S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3AF215710;
	Thu, 12 Dec 2024 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025765; cv=none; b=FxwSdv1U9tQ8H6J7k/At2uSiDHWDWnO0HccRAciiSxZqxyuQni7NrFl2tfFD+p1jKDLSFoY9l+jQ/gVdPoCfH5Ew/SScUic3gWFWSjOYpScL32JieXkEPKWLEd/mpTb4VJShH/j1zQYa69933Xa2i/RokTRpJLkGqHme9G+ktFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025765; c=relaxed/simple;
	bh=J7jDNsH0Uh5MiAR/pydkAKk01zFSKEyjBQXkmpMKrWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gr8DhbMDN6EKZ2xtCFDdw0MSlU3P6BsEhqS56xuBFrVhiM5L3/VXRk7B8jhq7fqodNmsHqd3EhB33OIx2vDIQTgaWGMTIpD5RmyKOZZ8D3hXqjfo3vFHR1rfbohVPJPPbB9gbdESJooZJ+TM8NevlR7utF2sZ7K/Swzlx12KJsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l2oLAi7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DDCC4CECE;
	Thu, 12 Dec 2024 17:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025765;
	bh=J7jDNsH0Uh5MiAR/pydkAKk01zFSKEyjBQXkmpMKrWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l2oLAi7ShRKOW9nGtWbm+PrLKg68zpSK1m4X32mFKCfMUWd/vFv2cy9JRhE/5QDO3
	 HVFbE/1sT4M4X8xIhHdTkfn0CrNS97AIPikGJTfELCfMPfKIJqjO69z3HNdcNAfh1j
	 hgTLI3LMz5XLzgEKusGLOGr23UxcGEAXG9nKucwU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Elena Salomatkina <esalomatkina@ispras.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 273/321] net/sched: cbs: Fix integer overflow in cbs_set_port_rate()
Date: Thu, 12 Dec 2024 16:03:11 +0100
Message-ID: <20241212144240.761597565@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
References: <20241212144229.291682835@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Elena Salomatkina <esalomatkina@ispras.ru>

[ Upstream commit 397006ba5d918f9b74e734867e8fddbc36dc2282 ]

The subsequent calculation of port_rate = speed * 1000 * BYTES_PER_KBIT,
where the BYTES_PER_KBIT is of type LL, may cause an overflow.
At least when speed = SPEED_20000, the expression to the left of port_rate
will be greater than INT_MAX.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Elena Salomatkina <esalomatkina@ispras.ru>
Link: https://patch.msgid.link/20241013124529.1043-1-esalomatkina@ispras.ru
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_cbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 2eaac2ff380fa..db92ae819fd28 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -309,7 +309,7 @@ static void cbs_set_port_rate(struct net_device *dev, struct cbs_sched_data *q)
 {
 	struct ethtool_link_ksettings ecmd;
 	int speed = SPEED_10;
-	int port_rate;
+	s64 port_rate;
 	int err;
 
 	err = __ethtool_get_link_ksettings(dev, &ecmd);
-- 
2.43.0




