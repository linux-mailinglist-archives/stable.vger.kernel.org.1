Return-Path: <stable+bounces-221083-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YG5/EUpXo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221083-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:59:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0A01C8AD8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03A14315F80B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82441450902;
	Sat, 28 Feb 2026 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBm8JW4F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C2F301F0D;
	Sat, 28 Feb 2026 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301427; cv=none; b=N1GPTwhcicNxFQiOcRw9ySnyCknYNC+hX7p3QwrVEImeE+MlzrdsbsUU2GqcsF6ldlbq+cXzZkE45gcTN1a2JkuITqa3oir5oKpbZBbfnr4Ha1i46oiiy1okG9WFP5ykCdN4UJ24aJ3XsLAM4X5MXd5riN32xm4fdlLZEbRnX9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301427; c=relaxed/simple;
	bh=bCX3xrgJz/OqLbwF3/TCMmwl4wvf4/kKWWEmbbdhnSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUbdHiJ1RIU+J2tDTzBp2fSLp1MCLbqm1GEWWghDGlmrr/XFRVj8KvMjDhrDZNafhNc12gKlkz23n6Xa4PD+zElgB4HbA56xjPVAdqX+DU0U+z6gJohTcxAs2H0bOvCD4ZfRN1KJsK+YesxAFX5NlRaQJIWzAJ8NItvQsVGI7V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBm8JW4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E677C116D0;
	Sat, 28 Feb 2026 17:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301427;
	bh=bCX3xrgJz/OqLbwF3/TCMmwl4wvf4/kKWWEmbbdhnSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VBm8JW4F1Yf/nnTB/rON447KeVvEcqpkiFM13FGcmlmZ+337QnQScQi5ZXFAw0D7Q
	 P4DXT8mI2e/8VBF3X4IbQU1lxjqyQoLitTnIIIwK6FCAnITWjS/4Y4YBsSOG+blPY2
	 Y605U5CoPHZVzHlrWOt6fyD+W12VYskEcyng3bBIWrH1DLZQ99ZwqsR7f0nDQU5xF5
	 aE887Q3YD7z3EKfjor/UDCeIt9euIMHDgDEUmXyh8wAFWyelrNPiFaEWCARmiqYlpG
	 Lg4oT0n714bjrb/WfHXrFHe6nxGVpYu5WTTp7lmYy8ZQMKrLE4XiS3pUUTcPi3vJ1U
	 BBMowThU9bgKw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	r772577952@gmail.com,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 617/752] xfs: check return value of xchk_scrub_create_subord
Date: Sat, 28 Feb 2026 12:45:28 -0500
Message-ID: <20260228174750.1542406-617-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,lst.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-221083-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E0A01C8AD8
X-Rspamd-Action: no action

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit ca27313fb3f23e4ac18532ede4ec1c7cc5814c4a ]

Fix this function to return NULL instead of a mangled ENOMEM, then fix
the callers to actually check for a null pointer and return ENOMEM.
Most of the corrections here are for code merged between 6.2 and 6.10.

Cc: r772577952@gmail.com
Cc: <stable@vger.kernel.org> # v6.12
Fixes: 1a5f6e08d4e379 ("xfs: create subordinate scrub contexts for xchk_metadata_inode_subtype")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Jiaming Zhang <r772577952@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/common.c | 3 +++
 fs/xfs/scrub/repair.c | 3 +++
 fs/xfs/scrub/scrub.c  | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index e6145c2eda02a..975c879c8d7f5 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -1399,6 +1399,9 @@ xchk_metadata_inode_subtype(
 	int			error;
 
 	sub = xchk_scrub_create_subord(sc, scrub_type);
+	if (!sub)
+		return -ENOMEM;
+
 	error = sub->sc.ops->scrub(&sub->sc);
 	xchk_scrub_free_subord(sub);
 	return error;
diff --git a/fs/xfs/scrub/repair.c b/fs/xfs/scrub/repair.c
index efd5a7ccdf624..4d45d39e67f11 100644
--- a/fs/xfs/scrub/repair.c
+++ b/fs/xfs/scrub/repair.c
@@ -1136,6 +1136,9 @@ xrep_metadata_inode_subtype(
 	 * setup/teardown routines.
 	 */
 	sub = xchk_scrub_create_subord(sc, scrub_type);
+	if (!sub)
+		return -ENOMEM;
+
 	error = sub->sc.ops->scrub(&sub->sc);
 	if (error)
 		goto out;
diff --git a/fs/xfs/scrub/scrub.c b/fs/xfs/scrub/scrub.c
index 3c3b0d25006ff..c312f0a672e65 100644
--- a/fs/xfs/scrub/scrub.c
+++ b/fs/xfs/scrub/scrub.c
@@ -634,7 +634,7 @@ xchk_scrub_create_subord(
 
 	sub = kzalloc(sizeof(*sub), XCHK_GFP_FLAGS);
 	if (!sub)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	sub->old_smtype = sc->sm->sm_type;
 	sub->old_smflags = sc->sm->sm_flags;
-- 
2.51.0


