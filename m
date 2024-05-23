Return-Path: <stable+bounces-45772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A948CD3CC
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C7D1C203E3
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCD514B061;
	Thu, 23 May 2024 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s2R5pn0i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EED42AE94;
	Thu, 23 May 2024 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470317; cv=none; b=vFHjuFU7pC645IAh77Y9loZbyd6QKipoq3JVLXxhKRlODySIWbQF2vUJpxBvd3ap+ZzaUmq3xqL+4kZZD2q4YXNauFqLzjC8EM0v635tmYH6Zpv4XGjqLJVQhqThvTnvK2iwXmqmsPEmxVfGtBnk1yg9rU8S1NZ0HKSKjeZkqAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470317; c=relaxed/simple;
	bh=1Oi5p6zqs0IQSz3zI82ta9LM+uVuiKVJdmTjsIo2Yyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojokQt8IyY0syprlfDqe+oKVA5cK1Rz1iHf+ZSBxOuntvuBTWwtUw64ymvyUQXnmfOhyv0lTKe1qfrLnE+HhzHvaY4hOhzQ3pJCluYuQUrVguXkLVohamLPwhPPzw8VRIn1SggTiBYD9JhVwZ3m83cwTew2FMbALgtQlIRoVFis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s2R5pn0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EC5C3277B;
	Thu, 23 May 2024 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470317;
	bh=1Oi5p6zqs0IQSz3zI82ta9LM+uVuiKVJdmTjsIo2Yyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s2R5pn0isdjl90LYpbB1msYoHLucUO1uX5KjJpCxzpjc6YALfNWvBelfwMWh/soOZ
	 TlmuprfjYlSOkkIC3ACSoYb9Go9Ao846Or4wNazMlEnWozyOUj+bc6EoTvlG95dlf2
	 QNRSIbCYYFCxjfR92kD73uJeOWe1QOWpKvWuMLNc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"sashal@kernel.org, vegard.nossum@oracle.com, darren.kenny@oracle.com, Harshit Mogalapalli" <harshit.m.mogalapalli@oracle.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15 05/23] Revert "selftests: mm: fix map_hugetlb failure on 64K page size systems"
Date: Thu, 23 May 2024 15:13:01 +0200
Message-ID: <20240523130328.160831758@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523130327.956341021@linuxfoundation.org>
References: <20240523130327.956341021@linuxfoundation.org>
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


This reverts commit 0d29b474fb90ff35920642f378d9baace9b47edd which is
commit 91b80cc5b39f00399e8e2d17527cad2c7fa535e2 upstream.

map_hugetlb.c:18:10: fatal error: vm_util.h: No such file or directory
   18 | #include "vm_util.h"
      |          ^~~~~~~~~~~
compilation terminated.

vm_util.h is not present in 5.15.y, as commit:642bc52aed9c ("selftests:
vm: bring common functions to a new file") is not present in stable
kernels <=6.1.y

Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 tools/testing/selftests/vm/map_hugetlb.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/tools/testing/selftests/vm/map_hugetlb.c
+++ b/tools/testing/selftests/vm/map_hugetlb.c
@@ -15,7 +15,6 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <fcntl.h>
-#include "vm_util.h"
 
 #define LENGTH (256UL*1024*1024)
 #define PROTECTION (PROT_READ | PROT_WRITE)
@@ -71,16 +70,10 @@ int main(int argc, char **argv)
 {
 	void *addr;
 	int ret;
-	size_t hugepage_size;
 	size_t length = LENGTH;
 	int flags = FLAGS;
 	int shift = 0;
 
-	hugepage_size = default_huge_page_size();
-	/* munmap with fail if the length is not page aligned */
-	if (hugepage_size > length)
-		length = hugepage_size;
-
 	if (argc > 1)
 		length = atol(argv[1]) << 20;
 	if (argc > 2) {



