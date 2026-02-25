Return-Path: <stable+bounces-218534-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAtWEvdSnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218534-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:40:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB91E18F62A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54E583103BA2
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B53C20C012;
	Wed, 25 Feb 2026 01:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="19bApyUQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E415E1EB5E1;
	Wed, 25 Feb 2026 01:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983372; cv=none; b=F0pP14pXX0hF/p9WBV6yIR305DsaJYz9Swm14RpQ1Xsgmmb5ywKoGjvPPRfyAcC9d7a2ylnHNGpZ3Cy1CbAxPBmjnQZsTMb1XlLuP45c8nnTIRXqGKiLm0Z8QtsBcrvja/gaPsp83Kpe7b9HL3D/r4V40B7RvtVyHMn4X17+BFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983372; c=relaxed/simple;
	bh=/cJFzM6aRijBpKBOt1K8PtmnyDkb54MlE7zxJYgn+n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NogGrvvSUJ1pIA4nOx1XGCDyb4WEYkqhnHNgL4r8mwCA59rS+QLc0qRn0XSd4U/yEypjBy3KCcGU9aapbJSO6Gtwc1LtzABSFXvFLYujwkDxwWiX5e9lY/+EeA0+EqY1VPAI+5YrhzTpcrUlVr1UV7OTZZxCdFCT3yWFo8nHekg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=19bApyUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A479AC19424;
	Wed, 25 Feb 2026 01:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983371;
	bh=/cJFzM6aRijBpKBOt1K8PtmnyDkb54MlE7zxJYgn+n4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=19bApyUQMwpb1DMDB5c6HbsJjpCJ4m5HqWo1Bm+lsDw8FFmiBm2yjZt76EasjqRmO
	 5PUiUmpOHqCfZQygRMgGchILEnacbEDpQ+mO1gwEAjygXtAppy7hi+uMcnhmmGXElQ
	 caxbYgpU9l8oVVXfkg0mq/CEFoB7kSTgg5tcTYiI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 497/781] pNFS: fix a missing wake up while waiting on NFS_LAYOUT_DRAIN
Date: Tue, 24 Feb 2026 17:20:06 -0800
Message-ID: <20260225012411.995709041@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218534-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,hammerspace.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB91E18F62A
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Olga Kornievskaia <okorniev@redhat.com>

[ Upstream commit 5248d8474e594d156bee1ed10339cc16e207a28b ]

It is possible to have a task get stuck on waiting on the
NFS_LAYOUT_DRAIN in the following scenario

1. cpu a: waiter test NFS_LAYOUT_DRAIN (1) and plh_outstanding (1)
2. cpu b: atomic_dec_and_test() -> clear bit -> wake up
3. cpu c: sets NFS_LAYOUT_DRAIN again
4. cpu a: calls wait_on_bit() sleeps forever.

To expand on this we have say 2 outstanding pnfs write IO that get
ESTALE which causes both to call pnfs_destroy_layout() and set the
NFS_LAYOUT_DRAIN bit but the 1st one doesn't call the
pnfs_put_layout_hdr() yet (as that would prevent the 2nd ESTALE write
from trying to call pnfs_destroy_layout()). If the 1st ESTALE write
is the one that initially sets the NFS_LAYOUT_DRAIN so that new IO
on this file initiates new LAYOUTGET. Another new write would find
NFS_LAYOUT_DRAIN set and phl_outstanding>0 (step 1) and would
wait_on_bit(). LAYOUTGET completes doing step 2. Now, the 2nd of
ESTALE writes is calling pnfs_destory_layout() and set the
NFS_LAYOUT_DRAIN bit (step 3). Finally, the waiting write wakes up
to check the bit and goes back to sleep.

The problem revolves around the fact that if NFS_LAYOUT_INVALID_STID
was already set, it should not do the work of
pnfs_mark_layout_stateid_invalid(), thus NFS_LAYOUT_DRAIN will not
be set more than once for an invalid layout.

Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Fixes: 880265c77ac4 ("pNFS: Avoid a live lock condition in pnfs_update_layout()")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/pnfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index cff225721d1ce..ff8483d3373a8 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -463,7 +463,8 @@ pnfs_mark_layout_stateid_invalid(struct pnfs_layout_hdr *lo,
 	};
 	struct pnfs_layout_segment *lseg, *next;
 
-	set_bit(NFS_LAYOUT_INVALID_STID, &lo->plh_flags);
+	if (test_and_set_bit(NFS_LAYOUT_INVALID_STID, &lo->plh_flags))
+		return !list_empty(&lo->plh_segs);
 	clear_bit(NFS_INO_LAYOUTCOMMIT, &NFS_I(lo->plh_inode)->flags);
 	list_for_each_entry_safe(lseg, next, &lo->plh_segs, pls_list)
 		pnfs_clear_lseg_state(lseg, lseg_list);
-- 
2.51.0




