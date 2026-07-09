Return-Path: <stable+bounces-273009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5u6LFu7cT2pbpQIAu9opvQ
	(envelope-from <stable+bounces-273009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 19:39:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F39733E3B
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 19:39:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="KUHG/UTL";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273009-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273009-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96026300FC4B
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 17:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA5B4D9900;
	Thu,  9 Jul 2026 17:36:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBF44D9905
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 17:36:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618612; cv=none; b=eiQOzpAqTAqQIlZs71xrdDU9/ycqQKszdGZBUVVuv4PGJhDvE24NVWdjAtNe40GOhFaWqwHpVNOT4lVdktX6eTW46+kKyXnW3sDvCOOjZ4FQ0LJXWgK7uw4j8VbLLdFrxrsN75gh5FxSLYA0F7rjq+NUNx+hgKkrMyGvIE5tZZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618612; c=relaxed/simple;
	bh=iuRsIfWADv0UwAteqcMid8DRNtDnVrryh4eQtOra86I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=d6560gRrti8NCgVrftje9VhfX6x4wc9AH6KU+86N8s9lWwp3IXNhC2z+Lofak67B/xQtyppnNcnq2k6SYGNnqizxBQQLDgk80aP5lfv/GYVYM30WtB99bziZeCBijxoTyC6b5iQ+mzm1ADFi/dha/XroXGMXV1+Hm44Cd3tS+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KUHG/UTL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D121F000E9;
	Thu,  9 Jul 2026 17:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783618611;
	bh=xEsSSx7dfb0V1cNvxRvF0F/UTU+dVbYnH4vtUJUY53A=;
	h=Subject:To:Cc:From:Date;
	b=KUHG/UTLBtRj3qLTclmTrCOHPVY1HOqzl1wmRrezgmSWU717FwqxLP9ZVcYV2S3K/
	 I56V2gZ8YnuyYWDQqKsJmTBB/CGstUmGntNjxHcpwLSTBw21JpzVYPkUhVccxdIpc7
	 4pCrtRQnrj+XOyv8kimcoLzQoRMy1NHZHBw13y7M=
Subject: FAILED: patch "[PATCH] rust: kasan: KASAN+RUST requires clang" failed to apply to 6.12-stable tree
To: aliceryhl@google.com,gary@garyguo.net,ojeda@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 09 Jul 2026 19:36:39 +0200
Message-ID: <2026070939-unworldly-mantra-5611@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273009-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:gary@garyguo.net,m:ojeda@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:mid,vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4F39733E3B


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5b271543d0f08e9733d4732721e960e285f6448f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070939-unworldly-mantra-5611@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5b271543d0f08e9733d4732721e960e285f6448f Mon Sep 17 00:00:00 2001
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 8 Apr 2026 08:32:16 +0000
Subject: [PATCH] rust: kasan: KASAN+RUST requires clang

Kernel KASAN involves passing various llvm/gcc specific arguments to
the C and Rust compiler. Since these arguments differ between llvm and
gcc, it's not safe to mix an llvm-based rustc with a gcc build when
kasan is enabled.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Cc: stable@vger.kernel.org
Fixes: e3117404b411 ("kbuild: rust: Enable KASAN support")
Link: https://patch.msgid.link/20260408-kasan-rust-sw-tags-v3-1-e07964d14363@google.com
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

diff --git a/init/Kconfig b/init/Kconfig
index 2937c4d308ae..826a7d768ca3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2198,6 +2198,7 @@ config RUST
 	depends on !DEBUG_INFO_BTF || (PAHOLE_HAS_LANG_EXCLUDE && !LTO)
 	depends on !CFI || HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC
 	select CFI_ICALL_NORMALIZE_INTEGERS if CFI
+	depends on !KASAN || CC_IS_CLANG
 	depends on !KASAN_SW_TAGS
 	help
 	  Enables Rust support in the kernel.


