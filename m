Return-Path: <stable+bounces-54053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D2A90EC70
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC9F1C208D4
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAE51459E3;
	Wed, 19 Jun 2024 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C0wcEuIN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2926B143C58;
	Wed, 19 Jun 2024 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802453; cv=none; b=bLjc/SRkTXfRIWUMfebGy+T/4GdmDvuc8v028upOpxkJRcQeN6BgB/1TjzWFlbbDoFKqI4DENb765ADz21zqdkt4pfpaAHF4DpcrenuMKkR82w/82LZNUE36bBuUHKyLO71ieUX1j/s01kd6JD28SjmlkPYn7xsUEFvvMEvggO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802453; c=relaxed/simple;
	bh=AJpVwQGLq3ur/1dPlLeY9PXbh0xR60MfL2AY5jjygAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6KdVEJswmtZx63Tjg6SuAfexwubXvSY3pp1UTBf3OLQWg8+FuZ5rB/5qNCHEAWt6n/AMWBnwsk4UlNaX7Jj8SILLdXkuJzZyYdf0KfFcIpMHNeNhqo/N35VBR26I3XiB3HZacOdB8AuLN79teLCZP2s2UglzcldOCXRpFqobUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C0wcEuIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1925C2BBFC;
	Wed, 19 Jun 2024 13:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718802453;
	bh=AJpVwQGLq3ur/1dPlLeY9PXbh0xR60MfL2AY5jjygAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C0wcEuIN56vV4rwIZcbBPJsRZ0nG/r9THPnS17GlZoIysoXxEjdS9XPrP277LWTen
	 yuZXTEzvKAR5JzA643TiwLGBTUZGVBz/OHEZrTu8Dr3zvo9AvQNkLiOcI1rcEu+zXA
	 kdFoF2IDK26dl01vbFFGuj8wWYWzZNA8wEBli2SA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.6 202/267] knfsd: LOOKUP can return an illegal error value
Date: Wed, 19 Jun 2024 14:55:53 +0200
Message-ID: <20240619125614.084585255@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125606.345939659@linuxfoundation.org>
References: <20240619125606.345939659@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit e221c45da3770962418fb30c27d941bbc70d595a upstream.

The 'NFS error' NFSERR_OPNOTSUPP is not described by any of the official
NFS related RFCs, but appears to have snuck into some older .x files for
NFSv2.
Either way, it is not in RFC1094, RFC1813 or any of the NFSv4 RFCs, so
should not be returned by the knfsd server, and particularly not by the
"LOOKUP" operation.

Instead, let's return NFSERR_STALE, which is more appropriate if the
filesystem encodes the filehandle as FILEID_INVALID.

Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfsfh.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -572,7 +572,7 @@ fh_compose(struct svc_fh *fhp, struct sv
 		_fh_update(fhp, exp, dentry);
 	if (fhp->fh_handle.fh_fileid_type == FILEID_INVALID) {
 		fh_put(fhp);
-		return nfserr_opnotsupp;
+		return nfserr_stale;
 	}
 
 	return 0;
@@ -598,7 +598,7 @@ fh_update(struct svc_fh *fhp)
 
 	_fh_update(fhp, fhp->fh_export, dentry);
 	if (fhp->fh_handle.fh_fileid_type == FILEID_INVALID)
-		return nfserr_opnotsupp;
+		return nfserr_stale;
 	return 0;
 out_bad:
 	printk(KERN_ERR "fh_update: fh not verified!\n");



