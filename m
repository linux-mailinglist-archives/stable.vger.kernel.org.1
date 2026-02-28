Return-Path: <stable+bounces-220488-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGP8MV88o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220488-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:05:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DFA1C694F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97CA8310C82F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665CE3C6C61;
	Sat, 28 Feb 2026 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fU6zCZWn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DF63C5CA5;
	Sat, 28 Feb 2026 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300374; cv=none; b=tpucmjN3MNPsildPu7mRNZLTGjneZd020B6ZkDxsIIrMsa2Kgp4BVKXlHWd6mHZ1BTn2shCTOKa9pVAwnxWy2vjh/nJWlByf5O+f3vCDCgrQwmaMCJYoqAwG//oz5DKcMZ0INlt6rs/8ZJUq56AaGFs1ubYVPCYAWOtXmF7xGk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300374; c=relaxed/simple;
	bh=p8922vCtxBCG5X3sTHGfzms+45v893kkBlH0TnDgQZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgvEQOAlHka6gYMCF4bRh5c/KK/RL0Cvjm6K7wESY0cEh7J7HZE5GZnVz2t4vexo5K5yPi3d00RQ3jN5yIWLakwZa359TEoTqb87W9UJEJvhIHdLWeDB3tTdeMkyak4wf6S/KXH5AZOiPaIqEKPF0EqfaV+wGl7lRFb4MDI38Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fU6zCZWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608C9C116D0;
	Sat, 28 Feb 2026 17:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300374;
	bh=p8922vCtxBCG5X3sTHGfzms+45v893kkBlH0TnDgQZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fU6zCZWnt08WFbwYF0kAyyc+joSwgnhlxv2x980kB7VNCUoH3NoVwJvtcJDsqZP8J
	 hq1aokkYhI+g0w50Vdi0NWS6aLIYIuqEPETXtvlRimJ0k5jvVV3PgtsbO3c76Py0xD
	 m89IqWcAcX8Ke+Y0Keh6aZFx2b7Tn7xKQOL0zdD5KbQlqXIlmqfGLquVP9nbicB/ku
	 Wcv3ZDfc8qw8gTiiAJ4iY5uSiNFIk934I2IGVs1ZLGX3yn0qMGm43tLG3YVI4lLwHx
	 +yuiwy90b0Y+J7SRj0yA9gzOMLACWFAuwX6KB2puwQ4ns0xZAMCThFsAfAIHxGS6CX
	 USQu2gmin2GRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 409/844] fs/ntfs3: avoid calling run_get_entry() when run == NULL in ntfs_read_run_nb_ra()
Date: Sat, 28 Feb 2026 12:25:22 -0500
Message-ID: <20260228173244.1509663-410-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220488-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,paragon-software.com:email]
X-Rspamd-Queue-Id: E4DFA1C694F
X-Rspamd-Action: no action

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit c5226b96c08a010ebef5fdf4c90572bcd89e4299 ]

When ntfs_read_run_nb_ra() is invoked with run == NULL the code later
assumes run is valid and may call run_get_entry(NULL, ...), and also
uses clen/idx without initializing them. Smatch reported uninitialized
variable warnings and this can lead to undefined behaviour. This patch
fixes it.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202512230646.v5hrYXL0-lkp@intel.com/
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/fsntfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index bd67ba7b50153..ea5b673462c35 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1252,6 +1252,12 @@ int ntfs_read_run_nb(struct ntfs_sb_info *sbi, const struct runs_tree *run,
 
 		} while (len32);
 
+		if (!run) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		/* Get next fragment to read. */
 		vcn_next = vcn + clen;
 		if (!run_get_entry(run, ++idx, &vcn, &lcn, &clen) ||
 		    vcn != vcn_next) {
-- 
2.51.0


