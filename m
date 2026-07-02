Return-Path: <stable+bounces-271260-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4jCqKZekRmp+awsAu9opvQ
	(envelope-from <stable+bounces-271260-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:49:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAA46FBA71
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:49:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=iMbQ+lrg;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271260-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271260-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97A0931B0A13
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED7633ADB0;
	Thu,  2 Jul 2026 16:51:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8DE395AF6;
	Thu,  2 Jul 2026 16:51:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011082; cv=none; b=ZZ6ql/S5HXkh22TdMENqXKu5kPF+dYAtdZp+HLfr8f31w/uOqERUHgQ74/NlWXZRxSlKG+AH0mottsdDmVjx0uAC/KMauCpABHLYksor0mUX6LcgYqGdBUElZa9egr/KVmuAWvxInOUxB36h6dxOCwx+CHzB8e/GP2k1YCJ79No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011082; c=relaxed/simple;
	bh=0y5ZQGunK913KSaZwTw33LRPfwod+CHv+YV8n4YaYX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsWaxao+WQN1aLXQV0UGuPNNjdSfaTk10t7TD20p8ExAp2Y56A1O4nCZN/mcS8hxIjIbm5Ce6L3h0zfggq2V44+6460Q0sjRZOOBU6cWaR/EbFmE0OwMJcDiQW0REIdFd00ZpczMHwO6sPTLhLBsbZvcblULRW2HKgCYtE0cQPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iMbQ+lrg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49911F000E9;
	Thu,  2 Jul 2026 16:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011081;
	bh=uU0TA50DKpwEWF9ylOlnJnUBWwJTv7NpxCfCTU1w3Sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iMbQ+lrgacc1rf1+d6iEdX/JihXjU72MRwWLdmUCj+X8Jgsr3LIB6LNfAQNCd0qcH
	 DsD6sJp9vqfpOjyWmz/uOqWTh+1RAEchwv19mXXxnazIYVnNkTru0E6IQHMgGARgdw
	 HJi1g3oOEvd9PS8qp0TaZffRdaiFTFln2LJl7dhY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Anna Schumaker <anna.schumaker@hammerspace.com>
Subject: [PATCH 6.6 150/175] pNFS: Fix use-after-free in pnfs_update_layout()
Date: Thu,  2 Jul 2026 18:20:51 +0200
Message-ID: <20260702155118.962412147@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155115.766838875@linuxfoundation.org>
References: <20260702155115.766838875@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271260-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:vulab@iscas.ac.cn,m:anna.schumaker@hammerspace.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hammerspace.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,iscas.ac.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFAA46FBA71

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2094,11 +2094,11 @@ lookup_again:
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



