Return-Path: <stable+bounces-91422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18C49BEDE9
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C3CEB23728
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D3E1F4FCC;
	Wed,  6 Nov 2024 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xR2gQBuR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A671E1C38;
	Wed,  6 Nov 2024 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898689; cv=none; b=QSVOpf2Mz/rAaxYGJ9ZezU3uXugZqAq+3bn07oEiKGRAw+fot/pcOBt9AQ6XH+7xeCmNwoCgco0DmeA1RqoErmaZotrNOtlFXDzJ622fv5zv4tzG8+TMJsjA9TsULWzQhUTTDR05G0M6oiMLCTe9f1Ux2JL947tAe9p1lOOnWxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898689; c=relaxed/simple;
	bh=R4GI0U3gCt6bRb74RQjUQ3nok4gGobx2Bfr7ykpS3Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4waYOAkubyzXOfNsDgjbSYXglrmBCL4g4quc2UkFITyXmcaB6Eh/zDFZjz82AAtqJFazcSGAhB7lU0mVCiHqtSp64lILK1+FLV1DnoAf84TLnJzF4+pTJA0/u5/or4CfJCBbzZsweW/kPGr3WNgQZQczB04jpWDl+l/4eu3k0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xR2gQBuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFBAC4CECD;
	Wed,  6 Nov 2024 13:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898689;
	bh=R4GI0U3gCt6bRb74RQjUQ3nok4gGobx2Bfr7ykpS3Is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xR2gQBuR+jgp/n0azL0f8fWBqfwkN07H3yptcErD901D6paTVPB5iGM1NluSmlerl
	 zjoEAYFr+OqUMqTTQXuJpUp0yclWM+jp6OBaHMjxtoqinzsO8B+0G3tCy9AdgCDSUe
	 D4JnDxHoUAdc4Ul7ATqh5n+WK3V0ifmAXGIOecK8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 323/462] SUNRPC: Fix integer overflow in decode_rc_list()
Date: Wed,  6 Nov 2024 13:03:36 +0100
Message-ID: <20241106120339.507244355@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 6dbf1f341b6b35bcc20ff95b6b315e509f6c5369 ]

The math in "rc_list->rcl_nrefcalls * 2 * sizeof(uint32_t)" could have an
integer overflow.  Add bounds checking on rc_list->rcl_nrefcalls to fix
that.

Fixes: 4aece6a19cf7 ("nfs41: cb_sequence xdr implementation")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/callback_xdr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 04d27f0ed39ac..1b860995e6bcf 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -372,6 +372,8 @@ static __be32 decode_rc_list(struct xdr_stream *xdr,
 
 	rc_list->rcl_nrefcalls = ntohl(*p++);
 	if (rc_list->rcl_nrefcalls) {
+		if (unlikely(rc_list->rcl_nrefcalls > xdr->buf->len))
+			goto out;
 		p = xdr_inline_decode(xdr,
 			     rc_list->rcl_nrefcalls * 2 * sizeof(uint32_t));
 		if (unlikely(p == NULL))
-- 
2.43.0




