Return-Path: <stable+bounces-270919-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 04ehEwuYRmovZgsAu9opvQ
	(envelope-from <stable+bounces-270919-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:55:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 591E66FAC22
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:55:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=C+OVihcC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270919-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270919-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8784A30432F0
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4D238D402;
	Thu,  2 Jul 2026 16:36:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2FB381E92;
	Thu,  2 Jul 2026 16:36:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010194; cv=none; b=Dbye2E+MhhMXK7WpsjWxDNCUzIqUsqzrZs8Wj9n+YQ/l1rmQ37aLrpGAdZh0yyqDxrS1yGds/ZtsNQXdDWqvR/euBmbNdp3Ze9u7AwpFFORIt9dmm/SnehJHTsIrm3fotHGaksZNRGwtAgZcEPGXIKOY4LTBmboUg7gotRZgOjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010194; c=relaxed/simple;
	bh=+9ixt2SdzpQk9RUSKt9X5cdsw1+qFJcxdte3YthQPGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZjJc6Qrf4XduCvRXp4sUfv4UidhMD5JP6JMn0DUNf/AlLIOvCvNmW2RE6ptQUPdIbPPlZtF8TBRrGQTP9WmJGrSdDM/aM2RRspVv5r2NuZJIx0c0ypIVwG3qNvObZxQncEczarDckx9dOa7xtRdTjYrHjDP4Nkvuv5j3OKed5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C+OVihcC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D584C1F00A3A;
	Thu,  2 Jul 2026 16:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010193;
	bh=P48gxzQQ9eA8IpBH7ME/n7dEZnceLlTBnqZKpgnqlTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C+OVihcCoPc7ZAtayjO5qm97fyl8tqyIHcJJqq2u3uwfJOZME35ILYXYJ6A/WtbyB
	 Q25Sh8xcL021DnfSMxbpHqaG3dhSWgPZZepecLtxYccT14w+RYRa4xUO3fuh+xb4ua
	 TZ4NULo0byIJ7segJG4c8sVjVvP0tMBUozEhtpCM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Jann Horn <jannh@google.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 004/204] fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios
Date: Thu,  2 Jul 2026 18:17:41 +0200
Message-ID: <20260702155118.761149243@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270919-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:jannh@google.com,m:mszeredi@redhat.com,m:brauner@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 591E66FAC22

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

[ Upstream commit 4e3d1b2c48ca6c55f1e9ca7f8dccc76f120f276c ]

FUSE_NOTIFY_RETRIEVE must be limited to uptodate folios; !uptodate folios
can contain uninitialized data.
Since FUSE_NOTIFY_RETRIEVE is intended to only return data that is already
in the page cache and not wait for data from the FUSE daemon, treat
!uptodate folios as if they weren't present.

This only has security impact on systems that don't enable automatic
zero-initialization of all page allocations via
CONFIG_INIT_ON_ALLOC_DEFAULT_ON or init_on_alloc=1.

Cc: stable@kernel.org
Fixes: 2d45ba381a74 ("fuse: add retrieve request")
Signed-off-by: Jann Horn <jannh@google.com>
Link: https://patch.msgid.link/20260519-fuse-retrieve-uptodate-v1-1-a7a1912a37f9@google.com
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[adjusted for stable: page instead of folio]
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 8f4a2ff56cc3be..6381a4626bc5a6 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1769,6 +1769,10 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 		page = find_get_page(mapping, index);
 		if (!page)
 			break;
+		if (!PageUptodate(page)) {
+			put_page(page);
+			break;
+		}
 
 		this_num = min_t(unsigned, num, PAGE_SIZE - offset);
 		ap->pages[ap->num_pages] = page;
-- 
2.53.0




