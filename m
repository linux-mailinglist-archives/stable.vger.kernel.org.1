Return-Path: <stable+bounces-138550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B5AAA1898
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0533A4C82A9
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF441253941;
	Tue, 29 Apr 2025 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XXUQnEcq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9FB253322;
	Tue, 29 Apr 2025 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949607; cv=none; b=U+U+uwgHRD+dDvFpWkjUaGr3W5gXMiX3xx79AHVdks8qidIrjX4qY8pYCRY6143feiw2jvBU2PGF9PO0mhLiQjAjgdZUYHS1h5zypfcYyHqAumysg/4dbaUKuOGkG6xmSlzo6daHrj7EzFzDNL5f2rRH2lIAGRs79kNkZDtbY90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949607; c=relaxed/simple;
	bh=/uJr6sJVKcsAHECI7+vigOZTePLAiaQs1+7ftHZsi3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUh7lP9KJ4uJePMYI+Yk1L6zv8XUsod30yKjGexLq8bEU3xH9HjFjYOXgtEMKKX5gENd1B2AFVSipD+zNNQtxmSV2vT2zKhjwk1CKUdQcSAELk0u9YFIMwUq/aVE1mOQOy26veFH5BikM8bM4Ad+zzwT4Xg3q/lW0UqUDBd2lKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XXUQnEcq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01EBC4CEE3;
	Tue, 29 Apr 2025 18:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949607;
	bh=/uJr6sJVKcsAHECI7+vigOZTePLAiaQs1+7ftHZsi3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XXUQnEcqztNqHlPgh6qgCXR7SADtfKdSJpLPTgcckjxmwNkJeGohKjpGTQlsn+zVx
	 8F2P4DuUHsHZM8hLaEUOP5XsnCTl6RecjExr8t8zGI3hrNmiAC2+i0zOwFm0sbR3Ic
	 z98Fls9LcZS3g4tYGN/FZz31+anzd8VNVBqH9vsc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 5.15 372/373] PCI: Fix dropping valid root bus resources with .end = zero
Date: Tue, 29 Apr 2025 18:44:09 +0200
Message-ID: <20250429161138.434186275@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 9d8ba74a181b1c81def21168795ed96cbe6f05ed upstream.

On r8a7791/koelsch:

  kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
  # cat /sys/kernel/debug/kmemleak
  unreferenced object 0xc3a34e00 (size 64):
    comm "swapper/0", pid 1, jiffies 4294937460 (age 199.080s)
    hex dump (first 32 bytes):
      b4 5d 81 f0 b4 5d 81 f0 c0 b0 a2 c3 00 00 00 00  .]...]..........
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    backtrace:
      [<fe3aa979>] __kmalloc+0xf0/0x140
      [<34bd6bc0>] resource_list_create_entry+0x18/0x38
      [<767046bc>] pci_add_resource_offset+0x20/0x68
      [<b3f3edf2>] devm_of_pci_get_host_bridge_resources.constprop.0+0xb0/0x390

When coalescing two resources for a contiguous aperture, the second
resource is enlarged to cover the full contiguous range, while the first
resource is marked invalid.  This invalidation is done by clearing the
flags, start, and end members.

When adding the initial resources to the bus later, invalid resources are
skipped.  Unfortunately, the check for an invalid resource considers only
the end member, causing false positives.

E.g. on r8a7791/koelsch, root bus resource 0 ("bus 00") is skipped, and no
longer registered with pci_bus_insert_busn_res() (causing the memory leak),
nor printed:

   pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
   pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff -> 0x00ee080000
   pci-rcar-gen2 ee090000.pci: PCI: revision 11
   pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
  -pci_bus 0000:00: root bus resource [bus 00]
   pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]

Fix this by only skipping resources where all of the flags, start, and end
members are zero.

Fixes: 7c3855c423b17f6c ("PCI: Coalesce host bridge contiguous apertures")
Link: https://lore.kernel.org/r/da0fcd5e86c74239be79c7cb03651c0fce31b515.1676036673.git.geert+renesas@glider.be
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/probe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -999,7 +999,7 @@ static int pci_register_host_bridge(stru
 	resource_list_for_each_entry_safe(window, n, &resources) {
 		offset = window->offset;
 		res = window->res;
-		if (!res->end)
+		if (!res->flags && !res->start && !res->end)
 			continue;
 
 		list_move_tail(&window->node, &bridge->windows);



