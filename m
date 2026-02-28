Return-Path: <stable+bounces-220482-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDRxDtc4o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220482-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:49:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7695B1C64DA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1BF6311D316
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0213E3C4C5F;
	Sat, 28 Feb 2026 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8W8bjBc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91003C54B9;
	Sat, 28 Feb 2026 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300368; cv=none; b=OP6NCDfZ82d68gwRHmUgjXmxF/K+S158A1kh7yguWL7O33iTI8MwWgKMucv+5H9kHmhQUX2rAFaNPfgoDHkhpI2AJbfiJXrOBgX2SzwiiW68s4Py2FEHisD8GWfy/YwdGWPDvYE7kjVBwzKL8COGE8/md4qwjVFR4xlKRl9ShhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300368; c=relaxed/simple;
	bh=8QqsC/w7loO7pIvqjHyjqBcYWmo3bQPoDN2bYXPQljY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taLK90de3na6/GJdC8WngJ/azVWW0JWM2kCWs8x1znFJeNyeLyRaj1tL0WsupCLxsD+0bUX/l2SW5wzUet7r5FRMkujF2fF04PStifT/PcufPdbs+aOrYlv4ZTqhCklVupNulcd1OfZjZA9qpHuu6LS7lF0RzSAHmkop1vyRf/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8W8bjBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6973C116D0;
	Sat, 28 Feb 2026 17:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300368;
	bh=8QqsC/w7loO7pIvqjHyjqBcYWmo3bQPoDN2bYXPQljY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P8W8bjBcXM6TY9zBqyQ+92/sAVqjQgrODorVjusZRL5TM5ttdNsy34fIPrCpuhyhQ
	 sG9PkpvboSZaMKkB0rRR9VCLaviXueFtMAiRjs7Qaln4hbdC6ghTwCvMK+ZBEH3Q8a
	 IpvneJW6YZn0fLX5Carg+qkn7XOt/1uuKswHYQ2+W7vkY4m/0loBqVroA82nQDYCk0
	 MkgeLUoDtA007HLQ0oduHO3mDnX0qDyh1eRvhVns9+s2iu62CksxywgJ7N5PKAad/z
	 Eoouug8oQdcinLTY26oWEnV0sQ6+/Q+y27HSkLfC7586fPoNs0EYPNQzVU0UjWuRXH
	 QfsAY4Nt0PRKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jaehun Gou <p22gone@gmail.com>,
	Seunghun Han <kkamagui@gmail.com>,
	Jihoon Kwon <kjh010315@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 403/844] fs: ntfs3: check return value of indx_find to avoid infinite loop
Date: Sat, 28 Feb 2026 12:25:16 -0500
Message-ID: <20260228173244.1509663-404-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail,paragon-software.com:server fail];
	FREEMAIL_CC(0.00)[gmail.com,paragon-software.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220482-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7695B1C64DA
X-Rspamd-Action: no action

From: Jaehun Gou <p22gone@gmail.com>

[ Upstream commit 1732053c8a6b360e2d5afb1b34fe9779398b072c ]

We found an infinite loop bug in the ntfs3 file system that can lead to a
Denial-of-Service (DoS) condition.

A malformed dentry in the ntfs3 filesystem can cause the kernel to hang
during the lookup operations. By setting the HAS_SUB_NODE flag in an
INDEX_ENTRY within a directory's INDEX_ALLOCATION block and manipulating the
VCN pointer, an attacker can cause the indx_find() function to repeatedly
read the same block, allocating 4 KB of memory each time. The kernel lacks
VCN loop detection and depth limits, causing memory exhaustion and an OOM
crash.

This patch adds a return value check for fnd_push() to prevent a memory
exhaustion vulnerability caused by infinite loops. When the index exceeds the
size of the fnd->nodes array, fnd_push() returns -EINVAL. The indx_find()
function checks this return value and stops processing, preventing further
memory allocation.

Co-developed-by: Seunghun Han <kkamagui@gmail.com>
Signed-off-by: Seunghun Han <kkamagui@gmail.com>
Co-developed-by: Jihoon Kwon <kjh010315@gmail.com>
Signed-off-by: Jihoon Kwon <kjh010315@gmail.com>
Signed-off-by: Jaehun Gou <p22gone@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/index.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 7157cfd70fdcb..75b94beac1613 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1190,7 +1190,12 @@ int indx_find(struct ntfs_index *indx, struct ntfs_inode *ni,
 			return -EINVAL;
 		}
 
-		fnd_push(fnd, node, e);
+		err = fnd_push(fnd, node, e);
+
+		if (err) {
+			put_indx_node(node);
+			return err;
+		}
 	}
 
 	*entry = e;
-- 
2.51.0


