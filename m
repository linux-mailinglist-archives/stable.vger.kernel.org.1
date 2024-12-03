Return-Path: <stable+bounces-98060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC8A9E26D3
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1600288D9B
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612351EE00B;
	Tue,  3 Dec 2024 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vhoi7CMs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2050A1F7567;
	Tue,  3 Dec 2024 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242660; cv=none; b=dxP45DwgzPlqikTfcBXrhc34vzfWE5hIa83lqQsRxzrtt01kM+Mc/v+IHgNxe1mfyadszAgWOTlz8frSgh75TKuzOBmdv7rDM6EiFy+pSXOdzUQ8NHE3qQm6HrtK0bsPQgjpJl9d/yOyR4Yo3vXKld+rqIrnIfP5L/fEzW5bUUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242660; c=relaxed/simple;
	bh=BHFUG6v3E60hHsetNtGFNTRoHnjPKDn7ymeXT4ocbj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOGDgWFKdV+7N2sT4H+SGwI5xljmYmePUZgzbQiZcN3u55OvTvUKVZYofEWQSZlS1wtKeMCWrPx32M2vrPUvGmKkZGb2Py0WVMOJjagerYwPNxP31blbI7U74OHDcgMbX37PPl4FzuzsfGNQUf/vwwq79oxesQTRMRIjpAXvB/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vhoi7CMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3FCC4CECF;
	Tue,  3 Dec 2024 16:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733242660;
	bh=BHFUG6v3E60hHsetNtGFNTRoHnjPKDn7ymeXT4ocbj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vhoi7CMs2zBNxme0pZk9GlGAMVRkWMTTF96Sy0Q3iDCSMouTifV2slGVZsXJv26Ua
	 O4NINOJbboDv1u07838zf31yhgrnqVeR1mZvBiPkXXtNNW/op9p1KMCraRIdZGvGJJ
	 GpHlAwHIWf8sbJxxEXLlZ1pOVdmNz1cPVotJCgMQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.12 770/826] NFSD: Prevent a potential integer overflow
Date: Tue,  3 Dec 2024 15:48:17 +0100
Message-ID: <20241203144813.800618131@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

commit 7f33b92e5b18e904a481e6e208486da43e4dc841 upstream.

If the tag length is >= U32_MAX - 3 then the "length + 4" addition
can result in an integer overflow. Address this by splitting the
decoding into several steps so that decode_cb_compound4res() does
not have to perform arithmetic on the unsafe length value.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4callback.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -287,17 +287,17 @@ static int decode_cb_compound4res(struct
 	u32 length;
 	__be32 *p;
 
-	p = xdr_inline_decode(xdr, 4 + 4);
+	p = xdr_inline_decode(xdr, XDR_UNIT);
 	if (unlikely(p == NULL))
 		goto out_overflow;
-	hdr->status = be32_to_cpup(p++);
+	hdr->status = be32_to_cpup(p);
 	/* Ignore the tag */
-	length = be32_to_cpup(p++);
-	p = xdr_inline_decode(xdr, length + 4);
-	if (unlikely(p == NULL))
+	if (xdr_stream_decode_u32(xdr, &length) < 0)
+		goto out_overflow;
+	if (xdr_inline_decode(xdr, length) == NULL)
+		goto out_overflow;
+	if (xdr_stream_decode_u32(xdr, &hdr->nops) < 0)
 		goto out_overflow;
-	p += XDR_QUADLEN(length);
-	hdr->nops = be32_to_cpup(p);
 	return 0;
 out_overflow:
 	return -EIO;



