Return-Path: <stable+bounces-167569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C019AB230B0
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967C11895F3A
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A18C2F8BE7;
	Tue, 12 Aug 2025 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ba1xvy2m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487B72FDC2C;
	Tue, 12 Aug 2025 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021258; cv=none; b=ZTOlTSTBkwIBkYHlMCAmSnAP6sN7RGL88V4nE26j0p6JuJN5vrJE3n5wUTTIXxXLnPU2H699M1zZqpB52PC89FsJkAdjNM9tPfIfZ3wCQ/ciC8ZHHrMwmO5UieCnj5WtTb3sHt5K5hHqkzBzTxuzhhnO+4ZakW6jeFDBU/twIwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021258; c=relaxed/simple;
	bh=Kh22GwZGllxymCtwj9nCgMD/y2wNG+oWzIbr1IEbVoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFRsxUnp9EIeNyfphH3pcv52+izPZqEBn2Gu/zXhCr84+8U1xUo4mcQ8eXMFDvUEXgqdcIpoHpdBGdOrDEzHl4I4XyJ8ARRoW6cgA/tuIPeAqz/CAhCblmwHp/GWRJXWoY9nAdw4O1/0rQEdYLeaexsmjqvVp1wLnoy+cABydRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ba1xvy2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59302C4CEF0;
	Tue, 12 Aug 2025 17:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021257;
	bh=Kh22GwZGllxymCtwj9nCgMD/y2wNG+oWzIbr1IEbVoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ba1xvy2mJ/6re3DbBtxiCApsRv/JLUkAi6kMPaiPwUfcLCkr4AHDno6Qgm3O5i6ud
	 /NvmoJEAb+Xx1fzzWKm+H/KLtVPCfXwH95Zfxzhv/MA1vci86NG+RC0kVdnZ7OQZWZ
	 H15JHJ+ydKEQIHx0VtNu9cc33fhhjlIKmy8TV0js=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 6.1 236/253] selftests/perf_events: Add a mmap() correctness test
Date: Tue, 12 Aug 2025 19:30:24 +0200
Message-ID: <20250812172958.876996843@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
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

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

commit 084d2ac4030c5919e85bba1f4af26e33491469cb upstream.

Exercise various mmap(), munmap() and mremap() invocations, which might
cause a perf buffer mapping to be split or truncated.

To avoid hard coding the perf event and having dependencies on
architectures and configuration options, scan through event types in sysfs
and try to open them. On success, try to mmap() and if that succeeds try to
mmap() the AUX buffer.

In case that no AUX buffer supporting event is found, only test the base
buffer mapping. If no mappable event is found or permissions are not
sufficient, skip the tests.

Reserve a PROT_NONE region for both rb and aux tests to allow testing the
case where mremap unmaps beyond the end of a mapped VMA to prevent it from
unmapping unrelated mappings.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/perf_events/.gitignore |    1 
 tools/testing/selftests/perf_events/Makefile   |    2 
 tools/testing/selftests/perf_events/mmap.c     |  236 +++++++++++++++++++++++++
 3 files changed, 238 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/perf_events/mmap.c

--- a/tools/testing/selftests/perf_events/.gitignore
+++ b/tools/testing/selftests/perf_events/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 sigtrap_threads
 remove_on_exec
+mmap
--- a/tools/testing/selftests/perf_events/Makefile
+++ b/tools/testing/selftests/perf_events/Makefile
@@ -2,5 +2,5 @@
 CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
 LDFLAGS += -lpthread
 
-TEST_GEN_PROGS := sigtrap_threads remove_on_exec
+TEST_GEN_PROGS := sigtrap_threads remove_on_exec mmap
 include ../lib.mk
