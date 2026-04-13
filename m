Return-Path: <stable+bounces-236181-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOSMAggW3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236181-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:12:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2063EE6F5
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC9AF30C11FC
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0701248880;
	Mon, 13 Apr 2026 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JXV9kRpM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EF624DCF6;
	Mon, 13 Apr 2026 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096251; cv=none; b=QVgl3Otl9Lrav65snAoBaluDf1XRMLkDkj712/FaiRKVsO/V6jBb4SSGRX6kk73fCcI4CyY+12s+NwHFyBJLfRBli4Ouqn7QyhrrBQmtzmcM3WPlx17in1Uw+zuEOhnZfEdITIbcUDz6NX/kiPk2LV7TM19wYk+PIXenX80ZvjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096251; c=relaxed/simple;
	bh=ll0qtaeJotfv9NP9LTqdNCkhbwYS/06MTCSbx9pNq1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7WGqZYeEh0hgVWYx2mbDDqjkjN/tHNm1PdGkY+0XUnX8AMTf9d9GzeyJeL/uGcQxpOEbf6RN3dPnPvUJQ3PRjRh8emoeabwheBBZbqT+9tdsmCKDpdYfsIO/vdwQRUgRqGA6pXroNcHyi4Qk0y5SIn+rJlSgykU95rMUpBClWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JXV9kRpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A05AC2BCAF;
	Mon, 13 Apr 2026 16:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096251;
	bh=ll0qtaeJotfv9NP9LTqdNCkhbwYS/06MTCSbx9pNq1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JXV9kRpMJ3nHOY+YId7hzt1OGCbpp7wP+bpHTcHgagZeR3AdHA9qLcvrENPVuYdMO
	 nC2Mv5dGTABd6cVJVeosZH77tVGQ6sRBABsXMsoHdyQ8FubPXuf51VLMSrkuqfh2WO
	 oft8Qj//+VGB9LRMLRp31Zwuxnau8S7CX4SRQhRE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Glass <sjg@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Janne Grunau <j@jannau.net>,
	Nicolas Schier <nsc@kernel.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: [PATCH 6.19 25/86] kbuild: modules-cpio-pkg: Respect INSTALL_MOD_PATH
Date: Mon, 13 Apr 2026 17:59:32 +0200
Message-ID: <20260413155732.512946666@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.568515178@linuxfoundation.org>
References: <20260413155731.568515178@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236181-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,chromium.org:email,linutronix.de:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: 6D2063EE6F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Janne Grunau <j@jannau.net>

commit 742de64b62b690a368dbeb846499eb8ac8ceedb9 upstream.

The modules-cpio-pkg target added in commit 2a9c8c0b59d3 ("kbuild: add
target to build a cpio containing modules") is incompatible with
initramfs with merged /lib and /usr/lib directories [1]. "/lib" cannot
be a link and directory at the same time.
Respect a non-empty INSTALL_MOD_PATH in the modules-cpio-pkg target so
that `make INSTALL_MOD_PATH=/usr modules-cpio-pkg` results in the same
module install location as `make INSTALL_MOD_PATH=/usr modules_install`.

Tested with Fedora distribution initramfs produced by dracut.

Link: https://systemd.io/THE_CASE_FOR_THE_USR_MERGE/ [1]
Fixes: 2a9c8c0b59d3 ("kbuild: add target to build a cpio containing modules")
Cc: stable@vger.kernel.org
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Janne Grunau <j@jannau.net>
Reviewed-by: Nicolas Schier <nsc@kernel.org>
Tested-by: Nicolas Schier <nsc@kernel.org>
Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Link: https://patch.msgid.link/20260327-kbuild-modules-cpio-pkg-usr-merge-v3-1-ef507dfa006c@jannau.net
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/Makefile.package |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -195,7 +195,7 @@ tar%-pkg: linux-$(KERNELRELEASE)-$(ARCH)
 .tmp_modules_cpio: FORCE
 	$(Q)$(MAKE) -f $(srctree)/Makefile
 	$(Q)rm -rf $@
-	$(Q)$(MAKE) -f $(srctree)/Makefile INSTALL_MOD_PATH=$@ modules_install
+	$(Q)$(MAKE) -f $(srctree)/Makefile INSTALL_MOD_PATH=$@/$(INSTALL_MOD_PATH) modules_install
 
 quiet_cmd_cpio = CPIO    $@
       cmd_cpio = $(CONFIG_SHELL) $(srctree)/usr/gen_initramfs.sh -o $@ $<
@@ -265,6 +265,7 @@ help:
 	@echo '  tarxz-pkg           - Build the kernel as a xz compressed tarball'
 	@echo '  tarzst-pkg          - Build the kernel as a zstd compressed tarball'
 	@echo '  modules-cpio-pkg    - Build the kernel modules as cpio archive'
+	@echo '                        (uses INSTALL_MOD_PATH inside the archive)'
 	@echo '  perf-tar-src-pkg    - Build the perf source tarball with no compression'
 	@echo '  perf-targz-src-pkg  - Build the perf source tarball with gzip compression'
 	@echo '  perf-tarbz2-src-pkg - Build the perf source tarball with bz2 compression'



