Return-Path: <stable+bounces-228942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Bwu1G4VXwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-228942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:08:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FBA2F5D99
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EAC030A6831
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E2D3AF66A;
	Mon, 23 Mar 2026 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1GYmL8wP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102723AC0EB;
	Mon, 23 Mar 2026 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277558; cv=none; b=WZ1jAn4Qx7GRzgOP4knOxIM2RL0aaNavWPi2Qxa4aUrY8ugYH5UtuM5GkNDYACG7aiYUMW4mIdpH5rlh7QZJI6oBu+VWNxgdtGZRw/e/DNo9we3W2TUKO4EoxTXVP6wLal1ZB/8jFHeaUdQXT3ClFN1QkDt0C06gZCGQqG5R7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277558; c=relaxed/simple;
	bh=I/OyTXMNQcSYJmYMPk1Mc1K//0Uymh+o5e9rSUMsyhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ch59l+hD9w5vY9qXOgxUbgUgxCBPtsfC6xaNcHG+lyJN4gJyufLiSXTmOb8KIdaOFNy6QNlp2ZpAE0lbcu8ucgA8Lvmj48S4GGRHT2rnQdWBcFRGHk7P79h3auRYkMuWYWVgMl+ApMJFbowGK1c4xSWXfMMVns4Jc4j/nuELb/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1GYmL8wP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87337C4CEF7;
	Mon, 23 Mar 2026 14:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277557;
	bh=I/OyTXMNQcSYJmYMPk1Mc1K//0Uymh+o5e9rSUMsyhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1GYmL8wP6WsMwVHuRJeOA6WgUfhTUX6MQNEdfE30a2fMaQDClW0W1PI+cXauxBoTP
	 KW9pld3pSx2aZIbivok9jlhmeBsBtoEJb8QR5xyh/CECnPTEOMcdCynBjKn4fLJFl4
	 Rg0U0v7OUO01HG7lzFyDfy/RAFneB3jSQzHQcB7s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Mark Harmstone <mark@harmstone.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 023/567] btrfs: fix warning in scrub_verify_one_metadata()
Date: Mon, 23 Mar 2026 14:39:03 +0100
Message-ID: <20260323134534.341329936@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228942-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 00FBA2F5D99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Harmstone <mark@harmstone.com>

[ Upstream commit 44e2fda66427a0442d8d2c0e6443256fb458ab6b ]

Commit b471965fdb2d ("btrfs: fix replace/scrub failure with
metadata_uuid") fixed the comparison in scrub_verify_one_metadata() to
use metadata_uuid rather than fsid, but left the warning as it was. Fix
it so it matches what we're doing.

Fixes: b471965fdb2d ("btrfs: fix replace/scrub failure with metadata_uuid")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/scrub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 3338e2e7a9a02..d2d2548eea05a 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -635,7 +635,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 		btrfs_warn_rl(fs_info,
 		"tree block %llu mirror %u has bad fsid, has %pU want %pU",
 			      logical, stripe->mirror_num,
-			      header->fsid, fs_info->fs_devices->fsid);
+			      header->fsid, fs_info->fs_devices->metadata_uuid);
 		return;
 	}
 	if (memcmp(header->chunk_tree_uuid, fs_info->chunk_tree_uuid,
-- 
2.51.0




