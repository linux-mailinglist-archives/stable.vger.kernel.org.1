Return-Path: <stable+bounces-131156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7E0A80879
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EAFE8A5F29
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5DC26E162;
	Tue,  8 Apr 2025 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qwy4tynm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294282690EB;
	Tue,  8 Apr 2025 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115641; cv=none; b=brvfHIhJCTxxJf7ifE3bikFkIxs4N/k+qDtUHmuQjIM1XX/UlWG8G2zASCCALT4Ys/VVntXQ44M+hgXLJoaibp9VWIvuLTuGTXzyp3ALHrAHFfGidPujCRNaxGxlKWgOlb+Y2Nzizj3rYmv5SDR1uVFsDpGCWDIwG0y0p5Rauho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115641; c=relaxed/simple;
	bh=z3eplziqngVVrPdufZ+1F1NVAQopHeGiGqip0R5mqa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPp7sd/3qoWjArdIRa7dYEbLpWUe29crVUJBglcfafmaFsgs04ocZv1CFb+zs5F+9ag3pZGyyFkZQ2eOIRW0p+aHLN25SUwaU9ZdJ+IcuxuXBqvtyhEqJhgeiG0fDWdaOYD/3Zy1nxr5x5V4YEDNu5b1GU8n0eVeBo39G0PQaac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qwy4tynm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2872CC4CEE5;
	Tue,  8 Apr 2025 12:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115640;
	bh=z3eplziqngVVrPdufZ+1F1NVAQopHeGiGqip0R5mqa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qwy4tynmztli8WMw8w2cpRZNkBHTaEvQ4nF9mp8m6kvhDw1nxHh+OTx5ByJNgS0n8
	 lnjqrxzdu5q800SyMdnWYX/Y6sGBHBE5y3gjaN1FviFgS0j823LOaNdG7wT8PIRHLD
	 yL0UgWbMUAURbO/wR1IdWbV9nd8kZTKbfKamS/yA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Carol Soto <csoto@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Chris Chiu <chris.chiu@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 032/204] PCI: Use downstream bridges for distributing resources
Date: Tue,  8 Apr 2025 12:49:22 +0200
Message-ID: <20250408104821.275198719@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
References: <20250408104820.266892317@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Kai-Heng Feng <kaihengf@nvidia.com>

[ Upstream commit 1a596ad00ffe9b37fc60a93cbdd4daead3bf95f3 ]

7180c1d08639 ("PCI: Distribute available resources for root buses, too")
breaks BAR assignment on some devices:

  pci 0006:03:00.0: BAR 0 [mem 0x6300c0000000-0x6300c1ffffff 64bit pref]: assigned
  pci 0006:03:00.1: BAR 0 [mem 0x6300c2000000-0x6300c3ffffff 64bit pref]: assigned
  pci 0006:03:00.2: BAR 0 [mem size 0x00800000 64bit pref]: can't assign; no space
  pci 0006:03:00.0: VF BAR 0 [mem size 0x02000000 64bit pref]: can't assign; no space
  pci 0006:03:00.1: VF BAR 0 [mem size 0x02000000 64bit pref]: can't assign; no space

The apertures of domain 0006 before 7180c1d08639:

  6300c0000000-63ffffffffff : PCI Bus 0006:00
    6300c0000000-6300c9ffffff : PCI Bus 0006:01
      6300c0000000-6300c9ffffff : PCI Bus 0006:02        # 160MB
        6300c0000000-6300c8ffffff : PCI Bus 0006:03      #   144MB
          6300c0000000-6300c1ffffff : 0006:03:00.0       #     32MB
          6300c2000000-6300c3ffffff : 0006:03:00.1       #     32MB
          6300c4000000-6300c47fffff : 0006:03:00.2       #      8MB
          6300c4800000-6300c67fffff : 0006:03:00.0       #     32MB
          6300c6800000-6300c87fffff : 0006:03:00.1       #     32MB
        6300c9000000-6300c9bfffff : PCI Bus 0006:04      #    12MB
          6300c9000000-6300c9bfffff : PCI Bus 0006:05    #    12MB
            6300c9000000-6300c91fffff : PCI Bus 0006:06  #      2MB
            6300c9200000-6300c93fffff : PCI Bus 0006:07  #      2MB
            6300c9400000-6300c95fffff : PCI Bus 0006:08  #      2MB
            6300c9600000-6300c97fffff : PCI Bus 0006:09  #      2MB

After 7180c1d08639:

  6300c0000000-63ffffffffff : PCI Bus 0006:00
    6300c0000000-6300c9ffffff : PCI Bus 0006:01
      6300c0000000-6300c9ffffff : PCI Bus 0006:02        # 160MB
        6300c0000000-6300c43fffff : PCI Bus 0006:03      #    68MB
          6300c0000000-6300c1ffffff : 0006:03:00.0       #      32MB
          6300c2000000-6300c3ffffff : 0006:03:00.1       #      32MB
              --- no space ---      : 0006:03:00.2       #       8MB
              --- no space ---      : 0006:03:00.0       #      32MB
              --- no space ---      : 0006:03:00.1       #      32MB
        6300c4400000-6300c4dfffff : PCI Bus 0006:04      #    10MB
          6300c4400000-6300c4dfffff : PCI Bus 0006:05    #      10MB
            6300c4400000-6300c45fffff : PCI Bus 0006:06  #        2MB
            6300c4600000-6300c47fffff : PCI Bus 0006:07  #        2MB
            6300c4800000-6300c49fffff : PCI Bus 0006:08  #        2MB
            6300c4a00000-6300c4bfffff : PCI Bus 0006:09  #        2MB

We can see that the window to 0006:03 gets shrunken too much and 0006:04
eats away the window for 0006:03:00.2.

The offending commit distributes the upstream bridge's resources multiple
times to every downstream bridge, hence makes the aperture smaller than
desired because calculation of io_per_b, mmio_per_b and mmio_pref_per_b
becomes incorrect.

Instead, distribute downstream bridges' own resources to resolve the issue.

Link: https://lore.kernel.org/r/20241204022457.51322-1-kaihengf@nvidia.com
Fixes: 7180c1d08639 ("PCI: Distribute available resources for root buses, too")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219540
Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Carol Soto <csoto@nvidia.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Chris Chiu <chris.chiu@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index b8cb990044fb2..8c1ad20a21ec5 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2027,8 +2027,7 @@ pci_root_bus_distribute_available_resources(struct pci_bus *bus,
 		 * in case of root bus.
 		 */
 		if (bridge && pci_bridge_resources_not_assigned(dev))
-			pci_bridge_distribute_available_resources(bridge,
-								  add_list);
+			pci_bridge_distribute_available_resources(dev, add_list);
 		else
 			pci_root_bus_distribute_available_resources(b, add_list);
 	}
-- 
2.39.5




