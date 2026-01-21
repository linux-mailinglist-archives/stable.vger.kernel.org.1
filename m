Return-Path: <stable+bounces-210672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLjmJ9lCcGnXXAAAu9opvQ
	(envelope-from <stable+bounces-210672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:07:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 639C1503DD
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C87535E345E
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5933559DA;
	Wed, 21 Jan 2026 03:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bmswt8B3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D875329384
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 03:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768964818; cv=none; b=ShNymCvFScPh8lag4oHTHPV3KfYYCX4SnR1/k9deXt+FsujrQHFckBxlHlOg8QSy0D8pW5eH90KbTGipEezUvJFj1aj6N9cSx8Bhn2iSs/K86cG2oz1XBWcUbeWN4GaoO+DBNjiWJhDiUXh26bzjWUuLSdFtpvtkwTwQKOQq3Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768964818; c=relaxed/simple;
	bh=DNFKL7Zp8wToFkG0CvmI6wcZW57ae15+GK68JSvHJIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nz1cxD6z4VMtd5DPe+WrFn91UKYgsvj/HB2SG943398P/RRateSmrcvRMswSo0jHPNkyyn5B/LaYpp9NI9kh6tx88uin5lxidJqSAOjNqehWF9wRUuHnqjaoS0MAnhkA65j9ER90HHwo4Iz1PwsVjUcYX1IalAS5RJpG85alXOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bmswt8B3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DA3C16AAE;
	Wed, 21 Jan 2026 03:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768964818;
	bh=DNFKL7Zp8wToFkG0CvmI6wcZW57ae15+GK68JSvHJIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bmswt8B31l+QwWRAPDPPPn3ETQDe8H13qGrV0ZLLNW4vesj+WkBuPFejDUld9jARL
	 ABNF24FRXNYIMNU46VMBnOIJk31qU7K2ivgL3TA3HUu7IkWxKHGJnBt71EUFHCQ/5h
	 W/OppleEvT+ddM3xr3pI1W1qNP0gBB9YfZK+AYOg+MnKnQsqlKiGpBqdHaNWkT1qwk
	 fZln/pfhxpf7tfqvPsaVMYFTofY4TZGioEAB2e7xODCaJAQIYMoCoafHbORqnTVZcq
	 AW0oDYZiU7ZA841DWPDIse78gPdGRSPTLFdrj52XqbPhC8c4FOOnJHVXgV4NAWEy2t
	 TfOlizS53QQPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bruno Faccini <bfaccini@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] mm/fake-numa: allow later numa node hotplug
Date: Tue, 20 Jan 2026 22:06:54 -0500
Message-ID: <20260121030655.1173340-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012036-system-boots-1902@gregkh>
References: <2026012036-system-boots-1902@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210672-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux-foundation.org:email]
X-Rspamd-Queue-Id: 639C1503DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bruno Faccini <bfaccini@nvidia.com>

[ Upstream commit 63db8170bf34ce9e0763f87d993cf9b4c9002b09 ]

Current fake-numa implementation prevents new Numa nodes to be later
hot-plugged by drivers.  A common symptom of this limitation is the "node
<X> was absent from the node_possible_map" message by associated warning
in mm/memory_hotplug.c: add_memory_resource().

This comes from the lack of remapping in both pxm_to_node_map[] and
node_to_pxm_map[] tables to take fake-numa nodes into account and thus
triggers collisions with original and physical nodes only-mapping that had
been determined from BIOS tables.

This patch fixes this by doing the necessary node-ids translation in both
pxm_to_node_map[]/node_to_pxm_map[] tables.  node_distance[] table has
also been fixed accordingly.

Details:

When trying to use fake-numa feature on our system where new Numa nodes
are being "hot-plugged" upon driver load, this fails with the following
type of message and warning with stack :

node 8 was absent from the node_possible_map WARNING: CPU: 61 PID: 4259 at
mm/memory_hotplug.c:1506 add_memory_resource+0x3dc/0x418

