Return-Path: <stable+bounces-145028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8410ABD1B3
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 10:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68EBC3AC5CC
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 08:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BD5261372;
	Tue, 20 May 2025 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7dltRLw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F1225FA01
	for <stable@vger.kernel.org>; Tue, 20 May 2025 08:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729155; cv=none; b=WW99SBEm6jBxWAAQeCXPQ64fgA6ON+dUoJPGXIJk0tB3bm76v3Xjxqzc8BE1nZo5S1RdKnEU4Rz2octQrgxdGZnZTKwtm56g3aTA0x8pWLca4Zfjumly+bAcyBbBTLMfIcTN9XXIcMXW8+VtrWupgioWjyp+Fs40WwBaSroI/ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729155; c=relaxed/simple;
	bh=X01yOZPuM1lHN+S16JRxA48Kq7Y9JfQ7LPcF5WdPfXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CN+tPNbUAJnmZhP5qQ4iaF+DsVc1SlkKUJZ5p2hSWTGWZq3xdbl11aj4OXb2EoRgRT5TVYZm+m5EBBL5lfDse3RrpxIMkC30VATwnHRhRv/OImgtAyla9bdeLBCye7sd6KdxAsL67fZywHCEZH2UN+LL9st4yPFBnpQ3+n2JaZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7dltRLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45098C4CEEB;
	Tue, 20 May 2025 08:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747729154;
	bh=X01yOZPuM1lHN+S16JRxA48Kq7Y9JfQ7LPcF5WdPfXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X7dltRLwNcyI6ZvCO6PZ7CYui11mNPPk/sR6zHuvitod6YXbzt1ITpPXdKDC7bR6S
	 YQIH1ubxgGORMwYx6vp2rNEFnh56LmQvcOoMJRFRhI4MpiAjf8uvOBiLOfOLIajF4Y
	 SXL5N489RX5g9dtKcCoyAIpI3j6bH7o1gv/eMIH8bCKytkEimlQC59YOuqs09RnjGY
	 akajg55c0xvjHl8FE5rwU7BRbgH0UNS4vZLYBZxQqnjZGGzsjOtQDyGw7XC7oo1gNk
	 HQONPE0m46yUB1o/3xoEDpJ6w6V5TfXx0mV9OQGTCE3gVlojdiuAk8PrdPb1JoK/F+
	 BO8Txvse4YFjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Feng Liu <Feng.Liu3@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] mt76: mt7921: fix kernel crash at mt7921_pci_remove
Date: Tue, 20 May 2025 04:19:12 -0400
Message-Id: <20250519180452-055f507c8c5ba9fe@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250519014422.3677354-1-Feng.Liu3@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: ad483ed9dd5193a54293269c852a29051813b7bd

WARNING: Author mismatch between patch and upstream commit:
Backport author: Feng Liu<Feng.Liu3@windriver.com>
Commit author: Sean Wang<sean.wang@mediatek.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  ad483ed9dd519 < -:  ------------- mt76: mt7921: fix kernel crash at mt7921_pci_remove
-:  ------------- > 1:  dbcfcf299f69d mt76: mt7921: fix kernel crash at mt7921_pci_remove
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

