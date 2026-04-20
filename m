Return-Path: <stable+bounces-239300-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMDwBd1V5mkDuwEAu9opvQ
	(envelope-from <stable+bounces-239300-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:35:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A16D642FAE3
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BFE832263B2
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CF133C192;
	Mon, 20 Apr 2026 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ApUQCyko"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1505133BBCC;
	Mon, 20 Apr 2026 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699896; cv=none; b=r2JJIkwVd/6y90g+XSYLwz6QBigBrMlBpXhfNIT4bsg8LRDsICiJxP2eJTpkXeJxS74HwVISrI/04qScacaTGXekig7Qap0sIw69Cjt2Xia+Z09mBrS5rNhYTMp6SdrvCosmqgoRuoav9OwxliBmilkdG27LQKtsXg5MP+JY534=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699896; c=relaxed/simple;
	bh=d1AJ7EqISkmFq1MFrmBGUTKBMGnuHKSD01qzFlDTVE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgntEF20IsbIctx4np+gmK97hbPHrFk8TzfaWZxdeSF60LF3Uk1kO1mewc1u7wWM17NP6V4BnzVcAL5m03T/nLvcIlFLWbjkg1XopqJGDQp4QXkNonAS0NfHR5PJkiJufuRMpw7KfgeBg6+YGPqZkEVyNiqMguNqEc87BC0dVzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ApUQCyko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E802C19425;
	Mon, 20 Apr 2026 15:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776699896;
	bh=d1AJ7EqISkmFq1MFrmBGUTKBMGnuHKSD01qzFlDTVE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ApUQCykonC0ydv6D2XlYgbPNA+lIP2DM+QaDqDdobV6QB09aGmJO7C9WsCRpSyDny
	 73pfRLssQNs+dgjzy57mdrmWG9CrOp9+kRAGWgEmXbt6HPdpN+iLHdKsvHPN7PZBpc
	 veE8DsUxaYyJnTz/7PTpYyHmQk/7LrDjqd4qMO54=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 7.0 32/76] scripts/gdb/symbols: handle module path parameters
Date: Mon, 20 Apr 2026 17:41:43 +0200
Message-ID: <20260420153911.991319967@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153910.810034134@linuxfoundation.org>
References: <20260420153910.810034134@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239300-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:email,intel.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: A16D642FAE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Berg <benjamin.berg@intel.com>

commit 8e4513303b8726e4434f718ab39749cbb4c142b1 upstream.

commit 581ee79a2547 ("scripts/gdb/symbols: make BPF debug info available
to GDB") added support to make BPF debug information available to GDB.
However, the argument handling loop was slightly broken, causing it to
fail if further modules were passed.  Fix it to append these passed
modules to the instance variable after expansion.

Link: https://lkml.kernel.org/r/20260304110642.2020614-2-benjamin@sipsolutions.net
Fixes: 581ee79a2547 ("scripts/gdb/symbols: make BPF debug info available to GDB")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/gdb/linux/symbols.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -298,7 +298,7 @@ are loaded as well."""
             if p == "-bpf":
                 monitor_bpf = True
             else:
-                p.append(os.path.abspath(os.path.expanduser(p)))
+                self.module_paths.append(os.path.abspath(os.path.expanduser(p)))
         self.module_paths.append(os.getcwd())
 
         if self.breakpoint is not None:



