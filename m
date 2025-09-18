Return-Path: <stable+bounces-169255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAE1B238FF
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C743AC529
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F352D3A94;
	Tue, 12 Aug 2025 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cUF1L54e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8427FB35;
	Tue, 12 Aug 2025 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026902; cv=none; b=cTn2sJJbOxC/BSaqNt3VF0eqXojejd+r/qn3scqpJeXQmVwNuHY08LfOxGs3y6cJp/Rz5/mIqKZAiQcXnji1FFpBS3pKDo2VY1nELhGpGws7gEddamAnb5+k7i5TnPBYzqIYcPEvWtQlXqK37OCkB/K3genBnbRJbfGWV8tztN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026902; c=relaxed/simple;
	bh=a3PLvs9A7iVZf32vlRobrDNYIQEvn3WQv5ITxOVAvLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egHYCkVv32n0W0YMQqjRCAVgchbsYzogjA1q+aC7Hmw6NMFNQ8Jtl9T0njLUaTOyAE/t09SZL7+l06v4+Tv0XAxOSusjIBIpsi7sUXhOiZHSN6Zzxf6xaFVvMW8yvacqA4yKTVfoz+USZPiSpzOF5FZWCGq44IVrZoBjSXHpLnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cUF1L54e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CCBC4CEF0;
	Tue, 12 Aug 2025 19:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755026902;
	bh=a3PLvs9A7iVZf32vlRobrDNYIQEvn3WQv5ITxOVAvLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cUF1L54eCahD7/soDAmXEaKYQ4SebLYb8C9FLwpyfsqL4vXy9WOnX3QGwAm6s3Jpv
	 Yu0f391yo2VEut8gHf0Yv7NT6VoOofKNcsguFfarFpOEZv4ZRcDyDuuhHRMjU/3O/C
	 cax92AvexS0Lyden3y1VwqakgbPLjJuGEarv0dQA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	zdi-disclosures@trendmicro.com
Subject: [PATCH 6.15 440/480] perf/core: Prevent VMA split of buffer mappings
Date: Tue, 12 Aug 2025 19:50:48 +0200
Message-ID: <20250812174415.546083643@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit b024d7b56c77191cde544f838debb7f8451cd0d6 upstream.

The perf mmap code is careful about mmap()'ing the user page with the
ringbuffer and additionally the auxiliary buffer, when the event supports
it. Once the first mapping is established, subsequent mapping have to use
the same offset and the same size in both cases. The reference counting for
the ringbuffer and the auxiliary buffer depends on this being correct.

Though perf does not prevent that a related mapping is split via mmap(2),
munmap(2) or mremap(2). A split of a VMA results in perf_mmap_open() calls,
which take reference counts, but then the subsequent perf_mmap_close()
calls are not longer fulfilling the offset and size checks. This leads to
reference count leaks.

As perf already has the requirement for subsequent mappings to match the
initial mapping, the obvious consequence is that VMA splits, caused by
resizing of a mapping or partial unmapping, have to be prevented.

Implement the vm_operations_struct::may_split() callback and return
unconditionally -EINVAL.

That ensures that the mapping offsets and sizes cannot be changed after the
fact. Remapping to a different fixed address with the same size is still
possible as it takes the references for the new mapping and drops those of
the old mapping.

Fixes: 45bfb2e50471 ("perf/core: Add AUX area to ring buffer for raw data streams")
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-27504
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/events/core.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6790,10 +6790,20 @@ static vm_fault_t perf_mmap_pfn_mkwrite(
 	return vmf->pgoff == 0 ? 0 : VM_FAULT_SIGBUS;
 }
 
+static int perf_mmap_may_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	/*
+	 * Forbid splitting perf mappings to prevent refcount leaks due to
+	 * the resulting non-matching offsets and sizes. See open()/close().
+	 */
+	return -EINVAL;
+}
+
 static const struct vm_operations_struct perf_mmap_vmops = {
 	.open		= perf_mmap_open,
 	.close		= perf_mmap_close, /* non mergeable */
 	.pfn_mkwrite	= perf_mmap_pfn_mkwrite,
+	.may_split	= perf_mmap_may_split,
 };
 
 static int map_range(struct perf_buffer *rb, struct vm_area_struct *vma)



