Return-Path: <stable+bounces-231658-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qADEJFv/y2kJNQYAu9opvQ
	(envelope-from <stable+bounces-231658-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:07:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBEF36DEBB
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC3A630F953A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A452D3E3C5C;
	Tue, 31 Mar 2026 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bx0jJeb/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C412EE262;
	Tue, 31 Mar 2026 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974734; cv=none; b=tKLDboBOZ7fLlQXnN9Dl2hWWr9ADoP+G3whOTPcQ7hRlKbeWTHRzFc3HM0ZYhw/w/rAWvjrW1IzQLMKzC1/mvLiViUhJDk/kTNH2SSEpD9kMa6DMGFx71Bmb/Pb34STpJdFBemICtLCKhLnQerg4q22u5UazynC+787p1QdbV20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974734; c=relaxed/simple;
	bh=akE71Jv4xiYg/mCBSuxw12mhohUmCdr84UcczpAzMbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoZ8zIdzz6ICUaGChi8xaHBOrQVHtsn+/7jMEfdwdaabL3hpwzhGBXhs0JJPW2ajKoMRXqqzN9dr8lN/9hy+uFt/1sSJcLYoGSwI1PdlPaBw2E8GJNRfq1+qZcLiyZmwSWh/b6tSbF+JZYBIpXDnEAFOj6egDPlnlGJTyRERVh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bx0jJeb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F82C19423;
	Tue, 31 Mar 2026 16:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974734;
	bh=akE71Jv4xiYg/mCBSuxw12mhohUmCdr84UcczpAzMbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bx0jJeb/oKL0ND74SaDLfsCOiiuh1m0+3wAn9ddIo9xvydiXO9/t14WGoKF8Ls2KZ
	 N5PgYThGJpekbqD6+pj21VBmcgAQ9o8N8Z3WdyktdiTBZJwB/pY76rQdZ1rQxeVEgb
	 qJgNaELdT8teMRgW30T/0Tg0ktAT3Kq1zN4pSxSw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 009/342] livepatch/klp-build: Fix inconsistent kernel version
Date: Tue, 31 Mar 2026 18:17:22 +0200
Message-ID: <20260331161759.254942270@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231658-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: 0CBEF36DEBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 6f93f7b06810d04acc6b106a7d5ecd6000f80545 ]

If .config hasn't been synced with auto.conf, any recent changes to
CONFIG_LOCALVERSION* may not get reflected in the kernel version name.

Use "make syncconfig" to force them to sync, and "make -s kernelrelease"
to get the version instead of having to construct it manually.

Fixes: 24ebfcd65a87 ("livepatch/klp-build: Introduce klp-build script for generating livepatch modules")
Closes: https://lore.kernel.org/20260217160645.3434685-10-joe.lawrence@redhat.com
Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Acked-by: Song Liu <song@kernel.org>
Link: https://patch.msgid.link/20260310203751.1479229-10-joe.lawrence@redhat.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/livepatch/klp-build | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 809e198a561d5..7b82c7503c2bf 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -285,15 +285,14 @@ set_module_name() {
 # application from appending it with '+' due to a dirty git working tree.
 set_kernelversion() {
 	local file="$SRC/scripts/setlocalversion"
-	local localversion
+	local kernelrelease
 
 	stash_file "$file"
 
-	localversion="$(cd "$SRC" && make --no-print-directory kernelversion)"
-	localversion="$(cd "$SRC" && KERNELVERSION="$localversion" ./scripts/setlocalversion)"
-	[[ -z "$localversion" ]] && die "setlocalversion failed"
+	kernelrelease="$(cd "$SRC" && make syncconfig &>/dev/null && make -s kernelrelease)"
+	[[ -z "$kernelrelease" ]] && die "failed to get kernel version"
 
-	sed -i "2i echo $localversion; exit 0" scripts/setlocalversion
+	sed -i "2i echo $kernelrelease; exit 0" scripts/setlocalversion
 }
 
 get_patch_files() {
-- 
2.51.0




