Return-Path: <stable+bounces-236894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NCoHrgd3WlWaAkAu9opvQ
	(envelope-from <stable+bounces-236894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:45:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E30923EFB80
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B77D3078AE6
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B660B2D5A19;
	Mon, 13 Apr 2026 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YoeBIga3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CD9305064;
	Mon, 13 Apr 2026 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098066; cv=none; b=F4SbKg3MTWvEtWOtFqY5FkM+jQIyTysZ7YLwF8aiwln4vIwBfWV4ntybAiKSMS+CtZ3WZ3prXcyE8YbHqc4giCFFMIHKSc+GNyqWrHI/9wqxCMt2rKLH/RGgWIu8E7FfuMDW5PjYafB3fgNR2TQB1gW6/IadyWVhOEsc5rUjvCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098066; c=relaxed/simple;
	bh=VhJ6smm/j11jlbRpTTfZQTf047oTrafyHezPY3I+7bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anKc//VvaRxoO/IfGQxjshx8CvWR6+5U3RSfObrMhtzAGX0A8ZnrtNeU8oKp+F5oBXF1nD8QF6R4aW94+wCJWUF71bPeiR43VDSNXOVjeaBRIDY+/QHc+ck0ujmR5agTFSEc7uB93yu38TMtcHkMOPk9iNSHtVaJl2LofFn6qwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YoeBIga3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DA3C2BCAF;
	Mon, 13 Apr 2026 16:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098066;
	bh=VhJ6smm/j11jlbRpTTfZQTf047oTrafyHezPY3I+7bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YoeBIga3S1SI8sNPmWsefC3PGkzMkyB95+uZXHZ67XHHpYyjl43DStL0RuxG4yA5C
	 oUxWwz1bwwfI3mQ3a5Lren3UWQQXDyHomYak+RtIAG8JaGoEF3y96GF0lS3AcfpuRn
	 N0uQt/OxO9YY6CBr06P3KtLuG7YHR+6dmRy0GHXM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Tso <tytso@mit.edu>,
	stable@kernel.org
Subject: [PATCH 5.15 381/570] ext4: make recently_deleted() properly work with lazy itable initialization
Date: Mon, 13 Apr 2026 17:58:32 +0200
Message-ID: <20260413155844.751817543@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236894-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,suse.cz:email,msgid.link:url]
X-Rspamd-Queue-Id: E30923EFB80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit bd060afa7cc3e0ad30afa9ecc544a78638498555 upstream.

recently_deleted() checks whether inode has been used in the near past.
However this can give false positive result when inode table is not
initialized yet and we are in fact comparing to random garbage (or stale
itable block of a filesystem before mkfs). Ultimately this results in
uninitialized inodes being skipped during inode allocation and possibly
they are never initialized and thus e2fsck complains.  Verify if the
inode has been initialized before checking for dtime.

Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://patch.msgid.link/20260216164848.3074-3-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/ialloc.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -688,6 +688,12 @@ static int recently_deleted(struct super
 	if (unlikely(!gdp))
 		return 0;
 
+	/* Inode was never used in this filesystem? */
+	if (ext4_has_group_desc_csum(sb) &&
+	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_INODE_UNINIT) ||
+	     ino >= EXT4_INODES_PER_GROUP(sb) - ext4_itable_unused_count(sb, gdp)))
+		return 0;
+
 	bh = sb_find_get_block(sb, ext4_inode_table(sb, gdp) +
 		       (ino / inodes_per_block));
 	if (!bh || !buffer_uptodate(bh))



