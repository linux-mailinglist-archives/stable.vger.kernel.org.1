Return-Path: <stable+bounces-250032-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKlwNhniDWop4gUAu9opvQ
	(envelope-from <stable+bounces-250032-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:32:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7659A5920C0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3EE61307A783
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C5C39DBE1;
	Wed, 20 May 2026 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kOV86/kp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8082D39B4AE;
	Wed, 20 May 2026 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294364; cv=none; b=GdwaR+2p6387t4kR4jhcHSi2SP5pI1hUin8y0ZT5GrxDkEDvg1aOHCXK1/BjJ6yo639hfxyuEHLPBqOGeh91Gx8pZ6sL/tpxMqeXlQbuTS3Ez+wE27rXZqNbmj7A/i3asD0Xjq8NvtiL3M16CT29Ol1GidzU7FZeKPQOEVv/Ez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294364; c=relaxed/simple;
	bh=U8qX6sOP29giCfc+XQvJo3/rWJsH8uMRu+nFBep8/Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMPPuy8WPTUu07jiuzfmj2SH/R0JdTh8jsM6FQqk+IsCPTITJqNLw6/iM8iml5wEGHp4DklqxpKagC7nZZzsXGRge2AqT0rX3qqGZTez8f5aNBQMsoZFAwwIDapXhJWxlEtyrao3cvUXt94456NYELIBXRU14Ky2eNy7yc9y++w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kOV86/kp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9101F000E9;
	Wed, 20 May 2026 16:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294363;
	bh=VtYZSel5iLTR3+g8Nv5PJMHk/rL5qCI7wR+YzId8ISk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kOV86/kpOAMzOGjLEGxCt8WuXB9O5Hu/vMkcPyAuaZjaszKSJJ2SX26GMKYP8VgkX
	 yNb+HKKkwhoEWRzSi9Ok504Q9Vm+pgeewcuJLyt67ZMawZZ4P4HsFiLx0AcOPBe8w/
	 3CxLtUEAh/knW8XuiLYoiQ8Hccfuyws/ErCFBwCw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cole Leavitt <cole@unwrap.rs>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0012/1146] pstore/ram: fix resource leak when ioremap() fails
Date: Wed, 20 May 2026 18:04:22 +0200
Message-ID: <20260520162148.669892758@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250032-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7659A5920C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cole Leavitt <cole@unwrap.rs>

[ Upstream commit 2ddb69f686ef7a621645e97fc7329c50edf5d0e5 ]

In persistent_ram_iomap(), ioremap() or ioremap_wc() may return NULL on
failure. Currently, if this happens, the function returns NULL without
releasing the memory region acquired by request_mem_region().

This leads to a resource leak where the memory region remains reserved
but unusable.

Additionally, the caller persistent_ram_buffer_map() handles NULL
correctly by returning -ENOMEM, but without this check, a NULL return
combined with request_mem_region() succeeding leaves resources in an
inconsistent state.

This is the ioremap() counterpart to commit 05363abc7625 ("pstore:
ram_core: fix incorrect success return when vmap() fails") which fixed
a similar issue in the vmap() path.

Fixes: 404a6043385d ("staging: android: persistent_ram: handle reserving and mapping memory")
Signed-off-by: Cole Leavitt <cole@unwrap.rs>
Link: https://patch.msgid.link/20260225235406.11790-1-cole@unwrap.rs
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pstore/ram_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index ed97494abf60f..0713ef986c204 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -488,6 +488,10 @@ static void *persistent_ram_iomap(phys_addr_t start, size_t size,
 	else
 		va = ioremap_wc(start, size);
 
+	/* We must release the mem region if ioremap fails. */
+	if (!va)
+		release_mem_region(start, size);
+
 	/*
 	 * Since request_mem_region() and ioremap() are byte-granularity
 	 * there is no need handle anything special like we do when the
-- 
2.53.0




