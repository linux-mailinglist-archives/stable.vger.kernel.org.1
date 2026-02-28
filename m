Return-Path: <stable+bounces-220486-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCnLKLU3o2lx+gQAu9opvQ
	(envelope-from <stable+bounces-220486-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:45:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2187A1C638B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FC6530B92E0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D092835DA58;
	Sat, 28 Feb 2026 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQNtNJ/v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949CE35DA50;
	Sat, 28 Feb 2026 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300372; cv=none; b=Z4SopTOl6hmUwpyIJYkVGMG9+UD9wP3NVjk+SGIP4Lae/bscX01tjKEwX/CoTHsQ+oAMlEVhZFD1iysLVIm2gcLZ2Umqaa22DnIC+36t7LBK52OMJ/ug1OFUPvc0Du4E9cwrtjNulOBxFGsBr7p4m4u86bUHEhZ8O8fkphnhXHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300372; c=relaxed/simple;
	bh=z69yTu7YGTdTn6w8tiKYhaaMN4El/O20bnCQeaVdANU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDLlss21nzcMccf5gpiGET0bG10terAwkVnTYaqKMTOzFNR65lgfI8rHy2pIrrPXTB9Num6nKvKIZaE2zY5G9MvJ5GWlxlxfojoFKYlBYslm/VzXmpfIX10wz0Zuz5dwd5CpPfvFHVV2m4wy8L+yn5ZmdJ0lB9AjenGfgysfPc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQNtNJ/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB655C19425;
	Sat, 28 Feb 2026 17:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300372;
	bh=z69yTu7YGTdTn6w8tiKYhaaMN4El/O20bnCQeaVdANU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQNtNJ/vntFGHO7/ZoyiqZrBo60sVz13+OUbg1t89qbjz8vt7doNG9EHnH7Sga3Hn
	 1KCej+onQNJ5RuPD4Kq3f+hgZyVhGaR8+hMEbfOFy/UDZBIlG34JBx3AlJ4EI8cIQs
	 WuIr+tH5ytdkmvjiq89e6SdgrsUi6AvnSC7wNOY9bwBpxbCoLmX2t/DGbFpmHe9VW9
	 jgYZy5QlVUTu0OvrihhQx8Ufw49ZYav4brxgXm/PN6PDgT66TB9M8W+BvNadnwlTx1
	 CkBxqZIVWb55tflgKD3Fajena0gKFLXTcqUsTiRIzNto7Y5UArUkfhoVUZ9avVCu71
	 3M6DBDO6IAg0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 407/844] fs/ntfs3: drop preallocated clusters for sparse and compressed files
Date: Sat, 28 Feb 2026 12:25:20 -0500
Message-ID: <20260228173244.1509663-408-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-220486-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2187A1C638B
X-Rspamd-Action: no action

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 3a6aba7f3cf2b46816e08548c254d98de9c74eba ]

Do not keep preallocated clusters for sparsed and compressed files.
Preserving preallocation in these cases causes fsx failures when running
with sparse files and preallocation enabled.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrib.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index c45880ab23912..0cd15a0983fee 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -448,8 +448,10 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 
 	is_ext = is_attr_ext(attr_b);
 	align = sbi->cluster_size;
-	if (is_ext)
+	if (is_ext) {
 		align <<= attr_b->nres.c_unit;
+		keep_prealloc = false;
+	}
 
 	old_valid = le64_to_cpu(attr_b->nres.valid_size);
 	old_size = le64_to_cpu(attr_b->nres.data_size);
-- 
2.51.0


