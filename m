Return-Path: <stable+bounces-69009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6975953503
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B725286EBD
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C58F1A2570;
	Thu, 15 Aug 2024 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pizz7J60"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6FD1A0733;
	Thu, 15 Aug 2024 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732373; cv=none; b=Y+9SI83C5pt6LUCXGUiHtPTY23ezYFz1R0+PMm9IdP6Mdjw5kKkTPKVfaeRnri036x2Br3xAzKoehaq6DhX1wcD0QDWAPZb9aWtHfqDNVcihTLwt3l2yv+tr7qEqvmeu/GaDuXOCtvbrODU5WbYOVOhy+X7wqPErLZ0ruj70zK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732373; c=relaxed/simple;
	bh=DXtV6wtaYHwXcJJYsQXEKUxMcFpP+jNYCVkI8RIxOBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hd6kU7/ruEyuAQVwsHUpj5C56jQfd12sWsgPmxlh3ehV8ZgrAabhXQjiiBSU6OZhUjKo5NYgM32lBGKGQozHuRj/xg7CcTKyGHUHfvhcOArjNfa/GVysBkO9Thy88gvWxE0IPol/T5neaxKQ7zig+ND3Uvswy43ypqmE83K2Sis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pizz7J60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA2EC4AF0C;
	Thu, 15 Aug 2024 14:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723732373;
	bh=DXtV6wtaYHwXcJJYsQXEKUxMcFpP+jNYCVkI8RIxOBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pizz7J60W4MzDcNeE9eEgh68jYqj94gtMMcUpDB1PiUTGtWwxsMHWQwJZU9cQNEV6
	 fzMjwIfvu/cTZsaBQvXlwkv8Z+h8G1ZJBEG6eTKKyRdjlkeaxyxobaJo962tDe3NqP
	 TPdEPdIvKGI0ZottpyfdIoqXx/GW7VNX2aZzI2dQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ross Lagerwall <ross.lagerwall@citrix.com>,
	Alain Knaff <alain@knaff.lu>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10 160/352] decompress_bunzip2: fix rare decompression failure
Date: Thu, 15 Aug 2024 15:23:46 +0200
Message-ID: <20240815131925.453438041@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ross Lagerwall <ross.lagerwall@citrix.com>

commit bf6acd5d16057d7accbbb1bf7dc6d8c56eeb4ecc upstream.

The decompression code parses a huffman tree and counts the number of
symbols for a given bit length.  In rare cases, there may be >= 256
symbols with a given bit length, causing the unsigned char to overflow.
This causes a decompression failure later when the code tries and fails to
find the bit length for a given symbol.

Since the maximum number of symbols is 258, use unsigned short instead.

Link: https://lkml.kernel.org/r/20240717162016.1514077-1-ross.lagerwall@citrix.com
Fixes: bc22c17e12c1 ("bzip2/lzma: library support for gzip, bzip2 and lzma decompression")
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: Alain Knaff <alain@knaff.lu>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/decompress_bunzip2.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/lib/decompress_bunzip2.c
+++ b/lib/decompress_bunzip2.c
@@ -232,7 +232,8 @@ static int INIT get_next_block(struct bu
 	   RUNB) */
 	symCount = symTotal+2;
 	for (j = 0; j < groupCount; j++) {
-		unsigned char length[MAX_SYMBOLS], temp[MAX_HUFCODE_BITS+1];
+		unsigned char length[MAX_SYMBOLS];
+		unsigned short temp[MAX_HUFCODE_BITS+1];
 		int	minLen,	maxLen, pp;
 		/* Read Huffman code lengths for each symbol.  They're
 		   stored in a way similar to mtf; record a starting



