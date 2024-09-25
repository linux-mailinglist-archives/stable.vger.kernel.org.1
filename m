Return-Path: <stable+bounces-77635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 153D698606E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97F78B20371
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD2B1D26E5;
	Wed, 25 Sep 2024 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2Lj03ES"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99A818FC9C;
	Wed, 25 Sep 2024 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266534; cv=none; b=bYVXcCxFH5PKTOdBfebx85tj8ylAf8ffYpExX0054iln7fzp5ujZtranm/oXpn9ArEQxaw7v6Xi33TAK0UA4rXEpLAcv26uNftLj8k+dg9fHwxPRJEaEXBF+Cdr7OhOcvJJCQZdgOtSk4VuJJPBLr2epJwITDWF3crngcrQm4hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266534; c=relaxed/simple;
	bh=g0zE39GBuH4ZjArwrbT8IP/+yOOc+74Bh/3s8uIGzUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjLX/1RnofhyLcKKPLmfaozRVWL54s0mdZDLyHu3WzXk55rMsvLSbmg9r4UByHLB3qQjVPDkivuxUQQqsaTax6kEE8H1lEpEqG8cCUicvoHyOxB71HAz6PuKWxx7D1sDj+tTNhQwiQc48243am2f+HZAGvznK57xB32M6ciRKLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2Lj03ES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8A2C4CECE;
	Wed, 25 Sep 2024 12:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266534;
	bh=g0zE39GBuH4ZjArwrbT8IP/+yOOc+74Bh/3s8uIGzUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2Lj03ES9TO9MZo/F0D0Nem3JUo8P7VnbjjuoGKg0Eis/cR7LY3O4HRIEaFJkENIm
	 3wx+Hm54vMofoCJ+UHze6P8urb9XC6KUES1+1YzMgKC9G7bcBT9Bzis9fLTIUHrydc
	 J9KFuSJJRPIhwC5/NHbY9ukVl253l3i6sLq7J+SRQW+huC3BidAsA+1ihXRaXfTPDv
	 YCmTlsU3l7fCY7Ug5vSg915yEgiMd+RouG2O6h5+0MTrYpho2GWTK72FUp+K1Y/P14
	 47gWi94Og4GJ4kjk4rpRJ1ha3x2GWrnBDDIVmstOtjVwuN+HPzMH4X7F2OP50dU5+S
	 1TNk4A+YIWxuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Igor Pylypiv <ipylypiv@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 088/139] ata: pata_serverworks: Do not use the term blacklist
Date: Wed, 25 Sep 2024 08:08:28 -0400
Message-ID: <20240925121137.1307574-88-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit 858048568c9e3887d8b19e101ee72f129d65cb15 ]

Let's not use the term blacklist in the function
serverworks_osb4_filter() documentation comment and rather simply refer
to what that function looks at: the list of devices with groken UDMA5.

While at it, also constify the values of the csb_bad_ata100 array.

Of note is that all of this should probably be handled using libata
quirk mechanism but it is unclear if these UDMA5 quirks are specific
to this controller only.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/pata_serverworks.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 549ff24a98231..4edddf6bcc150 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -46,10 +46,11 @@
 #define SVWKS_CSB5_REVISION_NEW	0x92 /* min PCI_REVISION_ID for UDMA5 (A2.0) */
 #define SVWKS_CSB6_REVISION	0xa0 /* min PCI_REVISION_ID for UDMA4 (A1.0) */
 
-/* Seagate Barracuda ATA IV Family drives in UDMA mode 5
- * can overrun their FIFOs when used with the CSB5 */
-
-static const char *csb_bad_ata100[] = {
+/*
+ * Seagate Barracuda ATA IV Family drives in UDMA mode 5
+ * can overrun their FIFOs when used with the CSB5.
+ */
+static const char * const csb_bad_ata100[] = {
 	"ST320011A",
 	"ST340016A",
 	"ST360021A",
@@ -163,10 +164,11 @@ static unsigned int serverworks_osb4_filter(struct ata_device *adev, unsigned in
  *	@adev: ATA device
  *	@mask: Mask of proposed modes
  *
- *	Check the blacklist and disable UDMA5 if matched
+ *	Check the list of devices with broken UDMA5 and
+ *	disable UDMA5 if matched.
  */
-
-static unsigned int serverworks_csb_filter(struct ata_device *adev, unsigned int mask)
+static unsigned int serverworks_csb_filter(struct ata_device *adev,
+					   unsigned int mask)
 {
 	const char *p;
 	char model_num[ATA_ID_PROD_LEN + 1];
-- 
2.43.0


