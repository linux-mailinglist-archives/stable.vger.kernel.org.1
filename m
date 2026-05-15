Return-Path: <stable+bounces-248120-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFs5BSBUB2oqywIAu9opvQ
	(envelope-from <stable+bounces-248120-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:13:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FA05549DF
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3C5A309F716
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32553F44CB;
	Fri, 15 May 2026 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EYD8MdPj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A5F30568A;
	Fri, 15 May 2026 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860923; cv=none; b=JmPqQwULwaKfRl5kYLsLipdqFJV3zpPSJ5sHCN7p2yh0tYpklmVxDAsWOUE3u/pJ7A/UhvK/JJO1NrUxksyQjumKNCdZPa7+Y2/2YJQdi78jOU9q0lkZ5vII7np/Dnz3YggjrHWxpAiLcTcHbfx0HTPI20QrDhEPFWzZdLe6eho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860923; c=relaxed/simple;
	bh=ezl4yLPUptX+gUkY0h6Lttk1ZeFN5dccwyu4/otr6KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIBJ9L05RcsS/1l+HJFjBD99TrxrI0l9/c2URXGjI6ZrpvQ1xt9z2Hb0L+zsLbLsTfWBg9hY7PoxVhZctVpm85UXiywNWaAFEalpOTOWTLZc9YAcsLbF+oc5zmxVuidYTlkWwOWzhL1WSJHT3xydXwX01f1LctVjFdgKacaKMko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EYD8MdPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D663C2BCB0;
	Fri, 15 May 2026 16:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860923;
	bh=ezl4yLPUptX+gUkY0h6Lttk1ZeFN5dccwyu4/otr6KU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EYD8MdPjszRTdmbrXpnvB6fRSXqAx+2jjkJJbZzS3SYQIMg1413rfvCXg5SFPvuyX
	 Db5X2+Ks+LLb8vYXnWq+lrrKxERXlAKKfe2LYN+bCzVgw/jvIpjRAMAt7A7nGE3AjS
	 ZDSZc31vkcrp+BcwXQexIDQXXoljcFE2Va0f6ePA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tobias Gaertner <tob.gaertner@me.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 6.6 131/474] ntfs3: fix integer overflow in run_unpack() volume boundary check
Date: Fri, 15 May 2026 17:44:00 +0200
Message-ID: <20260515154717.866959897@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 88FA05549DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248120-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,me.com,paragon-software.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,me.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tobias Gaertner <tob.gaertner@me.com>

commit 984a415f019536ea2d24de9010744e5302a9a948 upstream.

The volume boundary check `lcn + len > sbi->used.bitmap.nbits` uses raw
addition which can wrap around for large lcn and len values, bypassing
the validation.  Use check_add_overflow() as is already done for the
adjacent prev_lcn + dlcn and vcn64 + len checks added by commit
3ac37e100385 ("ntfs3: Fix integer overflow in run_unpack()").

Found by fuzzing with a source-patched harness (LibAFL + QEMU).

Fixes: 82cae269cfa95 ("fs/ntfs3: Add initialization of super block")
Cc: stable@vger.kernel.org
Signed-off-by: Tobias Gaertner <tob.gaertner@me.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ntfs3/run.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -1018,9 +1018,15 @@ int run_unpack(struct runs_tree *run, st
 			return -EOPNOTSUPP;
 		}
 #endif
-		if (lcn != SPARSE_LCN64 && lcn + len > sbi->used.bitmap.nbits) {
-			/* LCN range is out of volume. */
-			return -EINVAL;
+		if (lcn != SPARSE_LCN64) {
+			u64 lcn_end;
+
+			if (check_add_overflow(lcn, len, &lcn_end))
+				return -EINVAL;
+			if (lcn_end > sbi->used.bitmap.nbits) {
+				/* LCN range is out of volume. */
+				return -EINVAL;
+			}
 		}
 
 		if (!run)



