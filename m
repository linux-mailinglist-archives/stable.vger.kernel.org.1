Return-Path: <stable+bounces-203629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B00CE71A7
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C92E305B1E2
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E4932E696;
	Mon, 29 Dec 2025 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bZOUdurW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA36C32E750
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767018834; cv=none; b=WIoz4Xd/LaTyd0pCUahQ3AIceFR9uEBBAo03y0LmH9KfNFl9Osc0V+T8pRVhDYGpwYo8Z0icVQcyM7P4koUexETsVeCuMCoCZRd8YPR5fm6WCuR6WW2Vs3FPDT9myYXXtTLvzhESehtGjXzElhHoZARajM7tgqE5P5LM+jqAViE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767018834; c=relaxed/simple;
	bh=7oqbuv3GKbiPh202+8F1Ul+6TqrsAbFKYXYhLPRsPRE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NU2KW+rpf3nMoW3LA2rU33Wecw+QS4J7D2whRAFHueeCKGwAQ1VkHwkGBrvd569B5VBl/wQ23IyhtjTKlGHQ3KkhVmRXkjp+WAnikqu7WFj6VHDK3erraECmdMZn++ZVD7YI8p8JQ883ENbCFQN3Ni1vGbHqNHGO24UbgX/5lLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bZOUdurW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC651C19421;
	Mon, 29 Dec 2025 14:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767018834;
	bh=7oqbuv3GKbiPh202+8F1Ul+6TqrsAbFKYXYhLPRsPRE=;
	h=Subject:To:Cc:From:Date:From;
	b=bZOUdurWRSRBudiDD9xJfsz5T4IhM+R5yEjf9QjPET8tCI7RSARLhqxmfG2Ooy64l
	 vQFxy7CKYqsihlwQUyviKgCiy+4vFraJK6BAQvh55mSW7sl0P08NPHwtHMPCKha5Zf
	 ZU8j7awB+QGr4A7co/KTP8GEBsLW8GZCgpYHNLcE=
Subject: FAILED: patch "[PATCH] SUNRPC: svcauth_gss: avoid NULL deref on zero length" failed to apply to 5.10-stable tree
To: linux@joshua.hu,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:33:41 +0100
Message-ID: <2025122941-pupil-strongly-abe3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d4b69a6186b215d2dc1ebcab965ed88e8d41768d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122941-pupil-strongly-abe3@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d4b69a6186b215d2dc1ebcab965ed88e8d41768d Mon Sep 17 00:00:00 2001
From: Joshua Rogers <linux@joshua.hu>
Date: Fri, 7 Nov 2025 10:05:33 -0500
Subject: [PATCH] SUNRPC: svcauth_gss: avoid NULL deref on zero length
 gss_token in gss_read_proxy_verf

A zero length gss_token results in pages == 0 and in_token->pages[0]
is NULL. The code unconditionally evaluates
page_address(in_token->pages[0]) for the initial memcpy, which can
dereference NULL even when the copy length is 0. Guard the first
memcpy so it only runs when length > 0.

Fixes: 5866efa8cbfb ("SUNRPC: Fix svcauth_gss_proxy_init()")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index a8ec30759a18..e2f0df8cdaa6 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1083,7 +1083,8 @@ static int gss_read_proxy_verf(struct svc_rqst *rqstp,
 	}
 
 	length = min_t(unsigned int, inlen, (char *)xdr->end - (char *)xdr->p);
-	memcpy(page_address(in_token->pages[0]), xdr->p, length);
+	if (length)
+		memcpy(page_address(in_token->pages[0]), xdr->p, length);
 	inlen -= length;
 
 	to_offs = length;


