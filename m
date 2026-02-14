Return-Path: <stable+bounces-216485-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDnKKOV5kGkBaQEAu9opvQ
	(envelope-from <stable+bounces-216485-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 14:34:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 819CD13C1E6
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 14:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E8B330210F6
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 13:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF851D5ABA;
	Sat, 14 Feb 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="cN+XJ0ud"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D70433B3;
	Sat, 14 Feb 2026 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771076064; cv=none; b=ZM94R1WB+CTN7fxyYz4jPrgwWSvRzS66cJR77ogGenmq+gnTq5eBp2l4Cl1rkF6CqlPTfSH5kouRNo0GQVmLb5ZbwsdNdsI88wBSmNiZB0lbY7oA6cGKYeNkCbyj7pM4NrgJiGf2Iz8jg6ch+0aTnjLAn/iUfeVotWKCww+/OFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771076064; c=relaxed/simple;
	bh=XYHDZzVKW99T6G9pkb2RTf2Fk7EvGAbdf7cdUCaErIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nRbZBzYnkafeFRStxRs/3D+LU+Ii5UM1D799c8L85zJyLA4EdhY6PIHKPcq31wCWOrQAP0j/eYzQRKvvrWHqfjmSLDERv0NyDUvdqtPFm9f94xBjed5U1AAexkT+o9RApuX9toIZdNIZyGdmj2Ea2G/FI//4Vg4JDVT1YwYbzwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=cN+XJ0ud; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1771076060;
	bh=phx2U09w0bMe/osybBoIqJR9EWk1uNkB+tFOzqwtjBc=;
	h=From:To:Cc:Subject:Date:From;
	b=cN+XJ0ud3ERtMvIy0pPuEuAQ8VUi2EDCF2gBmFpknfMeCM+E4KCmJ/xX3lcfIxeK7
	 uOiYd620PywDNo3Rnj9CcPjTPn7zsZwYI/vgRiA6yFcqhSHvWt5xmP+IWcb1RbeXzY
	 FvMjkZZ/HvOAH1xMITACe/n+N6aHJhWulIq1cq6o=
Received: from stargazer (unknown [IPv6:2408:8427:6a1:ffef:9848:ba49:67aa:3472])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 549C26696A;
	Sat, 14 Feb 2026 08:34:10 -0500 (EST)
From: Xi Ruoyao <xry111@xry111.site>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Mingcong Bai <jeffbai@aosc.io>,
	loongarch@lists.linux.dev,
	hev <r@hev.cc>,
	Xi Ruoyao <xry111@xry111.site>,
	Miguel Ojeda <ojeda@kernel.org>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Matt Gilbride <mattgilbride@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rust_binder: Fix build failure if !CONFIG_COMPAT
Date: Sat, 14 Feb 2026 21:32:06 +0800
Message-ID: <20260214133337.112720-1-xry111@xry111.site>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[xry111.site,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[xry111.site:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-216485-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[xry111.site:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,xen0n.name,aosc.io,lists.linux.dev,hev.cc,xry111.site,vger.kernel.org,linuxfoundation.org,android.com,google.com,gmail.com,paul-moore.com];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xry111.site:mid,xry111.site:dkim,xry111.site:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 819CD13C1E6
X-Rspamd-Action: no action

The bindgen utility cannot handle "#define compat_ptr_ioctl NULL" in the
C header, so we need to handle this case on our own.

Simply skip this field in the initializer when !CONFIG_COMPAT as the
SAFETY comment above this initializer implies this is allowed.

Reported-by: Miguel Ojeda <ojeda@kernel.org>
Closes: https://lore.kernel.org/all/CANiq72mrVzqXnAV=Hy2XBOonLHA6YQgH-ckZoc_h0VBvTGK8rA@mail.gmail.com/
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---

Changes from v1: fix Miguel's mail address and add tags for stable
backport.

 drivers/android/binder/rust_binder_main.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/android/binder/rust_binder_main.rs b/drivers/android/binder/rust_binder_main.rs
index 47bfb114cabb..e70f250bb4cd 100644
--- a/drivers/android/binder/rust_binder_main.rs
+++ b/drivers/android/binder/rust_binder_main.rs
@@ -312,6 +312,7 @@ unsafe impl<T> Sync for AssertSync<T> {}
         owner: THIS_MODULE.as_ptr(),
         poll: Some(rust_binder_poll),
         unlocked_ioctl: Some(rust_binder_ioctl),
+        #[cfg(CONFIG_COMPAT)]
         compat_ioctl: Some(bindings::compat_ptr_ioctl),
         mmap: Some(rust_binder_mmap),
         open: Some(rust_binder_open),
-- 
2.53.0


