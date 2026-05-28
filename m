Return-Path: <stable+bounces-255282-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPc4NkGfGGpAlggAu9opvQ
	(envelope-from <stable+bounces-255282-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:02:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 095945F7AF0
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFEBB3038C36
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5555E3E3147;
	Thu, 28 May 2026 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XMd0vGpy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F0224677F;
	Thu, 28 May 2026 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998472; cv=none; b=XCk/Ib4HnuLQq0nTeKaOhjXWJxLu/4Fm9YYzljl/3jPJA7YwJNl2Du3vxznZgzN4eWcpOGqMoIDzBvCMEad99Jc5zLz6p8UItvIOoNJesnnV0GMi0UWCSLEppTV3IEz7yyCtg6NGznBgqX14EkKSkUSA7PdYXoohwE4UGgmgdvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998472; c=relaxed/simple;
	bh=rq4SUR9/Z3z8WH5nxgzAj1X1/AAujMeDI7lD2EfQH7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snIIRzKBziil3KpGMJlMzU08tbAV5j5lwH1nrpV1OIbDHoOoiBdNXPSvIgezL7K4eTTFJubYgZbvjMkqegyFCt9d5Q1lIepoeNKDAwclNRlpXU9HIBq9CPrnGmvjkfY2BgVT281mxpyY+KuaHqvHoK0LLh8qWjDycxp4ROd1z/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XMd0vGpy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522AD1F000E9;
	Thu, 28 May 2026 20:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998470;
	bh=FowXgyKjfQu8Qbj9ZvZ1zY4r84MnLcHFNCNOEHFF3Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XMd0vGpyTLLG2RCJMqIy43ply2fYagdBTtWuoH3ecVpAJLJag7+ixiqtTvGdXqZoz
	 6rlqXGEYpMwqPjjec62KgRG/0v6NJeyyOEnWOfDxU4Hh3ANw6Xg+WZ5i2OVpMXSMAS
	 t84SdAsVe0eZXKILvn+uOUtLheBifRekEr7euCHc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Carlier <devnexen@gmail.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 184/461] mm/memfd_luo: report error when restoring a folio fails mid-loop
Date: Thu, 28 May 2026 21:45:13 +0200
Message-ID: <20260528194652.402387980@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-255282-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 095945F7AF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Carlier <devnexen@gmail.com>

[ Upstream commit 0fb1daf0b78d0e23b63b6b65de56d4a3fd83bc14 ]

memfd_luo_retrieve_folios() initialises err to -EIO, but the per-iteration
calls to mem_cgroup_charge(), shmem_add_to_page_cache() and
shmem_inode_acct_blocks() reuse and overwrite err.  Once any iteration
completes successfully, err becomes zero.

If a later iteration's kho_restore_folio() returns NULL, the failure path
jumps to put_folios without resetting err, so the function returns 0.
The caller memfd_luo_retrieve() then takes the success path, sets
args->file and reports the restore as successful, leaving userspace with
a partially populated memfd and no indication that anything went wrong.

Set err to -EIO in the kho_restore_folio() failure branch so the error
is propagated to the caller.

Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
Link: https://patch.msgid.link/20260415052300.362539-1-devnexen@gmail.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memfd_luo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index cfd665a5b7874..bb5f601418032 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -412,6 +412,7 @@ static int memfd_luo_retrieve_folios(struct file *file,
 		if (!folio) {
 			pr_err("Unable to restore folio at physical address: %llx\n",
 			       phys);
+			err = -EIO;
 			goto put_folios;
 		}
 		index = pfolio->index;
-- 
2.53.0




