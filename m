Return-Path: <stable+bounces-2278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7F67F8381
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1562B26017
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3F2381A2;
	Fri, 24 Nov 2023 19:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yo88FBGX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C128135F04;
	Fri, 24 Nov 2023 19:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A73C433CB;
	Fri, 24 Nov 2023 19:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853493;
	bh=UcjGjzbu4BwwyyTvdIoc7dwbJeGEr95Y6Fhfis5pzyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yo88FBGX+Hwl+Um/P734mIDmy4Vm1U5xgin02CBuVOwInbMQ+FH6ZyV1gSTLpj5Eo
	 BQluo8CwADn6lYSOz5zMsU9KgbCtIxA5eKWxDnog05UC6tlqB2F0NzU6biL6m13xvu
	 gPkSo0uvtM7bSkTL+TmW8aFoj6nAzcmfh/0toxm8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5.15 185/297] PCI/ASPM: Fix L1 substate handling in aspm_attr_store_common()
Date: Fri, 24 Nov 2023 17:53:47 +0000
Message-ID: <20231124172006.707529568@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

commit 8e37372ad0bea4c9b4712d9943f6ae96cff9491f upstream.

aspm_attr_store_common(), which handles sysfs control of ASPM, has the same
problem as fb097dcd5a28 ("PCI/ASPM: Disable only ASPM_STATE_L1 when driver
disables L1"): disabling L1 adds only ASPM_L1 (but not any of the L1.x
substates) to the "aspm_disable" mask.

Enabling one substate, e.g., L1.1, via sysfs removes ASPM_L1 from the
disable mask.  Since disabling L1 via sysfs doesn't add any of the
substates to the disable mask, enabling L1.1 actually enables *all* the
substates.

In this scenario:

  - Write 0 to "l1_aspm" to disable L1
  - Write 1 to "l1_1_aspm" to enable L1.1

the intention is to disable L1 and all L1.x substates, then enable just
L1.1, but in fact, *all* L1.x substates are enabled.

Fix this by explicitly disabling all the L1.x substates when disabling L1.

Fixes: 72ea91afbfb0 ("PCI/ASPM: Add sysfs attributes for controlling ASPM link states")
Link: https://lore.kernel.org/r/6ba7dd79-9cfe-4ed0-a002-d99cb842f361@gmail.com
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
[bhelgaas: commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pcie/aspm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1231,6 +1231,8 @@ static ssize_t aspm_attr_store_common(st
 			link->aspm_disable &= ~ASPM_STATE_L1;
 	} else {
 		link->aspm_disable |= state;
+		if (state & ASPM_STATE_L1)
+			link->aspm_disable |= ASPM_STATE_L1SS;
 	}
 
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));



