Return-Path: <stable+bounces-228649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKdQBs5NwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:27:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 153012F487A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D17E30185FA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEFE1A6828;
	Mon, 23 Mar 2026 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hsnlT76x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734B2A59;
	Mon, 23 Mar 2026 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275711; cv=none; b=HYj8lT4MdP+z0ICATW0IYQD7BaeWIgE8Kud61U1+dB1gYM/Gg4RyPORlbsvIsK1oLNR1zfLva6kmeMSv+8eg+VIL2/emOWMHPQyScY+enkxkAwK7gSZePpi6Jjj/lcvcj/LmAthcIx3jQEU8t6nEV+j4zwjBeFX03lHgkrfvBmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275711; c=relaxed/simple;
	bh=5j0QSoNQmDKd43upchVV46hKDaiZNTWwQyM8uSVOp4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9LRekpsUToC7sYjmRj4W4z3xs20/u3k+/hORcUoRe8gDCRFAmykhrZ4gheWu/eobl5r2CKdPOd7D+9wTE38fGcoDtjkA+xc5HDVAeIerL4asX96GNCJinO6KxpFzDXqJ1SQn4NWBgaXWTTmB3MhDwNzsIu8JW7LapCsz1jypec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hsnlT76x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025C5C4CEF7;
	Mon, 23 Mar 2026 14:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275711;
	bh=5j0QSoNQmDKd43upchVV46hKDaiZNTWwQyM8uSVOp4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hsnlT76xNugc/6tdcQotz2Qg+wwPJvs6gtl8kH1eIgpjO1/XqwdFGOWmV9domELND
	 bU+TWa6hhv9Yvw8kvbgWVI5qZ52LvGb46NtFsJeSOkER/H/46BT0VCtjluEIf87pJ8
	 zv6uOFCSLuJQvRcUBZFgi2BTgd/iQNbEw9228E4o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Filipe Manana <fdmanana@suse.com>,
	Mark Harmstone <mark@harmstone.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.12 149/460] btrfs: fix chunk map leak in btrfs_map_block() after btrfs_chunk_map_num_copies()
Date: Mon, 23 Mar 2026 14:42:25 +0100
Message-ID: <20260323134530.237909050@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228649-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 153012F487A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Harmstone <mark@harmstone.com>

commit f15fb3d41543244d1179f423da4a4832a55bc050 upstream.

Fix a chunk map leak in btrfs_map_block(): if we return early with -EINVAL,
we're not freeing the chunk map that we've just looked up.

Fixes: 0ae653fbec2b ("btrfs: reduce chunk_map lookups in btrfs_map_block()")
CC: stable@vger.kernel.org # 6.12+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/volumes.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6522,8 +6522,10 @@ int btrfs_map_block(struct btrfs_fs_info
 		return PTR_ERR(map);
 
 	num_copies = btrfs_chunk_map_num_copies(map);
-	if (io_geom.mirror_num > num_copies)
-		return -EINVAL;
+	if (io_geom.mirror_num > num_copies) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	map_offset = logical - map->start;
 	io_geom.raid56_full_stripe_start = (u64)-1;



