Return-Path: <stable+bounces-34408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D3B893F3A
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3381F221BC
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854A147A53;
	Mon,  1 Apr 2024 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iCVdTslQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43824446AC;
	Mon,  1 Apr 2024 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988020; cv=none; b=FEsNg9r+4BC5CNc3mXJGjcrc/+4mc743fOAcZsiUtkUM4Ay31BJFVxr9J11oigxHiOYdMmbdlcci2Atl6XuYKhL1gh9W721Qx7QD44E0BL2I1XCGPVObUZhKc6zwYEkmLLATbhCbY23zLWHqXFNpJk1k6tIG8Nb8TQPrmXZ+KUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988020; c=relaxed/simple;
	bh=NXgVcXnajk9Zzg3fVrxW3pz0ecdr5hZZwgmPz+TZ+JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UB0hVfuAU3n2ID4zu7kwNoybA7kOzpcd0aPl0QolyQpOwQ18KssEJSDSki83CRNRnfa85bJ+bcBe7ncypEKUJWtHUh6INUTBlWjUIOTso8sujlP8XvktJCM02V/gp7ImtJUUvlrgnDGqTMtYqdAhBwOsLI+MPoDgmifER6snQjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iCVdTslQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA333C43390;
	Mon,  1 Apr 2024 16:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711988020;
	bh=NXgVcXnajk9Zzg3fVrxW3pz0ecdr5hZZwgmPz+TZ+JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iCVdTslQOD9Yieo1AbL7WajUVpdC7RmG2nZkqYyjNIJ/8gNN832MmWvIxZZ3Dec2s
	 96Js/8JH0F5HfFu4bFr9ne2IyGTiw5M9NTBL/4e3Azf77wWIZ9tvzKr8KoD7flPATO
	 PdzAAilnsnNSUNi7Nu+XFZNZUF2OLZK8qP/BYkIc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 060/432] parisc: Fix csum_ipv6_magic on 64-bit systems
Date: Mon,  1 Apr 2024 17:40:47 +0200
Message-ID: <20240401152554.917267567@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 4b75b12d70506e31fc02356bbca60f8d5ca012d0 ]

hppa 64-bit systems calculates the IPv6 checksum using 64-bit add
operations. The last add folds protocol and length fields into the 64-bit
result. While unlikely, this operation can overflow. The overflow can be
triggered with a code sequence such as the following.

	/* try to trigger massive overflows */
	memset(tmp_buf, 0xff, sizeof(struct in6_addr));
	csum_result = csum_ipv6_magic((struct in6_addr *)tmp_buf,
				      (struct in6_addr *)tmp_buf,
				      0xffff, 0xff, 0xffffffff);

Fix the problem by adding any overflows from the final add operation into
the calculated checksum. Fortunately, we can do this without additional
cost by replacing the add operation used to fold the checksum into 32 bit
with "add,dc" to add in the missing carry.

Cc: Palmer Dabbelt <palmer@rivosinc.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/include/asm/checksum.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
index e619e67440db9..c949aa20fa162 100644
--- a/arch/parisc/include/asm/checksum.h
+++ b/arch/parisc/include/asm/checksum.h
@@ -137,8 +137,8 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 "	add,dc		%3, %0, %0\n"  /* fold in proto+len | carry bit */
 "	extrd,u		%0, 31, 32, %4\n"/* copy upper half down */
 "	depdi		0, 31, 32, %0\n"/* clear upper half */
-"	add		%4, %0, %0\n"	/* fold into 32-bits */
-"	addc		0, %0, %0\n"	/* add carry */
+"	add,dc		%4, %0, %0\n"	/* fold into 32-bits, plus carry */
+"	addc		0, %0, %0\n"	/* add final carry */
 
 #else
 
-- 
2.43.0




