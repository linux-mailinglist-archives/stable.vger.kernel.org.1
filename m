Return-Path: <stable+bounces-236920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKcuDBUe3WlhaAkAu9opvQ
	(envelope-from <stable+bounces-236920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:47:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B405F3EFC9E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A61983031B07
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE4130BF4E;
	Mon, 13 Apr 2026 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K0VDGBig"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C655429BD87;
	Mon, 13 Apr 2026 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098133; cv=none; b=RAgiOhl6yLj0tcj6oX/m6m1dYKKadwJp1bCRhMWYTygXXud/ENSQtT1piQDJo4zBbpfXn8xfC7jqOBdsojM529g5AAj3WutGEiqzWkGIXQfgAQn22nqLBXU5fPKCIf7vECkqQ77zy3SJQC2dnCyr579xr6n19nhzFjwPXeB/cNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098133; c=relaxed/simple;
	bh=iKWG7Jvykyu2rakjYjuI90DmJ3QyPoBrs9oQFsWUhWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ee1TSGafEZ7kQnafK+SS2hu5gt88/46VYqBHMqUw93WD0C87QXOCi4FR1A2IfhjAr7PNFYjD1shle4c8x8IkFSApl3H4nraAnyoNBJ9zV5xOdlPkGfAO+GNgjAH+/teRXfU81WoitTDWEKFVCgHjfRIwLgzpVOa5SxaaySQVWyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K0VDGBig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2AFC2BCAF;
	Mon, 13 Apr 2026 16:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098133;
	bh=iKWG7Jvykyu2rakjYjuI90DmJ3QyPoBrs9oQFsWUhWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K0VDGBigzlNTaLUA+Booy/63qqeiektYucMEFuaaMg439Ji1EmLnunJ9phXA7uT3/
	 gLizHzhm6OXeszc9AGfNRBrnmhZPjvGv9gAVSuBpGHPMea2erKo/dXWKaMikj0a9FG
	 ZivbSwVaj7yaE1mp+bn4Vr9k3urhqibrH+qb7W94=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 5.15 374/570] erofs: add GFP_NOIO in the bio completion if needed
Date: Mon, 13 Apr 2026 17:58:25 +0200
Message-ID: <20260413155844.489668506@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-236920-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B405F3EFC9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiucheng Xu <jiucheng.xu@amlogic.com>

commit c23df30915f83e7257c8625b690a1cece94142a0 upstream.

The bio completion path in the process context (e.g. dm-verity)
will directly call into decompression rather than trigger another
workqueue context for minimal scheduling latencies, which can
then call vm_map_ram() with GFP_KERNEL.

Due to insufficient memory, vm_map_ram() may generate memory
swapping I/O, which can cause submit_bio_wait to deadlock
in some scenarios.

Trimmed down the call stack, as follows:

f2fs_submit_read_io
  submit_bio                      //bio_list is initialized.
    mmc_blk_mq_recovery
      z_erofs_endio
        vm_map_ram
          __pte_alloc_kernel
            __alloc_pages_direct_reclaim
              shrink_folio_list
                __swap_writepage
                  submit_bio_wait  //bio_list is non-NULL, hang!!!

Use memalloc_noio_{save,restore}() to wrap up this path.

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/zdata.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -782,6 +782,7 @@ static void z_erofs_decompress_kickoff(s
 				       bool sync, int bios)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(io->sb);
+	int gfp_flag;
 
 	/* wake up the caller thread for sync decompression */
 	if (sync) {
@@ -802,7 +803,9 @@ static void z_erofs_decompress_kickoff(s
 		sbi->opt.readahead_sync_decompress = true;
 		return;
 	}
+	gfp_flag = memalloc_noio_save();
 	z_erofs_decompressqueue_work(&io->u.work);
+	memalloc_noio_restore(gfp_flag);
 }
 
 static bool z_erofs_page_is_invalidated(struct page *page)



