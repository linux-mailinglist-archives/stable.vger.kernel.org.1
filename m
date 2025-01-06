Return-Path: <stable+bounces-107035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9546FA029CD
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78435162026
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689E715A86A;
	Mon,  6 Jan 2025 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yl5ggc9S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A0D469D;
	Mon,  6 Jan 2025 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177256; cv=none; b=oAXV7fDGRqhuKmri54fCpS1R4vKeuqW0KBGnPXt+AvBCvyLhpH5K8cN+8sSaevu3zQ+POHM4kF6dCumLOJWiUpCaG5Up9sDqFYYjHLWczze4BX1K101C4Ick+wUPPTFQGgF9rHa5kMH6yS7n/DTrUX7mQE/r/aL4Ab7JkWWvYyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177256; c=relaxed/simple;
	bh=9lXgiqLczTgGNVS1K4ea8A4vfscoXiH5VrKp0hOPMKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7+rqUHGCv0slarPyusYJL9pBSxDlcKvBda6qtM+oCvMXgFtVg6udAqXqM0L/y8wmYRLUTh6+aLdvSnJDo3H2xDrBpyizLCJHGTN8F4JlSkIXkE9uQ/R4XDInBpT8yx1bmGXKjsh3mDBc6LMWr5J1Skuat5YOMacIJfqKVaCxp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yl5ggc9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AC9C4CEDF;
	Mon,  6 Jan 2025 15:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736177256;
	bh=9lXgiqLczTgGNVS1K4ea8A4vfscoXiH5VrKp0hOPMKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yl5ggc9SPQw8kzvIp3C6T13dDR3iWxa8eydnLwJUiGtU0FfeovRIbB6WL7CysOV3b
	 ok20UNf3shoH6jl/21pH8EXXD/1PHKHSvmLw95KLt5lGvGHY16hf+UL3OhftIB7UCo
	 DhMIJVXWfp5P3D2LgrCsH5yzFoe78Mwb4Vb37E/Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Beulich <jbeulich@suse.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 104/222] memblock: make memblock_set_node() also warn about use of MAX_NUMNODES
Date: Mon,  6 Jan 2025 16:15:08 +0100
Message-ID: <20250106151154.534272256@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151150.585603565@linuxfoundation.org>
References: <20250106151150.585603565@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Beulich <jbeulich@suse.com>

[ Upstream commit e0eec24e2e199873f43df99ec39773ad3af2bff7 ]

On an (old) x86 system with SRAT just covering space above 4Gb:

    ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0xfffffffff] hotplug

the commit referenced below leads to this NUMA configuration no longer
being refused by a CONFIG_NUMA=y kernel (previously

    NUMA: nodes only cover 6144MB of your 8185MB e820 RAM. Not used.
    No NUMA configuration found
    Faking a node at [mem 0x0000000000000000-0x000000027fffffff]

was seen in the log directly after the message quoted above), because of
memblock_validate_numa_coverage() checking for NUMA_NO_NODE (only). This
in turn led to memblock_alloc_range_nid()'s warning about MAX_NUMNODES
triggering, followed by a NULL deref in memmap_init() when trying to
access node 64's (NODE_SHIFT=6) node data.

To compensate said change, make memblock_set_node() warn on and adjust
a passed in value of MAX_NUMNODES, just like various other functions
already do.

Fixes: ff6c3d81f2e8 ("NUMA: optimize detection of memory with no node id assigned by firmware")
Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/1c8a058c-5365-4f27-a9f1-3aeb7fb3e7b2@suse.com
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memblock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 87a2b4340ce4..ba64b47b7c3b 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1321,6 +1321,10 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
 	int start_rgn, end_rgn;
 	int i, ret;
 
+	if (WARN_ONCE(nid == MAX_NUMNODES,
+		      "Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead\n"))
+		nid = NUMA_NO_NODE;
+
 	ret = memblock_isolate_range(type, base, size, &start_rgn, &end_rgn);
 	if (ret)
 		return ret;
-- 
2.39.5