This issue prevents the use of the fake-NUMA debug feature with the
system's full configuration, when it has proven to be sometimes extremely
useful for performance testing of multi-tasked, memory-bound applications,
as it enables better isolation of processes/ranks compared to fat NUMA
nodes.

Usual numactl output after driver has “hot-plugged”/unveiled some
new Numa nodes with and without memory :
$ numactl --hardware
available: 9 nodes (0-8)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42
43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64
65 66 67 68 69 70 71
node 0 size: 490037 MB
node 0 free: 484432 MB
node 1 cpus:
node 1 size: 97280 MB
node 1 free: 97279 MB
node 2 cpus:
node 2 size: 0 MB
node 2 free: 0 MB
node 3 cpus:
node 3 size: 0 MB
node 3 free: 0 MB
node 4 cpus:
node 4 size: 0 MB
node 4 free: 0 MB
node 5 cpus:
node 5 size: 0 MB
node 5 free: 0 MB
node 6 cpus:
node 6 size: 0 MB
node 6 free: 0 MB
node 7 cpus:
node 7 size: 0 MB
node 7 free: 0 MB
node 8 cpus:
node 8 size: 0 MB
node 8 free: 0 MB
node distances:
node   0   1   2   3   4   5   6   7   8
  0:  10  80  80  80  80  80  80  80  80
  1:  80  10  255  255  255  255  255  255  255
  2:  80  255  10  255  255  255  255  255  255
  3:  80  255  255  10  255  255  255  255  255
  4:  80  255  255  255  10  255  255  255  255
  5:  80  255  255  255  255  10  255  255  255
  6:  80  255  255  255  255  255  10  255  255
  7:  80  255  255  255  255  255  255  10  255
  8:  80  255  255  255  255  255  255  255  10

With recent M.Rapoport set of fake-numa patches in mm-everything
and using numa=fake=4 boot parameter :
$ numactl --hardware
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42
43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64
65 66 67 68 69 70 71
node 0 size: 122518 MB
node 0 free: 117141 MB
node 1 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42
43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64
65 66 67 68 69 70 71
node 1 size: 219911 MB
node 1 free: 219751 MB
node 2 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42
43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64
65 66 67 68 69 70 71
node 2 size: 122599 MB
node 2 free: 122541 MB
node 3 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42
43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64
65 66 67 68 69 70 71
node 3 size: 122479 MB
node 3 free: 122408 MB
node distances:
node   0   1   2   3
  0:  10  10  10  10
  1:  10  10  10  10
  2:  10  10  10  10
  3:  10  10  10  10

With recent M.Rapoport set of fake-numa patches in mm-everything,
this patch on top, using numa=fake=4 boot parameter :
# numactl —hardware
available: 12 nodes (0-11)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42
43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64
65 66 67 68 69 70 71
node 0 size: 122518 MB
node 0 free: 116429 MB
node 1 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42
43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64
65 66 67 68 69 70 71
node 1 size: 122631 MB
node 1 free: 122576 MB
node 2 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42
43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64
65 66 67 68 69 70 71
node 2 size: 122599 MB
node 2 free: 122544 MB
node 3 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42
43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64
65 66 67 68 69 70 71
node 3 size: 122479 MB
node 3 free: 122419 MB
node 4 cpus:
node 4 size: 97280 MB
node 4 free: 97279 MB
node 5 cpus:
node 5 size: 0 MB
node 5 free: 0 MB
node 6 cpus:
node 6 size: 0 MB
node 6 free: 0 MB
node 7 cpus:
node 7 size: 0 MB
node 7 free: 0 MB
node 8 cpus:
node 8 size: 0 MB
node 8 free: 0 MB
node 9 cpus:
node 9 size: 0 MB
node 9 free: 0 MB
node 10 cpus:
node 10 size: 0 MB
node 10 free: 0 MB
node 11 cpus:
node 11 size: 0 MB
node 11 free: 0 MB
node distances:
node   0   1   2   3   4   5   6   7   8   9  10  11
  0:  10  10  10  10  80  80  80  80  80  80  80  80
  1:  10  10  10  10  80  80  80  80  80  80  80  80
  2:  10  10  10  10  80  80  80  80  80  80  80  80
  3:  10  10  10  10  80  80  80  80  80  80  80  80
  4:  80  80  80  80  10  255  255  255  255  255  255  255
  5:  80  80  80  80  255  10  255  255  255  255  255  255
  6:  80  80  80  80  255  255  10  255  255  255  255  255
  7:  80  80  80  80  255  255  255  10  255  255  255  255
  8:  80  80  80  80  255  255  255  255  10  255  255  255
  9:  80  80  80  80  255  255  255  255  255  10  255  255
 10:  80  80  80  80  255  255  255  255  255  255  10  255
 11:  80  80  80  80  255  255  255  255  255  255  255  10

