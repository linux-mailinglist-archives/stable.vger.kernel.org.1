Return-Path: <stable+bounces-220899-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FXqDCVIo2l//AQAu9opvQ
	(envelope-from <stable+bounces-220899-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:55:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1D11C78AF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC07B342B8BF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B95D427D25;
	Sat, 28 Feb 2026 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAxGdZhY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D28E496914;
	Sat, 28 Feb 2026 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300788; cv=none; b=BuFrTaboOtkTqbJqPCde5jtIwCegDye6J7lm5WpGnros8GrJMN+SROSTEBUviZPKtUGZgQ8C6bmiwj2IBr/IRRD10B//GfogRBWm99BUuLmlSzORPPspdfP4TMSXSxBgTt7vssutdjrCRbuYz2IJKDaIhqPFTxTBFVz0hWFq3cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300788; c=relaxed/simple;
	bh=vWWgYDOWrP/1sJh38suuQpb9ZQiOHx8/B0uMDWh4wBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aIlDt6W3bECqfAsLAUELYyFWBzBeHCNka3XAqwW7mKIfy/51MeCDRi+uKuomtnBuUdHxma5jz6nAiqfVqlG/K12g2uhtQ4R66kYx1PnMDRHliN2Hdnoy/q4lr5wKVNyzeVN5iJKKxZPChX7GF/xxn+t1HSfGoNITDqAuAyLKcW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAxGdZhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B484C116D0;
	Sat, 28 Feb 2026 17:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300788;
	bh=vWWgYDOWrP/1sJh38suuQpb9ZQiOHx8/B0uMDWh4wBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jAxGdZhYintqUsVHiC+bVcqXfqN0xJY2jKBTtG5BzDoriZaWMtUGr0xdRFsrtlcgn
	 lR4kYhIafR8ADrHxb9qJ4oxn3204C41htfTZ7B7yhwP5WkjQ/HsJvgQ1GJsNEcYHzG
	 Fnq2jIbhrjHQWVpxiaDeJI6Oq27sfpnY2lEanAeTcG4ERt3KJwBJ+PXXOBLNlmDtR5
	 jQ4CVbUX0X88qTibnKNAzmbROEhDwLc/BvEVpqQngiQKIPZUjY9a7l3dDwE6zQXEdT
	 w3aRmxB15mStySNCbTBQFKmsn0zggScQYc4/q4pwrse8eEAvAJfqEIrCDeyUUxZS+H
	 vQ7myuChk+ykw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 820/844] kbuild: rpm-pkg: Disable automatic requires for manual debuginfo package
Date: Sat, 28 Feb 2026 12:32:13 -0500
Message-ID: <20260228173244.1509663-821-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220899-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: AA1D11C78AF
X-Rspamd-Action: no action

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit f94711255a73d8938cf3bb405a0af3a4d2700ed1 ]

Stefano reports that after commit 62089b804895 ("kbuild: rpm-pkg:
Generate debuginfo package manually"), building with an rpm package
using rpm 4.20.0 fails with:

  RPM build errors:
      Dependency tokens must begin with alpha-numeric, '_' or '/': #�) = 0x0d000002
      Dependency tokens must begin with alpha-numeric, '_' or '/': �) = 0x0d000000
      Dependency tokens must begin with alpha-numeric, '_' or '/': ) = 0x7c0e000000
      Unknown rich dependency op 'Hat': (Red Hat 15.2.1-7)) = 0x3130363230322000
      Unknown rich dependency op 'Hat': (Red Hat 15.2.1-7)) = 0x4728203a43434800
      Unknown rich dependency op 'Hat': (Red Hat 15.2.1-7)) = 0x3130363230322000
      Unknown rich dependency op 'Hat': (Red Hat 15.2.1-7)) = 0x4728203a43434800

This error comes from the automatic requirements feature of rpm. The
-debuginfo subpackage has no dependencies, so disable this feature with
'AutoReq: 0' for this subpackage, avoiding the error. This matches the
official %_debug_template macro that rpm provides. While automatic
provides should be default enabled, be explicit like %_debug_template
does.

Additionally, while in the area, add the manual debug information
package to the Development/Debug group, further aligning with
%_debug_template.

Cc: stable@vger.kernel.org
Fixes: 62089b804895 ("kbuild: rpm-pkg: Generate debuginfo package manually")
Reported-by: Stefano Garzarella <sgarzare@redhat.com>
Closes: https://lore.kernel.org/CAGxU2F7FFNgb781_A7a1oL63n9Oy8wsyWceKhUpeZ6mLk=focw@mail.gmail.com/
Tested-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://patch.msgid.link/20260216-improve-manual-debuginfo-template-v1-1-e584b3f8d3be@kernel.org
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/package/kernel.spec | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index bccf58bdd45fd..b3c956205af00 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -48,6 +48,9 @@ against the %{version} kernel package.
 %if %{with_debuginfo_manual}
 %package debuginfo
 Summary: Debug information package for the Linux kernel
+Group: Development/Debug
+AutoReq: 0
+AutoProv: 1
 %description debuginfo
 This package provides debug information for the kernel image and modules from the
 %{version} package.
-- 
2.51.0


