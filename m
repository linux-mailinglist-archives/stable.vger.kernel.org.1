Return-Path: <stable+bounces-252599-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIEOIoYmDmr26QUAu9opvQ
	(envelope-from <stable+bounces-252599-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:24:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1B159ACC0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6FC4337C0A6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18A13F23C5;
	Wed, 20 May 2026 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IAElVTbt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751AD29B78D;
	Wed, 20 May 2026 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301097; cv=none; b=FnYSvjQD92D2ssknF6Bau7rWq2IS8RXUBy0LSohAs4FRykT1nOxuBFm5MsnZrpyX2MPi4zIPic+1Y9UGpCEwBYpYLeUZb7UEC/6azUT6XzoORYwBAib5XmkvZSTxiELwqZqiNSPJBCV53LMB8rbsEiDy/u1vAyiNuHBovzk6mKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301097; c=relaxed/simple;
	bh=+r8N4XLdMOs6+qAZQUf01dfqU8XjA21GDXE3OMgXxDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYexuTVUTERK5ULX9vlIXgYWK5rHjREfrXKwfcvpEoYkdwuP8UHvAoLSRb+xJYt+qPjOg8EsvKMgFGiPOT0ZpMI9Ur5iBM2Ftbq+zozZEyEwHco48jQOIhNh3hDpXLQwLGwpoYU0LgMnQFY3EHXPS03vq00eQnKPCnU8jQSNHwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IAElVTbt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8C31F000E9;
	Wed, 20 May 2026 18:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301096;
	bh=14Ai7PohsfbIH5Jdv2SxzfldqySuezJj2Oejc6N5zto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IAElVTbtG7hI8BK8LAMN8kYyUL93O34Syux3KLcNNKpg5Bbv7Ty+gv1zt75QRPiwS
	 ELF6ovr5PDBRR9NXXuopcgMSYjPq9jJeUTo20IrM6HffioYIiyk7pYvxRzMhh3TH0+
	 80n6UGjJJEA+xZ+UW/7v1vOo8eICuLXJ5Cf2P+6U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 424/666] f2fs: protect extension_list reading with sb_lock in f2fs_sbi_show()
Date: Wed, 20 May 2026 18:20:35 +0200
Message-ID: <20260520162120.459389815@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252599-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,xiaomi.com:email]
X-Rspamd-Queue-Id: DF1B159ACC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

[ Upstream commit 5909bedbed38c558bee7cb6758ceedf9bc3a9194 ]

In f2fs_sbi_show(), the extension_list, extension_count and
hot_ext_count are read without holding sbi->sb_lock. If a concurrent
sysfs store modifies the extension list via f2fs_update_extension_list(),
the show path may read inconsistent count and array contents, potentially
leading to out-of-bounds access or displaying stale data.

Fix this by holding sb_lock around the entire extension list read
and format operation.

Fixes: b6a06cbbb5f7 ("f2fs: support hot file extension")
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/sysfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 7b490242bd054..4e1021eb372ee 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -358,10 +358,12 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 	if (!strcmp(a->attr.name, "extension_list")) {
 		__u8 (*extlist)[F2FS_EXTENSION_LEN] =
 					sbi->raw_super->extension_list;
-		int cold_count = le32_to_cpu(sbi->raw_super->extension_count);
-		int hot_count = sbi->raw_super->hot_ext_count;
+		int cold_count, hot_count;
 		int len = 0, i;
 
+		f2fs_down_read(&sbi->sb_lock);
+		cold_count = le32_to_cpu(sbi->raw_super->extension_count);
+		hot_count = sbi->raw_super->hot_ext_count;
 		len += sysfs_emit_at(buf, len, "cold file extension:\n");
 		for (i = 0; i < cold_count; i++)
 			len += sysfs_emit_at(buf, len, "%s\n", extlist[i]);
@@ -369,6 +371,7 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 		len += sysfs_emit_at(buf, len, "hot file extension:\n");
 		for (i = cold_count; i < cold_count + hot_count; i++)
 			len += sysfs_emit_at(buf, len, "%s\n", extlist[i]);
+		f2fs_up_read(&sbi->sb_lock);
 
 		return len;
 	}
-- 
2.53.0