Link: https://lkml.kernel.org/r/20250106120659.359610-2-bfaccini@nvidia.com
Signed-off-by: Bruno Faccini <bfaccini@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: f46c26f1bcd9 ("mm: numa,memblock: include <asm/numa.h> for 'numa_nodes_parsed'")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/numa/srat.c     | 86 ++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_numa.h     |  5 +++
 include/linux/numa_memblks.h |  3 ++
 mm/numa_emulation.c          | 45 ++++++++++++++++---
 mm/numa_memblks.c            |  2 +-
 5 files changed, 133 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index dccdc062d8aa3..76ad0f6758f57 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -81,6 +81,92 @@ int acpi_map_pxm_to_node(int pxm)
 }
 EXPORT_SYMBOL(acpi_map_pxm_to_node);
 
+#ifdef CONFIG_NUMA_EMU
+/*
+ * Take max_nid - 1 fake-numa nodes into account in both
+ * pxm_to_node_map()/node_to_pxm_map[] tables.
+ */
+int __init fix_pxm_node_maps(int max_nid)
+{
+	static int pxm_to_node_map_copy[MAX_PXM_DOMAINS] __initdata
+			= { [0 ... MAX_PXM_DOMAINS - 1] = NUMA_NO_NODE };
+	static int node_to_pxm_map_copy[MAX_NUMNODES] __initdata
+			= { [0 ... MAX_NUMNODES - 1] = PXM_INVAL };
+	int i, j, index = -1, count = 0;
+	nodemask_t nodes_to_enable;
+
+	if (numa_off || srat_disabled())
+		return -1;
+
+	/* find fake nodes PXM mapping */
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		if (node_to_pxm_map[i] != PXM_INVAL) {
+			for (j = 0; j <= max_nid; j++) {
+				if ((emu_nid_to_phys[j] == i) &&
+				    WARN(node_to_pxm_map_copy[j] != PXM_INVAL,
+					 "Node %d is already binded to PXM %d\n",
+					 j, node_to_pxm_map_copy[j]))
+					return -1;
+				if (emu_nid_to_phys[j] == i) {
+					node_to_pxm_map_copy[j] =
+						node_to_pxm_map[i];
+					if (j > index)
+						index = j;
+					count++;
+				}
+			}
+		}
+	}
+	if (WARN(index != max_nid, "%d max nid  when expected %d\n",
+		      index, max_nid))
+		return -1;
+
+	nodes_clear(nodes_to_enable);
+
+	/* map phys nodes not used for fake nodes */
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		if (node_to_pxm_map[i] != PXM_INVAL) {
+			for (j = 0; j <= max_nid; j++)
+				if (emu_nid_to_phys[j] == i)
+					break;
+			/* fake nodes PXM mapping has been done */
+			if (j <= max_nid)
+				continue;
+			/* find first hole */
+			for (j = 0;
+			     j < MAX_NUMNODES &&
+				 node_to_pxm_map_copy[j] != PXM_INVAL;
+			     j++)
+			;
+			if (WARN(j == MAX_NUMNODES,
+			    "Number of nodes exceeds MAX_NUMNODES\n"))
+				return -1;
+			node_to_pxm_map_copy[j] = node_to_pxm_map[i];
+			node_set(j, nodes_to_enable);
+			count++;
+		}
+	}
+
+	/* creating reverse mapping in pxm_to_node_map[] */
+	for (i = 0; i < MAX_NUMNODES; i++)
+		if (node_to_pxm_map_copy[i] != PXM_INVAL &&
+		    pxm_to_node_map_copy[node_to_pxm_map_copy[i]] == NUMA_NO_NODE)
+			pxm_to_node_map_copy[node_to_pxm_map_copy[i]] = i;
+
+	/* overwrite with new mapping */
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		node_to_pxm_map[i] = node_to_pxm_map_copy[i];
+		pxm_to_node_map[i] = pxm_to_node_map_copy[i];
+	}
+
+	/* enable other nodes found in PXM for hotplug */
+	nodes_or(numa_nodes_parsed, nodes_to_enable, numa_nodes_parsed);
+
+	pr_debug("found %d total number of nodes\n", count);
+	return 0;
+}
+#endif
+
 static void __init
 acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 {
diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
index b5f594754a9e4..99b960bd473c5 100644
--- a/include/acpi/acpi_numa.h
+++ b/include/acpi/acpi_numa.h
@@ -17,11 +17,16 @@ extern int node_to_pxm(int);
 extern int acpi_map_pxm_to_node(int);
 extern unsigned char acpi_srat_revision;
 extern void disable_srat(void);
+extern int fix_pxm_node_maps(int max_nid);
 
 extern void bad_srat(void);
 extern int srat_disabled(void);
 
 #else				/* CONFIG_ACPI_NUMA */
+static inline int fix_pxm_node_maps(int max_nid)
+{
+	return 0;
+}
 static inline void disable_srat(void)
 {
 }
diff --git a/include/linux/numa_memblks.h b/include/linux/numa_memblks.h
index cfad6ce7e1bd1..dd85613cdd86a 100644
--- a/include/linux/numa_memblks.h
+++ b/include/linux/numa_memblks.h
@@ -29,7 +29,10 @@ int __init numa_cleanup_meminfo(struct numa_meminfo *mi);
 int __init numa_memblks_init(int (*init_func)(void),
 			     bool memblock_force_top_down);
 
+extern int numa_distance_cnt;
+
 #ifdef CONFIG_NUMA_EMU
+extern int emu_nid_to_phys[MAX_NUMNODES];
 int numa_emu_cmdline(char *str);
 void __init numa_emu_update_cpu_to_node(int *emu_nid_to_phys,
 					unsigned int nr_emu_nids);
diff --git a/mm/numa_emulation.c b/mm/numa_emulation.c
index 031fb9961bf7b..9d55679d99cee 100644
--- a/mm/numa_emulation.c
+++ b/mm/numa_emulation.c
@@ -8,11 +8,12 @@
 #include <linux/memblock.h>
 #include <linux/numa_memblks.h>
 #include <asm/numa.h>
+#include <acpi/acpi_numa.h>
 
 #define FAKE_NODE_MIN_SIZE	((u64)32 << 20)
 #define FAKE_NODE_MIN_HASH_MASK	(~(FAKE_NODE_MIN_SIZE - 1UL))
 
-static int emu_nid_to_phys[MAX_NUMNODES];
+int emu_nid_to_phys[MAX_NUMNODES];
 static char *emu_cmdline __initdata;
 
 int __init numa_emu_cmdline(char *str)
@@ -379,6 +380,7 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
 	size_t phys_size = numa_dist_cnt * numa_dist_cnt * sizeof(phys_dist[0]);
 	int max_emu_nid, dfl_phys_nid;
 	int i, j, ret;
+	nodemask_t physnode_mask = numa_nodes_parsed;
 
 	if (!emu_cmdline)
 		goto no_emu;
@@ -395,7 +397,6 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
 	 * split the system RAM into N fake nodes.
 	 */
 	if (strchr(emu_cmdline, 'U')) {
-		nodemask_t physnode_mask = numa_nodes_parsed;
 		unsigned long n;
 		int nid = 0;
 
@@ -465,9 +466,6 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
 	 */
 	max_emu_nid = setup_emu2phys_nid(&dfl_phys_nid);
 
-	/* commit */
-	*numa_meminfo = ei;
-
 	/* Make sure numa_nodes_parsed only contains emulated nodes */
 	nodes_clear(numa_nodes_parsed);
 	for (i = 0; i < ARRAY_SIZE(ei.blk); i++)
@@ -475,10 +473,21 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
 		    ei.blk[i].nid != NUMA_NO_NODE)
 			node_set(ei.blk[i].nid, numa_nodes_parsed);
 
-	numa_emu_update_cpu_to_node(emu_nid_to_phys, ARRAY_SIZE(emu_nid_to_phys));
+	/* fix pxm_to_node_map[] and node_to_pxm_map[] to avoid collision
+	 * with faked numa nodes, particularly during later memory hotplug
+	 * handling, and also update numa_nodes_parsed accordingly.
+	 */
+	ret = fix_pxm_node_maps(max_emu_nid);
+	if (ret < 0)
+		goto no_emu;
+
+	/* commit */
+	*numa_meminfo = ei;
+
+	numa_emu_update_cpu_to_node(emu_nid_to_phys, max_emu_nid + 1);
 
 	/* make sure all emulated nodes are mapped to a physical node */
-	for (i = 0; i < ARRAY_SIZE(emu_nid_to_phys); i++)
+	for (i = 0; i < max_emu_nid + 1; i++)
 		if (emu_nid_to_phys[i] == NUMA_NO_NODE)
 			emu_nid_to_phys[i] = dfl_phys_nid;
 
@@ -501,12 +510,34 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
 			numa_set_distance(i, j, dist);
 		}
 	}
