Return-Path: <stable+bounces-97223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A689E2310
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A77D284D9C
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297211F8AD6;
	Tue,  3 Dec 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WOFIBUBb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4071F8ACD;
	Tue,  3 Dec 2024 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239870; cv=none; b=l+dFnSY3J95fya8C1rSJpnXn1Mk2noTHk8yainbuHpbOEKJEMgU2024DvWcntX4vn/xbkDe8OQm6WhS+Z6K8WqfsrUMCXS47cAAd9l+JlDKriEdEtvaeqkZ1eAeFNTunOV0EyAVE/q0IPZEsQB50TbPt64kPQJT6UcyxG9cTrjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239870; c=relaxed/simple;
	bh=cK3Qj4J/xqHwajjkLpNgeBF4eq0IDxGpFiCSBeQoIOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCSn7FigjBiGgLTlJTRZffin8O6wrr5aLIeN7x+lYAqNXPsb6BzEdyUtqGrlseDnHrpLNg1tGOPX7AM4t/LtriXhfZyqK5rmpary8I4BAotaKXMdET7jm9qWTvVaRLqCtP5aKhG/bY6F7yIaVK4dqvIB78gKRcnjPDv1bQDqN+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WOFIBUBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26147C4CEDF;
	Tue,  3 Dec 2024 15:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239870;
	bh=cK3Qj4J/xqHwajjkLpNgeBF4eq0IDxGpFiCSBeQoIOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOFIBUBb9lc0B+SpD+2ZMhrGLkazxSiKh9YXK4qTqmQhRqiFNii6MGqQRLVX5qncN
	 qPn1VVBwgkq4akwwT+ixM+x938VfXx8ybZDccVYTl3kh+uUw8D+9M/XEg1TnIkAddd
	 gQJwz6JF6Cp08dsp19gViu6t7i6zgwfN0izU3M5k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.11 763/817] NFSD: Prevent a potential integer overflow
Date: Tue,  3 Dec 2024 15:45:35 +0100
Message-ID: <20241203144025.778824593@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

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



