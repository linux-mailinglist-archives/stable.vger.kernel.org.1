Return-Path: <stable+bounces-249976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gXsyKbjKDWqq3QUAu9opvQ
	(envelope-from <stable+bounces-249976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:52:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FBD590325
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1CD233093A64
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39C43ECBF1;
	Wed, 20 May 2026 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NPhH2EJe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7513E95B3
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288154; cv=none; b=Esq7Rejt/BfIE1hAGxErHfE10nXdWGHWzHMeGt9zhf+cuGG/XorxFgENwGzsIZ05fmTZHDR67G3kybN6LTjKcB0DSKV3ShVK6wOo4Tja+z6ln+/NGGv/2cp3rLC4JWb4zUZAAKcoB+ePCPWxUpT5sIa0Fa/CmInoUkdkUfBViKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288154; c=relaxed/simple;
	bh=ldQS7hUXJ6BOPhAIloc+BrOPWn54OV+0IDacgmMVoow=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U64Np0d0VitN/AwfCr72wtAylMXeZ4Wz7Gg5McidPovFC4jdEEy7bYe1gBA3dgX1K7Al5FNlOgXesbNTFEI9GCmSmyRtBGq+39zV3m7pthUErTF50NibapveaEITdUSQtjG7aM7FQRnFuQ99yoMOE21tnzp49r3nbpTACiuFzrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NPhH2EJe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F4A1F000E9;
	Wed, 20 May 2026 14:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779288153;
	bh=ojKgWxTGOwZdduHElwofnZ2cxPWNOIfzF1DS+N0/OPQ=;
	h=Subject:To:Cc:From:Date;
	b=NPhH2EJeoOCyv+xEahE0Y2V5FJmvPftzKQHGABm4FvPLj9g78OwhXNUK0oOsZNlSM
	 +6VSZCu/ANC9tUs/PWKTlBejb3AdY/glMz5BoohYOSFYkOUTC37uNcQlAi4otRY59X
	 4dr1x5sy7YKYUnjToCNGNtNV9KdHw4X+Yjj/wrY8=
Subject: FAILED: patch "[PATCH] xfs: fix memory leak for data allocated by" failed to apply to 7.0-stable tree
To: wilfred.mallawa@wdc.com,cem@kernel.org,djwong@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:42:36 +0200
Message-ID: <2026052036-capped-deluge-ab83@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249976-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lst.de:email]
X-Rspamd-Queue-Id: 93FBD590325
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x af47a4be6a90c8bfc874f9994ac9c15813b9718b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052036-capped-deluge-ab83@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From af47a4be6a90c8bfc874f9994ac9c15813b9718b Mon Sep 17 00:00:00 2001
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Date: Fri, 17 Apr 2026 12:16:30 +1000
Subject: [PATCH] xfs: fix memory leak for data allocated by
 xfs_zone_gc_data_alloc()

In xfs_zone_gc_mount(), on error, a struct xfs_zone_gc_data allocated
with xfs_zone_gc_data_alloc() is freed with kfree(), however, this
doesn't free the underlying folios or the rmap_irecs.

Use xfs_zone_gc_data_free() to correctly free this memory.

Fixes: 080d01c41d44 ("xfs: implement zoned garbage collection")
Cc: stable@vger.kernel.org # v6.15
Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_zone_gc.c b/fs/xfs/xfs_zone_gc.c
index fedcc47048af..c8a1d5c0332c 100644
--- a/fs/xfs/xfs_zone_gc.c
+++ b/fs/xfs/xfs_zone_gc.c
@@ -1221,7 +1221,7 @@ out_put_oz:
 	if (data->oz)
 		xfs_open_zone_put(data->oz);
 out_free_gc_data:
-	kfree(data);
+	xfs_zone_gc_data_free(data);
 	return error;
 }
 


