Return-Path: <stable+bounces-231983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJtUAVH9y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:58:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F48736D94A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F8EA30FCC29
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E8F423A9A;
	Tue, 31 Mar 2026 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HFLtUGMw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965B2413258;
	Tue, 31 Mar 2026 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975572; cv=none; b=SnCdwdEmwgMXE87++zUIBKBVmalhzSTxxhvM5V0yamy3z2Mb69b+YMh50sX17d2EayYppR0GszvaryV0t3Bsk/m2m3LSvoMuyv3/r1GYKpkAFI+ooF/wzwTg2nWTznhfpfX+zj3OFtscer5W+j/E/Y3i6ce7i4Z7iYFLTG8pXEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975572; c=relaxed/simple;
	bh=1Ah35xL37FCMc6YMpXZh8dgW4dsycvN78TJzOX/QgAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFrAmTYguz/0C0Gy9r6jSYy7/wfWOhWLSLu0Xltu1ed4/JHscFxf84PwAXwTyINfwRwwvvWAdOsAlfMSMesnQeUqAuHK2U3NPsS1S0DebQgAYda0YOL/0spM6nP8FOxcJgR+IFE84HsIed7i2X6cRimb6B3FDY5JT/ZxMRDGaqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HFLtUGMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2F7C19423;
	Tue, 31 Mar 2026 16:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975572;
	bh=1Ah35xL37FCMc6YMpXZh8dgW4dsycvN78TJzOX/QgAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HFLtUGMw0fXV5QYcdPrLrbtI5kK9rkom8eATiYboYvJJq9DlRBEUfDqqtNBUi1KIn
	 qsdchKnv9TA1Ql7W8oxHDOjDtfhcqYl9VzBiQoWrofrVZM8qSuoe8k4UrxcI8KeXwJ
	 yowJq4Uc4k6SHCXZ9Fd8rOvyja0MxIHP/4G52aMs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ye Bin <yebin10@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 339/342] ext4: introduce EXPORT_SYMBOL_FOR_EXT4_TEST() helper
Date: Tue, 31 Mar 2026 18:22:52 +0200
Message-ID: <20260331161811.373384737@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-231983-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 9F48736D94A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 49504a512587147dd6da3b4b08832ccc157b97dc ]

Introduce EXPORT_SYMBOL_FOR_EXT4_TEST() helper for kuint test.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260314075258.1317579-2-yebin@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 519b76ac0b31 ("ext4: fix mballoc-test.c is not compiled when EXT4_KUNIT_TESTS=M")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/ext4.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index d4a98ff58076f..f1c476303f3a9 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3953,6 +3953,11 @@ static inline bool ext4_inode_can_atomic_write(struct inode *inode)
 extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 				  loff_t pos, unsigned len,
 				  get_block_t *get_block);
+
+#if IS_ENABLED(CONFIG_EXT4_KUNIT_TESTS)
+#define EXPORT_SYMBOL_FOR_EXT4_TEST(sym) \
+	EXPORT_SYMBOL_FOR_MODULES(sym, "ext4-test")
+#endif
 #endif	/* __KERNEL__ */
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
-- 
2.53.0




