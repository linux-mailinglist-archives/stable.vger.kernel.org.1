Return-Path: <stable+bounces-219319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL38Iq2dnmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:58:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6AA192A6C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 439A8307C9F3
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE1D30C360;
	Wed, 25 Feb 2026 06:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1fmPzPy5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADF32DC767;
	Wed, 25 Feb 2026 06:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002637; cv=none; b=o68NAD24cgzqGez2lJ6j5nyPtfqgIezXb7ZywxvveDwSo8rOLdLl7apV8iJN2QSJaAPVGxWvVXsCET2rjFXNTxGLqHhPHMJo9ZAoEH/Tr0+vbAYqFx5scDtocIzUEb1tCgMGfx4kMyHG20Yw/7kzeuDfR7YzqOPMl4XSoGoZdgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002637; c=relaxed/simple;
	bh=vYeT90wVbt+Y3Rs9jFSQbGFfwmBcQKhgfWVav5+LEII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtwJfKJ1GxFKqGLjk/SXszal9CfQrqkx5yi+ARzLlUivWFdRGbxNKDgVNxrNDyCYcbHw5rWyI/+76wrqjoD2BIa1T3X0mBJLrnB+SgLoTqJRYNrd16p7MccsAVtLNAkKi6KQNS33ppFMdZ4VfTRG7vwOAmG6on8aSsk19UqDBew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1fmPzPy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6E0C116D0;
	Wed, 25 Feb 2026 06:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002637;
	bh=vYeT90wVbt+Y3Rs9jFSQbGFfwmBcQKhgfWVav5+LEII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1fmPzPy5MKWFOOnDpIkoSF0ClSpJZzPfT+etJc3H0EUfmkpkpP4g8Dn8KbXgvMlRL
	 KJZyirlM3pubJsTNRZdIFgaEuJRPck/W6+bTIeHaYj7v7FBpEeBldh7LLky0Kk4GWa
	 TD6It8skTy3rK9l5zXEeFAEBF8iv5wDHuhw8yuQM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 376/641] NFS/localio: remove -EAGAIN handling in nfs_local_doio()
Date: Tue, 24 Feb 2026 17:21:42 -0800
Message-ID: <20260225012357.709183937@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219319-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,oracle.com:email]
X-Rspamd-Queue-Id: ED6AA192A6C
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Snitzer <snitzer@kernel.org>

[ Upstream commit e72a73957613653f50375db1f3a3fbb907a9c40b ]

Handling -EAGAIN in nfs_local_doio() was introduced with commit
0978e5b85fc08 (nfs_do_local_{read,write} were made to have negative
checks for correspoding iter method) but commit e43e9a3a3d66
since eliminated the possibility for this -EAGAIN early return.

So remove nfs_local_doio()'s -EAGAIN handling that calls
nfs_localio_disable_client() -- while it should never happen from
nfs_do_local_{read,write} this particular -EAGAIN handling is now
"dead" and so it has become a liability.

Fixes: e43e9a3a3d66 ("nfs/localio: refactor iocb initialization")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/localio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index d1a8f6fa9d74e..358d686d2ae33 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -995,8 +995,6 @@ int nfs_local_doio(struct nfs_client *clp, struct nfsd_file *localio,
 	}
 
 	if (status != 0) {
-		if (status == -EAGAIN)
-			nfs_localio_disable_client(clp);
 		nfs_local_iocb_release(iocb);
 		hdr->task.tk_status = status;
 		nfs_local_hdr_release(hdr, call_ops);
-- 
2.51.0




