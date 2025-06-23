Return-Path: <stable+bounces-155415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60673AE4202
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5047816F7DA
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1F6219E0;
	Mon, 23 Jun 2025 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H+CaIxKj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D861F1522;
	Mon, 23 Jun 2025 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684366; cv=none; b=VXTtutO486WbfYoEIQYIS0GUUHI4aOgrzH+n8t51M8F8tqYMLrH4SzilRGBXC3Zud9FP2x8Hu2OQBxFy+shzFd8wCPjCigQtM/Hzu90X2gMQeW+zhhoP3C/itqqcdEJwP/usjYv441EMZ18fAq1cxo1dUkLNVksebjulBo28pEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684366; c=relaxed/simple;
	bh=chxyeNToPJgGcAlga+RztedwYjSAPpMTpUTjICTQtSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFli4rGZiyfl45QSVRxof/sHqg1zbO3eJDLV2prZG+POi7OpOVueU1nF/JS2obbNFHiXk5sVpWGyJQEE2+50MZFEg+1rf4A9NkdrYHhlFxLzEy5AHHSJAAdcQv+Op0hh4LbbOGhPSdfbBV83zKXszZA/nTcaCLNfR/JSmhwh4pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H+CaIxKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E67C4CEF0;
	Mon, 23 Jun 2025 13:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750684366;
	bh=chxyeNToPJgGcAlga+RztedwYjSAPpMTpUTjICTQtSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H+CaIxKjyVqBnv/N9a8UTPapvAajFBSwQ3+/gxCOtMY0zD4CR7hVr5blwTZ3fDq19
	 +ujCJWy4NrsAea+Atx6IAgdWhqtR4u9BanpdLgkL0wjHU5fvC6VyS0lPeG9MhsUgjC
	 S0FfYYboqeMv/BQqdpfLkA+CwkNqnNC5QmKODvjU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Olga Kornievskaia <okorniev@redhat.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.15 042/592] nfsd: fix access checking for NLM under XPRTSEC policies
Date: Mon, 23 Jun 2025 15:00:00 +0200
Message-ID: <20250623130701.245355858@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Olga Kornievskaia <okorniev@redhat.com>

commit 0813c5f01249dbc32ccbc68d27a24fde5bf2901c upstream.

When an export policy with xprtsec policy is set with "tls"
and/or "mtls", but an NFS client is doing a v3 xprtsec=tls
mount, then NLM locking calls fail with an error because
there is currently no support for NLM with TLS.

Until such support is added, allow NLM calls under TLS-secured
policy.

Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
Cc: stable@vger.kernel.org
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/export.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1124,7 +1124,8 @@ __be32 check_nfsd_access(struct svc_expo
 		    test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
 			goto ok;
 	}
-	goto denied;
+	if (!may_bypass_gss)
+		goto denied;
 
 ok:
 	/* legacy gss-only clients are always OK: */



