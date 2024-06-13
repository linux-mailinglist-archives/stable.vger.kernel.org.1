Return-Path: <stable+bounces-52030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8FD9072E6
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF3BCB29AB1
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29254A0F;
	Thu, 13 Jun 2024 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OiRknJgx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7147A1C32;
	Thu, 13 Jun 2024 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718283028; cv=none; b=O3GI2AYbir6RjZIrwNKqyY8eYlj6hkYfO7nLt7BnnMQPOZ2zxTU5dFr6RZt8cEnCOWTYH01nV2RUEbGonfOnEBxVAZEnDf4XuQFpqrPYWzoGWOfanTlc/omi0waEuM0nCuidT9Mrq1PR6eoldcSOtrI3xChcla1FyFDRYIY3PqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718283028; c=relaxed/simple;
	bh=Oo+wFfFKXo0EkcA3h1BvSarqeyixqIHQQ828JwR5nqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPzYjaKbFf00keVSdvdY+0QGJJ/x06sLmFP+PqAWWdXsYvXMcNVL5AG+bXuyxqvxhpsXcpVDGa7LxwdHhu1SffXduRw5wtNI1LGJCLYIn5xYySKgKKPy1X+QXV5Z+lXr+SnRrC3MHQ9M9kxJodUM7M+7YmGXx1RqlT908n1Bylo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OiRknJgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD17C2BBFC;
	Thu, 13 Jun 2024 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718283028;
	bh=Oo+wFfFKXo0EkcA3h1BvSarqeyixqIHQQ828JwR5nqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OiRknJgxMTRGZmT+GswFjctv0OmdRJqcsRVYk+HgDFmKTE32GU6xVT22wr0EMBxXe
	 fHHZI0scK6KvKvkJhw0/W64pQX6v9fQsShjUKbW1eSkOz/CKk0fZpiwhR24oHKhgKQ
	 H4bnfTVW+WZ/MZE4FdbClDg98iRUsQqAStCV/W5E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Helge Deller <deller@gmx.de>,
	John David Anglin <dave.anglin@bell.net>
Subject: [PATCH 6.1 74/85] parisc: Define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
Date: Thu, 13 Jun 2024 13:36:12 +0200
Message-ID: <20240613113216.992868166@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113214.134806994@linuxfoundation.org>
References: <20240613113214.134806994@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit d4a599910193b85f76c100e30d8551c8794f8c2a upstream.

Define the HAVE_ARCH_HUGETLB_UNMAPPED_AREA macro like other platforms do in
their page.h files to avoid this compile warning:
arch/parisc/mm/hugetlbpage.c:25:1: warning: no previous prototype for 'hugetlb_get_unmapped_area' [-Wmissing-prototypes]

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org  # 6.0+
Reported-by: John David Anglin <dave.anglin@bell.net>
Tested-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/include/asm/page.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/parisc/include/asm/page.h
+++ b/arch/parisc/include/asm/page.h
@@ -16,6 +16,7 @@
 #define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE-1))
 
+#define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 
 #ifndef __ASSEMBLY__
 



