Return-Path: <stable+bounces-18248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D428481F8
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C392A1F2136D
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6A843AC1;
	Sat,  3 Feb 2024 04:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ip9T51cX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00C512B89;
	Sat,  3 Feb 2024 04:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933657; cv=none; b=aShjpFKtwILECedb3Y4fJVtZ/9QJH8tM3X4d0CCAcC7/Gh1QGiHYt6Icr7KUc15NS8Am9kRASkXgZaBgyFGY1DTFbk95/JgdXYXKrqYFKdzFx+W/IcoNXV25XPOsrk4ESnSAWAN8v+H/L4ugzz6zBTm2R2AMv3gtKzd4P7E+9Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933657; c=relaxed/simple;
	bh=A7E2MfZQK1l+CoKPaivKjGwmc0AasrIByfwobeMKLQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgtLHViVHAtWP3CsgpTUIaPhf/igRBOp8bCJeWajavSUYizb7vickSJHf/+WqBtgwf2Dn/Qr3Y3zZqn/KFpjp4UaNxb6gVsKUgtUNocCLtFr85C7mvp6zzytwj6l1e8AHU5p1Nyl3sE/yflt3IljovtcoKYr7szEmkbeaLpb/w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ip9T51cX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AF2C43390;
	Sat,  3 Feb 2024 04:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933656;
	bh=A7E2MfZQK1l+CoKPaivKjGwmc0AasrIByfwobeMKLQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ip9T51cXZ6dtyU3nYMimPyTEdZVReymGyW39vYsvjO1qOLNgHUqjdi9VqffCMKHAe
	 EeDSn4SwUUOokWbdFda4zRUMQPigHKE+1JPbvB5Z81RO6ePedwn6+jv7ymzwpVZ3zN
	 guxd7f5mn/D+CTguBGsXTRBGZMgMZ1aSGfi1Tq/Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 236/322] selftests/sgx: Fix linker script asserts
Date: Fri,  2 Feb 2024 20:05:33 -0800
Message-ID: <20240203035406.818021631@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
References: <20240203035359.041730947@linuxfoundation.org>
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

From: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>

[ Upstream commit 9fd552ee32c6c1e27c125016b87d295bea6faea7 ]

DEFINED only considers symbols, not section names. Hence, replace the
check for .got.plt with the _GLOBAL_OFFSET_TABLE_ symbol and remove other
(non-essential) asserts.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/all/20231005153854.25566-10-jo.vanbulck%40cs.kuleuven.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/sgx/test_encl.lds | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/selftests/sgx/test_encl.lds
index a1ec64f7d91f..108bc11d1d8c 100644
--- a/tools/testing/selftests/sgx/test_encl.lds
+++ b/tools/testing/selftests/sgx/test_encl.lds
@@ -34,8 +34,4 @@ SECTIONS
 	}
 }
 
-ASSERT(!DEFINED(.altinstructions), "ALTERNATIVES are not supported in enclaves")
-ASSERT(!DEFINED(.altinstr_replacement), "ALTERNATIVES are not supported in enclaves")
-ASSERT(!DEFINED(.discard.retpoline_safe), "RETPOLINE ALTERNATIVES are not supported in enclaves")
-ASSERT(!DEFINED(.discard.nospec), "RETPOLINE ALTERNATIVES are not supported in enclaves")
-ASSERT(!DEFINED(.got.plt), "Libcalls are not supported in enclaves")
+ASSERT(!DEFINED(_GLOBAL_OFFSET_TABLE_), "Libcalls through GOT are not supported in enclaves")
-- 
2.43.0




