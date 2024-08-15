Return-Path: <stable+bounces-68661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616AA953364
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0656928308B
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD4B1AB53F;
	Thu, 15 Aug 2024 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Y/ZtHzg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D571AB52A;
	Thu, 15 Aug 2024 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731268; cv=none; b=HRrDm4aGkvAVdvMKtWUA++aXkjH6Iqn/9aUtaCl8Z9egvbEzF9EJVahi0UNCKilYHrq5lB696yP4d1fSGDNsHv6tGZFrl0yDrMRrcVx8Gb7nb0/38CovcR7jEjRUpFdgANiNX3F6AYTzNuIxd+nwgpExwbk2NxN0llrF1jqIGF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731268; c=relaxed/simple;
	bh=auDaJEXeveCgSaA3lUSs5YHM5+MFHIYBoRK4T/AGu+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXX6NB76YHsyV59A2iR33tX9PEHF9z7+h1JRvpjmPo/lKFR5uPVAgsb9g+zmrU75UulKXeEP/K5CCzI0jq7Ht0eD9PNIVXJH1DSmcYOkNy430J2OMRJkBJC6bXcrgbjXYrBCZNRpnEwsXtPKwWmCBUAPcNJhyljkiCBIa2bI+U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Y/ZtHzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBD4C32786;
	Thu, 15 Aug 2024 14:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731268;
	bh=auDaJEXeveCgSaA3lUSs5YHM5+MFHIYBoRK4T/AGu+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1Y/ZtHzgb4uXznqzgCoKq93KiHRml1Yggi2NoR5Pg7kqq9epH76MkGmLOZ0dQ1emu
	 cGCbtcWzSWivuBa87JoppW/25/hTfRtswpCSRKLWj8zpLSXhW91fg3JNGewEvXiwRv
	 BJv5s1ZjqFhq5ZAx1iTHM/M17otUv20krEDrQOtI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 076/259] MIPS: Octeron: remove source file executable bit
Date: Thu, 15 Aug 2024 15:23:29 +0200
Message-ID: <20240815131905.739770906@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131902.779125794@linuxfoundation.org>
References: <20240815131902.779125794@linuxfoundation.org>
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

From: Dominique Martinet <dominique.martinet@atmark-techno.com>

[ Upstream commit 89c7f5078935872cf47a713a645affb5037be694 ]

This does not matter the least, but there is no other .[ch] file in the
repo that is executable, so clean this up.

Fixes: 29b83a64df3b ("MIPS: Octeon: Add PCIe link status check")
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/pci/pcie-octeon.c | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 arch/mips/pci/pcie-octeon.c

diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
old mode 100755
new mode 100644
-- 
2.43.0




