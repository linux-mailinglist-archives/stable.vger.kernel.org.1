Return-Path: <stable+bounces-271485-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ctjjDwCcRmpPaAsAu9opvQ
	(envelope-from <stable+bounces-271485-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:12:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 887846FB1F3
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:12:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=uqee7gkd;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271485-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271485-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0739834785AC
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 17:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B9433B951;
	Thu,  2 Jul 2026 17:01:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EB633689F;
	Thu,  2 Jul 2026 17:01:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011668; cv=none; b=HkYPQJens4+lWGlRa1a6EBTQvNmn5wHHjbnAoHabij4pqvXv8DGuxN/CECkCzHxAaBQujI3Lv9TtI/nbU0P9OPoz1TcTlzEz1a5zcHkTWgzBhuADW9uNEc7x992rCPgOMeQMVkGmuV1vP0gC74tU0XzBuDIZduBDGr6SGBlXBBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011668; c=relaxed/simple;
	bh=Ait/EprHyhqmG7VzfXmizfak6Nf8xHSeWry6pO8A6wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETZHfNLUw/erDWAv4e5a3KCXR7yvsPyJqIQUiY23UCXWh/mWntlhFyZdOdfi1xVp+4Fm6w9pvvn2Gn1nrnSBC5j31DCDheG/k84OwK2DGX5oeiDkVrvkY0eNnb9wripshzrpwrWL5UR23qfrtOhcClCitqYAM0I7DdSigLq+bJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uqee7gkd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD06E1F000E9;
	Thu,  2 Jul 2026 17:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011667;
	bh=BLlQnahTaosC/4eMzvwRucZdVuWUXn5JYaJd4YJ0qUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uqee7gkdJ2OhgCTxEoVn1YAHXCovvI3i3Ku3hssJs7XO+LFYIY3aRdzDwkqoypf10
	 JnRcDPGsOVb8tLIOiixym5AHkAUMRB4Z50HUHeTA7jRYnofqFp49mwOdLGoMgHoBzP
	 SfpAOXF1OoXzzddeL8zerLV2lmc/lbOVrfO1S6Zw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Anna Schumaker <anna.schumaker@hammerspace.com>
Subject: [PATCH 7.1 086/120] pNFS: Fix use-after-free in pnfs_update_layout()
Date: Thu,  2 Jul 2026 18:21:22 +0200
Message-ID: <20260702155114.739900348@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.964534952@linuxfoundation.org>
References: <20260702155112.964534952@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271485-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:vulab@iscas.ac.cn,m:anna.schumaker@hammerspace.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,vger.kernel.org:from_smtp,iscas.ac.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 887846FB1F3

7.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2229,11 +2229,11 @@ lookup_again:
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



