Return-Path: <stable+bounces-228953-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMrVF5dXwWmBSQQAu9opvQ
	(envelope-from <stable+bounces-228953-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:09:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB6E2F5DD2
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E82A6309E7CC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E78A393DC8;
	Mon, 23 Mar 2026 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xinHF6vJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB432741A0;
	Mon, 23 Mar 2026 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277592; cv=none; b=D1S0y7mhgOpPKPN+H9KcM11Mkbx1qkZdbD44rOFFFfMaenmDYfk42ao2eayP8XBts9BaK6w3oXOvWXSBCrjzIVRBeXaM1rRcWzqqZnXXxVPGUJtkrmfXh1ahydDfg5N/mtxo46FPHZlISNe4gtEPH928ZKTzc0O3eRbQdeEjlDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277592; c=relaxed/simple;
	bh=MWAhZybxcKjdtTtpgy/hJmtiOh10KwCmZIr9B6KLz1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lr93izP0hTHge9b93fJTzc7rgnhyFWnXoRwvgC+RYhiz6NJvpc6vMIv2QTjaE8SN5zH4sokXSeFR1iFsTBijrd72lY/8SZ58l+ohy9mvIpfgzPGrCABwvgXXWyh2MIbxAZ+mm/IAEPFHGyOK8p0+wLlSPY+iXaI9lSXoWWRuljk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xinHF6vJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AB9C4CEF7;
	Mon, 23 Mar 2026 14:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277592;
	bh=MWAhZybxcKjdtTtpgy/hJmtiOh10KwCmZIr9B6KLz1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xinHF6vJfpZye/9Ug4ufxP+xIkpVpjrev8tKAWSEg4PdgegsYDQMLrQSIYQWKIy38
	 6yyfkI6bZ4RcVTTdKPv0//+0CwbzVQNEZLCNxsjhoXq8CP+BMCEzIx6anTf3sAOegl
	 YcLvO61/bm+e6IUNnNJ1LzlckdEgRE5b0MW4eujs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Mark Harmstone <mark@harmstone.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 024/567] btrfs: fix compat mask in error messages in btrfs_check_features()
Date: Mon, 23 Mar 2026 14:39:04 +0100
Message-ID: <20260323134534.369436933@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-228953-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: CCB6E2F5DD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Harmstone <mark@harmstone.com>

[ Upstream commit 587bb33b10bda645a1028c1737ad3992b3d7cf61 ]

Commit d7f67ac9a928 ("btrfs: relax block-group-tree feature dependency
checks") introduced a regression when it comes to handling unsupported
incompat or compat_ro flags. Beforehand we only printed the flags that
we didn't recognize, afterwards we printed them all, which is less
useful. Fix the error handling so it behaves like it used to.

Fixes: d7f67ac9a928 ("btrfs: relax block-group-tree feature dependency checks")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 89e98f9cc2026..23431bc81c64a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3094,7 +3094,7 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
 	if (incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP) {
 		btrfs_err(fs_info,
 		"cannot mount because of unknown incompat features (0x%llx)",
-		    incompat);
+		    incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP);
 		return -EINVAL;
 	}
 
@@ -3126,7 +3126,7 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
 	if (compat_ro_unsupp && is_rw_mount) {
 		btrfs_err(fs_info,
 	"cannot mount read-write because of unknown compat_ro features (0x%llx)",
-		       compat_ro);
+		       compat_ro_unsupp);
 		return -EINVAL;
 	}
 
@@ -3139,7 +3139,7 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
 	    !btrfs_test_opt(fs_info, NOLOGREPLAY)) {
 		btrfs_err(fs_info,
 "cannot replay dirty log with unsupported compat_ro features (0x%llx), try rescue=nologreplay",
-			  compat_ro);
+			  compat_ro_unsupp);
 		return -EINVAL;
 	}
 
-- 
2.51.0




