Return-Path: <stable+bounces-126357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18046A70048
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA8617B73B
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DD2269AE8;
	Tue, 25 Mar 2025 12:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hbGNTIG0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2691A25BAA9;
	Tue, 25 Mar 2025 12:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906074; cv=none; b=SEfMsA3d1ss9iN+WzUVLsYumHHU89/+EEgkjZxTkmsMMMEO1QPh9g3vaoX3MU4zk18wXG1T1+sqUXLN8KYaAzzpk/5eEi0GNeEoIqTra8Sv3r9WKq5qoZltPlL3lrUUGPeDmZY093LmT4VMsb6kBSd1XzE1fhPWtbO2I7CZ2MAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906074; c=relaxed/simple;
	bh=DfOt0ThPWhGUoaenkfWu08FIugDwcOwvC3R1Jn4edFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7tF4+yJDrbMbOatiD5rgN9ClhkjqRZZaVGbgv6e9mZ+yGUx6dHkg7Efd8rwRPa4OqGDGebHYtCpn84klKeSgmwcdUmeaqqIg+ST/Jq2QeAVcrkPsPog79n6OZd36De1tGBOE1YRiQcJabKtDEJCOfaHE7jYXLi1lFCTCkPNjQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hbGNTIG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEA6C4CEE4;
	Tue, 25 Mar 2025 12:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742906074;
	bh=DfOt0ThPWhGUoaenkfWu08FIugDwcOwvC3R1Jn4edFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbGNTIG0SShk3YZb34ZaSICLDS7r68NQht3LQbAYMVbOuDMrzINxPaOY61k378SaD
	 RmtovaU9fgqRgaD+V8MRrVWkz3zBn4Yy9A7iJRxHqZMh+WjVGDXNnfUvX+G3dLjBDV
	 LJ8NNIoL3pQyaGW1D95Z8FrSebfR6n5HR6KRxsZ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.13 090/119] xsk: fix an integer overflow in xp_create_and_assign_umem()
Date: Tue, 25 Mar 2025 08:22:28 -0400
Message-ID: <20250325122151.359352650@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122149.058346343@linuxfoundation.org>
References: <20250325122149.058346343@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>

commit 559847f56769037e5b2e0474d3dbff985b98083d upstream.

Since the i and pool->chunk_size variables are of type 'u32',
their product can wrap around and then be cast to 'u64'.
This can lead to two different XDP buffers pointing to the same
memory area.

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with SVACE.

Fixes: 94033cd8e73b ("xsk: Optimize for aligned case")
Cc: stable@vger.kernel.org
Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
Link: https://patch.msgid.link/20250313085007.3116044-1-Ilia.Gavrilov@infotecs.ru
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xdp/xsk_buff_pool.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -105,7 +105,7 @@ struct xsk_buff_pool *xp_create_and_assi
 		if (pool->unaligned)
 			pool->free_heads[i] = xskb;
 		else
-			xp_init_xskb_addr(xskb, pool, i * pool->chunk_size);
+			xp_init_xskb_addr(xskb, pool, (u64)i * pool->chunk_size);
 	}
 
 	return pool;



