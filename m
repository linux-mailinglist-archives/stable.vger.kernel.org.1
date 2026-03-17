Return-Path: <stable+bounces-226453-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJV4B0uMuWnkJwIAu9opvQ
	(envelope-from <stable+bounces-226453-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:15:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CA22AF360
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EDD53025135
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2C33F660C;
	Tue, 17 Mar 2026 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W8ck1wMr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717F83F65E9;
	Tue, 17 Mar 2026 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766778; cv=none; b=PAnXNDc0RJW8kgk6++vqMcAOpldLmXlI7xqr1GkapYJF5ToO9ZXfjjFY+WlT8YZVe7brt9BurH7eFT9XzCWhItO21I4A8dBspiGAugJ/9OyrHeNJCIEWFkbjlSUNSd2edIh0Tg67b778qLXSAipL++oJyp/jqKqJ1Mqke0IkgkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766778; c=relaxed/simple;
	bh=L8sKnOUp5cVa+F20aSfF+a3eQEcUVwgRsOFo5xNDkVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+iWg6IVFB78/u3d91nwWltqJrrKrJHUIY50hYTme+4K8yg1yUJwpbegN624Xt00Y4yiE0w8c8LrU46ANGPJXoYlT5XQjh+8MgETaf96KSoghaq+vTFAjrTboBMbLDj5ki52L5xHOOgzBrOvgz77vHNaBUo+gYb4BySQ6zormy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W8ck1wMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC61AC4CEF7;
	Tue, 17 Mar 2026 16:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766778;
	bh=L8sKnOUp5cVa+F20aSfF+a3eQEcUVwgRsOFo5xNDkVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W8ck1wMrMrASO3tKR4ymWJi3sRFqoVelhP+AXWnGaaztq9on+hiEV4XzeagxVEkd0
	 5rIXYWkhqHycyXgg3PcJq+SNPp6teoY9Qo/cDMlGuyqiwtPIPbjL2qY2jbfmUtHwT+
	 NlRM+GbdY4aJ2IYtp4EUqLAY+uKEBiJ3kXKajMQ0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Carlos Maiolino <cmaiolino@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Souptick Joarder <souptick.joarder@hpe.com>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 6.19 320/378] xfs: fix returned valued from xfs_defer_can_append
Date: Tue, 17 Mar 2026 17:34:37 +0100
Message-ID: <20260317163018.763252117@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226453-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hpe.com:email]
X-Rspamd-Queue-Id: 38CA22AF360
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Carlos Maiolino <cem@kernel.org>

commit 54fcd2f95f8d216183965a370ec69e1aab14f5da upstream.

xfs_defer_can_append returns a bool, it shouldn't be returning
a NULL.

Found by code inspection.

Fixes: 4dffb2cbb483 ("xfs: allow pausing of pending deferred work items")
Cc: <stable@vger.kernel.org> # v6.8
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Acked-by: Souptick Joarder <souptick.joarder@hpe.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/libxfs/xfs_defer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/xfs/libxfs/xfs_defer.c
+++ b/fs/xfs/libxfs/xfs_defer.c
@@ -809,7 +809,7 @@ xfs_defer_can_append(
 
 	/* Paused items cannot absorb more work */
 	if (dfp->dfp_flags & XFS_DEFER_PAUSED)
-		return NULL;
+		return false;
 
 	/* Already full? */
 	if (ops->max_items && dfp->dfp_count >= ops->max_items)



