Return-Path: <stable+bounces-129482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E448A7FFC2
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A112188F006
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E768267F55;
	Tue,  8 Apr 2025 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1lU4Pe6V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC98224F6;
	Tue,  8 Apr 2025 11:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111149; cv=none; b=ELm6p4WwoIzkzO5VIzlSZFTJ+in7NEF3LiTgC4UI/ZZcEWwJZdHilOYlpE27gaIgM7JeL8RU8PJaKswkL1IsZHG/bpdYFk4BTYO9v+du9J1pC4F05Fhe/Av41QN3oqgoExYmzx4CAe6QR6BQyz1Z9PIDQ98kRiZBQIKXEGcbpWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111149; c=relaxed/simple;
	bh=Kgut6Brf1aSfU1/r0bdnchZkEM6IDrz/0NCFArwdBuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2Gm4VU/wA8FaNVOwhpRQvXfFqoqs50fd92ahJAzcE3L+S6nB3H70Y77CfcFMCPVC49Yn2vbycNCg8Fe1fmMCapcavHJPouW5WRoNrf5J1hOE8ZmJx8huX+JjnaWM90BanIHLFzQ2VwloweFEYoJb/iwcF2qQPodhCRczbE1MrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1lU4Pe6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF97C4CEE5;
	Tue,  8 Apr 2025 11:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111148;
	bh=Kgut6Brf1aSfU1/r0bdnchZkEM6IDrz/0NCFArwdBuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1lU4Pe6VAOq5nmf+lUqPt9QTU625qW8Y5mMbcXssdQjLqijVJ7kb71JLxHxJyhPnA
	 ClM59QQgscjNtTivTyqxwipOvIuK/knlYPQXPWAyfUSygbOxtgR6oNaXcQXI6wNJ1z
	 w5RtF3U2MwxJgxdi6UwQ4Kbu2i5KpKN5I/3/9Uls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 325/731] misc: pci_endpoint_test: Fix pci_endpoint_test_bars_read_bar() error handling
Date: Tue,  8 Apr 2025 12:43:42 +0200
Message-ID: <20250408104921.834850403@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit 2a93192d2058507b2e39b590fc1efa0e03344136 ]

Commit f26d37ee9bda ("misc: pci_endpoint_test: Fix IOCTL return value")
changed the return value of pci_endpoint_test_bars_read_bar() from false
to -EINVAL on error, however, it failed to update the error handling.

Fixes: f26d37ee9bda ("misc: pci_endpoint_test: Fix IOCTL return value")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20250204110640.570823-2-cassel@kernel.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index d5ac71a493865..7584d18768598 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -382,7 +382,7 @@ static int pci_endpoint_test_bars_read_bar(struct pci_endpoint_test *test,
 static int pci_endpoint_test_bars(struct pci_endpoint_test *test)
 {
 	enum pci_barno bar;
-	bool ret;
+	int ret;
 
 	/* Write all BARs in order (without reading). */
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
@@ -398,7 +398,7 @@ static int pci_endpoint_test_bars(struct pci_endpoint_test *test)
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		if (test->bar[bar]) {
 			ret = pci_endpoint_test_bars_read_bar(test, bar);
-			if (!ret)
+			if (ret)
 				return ret;
 		}
 	}
-- 
2.39.5