--- /dev/null
+++ b/tools/testing/selftests/perf_events/mmap.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define _GNU_SOURCE
+
+#include <dirent.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+
+#include <linux/perf_event.h>
+
+#include "../kselftest_harness.h"
+
+#define RB_SIZE		0x3000
+#define AUX_SIZE	0x10000
+#define AUX_OFFS	0x4000
+
+#define HOLE_SIZE	0x1000
+
+/* Reserve space for rb, aux with space for shrink-beyond-vma testing. */
+#define REGION_SIZE	(2 * RB_SIZE + 2 * AUX_SIZE)
+#define REGION_AUX_OFFS (2 * RB_SIZE)
+
+#define MAP_BASE	1
+#define MAP_AUX		2
+
+#define EVENT_SRC_DIR	"/sys/bus/event_source/devices"
+
+FIXTURE(perf_mmap)
+{
+	int		fd;
+	void		*ptr;
+	void		*region;
+};
+
+FIXTURE_VARIANT(perf_mmap)
+{
+	bool		aux;
+	unsigned long	ptr_size;
+};
+
+FIXTURE_VARIANT_ADD(perf_mmap, rb)
+{
+	.aux = false,
+	.ptr_size = RB_SIZE,
+};
+
+FIXTURE_VARIANT_ADD(perf_mmap, aux)
+{
+	.aux = true,
+	.ptr_size = AUX_SIZE,
+};
+
+static bool read_event_type(struct dirent *dent, __u32 *type)
+{
+	char typefn[512];
+	FILE *fp;
+	int res;
+
+	snprintf(typefn, sizeof(typefn), "%s/%s/type", EVENT_SRC_DIR, dent->d_name);
+	fp = fopen(typefn, "r");
+	if (!fp)
+		return false;
+
+	res = fscanf(fp, "%u", type);
+	fclose(fp);
+	return res > 0;
+}
+
+FIXTURE_SETUP(perf_mmap)
+{
+	struct perf_event_attr attr = {
+		.size		= sizeof(attr),
+		.disabled	= 1,
+		.exclude_kernel	= 1,
+		.exclude_hv	= 1,
+	};
+	struct perf_event_attr attr_ok = {};
+	unsigned int eacces = 0, map = 0;
+	struct perf_event_mmap_page *rb;
+	struct dirent *dent;
+	void *aux, *region;
+	DIR *dir;
+
+	self->ptr = NULL;
+
+	dir = opendir(EVENT_SRC_DIR);
+	if (!dir)
+		SKIP(return, "perf not available.");
+
+	region = mmap(NULL, REGION_SIZE, PROT_NONE, MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(region, MAP_FAILED);
+	self->region = region;
+
+	// Try to find a suitable event on this system
+	while ((dent = readdir(dir))) {
+		int fd;
+
+		if (!read_event_type(dent, &attr.type))
+			continue;
+
+		fd = syscall(SYS_perf_event_open, &attr, 0, -1, -1, 0);
+		if (fd < 0) {
+			if (errno == EACCES)
+				eacces++;
+			continue;
+		}
+
+		// Check whether the event supports mmap()
+		rb = mmap(region, RB_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED, fd, 0);
+		if (rb == MAP_FAILED) {
+			close(fd);
+			continue;
+		}
+
+		if (!map) {
+			// Save the event in case that no AUX capable event is found
+			attr_ok = attr;
+			map = MAP_BASE;
+		}
+
+		if (!variant->aux)
+			continue;
+
+		rb->aux_offset = AUX_OFFS;
+		rb->aux_size = AUX_SIZE;
+
+		// Check whether it supports a AUX buffer
+		aux = mmap(region + REGION_AUX_OFFS, AUX_SIZE, PROT_READ | PROT_WRITE,
+			   MAP_SHARED | MAP_FIXED, fd, AUX_OFFS);
+		if (aux == MAP_FAILED) {
+			munmap(rb, RB_SIZE);
+			close(fd);
+			continue;
+		}
+
+		attr_ok = attr;
+		map = MAP_AUX;
+		munmap(aux, AUX_SIZE);
+		munmap(rb, RB_SIZE);
+		close(fd);
+		break;
+	}
+	closedir(dir);
+
+	if (!map) {
+		if (!eacces)
+			SKIP(return, "No mappable perf event found.");
+		else
+			SKIP(return, "No permissions for perf_event_open()");
+	}
+
+	self->fd = syscall(SYS_perf_event_open, &attr_ok, 0, -1, -1, 0);
+	ASSERT_NE(self->fd, -1);
+
+	rb = mmap(region, RB_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED, self->fd, 0);
+	ASSERT_NE(rb, MAP_FAILED);
+
+	if (!variant->aux) {
+		self->ptr = rb;
+		return;
+	}
+
+	if (map != MAP_AUX)
+		SKIP(return, "No AUX event found.");
+
+	rb->aux_offset = AUX_OFFS;
+	rb->aux_size = AUX_SIZE;
+	aux = mmap(region + REGION_AUX_OFFS, AUX_SIZE, PROT_READ | PROT_WRITE,
+		   MAP_SHARED | MAP_FIXED, self->fd, AUX_OFFS);
+	ASSERT_NE(aux, MAP_FAILED);
+	self->ptr = aux;
+}
+
+FIXTURE_TEARDOWN(perf_mmap)
+{
+	ASSERT_EQ(munmap(self->region, REGION_SIZE), 0);
+	if (self->fd != -1)
+		ASSERT_EQ(close(self->fd), 0);
+}
+
+TEST_F(perf_mmap, remap)
+{
+	void *tmp, *ptr = self->ptr;
+	unsigned long size = variant->ptr_size;
+
+	// Test the invalid remaps
+	ASSERT_EQ(mremap(ptr, size, HOLE_SIZE, MREMAP_MAYMOVE), MAP_FAILED);
+	ASSERT_EQ(mremap(ptr + HOLE_SIZE, size, HOLE_SIZE, MREMAP_MAYMOVE), MAP_FAILED);
+	ASSERT_EQ(mremap(ptr + size - HOLE_SIZE, HOLE_SIZE, size, MREMAP_MAYMOVE), MAP_FAILED);
+	// Shrink the end of the mapping such that we only unmap past end of the VMA,
+	// which should succeed and poke a hole into the PROT_NONE region
+	ASSERT_NE(mremap(ptr + size - HOLE_SIZE, size, HOLE_SIZE, MREMAP_MAYMOVE), MAP_FAILED);
+
+	// Remap the whole buffer to a new address
+	tmp = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(tmp, MAP_FAILED);
+
+	// Try splitting offset 1 hole size into VMA, this should fail
+	ASSERT_EQ(mremap(ptr + HOLE_SIZE, size - HOLE_SIZE, size - HOLE_SIZE,
+			 MREMAP_MAYMOVE | MREMAP_FIXED, tmp), MAP_FAILED);
+	// Remapping the whole thing should succeed fine
+	ptr = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, tmp);
+	ASSERT_EQ(ptr, tmp);
+	ASSERT_EQ(munmap(tmp, size), 0);
+}
+
+TEST_F(perf_mmap, unmap)
+{
+	unsigned long size = variant->ptr_size;
+
+	// Try to poke holes into the mappings
+	ASSERT_NE(munmap(self->ptr, HOLE_SIZE), 0);
+	ASSERT_NE(munmap(self->ptr + HOLE_SIZE, HOLE_SIZE), 0);
+	ASSERT_NE(munmap(self->ptr + size - HOLE_SIZE, HOLE_SIZE), 0);
+}
+
+TEST_F(perf_mmap, map)
+{
+	unsigned long size = variant->ptr_size;
+
+	// Try to poke holes into the mappings by mapping anonymous memory over it
+	ASSERT_EQ(mmap(self->ptr, HOLE_SIZE, PROT_READ | PROT_WRITE,
+		       MAP_PRIVATE | MAP_ANON | MAP_FIXED, -1, 0), MAP_FAILED);
+	ASSERT_EQ(mmap(self->ptr + HOLE_SIZE, HOLE_SIZE, PROT_READ | PROT_WRITE,
+		       MAP_PRIVATE | MAP_ANON | MAP_FIXED, -1, 0), MAP_FAILED);
+	ASSERT_EQ(mmap(self->ptr + size - HOLE_SIZE, HOLE_SIZE, PROT_READ | PROT_WRITE,
+		       MAP_PRIVATE | MAP_ANON | MAP_FIXED, -1, 0), MAP_FAILED);
+}
+
+TEST_HARNESS_MAIN



