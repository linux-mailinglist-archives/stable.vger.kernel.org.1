Return-Path: <stable+bounces-271072-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GM0wHrWXRmoBZgsAu9opvQ
	(envelope-from <stable+bounces-271072-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:54:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FB96FAB9A
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:54:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=CkGzFiDo;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271072-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271072-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28BCD30C6359
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4443381EA6;
	Thu,  2 Jul 2026 16:43:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54C130C15A;
	Thu,  2 Jul 2026 16:43:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010596; cv=none; b=UUuuB4RCIkpGkYf3T5y9nCcny/0NZYscrf2V8cIVM7xJ6Q77XqaaH8r0pQgN76yTg+Rw6+jEUuOhQt+51du69lcVWLs9A2xm3tGDEkd6tlhdhsjYyMe7SiUw6S3wEF9JUtklwP7L+jcUzT9W2SEE2AZmmzKwQghaOla06NoCk0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010596; c=relaxed/simple;
	bh=QlO0pbe2Q5GsKGQu+QMdLGhyn76FoGaA4aXnpxLeU9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRxXOMlmuRq4FyfjT/qNO3sCTKRWV4ab4t1FDdxlmcAsXhHFuF4rv1sZ5wsvBJkVudv5331FjPcE8IGbVTGIiVa7GxzP03DwLTzv+QmNme20wPVuAG9NXazSOLC2rTOwN0Q33tWzItX5ATV68SRT/CCjEkKVh8tgNnKXHg64tZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CkGzFiDo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8A21F00A3A;
	Thu,  2 Jul 2026 16:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010595;
	bh=AgfB83ZwnqolcE97dV7vVnSZs24caZaugPwkpHcyD4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CkGzFiDoGqqr8u21F6YIaCt9x3m2JbzxKYfZzWK9bS6Zv5LT2aANAMzOD5pdJW/Kj
	 a70moN9ibrgcTVWA3WujlmMPaWHLuwThLJ6Q+oESrnKvKYGehJ5MolseFNx5y3LT3l
	 DDWHiqYJ+7l8uaZmfsciPjUptbqC+oyBgkZSSspY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Anna Schumaker <anna.schumaker@hammerspace.com>
Subject: [PATCH 6.12 170/204] pNFS: Fix use-after-free in pnfs_update_layout()
Date: Thu,  2 Jul 2026 18:20:27 +0200
Message-ID: <20260702155122.218529047@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271072-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:vulab@iscas.ac.cn,m:anna.schumaker@hammerspace.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,hammerspace.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4FB96FAB9A

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wentao Liang <vulab@iscas.ac.cn>

commit 13e198a90ca4050f4bee8a3f23680389a6563ccc upstream.

When hitting the NFS_LAYOUT_RETURN branch in pnfs_update_layout(),
the code calls pnfs_prepare_to_retry_layoutget(lo). If it succeeds,
pnfs_put_layout_hdr(lo) is called before trace_pnfs_update_layout(),
which still references 'lo'. This results in a use-after-free when the
tracepoint accesses lo's fields.

Fix this by moving the tracepoint call before pnfs_put_layout_hdr(lo).

Fixes: 2c8d5fc37fe2 ("pNFS: Stricter ordering of layoutget and layoutreturn")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/pnfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2217,11 +2217,11 @@ lookup_again:
 		dprintk("%s wait for layoutreturn\n", __func__);
 		lseg = ERR_PTR(pnfs_prepare_to_retry_layoutget(lo));
 		if (!IS_ERR(lseg)) {
-			pnfs_put_layout_hdr(lo);
 			dprintk("%s retrying\n", __func__);
 			trace_pnfs_update_layout(ino, pos, count, iomode, lo,
 						 lseg,
 						 PNFS_UPDATE_LAYOUT_RETRY);
+			pnfs_put_layout_hdr(lo);
 			goto lookup_again;
 		}
 		trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,



