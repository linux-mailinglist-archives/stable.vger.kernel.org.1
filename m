Return-Path: <stable+bounces-93207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F429CD7EC
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2232B25B56
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4921339A4;
	Fri, 15 Nov 2024 06:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mTEPHJox"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2924C2BB1B;
	Fri, 15 Nov 2024 06:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653148; cv=none; b=pSCTQjRH4HSmmANP8u4dOSB9m6oUdFOPOw5sQuzLMS1pEbE8q9nu4Ia1f7YbUD2OYoxSO/Qk1PcQjqVZhdWinBgQE94WtW2XZ8J346gH+493G+mtKDcjKdUqFsXbgCd8WfODleT5n6r9eGWUBIUkUh02yTTSHfPL5ZY9Dm4C2BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653148; c=relaxed/simple;
	bh=05JF2L+H7h1bWhDldl7ls6lOT+iUSmTvNLSEEnN51t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8ZNDj+Kiot5UFmupBBWCLWZotHvomZCWjfP0x5hv3d/+fmE/6KoSBvkJt/eqLq/rccr7/SIclOckZjW6jxDCXpUffRFK7d2JZbTLezu8LW5IW+sSmg6LJMcLWxKX11QHnSKgf0CI4JxwupquxKmuK2aCED3DItWn85FEnvHW0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mTEPHJox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84889C4CED0;
	Fri, 15 Nov 2024 06:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653148;
	bh=05JF2L+H7h1bWhDldl7ls6lOT+iUSmTvNLSEEnN51t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mTEPHJoxN7vKy1caikBIFpxq0DjB7X9hPHHCuLDWmgK232Rxm5HHh6dm8ju5f6+CT
	 kgoMifgBbP3u39MfTxIXndsfGSz4evocUuTedF0YeSrBDy/r8qtC4eyiKkQKOgEcBC
	 pxioXqyD3xaJYPxtHpsDJURr8Mc3KOsd3bwZ8U6o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cedric Blancher <cedric.blancher@gmail.com>,
	Dan Shelton <dan.f.shelton@gmail.com>,
	Roland Mainz <roland.mainz@nrubsig.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.4 49/66] NFSD: Fix NFSv4s PUTPUBFH operation
Date: Fri, 15 Nov 2024 07:37:58 +0100
Message-ID: <20241115063724.611663186@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063722.834793938@linuxfoundation.org>
References: <20241115063722.834793938@linuxfoundation.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

commit 202f39039a11402dcbcd5fece8d9fa6be83f49ae upstream.

According to RFC 8881, all minor versions of NFSv4 support PUTPUBFH.

Replace the XDR decoder for PUTPUBFH with a "noop" since we no
longer want the minorversion check, and PUTPUBFH has no arguments to
decode. (Ideally nfsd4_decode_noop should really be called
nfsd4_decode_void).

PUTPUBFH should now behave just like PUTROOTFH.

Reported-by: Cedric Blancher <cedric.blancher@gmail.com>
Fixes: e1a90ebd8b23 ("NFSD: Combine decode operations for v4 and v4.1")
Cc: Dan Shelton <dan.f.shelton@gmail.com>
Cc: Roland Mainz <roland.mainz@nrubsig.org>
Cc: stable@vger.kernel.org
[ cel: adjusted to apply to origin/linux-5.4.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4xdr.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1069,14 +1069,6 @@ nfsd4_decode_putfh(struct nfsd4_compound
 }
 
 static __be32
-nfsd4_decode_putpubfh(struct nfsd4_compoundargs *argp, void *p)
-{
-	if (argp->minorversion == 0)
-		return nfs_ok;
-	return nfserr_notsupp;
-}
-
-static __be32
 nfsd4_decode_read(struct nfsd4_compoundargs *argp, struct nfsd4_read *read)
 {
 	DECODE_HEAD;
@@ -1825,7 +1817,7 @@ static const nfsd4_dec nfsd4_dec_ops[] =
 	[OP_OPEN_CONFIRM]	= (nfsd4_dec)nfsd4_decode_open_confirm,
 	[OP_OPEN_DOWNGRADE]	= (nfsd4_dec)nfsd4_decode_open_downgrade,
 	[OP_PUTFH]		= (nfsd4_dec)nfsd4_decode_putfh,
-	[OP_PUTPUBFH]		= (nfsd4_dec)nfsd4_decode_putpubfh,
+	[OP_PUTPUBFH]		= (nfsd4_dec)nfsd4_decode_noop,
 	[OP_PUTROOTFH]		= (nfsd4_dec)nfsd4_decode_noop,
 	[OP_READ]		= (nfsd4_dec)nfsd4_decode_read,
 	[OP_READDIR]		= (nfsd4_dec)nfsd4_decode_readdir,



