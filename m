Return-Path: <stable+bounces-272067-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cQXBEoNlSmqfCQEAu9opvQ
	(envelope-from <stable+bounces-272067-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 16:09:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D527C70A3F4
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 16:09:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AQHFjY18;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272067-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272067-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F46B3016648
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 14:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FA7377EA1;
	Sun,  5 Jul 2026 14:09:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1AC322533
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 14:09:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260545; cv=none; b=tnVQdzhU7wP0yg5tprHu6cb2OMplqesMTprYjboaSQ9343xDTTG8SHIa4JKTWxgoTJ/XAeKo6+dUkqg2F2RbzvulzR4RHLFP0c9YOfUx0jcJ0RcOZHmusy1Akkbt6EhqOczcdE8OABMJsFVcN4WCA4tnLaTCgSdU8VfMlWQ+zqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260545; c=relaxed/simple;
	bh=usyfYd9OCoMjre8zU9vUSCStLGumLKLDcE+NUb1DsXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pd8vvXc8Ms/jhJIhTBZYanXrzk0+Xwdrg7q35zHJNqKe3CSK1UnOzeuHTy+bys+vp36E/XcvzeOqZYXh/SYcIuggMA1bpSStpOwPpD5piQpe4MlC5psPZ2tklvpgs6CglRabZfgwuBAzcV11oifSbH2dsTctQIvOm2bUii7cC34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQHFjY18; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9EF1F000E9;
	Sun,  5 Jul 2026 14:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783260544;
	bh=Bq/PN65VitlScGx4UbR/uJvWkuDICdJ8IXiyZJSHY6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AQHFjY18wnSwfbWQ504ZWgXl4b3D5kvDjxH0HJU/GHTH6CoRh5wY0yhN4yB1Tlsah
	 +t5GuYrb7imiILw/etO3QCSrkuMvMZPbGLM7+ru69JhD/dh+wnb1ZFKie77dAEJb4+
	 L5VhBSd/ke3fvgm0cx+CCxgIWQW0sryX4kopwFI40cqds4oVmT+iICo0bX/rF9nHgy
	 r5xkFWx8z0nru3gBuJB+wGi+DsDD75gTMTjp2e7AcU5sgAGGcGLQEJj114tuN9UNKB
	 US/93DKJ1y3auz3abK6J2nKyJ9Wf2O6ZRUxIF0jCSz7wjo5pHi3QySFsrSnJzFZml9
	 OzlJOehrAJkTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] NFSv4/flexfiles: reject zero filehandle version count
Date: Sun,  5 Jul 2026 10:09:02 -0400
Message-ID: <20260705140902.1776411-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070243-unafraid-spooky-0873@gregkh>
References: <2026070243-unafraid-spooky-0873@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272067-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:michael.bommarito@gmail.com,m:anna.schumaker@hammerspace.com,m:sashal@kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,hammerspace.com,kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,hammerspace.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D527C70A3F4

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit 2c6bb3c40bc24f6aa8dfbe6fe98c3ad6389203f2 ]

ff_layout_alloc_lseg() decodes the filehandle-version array count
from the flexfiles layout body. The value is used as the count for
kzalloc_objs(), and the current code only rejects NULL.

A zero count yields ZERO_SIZE_PTR, which can be stored in
dss_info->fh_versions even though later flexfiles paths assume that at
least one filehandle version exists.

Reject fh_count == 0 before the allocation, matching the existing zero
version_count validation in the flexfiles GETDEVICEINFO parser.

A QEMU/KASAN run with a malformed flexfiles layout hit:

  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:ff_layout_encode_ff_layoutupdate.isra.0+0x15f/0x750
  ff_layout_encode_layoutreturn+0x683/0x970
  nfs4_xdr_enc_layoutreturn+0x278/0x3a0
  Kernel panic - not syncing: Fatal exception

The patched kernel rejects the malformed layout without KASAN/oops/panic,
and a valid fh_count=1 regression still opens, reads, and unmounts cleanly.

Cc: stable@vger.kernel.org
Fixes: d67ae825a59d ("pnfs/flexfiles: Add the FlexFile Layout Driver")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index e84ac71bdc18f8..01378fb1958451 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -460,6 +460,10 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		if (!p)
 			goto out_err_free;
 		fh_count = be32_to_cpup(p);
+		if (fh_count == 0) {
+			rc = -EINVAL;
+			goto out_err_free;
+		}
 
 		fls->mirror_array[i]->fh_versions =
 			kcalloc(fh_count, sizeof(struct nfs_fh),
-- 
2.53.0


