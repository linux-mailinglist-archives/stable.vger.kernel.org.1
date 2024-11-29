Return-Path: <stable+bounces-94698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94489D6E1C
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D96BB21188
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 12:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D025518BBAC;
	Sun, 24 Nov 2024 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hw8mlqKL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833EB18B499;
	Sun, 24 Nov 2024 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732451959; cv=none; b=EnQv2LOM5d59rRj5rkhAz9Cqkyq3CGmjwE+4zP4kTdQNEt2CG7XzB7h2N2Pj32CYcShkgUSLz8vYyp60y2+14ekv+7fUtt0RLApx+H86sZMS+6yt0HjTuolJZiOSqk9ZK4hidtdXIC6iHKi7SE3AwH5ggMFkKlqmEaUVEyJLqH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732451959; c=relaxed/simple;
	bh=W8gLkoqCr4ylZMN7LYUTjsAp3elzJZy5tIpVigYUyuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJdPvR+J7j5XYQcKqvykbVqxRW7sQbSp9g5azYzYhhms8k+55vhoDG0KlGiNf9dMLeayMY+HgHNdsl95iZyHuuz8vuNq9sUlNBj+Pcdg/4dTUJhxSItEVVpCbMq1II6Lzzf8Qz87EXjcX25XJRBhw0Di2xhSKsJW3RD+7XHxV3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hw8mlqKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BFFC4CED3;
	Sun, 24 Nov 2024 12:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732451959;
	bh=W8gLkoqCr4ylZMN7LYUTjsAp3elzJZy5tIpVigYUyuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hw8mlqKL3lZj8KvXNd61P8LzhDLqEOZxUmGQ53WrOzQM7PG/uTqr7+q9t/TFPr4H9
	 LSLPOLzDgOOo7sPMXBmJ+WLPvjzpKJojT0BfIcS4OAw+Xqi3xiGXfoJh+VJv5k1uoS
	 tJi904K7nvi7rLLgdEoURIEz1Ix4XVDyWR1FUComSEIHb0Zzv8069WfvKpC0g99was
	 oZZ/ray8Y+GgTLDszO48/PScSxTYS7pmmJP1hq0Q8SET14g/7l0YKkMS/xzASUexNr
	 wUP/Mg3/TDv+iz+0DFqYVdsOGy8p183nA2UDGKe5lqrj3XT4cJQuBV2gZbz5DWCd0E
	 3XWYfb93JofOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	jgg@ziepe.ca,
	mjrosato@linux.ibm.com,
	lukas@wunner.de,
	wintera@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 02/19] s390/pci: Use topology ID for multi-function devices
Date: Sun, 24 Nov 2024 07:38:37 -0500
Message-ID: <20241124123912.3335344-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124123912.3335344-1-sashal@kernel.org>
References: <20241124123912.3335344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Niklas Schnelle <schnelle@linux.ibm.com>

[ Upstream commit 126034faaac5f356822c4a9bebfa75664da11056 ]

The newly introduced topology ID (TID) field in the CLP Query PCI
Function explicitly identifies groups of PCI functions whose RIDs belong
to the same (sub-)topology. When available use the TID instead of the
PCHID to match zPCI busses/domains for multi-function devices. Note that
currently only a single PCI bus per TID is supported. This change is
required because in future machines the PCHID will not identify a PCI
card but a specific port in the case of some multi-port NICs while from
a PCI point of view the entire card is a subtopology.

Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/pci.h     |  9 ++++++---
 arch/s390/include/asm/pci_clp.h |  8 +++++---
 arch/s390/pci/pci_bus.c         | 17 ++++++++++-------
 arch/s390/pci/pci_clp.c         |  3 +++
 4 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 45e87c7c122a6..e107eda7af86f 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -107,9 +107,10 @@ struct zpci_bus {
 	struct list_head	resources;
 	struct list_head	bus_next;
 	struct resource		bus_resource;
-	int			pchid;
+	int			topo;		/* TID if topo_is_tid, PCHID otherwise */
 	int			domain_nr;
-	bool			multifunction;
+	u8			multifunction	: 1;
+	u8			topo_is_tid	: 1;
 	enum pci_bus_speed	max_bus_speed;
 };
 