+	for (i = 0; i < numa_distance_cnt; i++) {
+		for (j = 0; j < numa_distance_cnt; j++) {
+			int physi, physj;
+			u8 dist;
+
+			/* distance between fake nodes is already ok */
+			if (emu_nid_to_phys[i] != NUMA_NO_NODE &&
+			    emu_nid_to_phys[j] != NUMA_NO_NODE)
+				continue;
+			if (emu_nid_to_phys[i] != NUMA_NO_NODE)
+				physi = emu_nid_to_phys[i];
+			else
+				physi = i - max_emu_nid;
+			if (emu_nid_to_phys[j] != NUMA_NO_NODE)
+				physj = emu_nid_to_phys[j];
+			else
+				physj = j - max_emu_nid;
+			dist = phys_dist[physi * numa_dist_cnt + physj];
+			numa_set_distance(i, j, dist);
+		}
+	}
 
 	/* free the copied physical distance table */
 	memblock_free(phys_dist, phys_size);
 	return;
 
 no_emu:
+	numa_nodes_parsed = physnode_mask;
 	/* No emulation.  Build identity emu_nid_to_phys[] for numa_add_cpu() */
 	for (i = 0; i < ARRAY_SIZE(emu_nid_to_phys); i++)
 		emu_nid_to_phys[i] = i;
diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
index a3877e9bc878a..ff4054f4334da 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -7,7 +7,7 @@
 #include <linux/numa.h>
 #include <linux/numa_memblks.h>
 
-static int numa_distance_cnt;
+int numa_distance_cnt;
 static u8 *numa_distance;
 
 nodemask_t numa_nodes_parsed __initdata;
-- 
2.51.0


