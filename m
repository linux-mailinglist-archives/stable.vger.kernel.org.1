Return-Path: <stable+bounces-203628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D7DCE719E
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1ED3304EDA0
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC3732E6A7;
	Mon, 29 Dec 2025 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vJ9nN91p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19D332340D
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767018831; cv=none; b=j0RpdfL+G3tsOmRR4vQrPuIvMc1g11ueExDf+oFamMea/atpt/E3HuxZU3TJZODTcuKJlNSueKpzVkMj9xAnAh667H6yhmKKOyCUa1CRHLxzN+0Pj45AAffXe0C4fLToR/+OxsELGvjVwIZo+KVspD2ARvDyEsMNQ7CThxsQf3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767018831; c=relaxed/simple;
	bh=17tkCsAht0prqP+wOM+Iq81+Mk+i+VngUItHA8YQaL0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KcbwGlq3v3KNzd/RoIzhRhLENA8nkCw0HtmN80pXErT0FZX2qfEEd+N9yMprp0n/SlfBvP1vCOc/vNRuoxfYHv212dtkP9v5ZzjJ8kb21RouCbNhbRLWg8ommiSGsNE4nuvLJR7cKVJ2lhXlJ2IiECnt9C56oS6jOHHsqBFTr3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vJ9nN91p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18716C4CEF7;
	Mon, 29 Dec 2025 14:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767018831;
	bh=17tkCsAht0prqP+wOM+Iq81+Mk+i+VngUItHA8YQaL0=;
	h=Subject:To:Cc:From:Date:From;
	b=vJ9nN91pNo75yTeFmb/YSVQ5jr1syOawMTbFOfGibn8TGwC32ApGXOetB2PnWaKQ1
	 odTUhloJ6eKN0KpcerjEM2UT3CxFd2H8R0wLnAwdvxydfT5rJZqj7iuVi2cw0ZGn+J
	 2nWPBCYjDDO3krbK4BQ7gvoodhtSn/5kngxkfxng=
Subject: FAILED: patch "[PATCH] SUNRPC: svcauth_gss: avoid NULL deref on zero length" failed to apply to 5.15-stable tree
To: linux@joshua.hu,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:33:40 +0100
Message-ID: <2025122940-illusion-nervy-c582@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d4b69a6186b215d2dc1ebcab965ed88e8d41768d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122940-illusion-nervy-c582@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