@@ -131,6 +132,7 @@ struct zpci_dev {
 	u16		pchid;		/* physical channel ID */
 	u16		maxstbl;	/* Maximum store block size */
 	u16		rid;		/* RID as supplied by firmware */
+	u16		tid;		/* Topology for which RID is valid */
 	u8		pfgid;		/* function group ID */
 	u8		pft;		/* pci function type */
 	u8		port;
@@ -141,7 +143,8 @@ struct zpci_dev {
 	u8		is_physfn	: 1;
 	u8		util_str_avail	: 1;
 	u8		irqs_registered	: 1;
-	u8		reserved	: 2;
+	u8		tid_avail	: 1;
+	u8		reserved	: 1;
 	unsigned int	devfn;		/* DEVFN part of the RID*/
 
 	u8 pfip[CLP_PFIP_NR_SEGMENTS];	/* pci function internal path */
diff --git a/arch/s390/include/asm/pci_clp.h b/arch/s390/include/asm/pci_clp.h
index f0c677ddd2706..14afb9ce91f3b 100644
--- a/arch/s390/include/asm/pci_clp.h
+++ b/arch/s390/include/asm/pci_clp.h
@@ -110,7 +110,8 @@ struct clp_req_query_pci {
 struct clp_rsp_query_pci {
 	struct clp_rsp_hdr hdr;
 	u16 vfn;			/* virtual fn number */
-	u16			:  3;
+	u16			:  2;
+	u16 tid_avail		:  1;
 	u16 rid_avail		:  1;
 	u16 is_physfn		:  1;
 	u16 reserved1		:  1;
@@ -130,8 +131,9 @@ struct clp_rsp_query_pci {
 	u64 edma;			/* end dma as */
 #define ZPCI_RID_MASK_DEVFN 0x00ff
 	u16 rid;			/* BUS/DEVFN PCI address */
-	u16 reserved0;
-	u32 reserved[10];
+	u32 reserved0;
+	u16 tid;
+	u32 reserved[9];
 	u32 uid;			/* user defined id */
 	u8 util_str[CLP_UTIL_STR_LEN];	/* utility string */
 	u32 reserved2[16];
diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index daa5d7450c7d3..54879e773e4a3 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -232,13 +232,13 @@ static void zpci_bus_put(struct zpci_bus *zbus)
 	kref_put(&zbus->kref, zpci_bus_release);
 }
 
-static struct zpci_bus *zpci_bus_get(int pchid)
+static struct zpci_bus *zpci_bus_get(int topo, bool topo_is_tid)
 {
 	struct zpci_bus *zbus;
 
 	mutex_lock(&zbus_list_lock);
 	list_for_each_entry(zbus, &zbus_list, bus_next) {
-		if (pchid == zbus->pchid) {
+		if (topo_is_tid == zbus->topo_is_tid && topo == zbus->topo) {
 			kref_get(&zbus->kref);
 			goto out_unlock;
 		}
@@ -249,7 +249,7 @@ static struct zpci_bus *zpci_bus_get(int pchid)
 	return zbus;
 }
 
-static struct zpci_bus *zpci_bus_alloc(int pchid)
+static struct zpci_bus *zpci_bus_alloc(int topo, bool topo_is_tid)
 {
 	struct zpci_bus *zbus;
 
@@ -257,7 +257,8 @@ static struct zpci_bus *zpci_bus_alloc(int pchid)
 	if (!zbus)
 		return NULL;
 
-	zbus->pchid = pchid;
+	zbus->topo = topo;
+	zbus->topo_is_tid = topo_is_tid;
 	INIT_LIST_HEAD(&zbus->bus_next);
 	mutex_lock(&zbus_list_lock);
 	list_add_tail(&zbus->bus_next, &zbus_list);
@@ -321,8 +322,9 @@ static int zpci_bus_add_device(struct zpci_bus *zbus, struct zpci_dev *zdev)
 
 int zpci_bus_device_register(struct zpci_dev *zdev, struct pci_ops *ops)
 {
+	bool topo_is_tid = zdev->tid_avail;
 	struct zpci_bus *zbus = NULL;
-	int rc = -EBADF;
+	int topo, rc = -EBADF;
 
 	if (zpci_nb_devices == ZPCI_NR_DEVICES) {
 		pr_warn("Adding PCI function %08x failed because the configured limit of %d is reached\n",
@@ -333,11 +335,12 @@ int zpci_bus_device_register(struct zpci_dev *zdev, struct pci_ops *ops)
 	if (zdev->devfn >= ZPCI_FUNCTIONS_PER_BUS)
 		return -EINVAL;
 
+	topo = topo_is_tid ? zdev->tid : zdev->pchid;
 	if (!s390_pci_no_rid && zdev->rid_available)
-		zbus = zpci_bus_get(zdev->pchid);
+		zbus = zpci_bus_get(topo, topo_is_tid);
 
 	if (!zbus) {
-		zbus = zpci_bus_alloc(zdev->pchid);
+		zbus = zpci_bus_alloc(topo, topo_is_tid);
 		if (!zbus)
 			return -ENOMEM;
 	}
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index f7430086e9739..e222036874e51 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -170,6 +170,9 @@ static int clp_store_query_pci_fn(struct zpci_dev *zdev,
 		zdev->rid = response->rid;
 	if (!s390_pci_no_rid && zdev->rid_available)
 		zdev->devfn = response->rid & ZPCI_RID_MASK_DEVFN;
+	zdev->tid_avail = response->tid_avail;
+	if (zdev->tid_avail)
+		zdev->tid = response->tid;
 
 	memcpy(zdev->pfip, response->pfip, sizeof(zdev->pfip));
 	if (response->util_str_avail) {
-- 
2.43.0


