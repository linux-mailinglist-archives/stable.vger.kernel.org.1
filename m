Return-Path: <stable+bounces-68231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C6095313A
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45F528946C
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9284F19DF58;
	Thu, 15 Aug 2024 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W/bf1kg9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F211494C5;
	Thu, 15 Aug 2024 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729910; cv=none; b=O34YUtVPQgAUY/aL+8rBof5kWDx7PrNn/TtCmZG9HQ+oD0VkJeFyBjNboYjfB75bVkmA12goIXb7/Il7YlrUlFO68TrQD+1X8uI26u9RuV+wC7nfnv9jodq74Xrf4emWVdCwaR9WX0RJ4USg2jOsu/JZNkFokkMEfUVPW1kGtzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729910; c=relaxed/simple;
	bh=zxgzfDx1NYin+wEfyn7zrhJyzThZ+dgsDKxjDz7/Nuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCT84GUD6JGH+0Z3J0+0ZBd2xDEQaPqvpzbhaKL3KtrhwD55i/d1c5qJ+W3s9iID6jWkDjbExmQOpabqsbpIG8Qlh71x2j4je9MDHgHrDviXBuynXbpJVL9vfPm1NxWFdm9NLFfzohkmBDVt0ERpHDwAf6opjbrI9K6uiWXrgB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W/bf1kg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB16C32786;
	Thu, 15 Aug 2024 13:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723729910;
	bh=zxgzfDx1NYin+wEfyn7zrhJyzThZ+dgsDKxjDz7/Nuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W/bf1kg95MjrFDzl+/td6eUdKszY0LICQ0MvKuVp4JEXzJYcM6MMdtDi8VEGdWLN2
	 0ARwaaDa6RYYDkwSy2s0NqTsXIPbMA2WkT7VbVudfMzIsPw2hCOQtqY+XxM7+B9aIw
	 8hpPf/gahYVyk3eUnOjt1ApgkLwbykLFPBN00xQ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 5.15 246/484] MIPS: ip30: ip30-console: Add missing include
Date: Thu, 15 Aug 2024 15:21:44 +0200
Message-ID: <20240815131950.902253012@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

commit 8de4ed75bd14ed197119ac509c6902a8561e0c1c upstream.

Include linux/processor.h to fix build error:

arch/mips/sgi-ip30/ip30-console.c: In function ‘prom_putchar’:
arch/mips/sgi-ip30/ip30-console.c:21:17: error: implicit declaration of function ‘cpu_relax’ [-Werror=implicit-function-declaration]
   21 |                 cpu_relax();

Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/sgi-ip30/ip30-console.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/sgi-ip30/ip30-console.c
+++ b/arch/mips/sgi-ip30/ip30-console.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/io.h>
+#include <linux/processor.h>
 
 #include <asm/sn/ioc3.h>
 



