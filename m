Return-Path: <stable+bounces-119240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636D8A42566
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883BD4244FE
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2EA190063;
	Mon, 24 Feb 2025 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fEOiPpWC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7CE27701;
	Mon, 24 Feb 2025 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408796; cv=none; b=W1GkpaGAFAIVHQOYeEy03esJ5C91YLKMaOZUW9zq0XE/khY3N0rdhRFQuWltRGuj88JOsH3dud3QDRm478IrD/jP1PW83mUNU46NMR/WKEkrdLuPitxDT8eSeUCeALFSampgGOv4KSDuYDgk+5olHRhdCSwbeaUyiWLuRz65sz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408796; c=relaxed/simple;
	bh=3iQNXpFH+hxzLLgXkO2LkLg3tB2D+k5mrPL3xA7v4Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oERpc8gZhkvKHptOI0bPzgNf5K669AUbFhroDA01A1HackPUOQ6LHNwBHqoYV+j3vUyuBMRm3VraeayYRTcUv/JywQIf+hgfyvkSC6NoxidgizHCEyrMe7217hbinKo6g98bPt4OYtRzZ4LnHDJavJesahE2dI32kum4Ui6kjpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fEOiPpWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73242C4CED6;
	Mon, 24 Feb 2025 14:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408794;
	bh=3iQNXpFH+hxzLLgXkO2LkLg3tB2D+k5mrPL3xA7v4Us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fEOiPpWCDJwjFe9R20KqBkFQP28q5nh/RasIOh0fBT4vxsV+3mtvJ0/S+i7d6S2t5
	 tFTK1Lwa+HyJyZCOyQgrbShwZQyiPNeFp5vDFh4LUywdH4FI5lJmoUutlFbcrGZM+r
	 nU4eLev7fnx6KN52aeVeEvdtzrLWMEnJB9mqZBts=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 6.12 123/154] s390/boot: Fix ESSA detection
Date: Mon, 24 Feb 2025 15:35:22 +0100
Message-ID: <20250224142611.868857820@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142607.058226288@linuxfoundation.org>
References: <20250224142607.058226288@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <hca@linux.ibm.com>

commit c3a589fd9fcbf295a7402a4b188dc9277d505f4f upstream.

The cmma_test_essa() inline assembly uses tmp as input and output, however
tmp is specified as output only, which allows the compiler to optimize the
initialization of tmp away.

Therefore the ESSA detection may or may not work depending on previous
contents of the register that the compiler selected for tmp.

Fix this by using the correct constraint modifier.

Fixes: 468a3bc2b7b9 ("s390/cmma: move parsing of cmma kernel parameter to early boot code")
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/boot/startup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -75,7 +75,7 @@ static int cmma_test_essa(void)
 		: [reg1] "=&d" (reg1),
 		  [reg2] "=&a" (reg2),
 		  [rc] "+&d" (rc),
-		  [tmp] "=&d" (tmp),
+		  [tmp] "+&d" (tmp),
 		  "+Q" (get_lowcore()->program_new_psw),
 		  "=Q" (old)
 		: [psw_old] "a" (&old),



