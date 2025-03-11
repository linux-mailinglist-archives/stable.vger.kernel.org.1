Return-Path: <stable+bounces-123704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E81DA5C67D
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 639A07AC367
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5563A25D918;
	Tue, 11 Mar 2025 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C0JN4qQ/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F6A1494BB;
	Tue, 11 Mar 2025 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706725; cv=none; b=gffoKk3LqYISayJC7Gl+85rq1SeFSuKg6y4+iROH7KQhWYYoamuufVCWKmWMkIqn6DDXFMN0uGgnT8Mrc2qfVteC2SF77zl1kUDyyany4kBlsYBuWR/qo3SE4OVuADXDsyTfwAv7CGQAvYPbEUo2yod8bah2zR+jhZuusA1WoMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706725; c=relaxed/simple;
	bh=BMnQG7icRgdMzV010qzxdFm9djLM82Dm9njaqNKwJJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhPlFNzHCXgy/TGHXlUuDajBgM11IccEcZ0oZ/Dluvjw3VcquGuj1NMJGQC9o3FHnRB472TiZPqON/yKLTaUiBfXKIMUqueTD0R23DxEhbk2qlnb5yujhnjMQpRcTuzgN6cWdxHxXHmwRePezUQ4UFpdV24HZQF6evfSOz3EQ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C0JN4qQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35398C4CEE9;
	Tue, 11 Mar 2025 15:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741706724;
	bh=BMnQG7icRgdMzV010qzxdFm9djLM82Dm9njaqNKwJJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C0JN4qQ/cbTLCK34XT3uO1r4GXlhO/mg/LbjeQBur7p7Fve6KX+MKLNmFJcsx7jQP
	 zVqNxiCznV7FKkR5V1qJc7luwqqYD3ds4O/0+XGn/q4nN4eIZ9Ozv8h6fUU+DzQb+X
	 jwrd14FGhmVmgp3XbLuBgJxx+Gm+wPTOFgA478vI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Christian Gmeiner <cgmeiner@igalia.com>,
	Brian Cain <bcain@quicinc.com>,
	Brian Cain <brian.cain@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 114/462] hexagon: fix using plain integer as NULL pointer warning in cmpxchg
Date: Tue, 11 Mar 2025 15:56:20 +0100
Message-ID: <20250311145802.867189115@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145758.343076290@linuxfoundation.org>
References: <20250311145758.343076290@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 8a20030038742b9915c6d811a4e6c14b126cafb4 ]

Sparse reports

    net/ipv4/inet_diag.c:1511:17: sparse: sparse: Using plain integer as NULL pointer

Due to this code calling cmpxchg on a non-integer type
struct inet_diag_handler *

    return !cmpxchg((const struct inet_diag_handler**)&inet_diag_table[type],
                    NULL, h) ? 0 : -EEXIST;

While hexagon's cmpxchg assigns an integer value to a variable of this
type.

    __typeof__(*(ptr)) __oldval = 0;

Update this assignment to cast 0 to the correct type.

The original issue is easily reproduced at head with the below block,
and is absent after this change.

    make LLVM=1 ARCH=hexagon defconfig
    make C=1 LLVM=1 ARCH=hexagon net/ipv4/inet_diag.o

Fixes: 99a70aa051d2 ("Hexagon: Add processor and system headers")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411091538.PGSTqUBi-lkp@intel.com/
Signed-off-by: Willem de Bruijn <willemb@google.com>
Tested-by: Christian Gmeiner <cgmeiner@igalia.com>
Link: https://lore.kernel.org/r/20241203221736.282020-1-willemdebruijn.kernel@gmail.com
Signed-off-by: Brian Cain <bcain@quicinc.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/hexagon/include/asm/cmpxchg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/include/asm/cmpxchg.h b/arch/hexagon/include/asm/cmpxchg.h
index 92b8a02e588ac..9c5f07749933e 100644
--- a/arch/hexagon/include/asm/cmpxchg.h
+++ b/arch/hexagon/include/asm/cmpxchg.h
@@ -56,7 +56,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr,
 	__typeof__(ptr) __ptr = (ptr);				\
 	__typeof__(*(ptr)) __old = (old);			\
 	__typeof__(*(ptr)) __new = (new);			\
-	__typeof__(*(ptr)) __oldval = 0;			\
+	__typeof__(*(ptr)) __oldval = (__typeof__(*(ptr))) 0;	\
 								\
 	asm volatile(						\
 		"1:	%0 = memw_locked(%1);\n"		\
-- 
2.39.5




