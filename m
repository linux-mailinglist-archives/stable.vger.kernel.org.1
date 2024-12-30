Return-Path: <stable+bounces-106428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE67C9FE848
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 16:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2923A2530
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94CD1531C4;
	Mon, 30 Dec 2024 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="INaRp3mG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8702C15E8B;
	Mon, 30 Dec 2024 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735573941; cv=none; b=pgcAdWKTvgLtHrNFvuMS5ggYue0DLwS2cxfq7W2ZjhmAszPbvOflnl1dvpWbF35nlu1/SneGW5B36GJPZcpa2jjFyPK2hzJoLSvPAk+tQQD2VON0Mb0bqn/ykTHr1/+kJVsSMV6A6Vwb06hdA8h9I9rcHd3v/Ykt3fWAX6k7B34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735573941; c=relaxed/simple;
	bh=QKLOsFM5D2MmWj1zsSrA7pRrM075yAP5efEMKQPf+EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljzH+kvXfIqK49tggXDqPOHwNSA/+NkLmvpwqfLAYDBq0C10jaOyjF3jvf7b7cvf/GfCgD9EbctoRfjFRVjzX/09fBvIlSnUgdrvvGHBNBJ4/IUyYMpjjb1BKxoltqMij7iGlIA+IBsdrRtj7U609wp9SXhZyV2kDtsxXNZ8pEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=INaRp3mG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC279C4CED0;
	Mon, 30 Dec 2024 15:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735573941;
	bh=QKLOsFM5D2MmWj1zsSrA7pRrM075yAP5efEMKQPf+EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=INaRp3mGm4XoCZVmuZ7lxwcQ5fbnbPKDmU+vrSjjxKJ80l1OQlel66a7D9WYrRU3o
	 mq0xVL+oSUcRWOanAONY+NeRcpgqZuPBEFfENjgGsU+MnsBQG4i0iiKoeM9iMWVVDX
	 MrJ87Y2QO8zGyIfJD6b0MBsic05/Vhc1qw1tkCaw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 62/86] x86/cpu: Add model number for Intel Clearwater Forest processor
Date: Mon, 30 Dec 2024 16:43:10 +0100
Message-ID: <20241230154214.074872318@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230154211.711515682@linuxfoundation.org>
References: <20241230154211.711515682@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Luck <tony.luck@intel.com>

[ Upstream commit 090e3bec01763e415bccae445f5bfe3d0c61b629 ]

Server product based on the Atom Darkmont core.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240117191844.56180-1-tony.luck@intel.com
Stable-dep-of: c9a4b55431e5 ("x86/cpu: Add Lunar Lake to list of CPUs with a broken MONITOR implementation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 197316121f04..b65e9c46b922 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -162,6 +162,8 @@
 #define INTEL_FAM6_ATOM_CRESTMONT_X	0xAF /* Sierra Forest */
 #define INTEL_FAM6_ATOM_CRESTMONT	0xB6 /* Grand Ridge */
 
+#define INTEL_FAM6_ATOM_DARKMONT_X	0xDD /* Clearwater Forest */
+
 /* Xeon Phi */
 
 #define INTEL_FAM6_XEON_PHI_KNL		0x57 /* Knights Landing */
-- 
2.39.5




