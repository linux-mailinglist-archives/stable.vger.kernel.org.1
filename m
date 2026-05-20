Return-Path: <stable+bounces-250954-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDXXKrrwDWp+4wUAu9opvQ
	(envelope-from <stable+bounces-250954-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:34:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A21594004
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05D363136849
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE8C3F1AC4;
	Wed, 20 May 2026 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MuJ9kCz+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800433E0C70;
	Wed, 20 May 2026 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296723; cv=none; b=q/EEMoglvx/e6Tumn0I/U0jkxQG4XlW5sf7ty28MtWLnzm01rwEjTZKnzPH3g/q2Unp6KMhV9WrqNt8m04zwlDRwRR20L8+uNY/eSuB29PBI893wGvIZbvZaD8OSTMR3gwulKv1LGLsidjUCfbsFV7wfCrv4G6PJeC+3Y8ZVPF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296723; c=relaxed/simple;
	bh=FgURfTNWx3AMIdyDyVa+vIz/hYWdog3B6298yq7ZP/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Se/fvJTeNnxuoltfKFDvwwxC8HykRt89YZeCMUUMTtDnsF7X5jToy3SdzSsIU4JtNgBCmOPVPm8HxrP9fq5bvMnN7C32S1tRAhz1FXDZUKLrKqIjWMmqNFX8dvhZiYTQNOUH3k2zaOL8YdXdEX7gbiRc5J94ST1MkC4Ml1io6AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MuJ9kCz+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C6A1F000E9;
	Wed, 20 May 2026 17:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296722;
	bh=Ljo+mf1Cu7tC4IYrNRrxBjkMWLNVHnnoV6he+8YYHkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MuJ9kCz+ihn0OkaUDe2Y6JWgC06qaSPN2DuMu1D5tUAyfq6zIcB5N1qmnZkGs3nO0
	 c6j9rQXDlaaQh1gCWYbDyzncqsYhs2PZdM6iwqMUNJ1nELxyewl3OOPZmbe+jFiumU
	 YZPpbnF6ugiWORTFs4MExOgzKSqvuJJ+4nRMdrzw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mathias Krause <minipli@grsecurity.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0870/1146] kbuild: builddeb - avoid recompiles for non-cross-compiles
Date: Wed, 20 May 2026 18:18:40 +0200
Message-ID: <20260520162207.927543971@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250954-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 65A21594004
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Krause <minipli@grsecurity.net>

[ Upstream commit 2452dcf4d740effff5aa71b7f6529ee8c04fd8f6 ]

Commit e2c318225ac1 ("kbuild: deb-pkg: add
pkg.linux-upstream.nokernelheaders build profile") changed how
install-extmod-build gets called, making it always rebuild the host
programs below scripts/ if HOSTCC wasn't specified with its full triplet
on the make command line. That is, apparently, needed to fix up commit
f1d87664b82a ("kbuild: cross-compile linux-headers package when
possible") for cross-compiles. However, in the much more common case of
non-cross-compile builds this will lead to unnecessary rebuilding of
host tools including gcc plugins. This, in turn, will lead to a full
kernel rebuild on the next 'make bindeb-pkg' which is unfortunate.

Avoid that by only triggering the rebuild of host tools for actual
cross-compile builds.

Signed-off-by: Mathias Krause <minipli@grsecurity.net>
Fixes: e2c318225ac1 ("kbuild: deb-pkg: add pkg.linux-upstream.nokernelheaders build profile")
Cc: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Nicolas Schier <nsc@kernel.org>
Link: https://patch.msgid.link/20260402145116.1010901-1-minipli@grsecurity.net
Signed-off-by: Nicolas Schier <nsc@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/package/builddeb | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 3627ca227e5a5..ba1defc616524 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -139,7 +139,13 @@ install_kernel_headers () {
 	pdir=debian/$1
 	version=${1#linux-headers-}
 
-	CC="${DEB_HOST_GNU_TYPE}-gcc" "${srctree}/scripts/package/install-extmod-build" "${pdir}/usr/src/linux-headers-${version}"
+	# Override $CC only for cross-compiles, to not unnecessarily rebuild
+	# scripts/ including plugins, which may lead to a full kernel rebuild.
+	if [ -n "${CROSS_COMPILE}" ]; then
+		CC="${DEB_HOST_GNU_TYPE}-gcc" "${srctree}/scripts/package/install-extmod-build" "${pdir}/usr/src/linux-headers-${version}"
+	else
+		"${srctree}/scripts/package/install-extmod-build" "${pdir}/usr/src/linux-headers-${version}"
+	fi
 
 	mkdir -p $pdir/lib/modules/$version/
 	ln -s /usr/src/linux-headers-$version $pdir/lib/modules/$version/build
-- 
2.53.0




