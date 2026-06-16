Return-Path: <stable+bounces-263987-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bXdiMo1sMWrkiwUAu9opvQ
	(envelope-from <stable+bounces-263987-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:32:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD326911E3
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:32:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=mMrMLQh9;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263987-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263987-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CDE731ED11A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEB1449ED6;
	Tue, 16 Jun 2026 15:25:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D8544A71C;
	Tue, 16 Jun 2026 15:25:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623538; cv=none; b=pthB94SuxBCpHSLpsgv7poOLtzYxDK24WCS87lhT2AsgAVtESpgudkuLCI5uhjATSB/5DwF/+VVWky+M5ZLh/opKFeBuIxEzRBD6lv5B6ISd6+oqdZwE+wkl4bt/pQIFC+p9XNDNmFc43leKHUktrFs+IeZxlUETrYUaK7x+lcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623538; c=relaxed/simple;
	bh=OnRxLllq0+gAUr1YnzgjYwzACeX6y20C8UIqexUC244=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/q1wKNd/0z8ysfgA0NURVUih46u8MqzbXVgfC1qOt8VtiSY2P01hUwIDlkMobdX9BLB4z55BUDex66az0sBKVd+ESKu8o9nZLyHQ6662PI9zr0L+axQ8h/UAbEdcFQvs7vGljFHaW7qOwl+5hL7su7i1VZ3nwlZdBe0M1hcv8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mMrMLQh9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A3D1F00A3A;
	Tue, 16 Jun 2026 15:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623537;
	bh=VhJd4H6MAnXiBrM02q07Di5Xc85Rj3vvMDzknZ2aq/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mMrMLQh9h6Fr39UVKk5NDuj4hRG6+36yOnGr1kZGYQ4V22OWwtX6JfxXYTJndPOk+
	 pnFgIRh3E33PomRx3TYuJS8rWVooBQT+0XQIZFHxbCumlBPA9PQ11I6JlzSBccEs+Q
	 2v2+TbfoTIoW8FKs5QPeSy6OwQ6WAjJqks193vzE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 167/378] accel/amdxdna: Fix mm_struct reference leak in aie2_populate_range()
Date: Tue, 16 Jun 2026 20:26:38 +0530
Message-ID: <20260616145119.096948480@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263987-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:superm1@kernel.org,m:lizhi.hou@amd.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,amd.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4FD326911E3

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lizhi Hou <lizhi.hou@amd.com>

[ Upstream commit 2f41af638c92bac6f1f9275ea2d1901baef578f3 ]

aie2_populate_range() jumps back to the again label without calling
mmput(mm), leaking a reference to the mm_struct.

Add the missing mmput() before jumping to again.

Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://patch.msgid.link/20260610151127.2994185-1-lizhi.hou@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/amdxdna/aie2_ctx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index c0d348884f7494..4c7264c6e6e76f 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -928,6 +928,7 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 
 		if (ret == -EBUSY) {
 			amdxdna_umap_put(mapp);
+			mmput(mm);
 			goto again;
 		}
 
@@ -938,11 +939,13 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 	if (mmu_interval_read_retry(&mapp->notifier, mapp->range.notifier_seq)) {
 		up_write(&xdna->notifier_lock);
 		amdxdna_umap_put(mapp);
+		mmput(mm);
 		goto again;
 	}
 	mapp->invalid = false;
 	up_write(&xdna->notifier_lock);
 	amdxdna_umap_put(mapp);
+	mmput(mm);
 	goto again;
 
 put_mm:
-- 
2.53.0




