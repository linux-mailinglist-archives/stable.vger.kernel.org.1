Return-Path: <stable+bounces-199867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D40DCA0782
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 18:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EA4D3077CE8
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06014306481;
	Wed,  3 Dec 2025 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CJx/7+PR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8ED398FBF;
	Wed,  3 Dec 2025 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764781197; cv=none; b=Q5dJUdtG7eqnXqZZjv9faeamhzsyCGoeB3I2E2Vp4Fx0vr6OYGJm7JB3+q0erUmnOE09xv82J+jEpgLXsqZ9nzPf7RfI1HHDNRmr69J7Kj79/MYyuO4WNCtVRTTh2l5fxnpp8kTZXNFfH/1E6FDVv9JGCGV0E8Ajy9C6SuO9OeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764781197; c=relaxed/simple;
	bh=wE/X5OQsDETPcZzsCX+MFihld6/uLOA3rSMu4zu0QuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtYOx/a32fSW1ezX1amChDSxDO0S/2pylcyzEkjGPAG6Guaczla7gfOO3U63g0Pwp5I0eMMPECbYBXrzMuMCLuG3QKCKLMOMk08V3NeGzPoWyFiHSTF56tKLNRirOxxwgpn+YMmCbZzo6kUTWoXoJa3ZWxZl5gWkFQ1jvWqaE0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CJx/7+PR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B74BC116C6;
	Wed,  3 Dec 2025 16:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764781196;
	bh=wE/X5OQsDETPcZzsCX+MFihld6/uLOA3rSMu4zu0QuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CJx/7+PRJej04lRSUgcWVWp/sUC9er53TEZTO29NTRtTnHBfnJg5weUc4IXko5S9s
	 I20nzB9qGAn/7PhCSv//MmU8KOscwjyzwPKq83IS+yOFwjfDckzxLCx8e4Cc2PibrP
	 eCWSLrAXviKDXkaoPCZ4DoX4ciUY5/3wxneAmP7Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neil@brown.name>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.6 80/93] nfsd: Replace clamp_t in nfsd4_get_drc_mem()
Date: Wed,  3 Dec 2025 16:30:13 +0100
Message-ID: <20251203152339.481450029@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152336.494201426@linuxfoundation.org>
References: <20251203152336.494201426@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: NeilBrown <neil@brown.name>

A recent change to clamp_t() in 6.1.y caused fs/nfsd/nfs4state.c to fail
to compile with gcc-9. The code in nfsd4_get_drc_mem() was written with
the assumption that when "max < min",

   clamp(val, min, max)

would return max.  This assumption is not documented as an API promise
and the change caused a compile failure if it could be statically
determined that "max < min".

The relevant code was no longer present upstream when commit 1519fbc8832b
("minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()")
landed there, so there is no upstream change to nfsd4_get_drc_mem() to
backport.

There is no clear case that the existing code in nfsd4_get_drc_mem()
is functioning incorrectly. The goal of this patch is to permit the clean
application of commit 1519fbc8832b ("minmax.h: use BUILD_BUG_ON_MSG() for
the lo < hi test in clamp()"), and any commits that depend on it, to LTS
kernels without affecting the ability to compile those kernels. This is
done by open-coding the __clamp() macro sans the built-in type checking.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220745#c0
Signed-off-by: NeilBrown <neil@brown.name>
Stable-dep-of: 1519fbc8832b ("minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed_by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Changes since Neil's post:
* Editorial changes to the commit message
* Attempt to address David's review comments
* Applied to linux-6.12.y, passed NFSD upstream CI suite

This patch is intended to be applied to linux-6.12.y, and should
apply cleanly to other LTS kernels since nfsd4_get_drc_mem hasn't
changed since v5.4.

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1820,8 +1820,10 @@ static u32 nfsd4_get_drc_mem(struct nfsd
 	 */
 	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
 
-	avail = clamp_t(unsigned long, avail, slotsize,
-			total_avail/scale_factor);
+	if (avail > total_avail / scale_factor)
+		avail = total_avail / scale_factor;
+	else if (avail < slotsize)
+		avail = slotsize;
 	num = min_t(int, num, avail / slotsize);
 	num = max_t(int, num, 1);
 	nfsd_drc_mem_used += num * slotsize;



