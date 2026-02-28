Return-Path: <stable+bounces-220484-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Om0A4FLo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220484-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:09:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B431C7F5E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5FCBC31020E3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C85D3C5CB1;
	Sat, 28 Feb 2026 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHRPO12i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27BC3C5CA8;
	Sat, 28 Feb 2026 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300370; cv=none; b=WWx3LMzAkMh3kE/aK7HYBntmSx98K+QZRWPXw8/f4q3ikWRO/bELws2vO1IIdlW4oEa9hQRKo92H113MKGvyjxebqO9ZutGMqMVjI6bQRVDP4gbNY3UfUqgYe09Jg2WlCY2v90BOEKmc1NAkz1GoNn2MPL3p8HbQx7Ob6JG7o5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300370; c=relaxed/simple;
	bh=nEBHn/E2vI88MIJ7nIqaANfuIDHotYdC5cPu7qAjxCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrAeiO7zVGRnNdUrtCz/NBVb3q6ywvfjFqggR49uyWZGDcqtogv45hMC35+TMGMiL0YyQ5qRMtp004iUvLY80LfzVQnegvnCMaD8+3GzsWD7OrtswscOqlEfY8q5fLPsLlBOZ2M79AxwGCSgIbaoBuTBgVwdrpEW1tteg2RyLHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHRPO12i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2498C19424;
	Sat, 28 Feb 2026 17:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300370;
	bh=nEBHn/E2vI88MIJ7nIqaANfuIDHotYdC5cPu7qAjxCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EHRPO12iWyoWyl1zrKtNPCz1q6cmy2niMI9/KlNDXObQJ314NH/UXt86AMW1qNOwf
	 S85Yw1dfuazbmzxCsQFMDMdkLmIAWIK8509L/ubX6iytOHgGl+f+tv3v8a5oZPspFA
	 8CZ82CHKedzRerrdKdlr6vGPukvpf7nz9FnZaaHtf5IFxIXTDKVoHzKyjaD19RJ3Vw
	 9m/s+TpPvGYdvryIZEceDz1lum7pfIC1+QowaXb3v0kMHEG502cNjg/zB5+j3csA7g
	 bxW66G0Lqy8U+Yk9tklCtvURvgDzngXEfUKIcnSikTayFVGEnl65HYu9PVCVcJc/sZ
	 iLhAxG7trS2cg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jaehun Gou <p22gone@gmail.com>,
	Seunghun Han <kkamagui@gmail.com>,
	Jihoon Kwon <kjh010315@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 405/844] fs: ntfs3: fix infinite loop triggered by zero-sized ATTR_LIST
Date: Sat, 28 Feb 2026 12:25:18 -0500
Message-ID: <20260228173244.1509663-406-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,paragon-software.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220484-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,paragon-software.com:email]
X-Rspamd-Queue-Id: 22B431C7F5E
X-Rspamd-Action: no action

From: Jaehun Gou <p22gone@gmail.com>

[ Upstream commit 06909b2549d631a47fcda249d34be26f7ca1711d ]

We found an infinite loop bug in the ntfs3 file system that can lead to a
Denial-of-Service (DoS) condition.

A malformed NTFS image can cause an infinite loop when an ATTR_LIST attribute
indicates a zero data size while the driver allocates memory for it.

When ntfs_load_attr_list() processes a resident ATTR_LIST with data_size set
to zero, it still allocates memory because of al_aligned(0). This creates an
inconsistent state where ni->attr_list.size is zero, but ni->attr_list.le is
non-null. This causes ni_enum_attr_ex to incorrectly assume that no attribute
list exists and enumerates only the primary MFT record. When it finds
ATTR_LIST, the code reloads it and restarts the enumeration, repeating
indefinitely. The mount operation never completes, hanging the kernel thread.

This patch adds validation to ensure that data_size is non-zero before memory
allocation. When a zero-sized ATTR_LIST is detected, the function returns
-EINVAL, preventing a DoS vulnerability.

Co-developed-by: Seunghun Han <kkamagui@gmail.com>
Signed-off-by: Seunghun Han <kkamagui@gmail.com>
Co-developed-by: Jihoon Kwon <kjh010315@gmail.com>
Signed-off-by: Jihoon Kwon <kjh010315@gmail.com>
Signed-off-by: Jaehun Gou <p22gone@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrlist.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index a4d74bed74fab..098bd7e8c3d64 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -52,6 +52,11 @@ int ntfs_load_attr_list(struct ntfs_inode *ni, struct ATTRIB *attr)
 
 	if (!attr->non_res) {
 		lsize = le32_to_cpu(attr->res.data_size);
+		if (!lsize) {
+			err = -EINVAL;
+			goto out;
+		}
+
 		/* attr is resident: lsize < record_size (1K or 4K) */
 		le = kvmalloc(al_aligned(lsize), GFP_KERNEL);
 		if (!le) {
@@ -66,6 +71,10 @@ int ntfs_load_attr_list(struct ntfs_inode *ni, struct ATTRIB *attr)
 		u16 run_off = le16_to_cpu(attr->nres.run_off);
 
 		lsize = le64_to_cpu(attr->nres.data_size);
+		if (!lsize) {
+			err = -EINVAL;
+			goto out;
+		}
 
 		run_init(&ni->attr_list.run);
 
-- 
2.51.0


