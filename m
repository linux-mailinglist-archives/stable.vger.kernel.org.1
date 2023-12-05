Return-Path: <stable+bounces-4090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7E08045F4
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4E51C20CBE
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4BE6FB8;
	Tue,  5 Dec 2023 03:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YBu7RHui"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9A66AA0;
	Tue,  5 Dec 2023 03:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88546C433C9;
	Tue,  5 Dec 2023 03:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746591;
	bh=mrX7JmEYRkjG1hAkGlcX0YOCSU8WKJOEg/yDR+r86QY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YBu7RHuiiXI+rWXd1H3JnphKgKBIFcm9YCZ3pmTYQ7pkB4HjXQD/Ou7nV+cUzYOdH
	 IYa6omINgqL6+2nhJojG860+wLDBw1JRRZoOpUFHd7HZ5zsHMdxK6mex+jgxeRKaXc
	 q8P+Y1Tv5daswwEpwfpXjF/42vi2vu6Fy/mvNhLg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.6 059/134] parisc: Mark lock_aligned variables 16-byte aligned on SMP
Date: Tue,  5 Dec 2023 12:15:31 +0900
Message-ID: <20231205031539.263147985@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
References: <20231205031535.163661217@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit b28fc0d8739c03e7b6c44914a9d00d4c6dddc0ea upstream.

On parisc we need 16-byte alignment for variables which are used for
locking. Mark the __lock_aligned attribute acordingly so that the
.data..lock_aligned section will get that alignment in the generated
object files.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org   # v6.0+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/include/asm/ldcw.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/parisc/include/asm/ldcw.h
+++ b/arch/parisc/include/asm/ldcw.h
@@ -55,7 +55,7 @@
 })
 
 #ifdef CONFIG_SMP
-# define __lock_aligned __section(".data..lock_aligned")
+# define __lock_aligned __section(".data..lock_aligned") __aligned(16)
 #endif
 
 #endif /* __PARISC_LDCW_H */



