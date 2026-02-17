Return-Path: <stable+bounces-217119-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMddOAzVlGnnIAIAu9opvQ
	(envelope-from <stable+bounces-217119-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:52:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 715681506DF
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D81FC305BFE1
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91144284B3B;
	Tue, 17 Feb 2026 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g4sCK2WT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5596229A1;
	Tue, 17 Feb 2026 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361487; cv=none; b=ihnuy4U26JMJnzpZ7U6IoFAI1ivifGPxFu9jNKNgSAfXwjX/EwYYmZnnE+DRayKCys5R1xNdS2mmOXJs/CU8/iYTv2m0Xz0TLk2mNmOPhLmgpkv+HRXgwrjorfnfPC+en9Qt9Ag6wLHbs4RWzN14feoQrBgsCRCZlnppDoaYjyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361487; c=relaxed/simple;
	bh=g+jfcuMClH2FAUO6pUMdFxgYLfAn+NlJGepFkKBgkSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5ZFZEYPBY6nlzSGlSldtc3mzciKrwJnGICnqj8WZxMkOnQwxdrLiYUquSBkZYqQYx7M+lvQR34aRSQfMqiKgpuOMZBpmlCtSE841v0BLOad3j0VSh8y9/3JKdGtIK1Ece4mVpEZEbeEBT5GodWrRCBYrUXZGtqWKjJ1078EVI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g4sCK2WT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8844C4CEF7;
	Tue, 17 Feb 2026 20:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361487;
	bh=g+jfcuMClH2FAUO6pUMdFxgYLfAn+NlJGepFkKBgkSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g4sCK2WTtdFlpWDbU67z+A3fQSqGN+9BQga1fhKGPZzT+36S01YDTjNsel5+tRgg6
	 rrWTjbvJ04beGT8phCmu4hx+cJSQD99xUtBlCx3o+snkpbM+FyfRnC+KY3QWbK63J9
	 /y3NpoNvjGYHm5OtMv/uIsDJWeTEORoJRlFRXaTE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 6.18 03/43] rust: dma: fix broken intra-doc links
Date: Tue, 17 Feb 2026 21:31:43 +0100
Message-ID: <20260217200006.602617696@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,de.bosch.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-217119-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,bosch.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 715681506DF
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: FUJITA Tomonori <fujita.tomonori@gmail.com>

commit 32cb3840386fd3684fbe8294cfc0a6684417139e upstream.

The `pci` module is conditional on CONFIG_PCI. When it's disabled, the
intra-doc link to `pci::Device` causes rustdoc warnings:

warning: unresolved link to `::kernel::pci::Device`
  --> rust/kernel/dma.rs:30:70
   |
30 | /// where the underlying bus is DMA capable, such as [`pci::Device`](::kernel::pci::Device) or
   |                                                                      ^^^^^^^^^^^^^^^^^^^^^ no item named `pci` in module `kernel`

Fix this by making the documentation conditional on CONFIG_PCI.

Fixes: d06d5f66f549 ("rust: dma: implement `dma::Device` trait")
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Dirk Behme <dirk.behme@de.bosch.com>
Link: https://patch.msgid.link/20251231045728.1912024-1-fujita.tomonori@gmail.com
[ Keep the "such as" part indicating a list of examples; fix typos in
  commit message. - Danilo ]
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/kernel/dma.rs |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -26,8 +26,9 @@ pub type DmaAddress = bindings::dma_addr
 /// Trait to be implemented by DMA capable bus devices.
 ///
 /// The [`dma::Device`](Device) trait should be implemented by bus specific device representations,
-/// where the underlying bus is DMA capable, such as [`pci::Device`](::kernel::pci::Device) or
-/// [`platform::Device`](::kernel::platform::Device).
+/// where the underlying bus is DMA capable, such as:
+#[cfg_attr(CONFIG_PCI, doc = "* [`pci::Device`](kernel::pci::Device)")]
+/// * [`platform::Device`](::kernel::platform::Device)
 pub trait Device: AsRef<device::Device<Core>> {
     /// Set up the device's DMA streaming addressing capabilities.
     ///



