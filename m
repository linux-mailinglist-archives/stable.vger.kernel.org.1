Return-Path: <stable+bounces-185698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C7FBDA8E8
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 18:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A1B53419D5
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 16:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2418C2C3768;
	Tue, 14 Oct 2025 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDs5LFai"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2572BD5A2
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457987; cv=none; b=qZlTnEPvKrT/H0w3ZU9XBzuVFMZsoc6l1vwCkr+yl+sjJYb6rOoAr0cRugJ7S/gXhqIwEIkbTtSTOf+zdr7oYl/4zvI2h6jMaHO4QV7n/BDr3lZtYTwONpISu5oMIyz8RaZfI2HwmpXFPKG2K1Dw1LWFcrWubeqg97Y0Hi6cqRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457987; c=relaxed/simple;
	bh=HmCzQk6AAkIzSjrhAiRSh2joj4CiHHCrHHg9veKwEFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/pOs8J7YSL7DhB7uAVXylBaA0/bmPAh+6H+Lobyd2uraDFkRS0N5/aBMjSy7gG0MzvnUu6oBQP4qD1TVifL7imK95qmilNpoW25YdQv9Y+coKBbWXI9Zu3b5sn/0fb1T3ZBlLttq2Q/R0td/Cl1NnvJoWFMhTJut3ToHWTy6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDs5LFai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA38C4CEE7;
	Tue, 14 Oct 2025 16:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760457986;
	bh=HmCzQk6AAkIzSjrhAiRSh2joj4CiHHCrHHg9veKwEFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HDs5LFaiSuvaSgDnnudDLQB1pkxTU3ayF6QIv7Ec+EcosO7sFbor5aFNXxNB+2mp4
	 H5j5iooqzIy0owaH4/xXH5cshf9dCwT6aqBSeCak1WvSReOXwDem0CJ7+P3z6+dbo9
	 vGRlFe1+UMUmYU9SqTH8jsSaKI2EEbLhIdDiNn0f8fFy/HOEKnw3SITU3AR3apFFTr
	 F+wj4SyK4tv/DhgVfsJOShGijyyE+P4z3WyZiyh9o4hFk6A0rE41DPSlMT2PuRfVIK
	 mids7SrOU3YBGs8cnLbqHmxGyJQyRUWRfsUbIfGoar4UJErPCPSp8LdjYqUwJ1adLo
	 nOeN7oSuvbbiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wang Jiang <jiangwang@kylinos.cn>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] PCI: endpoint: Remove surplus return statement from pci_epf_test_clean_dma_chan()
Date: Tue, 14 Oct 2025 12:06:17 -0400
Message-ID: <20251014160618.158328-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101340-passably-rounding-59df@gregkh>
References: <2025101340-passably-rounding-59df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Wang Jiang <jiangwang@kylinos.cn>

[ Upstream commit 9b80bdb10aee04ce7289896e6bdad13e33972636 ]

Remove a surplus return statement from the void function that has been
added in the commit commit 8353813c88ef ("PCI: endpoint: Enable DMA
tests for endpoints with DMA capabilities").

Especially, as an empty return statements at the end of a void functions
serve little purpose.

This fixes the following checkpatch.pl script warning:

  WARNING: void function return statements are not generally useful
  #296: FILE: drivers/pci/endpoint/functions/pci-epf-test.c:296:
  +     return;
  +}

Link: https://lore.kernel.org/r/tencent_F250BEE2A65745A524E2EFE70CF615CA8F06@qq.com
Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Stable-dep-of: 85afa9ea122d ("PCI: endpoint: pci-epf-test: Add NULL check for DMA channels before release")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ac1dae113f2d9..ff4ca6ea5cb8e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -291,8 +291,6 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
 
 	dma_release_channel(epf_test->dma_chan_rx);
 	epf_test->dma_chan_rx = NULL;
-
-	return;
 }
 
 static void pci_epf_test_print_rate(struct pci_epf_test *epf_test,
-- 
2.51.0


