Return-Path: <stable+bounces-217108-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PhIEavUlGnHIAIAu9opvQ
	(envelope-from <stable+bounces-217108-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:50:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E893615061E
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5091A3016B9E
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEBF29A1;
	Tue, 17 Feb 2026 20:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eVAYuFIL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42584266581;
	Tue, 17 Feb 2026 20:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361449; cv=none; b=etwe/4F3KJdXPhu3WxpgBeHVaABodkAgbQLWlI6Eko67A2BBgsEBuYidIAd8czi1WiaK7mQNSFU5MlCAL0D4LSdw0Zo8espDCAgQlBUQLhzQj5Q5mFUIPoKrWdzFj6DdB2FC3yZIEHAxTeV+a1hKxmcsihI26+kvy9HCJK3OwRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361449; c=relaxed/simple;
	bh=EASunKS68P8Xf5tDVhZmrpeawRcMKjNSCYJKxbpNIq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxbSgZDjTU/grbFyKIVRJUJZwWc+Vbc8Yf+x/GYFMKlkiqmuKtpAwwhQvKwAaZrm9uuo0OqOK/QQmQnE5jAZTj8CR5MaxvE54oJB1eyZXKE+Xqezae8aMTPs3le3eUIGuFVxxGasTteSiZVXzzUnPGLSBpgGgaldboc0lWv+WLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eVAYuFIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52ADC4CEF7;
	Tue, 17 Feb 2026 20:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361449;
	bh=EASunKS68P8Xf5tDVhZmrpeawRcMKjNSCYJKxbpNIq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eVAYuFILbKKHvcFEgIV42eyi5i2DP+OoQ0Y6TDbsu5H4xJTeUIg2zMHnHMyPMUvtA
	 7k6PgRNJAadYWFP67KzjzC312LO6ICUxGvt52zfNrsbR17Tohm4RbCK577wft6wyig
	 /jyOjOeKU9sQCNS6NYcyB9MVvTxgSNW3q/mXbDb8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 6.18 02/43] rust: device: fix broken intra-doc links
Date: Tue, 17 Feb 2026 21:31:42 +0100
Message-ID: <20260217200006.565592619@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200006.470920131@linuxfoundation.org>
References: <20260217200006.470920131@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,de.bosch.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-217108-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,msgid.link:url]
X-Rspamd-Queue-Id: E893615061E
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: FUJITA Tomonori <fujita.tomonori@gmail.com>

commit a9a42f0754b6c69525612d678b73da790e28b9fd upstream.

The `pci` module is conditional on CONFIG_PCI. When it's disabled, the
intra-doc link to `pci::Device` causes rustdoc warnings:

warning: unresolved link to `kernel::pci::Device`
   --> rust/kernel/device.rs:163:22
    |
163 | /// [`pci::Device`]: kernel::pci::Device
    |                      ^^^^^^^^^^^^^^^^^^^ no item named `pci` in module `kernel`
    |
    = note: `#[warn(rustdoc::broken_intra_doc_links)]` on by default

Fix this by making the documentation conditional on CONFIG_PCI.

Fixes: d6e26c1ae4a6 ("device: rust: expand documentation for Device")
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Dirk Behme <dirk.behme@de.bosch.com>
Link: https://patch.msgid.link/20251231045728.1912024-2-fujita.tomonori@gmail.com
[ Keep the "such as" part indicating a list of examples; fix typos in
  commit message. - Danilo ]
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/kernel/device.rs |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -62,8 +62,9 @@ pub mod property;
 ///
 /// # Implementing Bus Devices
 ///
-/// This section provides a guideline to implement bus specific devices, such as [`pci::Device`] or
-/// [`platform::Device`].
+/// This section provides a guideline to implement bus specific devices, such as:
+#[cfg_attr(CONFIG_PCI, doc = "* [`pci::Device`](kernel::pci::Device)")]
+/// * [`platform::Device`]
 ///
 /// A bus specific device should be defined as follows.
 ///
@@ -155,7 +156,6 @@ pub mod property;
 ///
 /// [`AlwaysRefCounted`]: kernel::types::AlwaysRefCounted
 /// [`impl_device_context_deref`]: kernel::impl_device_context_deref
-/// [`pci::Device`]: kernel::pci::Device
 /// [`platform::Device`]: kernel::platform::Device
 #[repr(transparent)]
 pub struct Device<Ctx: DeviceContext = Normal>(Opaque<bindings::device>, PhantomData<Ctx>);



