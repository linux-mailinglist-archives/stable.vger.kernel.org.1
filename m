Return-Path: <stable+bounces-31467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1EB8896FE
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 10:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652FF1C309AA
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 09:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D60257659;
	Mon, 25 Mar 2024 02:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="io0T2nMt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E5920AF7B;
	Sun, 24 Mar 2024 23:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321606; cv=none; b=Yq2NGHz5o+JpD4CO2jlhHCNbGmIuV1srd6bZJuvadzpqksMSmstfWO3QIC1FwZ0TWLyTSywY/JExeOL3rFyc4fTAcDnYg5/BKjykyb2RdF3Hkj6WMfnDtXWAJWNK8k7ivqtOsCvr3f/tfG8VqROG12hAl2DXTFwtAPWeDD2lz54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321606; c=relaxed/simple;
	bh=NMB/Dvckd0N0jkQPCy6uceSyX5z8ocUXKOUi3TZ+sNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjIbw2itIJilwHvAVQfC6FJXabd3apOee8d4FrzfzsGKD79a50GP5WRzxoqZRmLDhAibEN1kT0Sor4RTczJzOIxKydy9YFGM/235L/DiQZblBBrR7LBTnAFPFYtz1UXe9d0mOoRxkgAnkGDJ92azu6nLSuidQW3NW8hoPD0iZa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=io0T2nMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEB9C433C7;
	Sun, 24 Mar 2024 23:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321606;
	bh=NMB/Dvckd0N0jkQPCy6uceSyX5z8ocUXKOUi3TZ+sNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=io0T2nMt+6gUMDHoOZ3Ol0R7fxEoY9oUp46UgMtqs4x9Qk5OJbanHoxZMz/axGYc3
	 6wbo7YdslGrU3bMZWDDvX8Dwfl3ceDDXuBn2/FvhWwRIcvo26KBcTP2l4fucak7JM4
	 4pbmTr1yciTVMNcqOHCaSEqQEVw4Iyowdg+w5VXMdK+Mj2lc7/hOFj7h9SPZpT0wa0
	 Q1TSdgqoIX3D1Mm9HqX99Edk12l45kIs272aK1qUl/5kDUk8Vjd5La3g67PYVbT8U8
	 YrIyP+1qRibclrXrzghcYlqcHUByFm1BuSGbGXKwrn+W2zwKa1zMiEkFh57ZXhYcEp
	 6QrJvqaFTYa6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 336/638] udp: fix incorrect parameter validation in the udp_lib_getsockopt() function
Date: Sun, 24 Mar 2024 18:56:13 -0400
Message-ID: <20240324230116.1348576-337-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>

[ Upstream commit 4bb3ba7b74fceec6f558745b25a43c6521cf5506 ]

The 'len' variable can't be negative when assigned the result of
'min_t' because all 'min_t' parameters are cast to unsigned int,
and then the minimum one is chosen.

To fix the logic, check 'len' as read from 'optlen',
where the types of relevant variables are (signed) int.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/udp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 8e5a8b3b22c63..848072793fa98 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2779,11 +2779,11 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-	len = min_t(unsigned int, len, sizeof(int));
-
 	if (len < 0)
 		return -EINVAL;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	switch (optname) {
 	case UDP_CORK:
 		val = udp_test_bit(CORK, sk);
-- 
2.43.0


