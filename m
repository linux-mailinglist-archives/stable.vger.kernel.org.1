Return-Path: <stable+bounces-226636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ2fAoqMuWnkJwIAu9opvQ
	(envelope-from <stable+bounces-226636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:16:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6F82AF3D6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E25A30514AE
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154923F54C2;
	Tue, 17 Mar 2026 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uS1rUrgB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACDB2FFDEA;
	Tue, 17 Mar 2026 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767577; cv=none; b=eY89k5jCwRiwLvM+zQJVUZEhbWYF/aqr7UZkYqX8hpc5j8Vydce+2a3120IH4k2eD2CZ7RIA2u6TGWjI3xkHSguOw/yEx15kVFZmGBwn7L6DHrLiaSjdHTQzjQdlgBtHhZnSJNB8Y8ivZ29QVhAm06vLJBNOIep3MAaA/2+47zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767577; c=relaxed/simple;
	bh=HfLz+0HkF1WCPuDP3HsDHjANpCHDPoFBwLyBeb4lp88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rACunMhBu9OvsPLzihiSQBayIeiaA/6HMgDqzOr45eDDLHdh3ox6NT3bLwTLNiEwHFz1blpUN7G/kZV3a1+oqCW4GCIk1bC/CkSyi1w++E8AcniAW4OlkvDjqljtFSsAOtqBLgpcWOR5an5QbAN5YWe7yexm7t6Nbl+dmvdQi24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uS1rUrgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1C6C19424;
	Tue, 17 Mar 2026 17:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767577;
	bh=HfLz+0HkF1WCPuDP3HsDHjANpCHDPoFBwLyBeb4lp88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uS1rUrgBFbDzxAeoztLj0aJL4HyYgIz8hQ++QR8OUXVO3zAuyCjbzuOWspVG/kgs9
	 CdNhP1MnDy0P5fxB9FCgUF1JHurkbANtpqZiHGSuLq5nfOxqcbcWZOHvXlYLZhRe8r
	 dhad+Hm7/qkkpkVVwtmPqW5I2isntIcM8k3iLyCQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Jann Horn <jannh@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 6.18 116/333] rust_binder: avoid reading the written value in offsets array
Date: Tue, 17 Mar 2026 17:32:25 +0100
Message-ID: <20260317163003.669295874@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226636-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE6F82AF3D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alice Ryhl <aliceryhl@google.com>

commit 4cb9e13fec0de7c942f5f927469beb8e48ddd20f upstream.

When sending a transaction, its offsets array is first copied into the
target proc's vma, and then the values are read back from there. This is
normally fine because the vma is a read-only mapping, so the target
process cannot change the value under us.

However, if the target process somehow gains the ability to write to its
own vma, it could change the offset before it's read back, causing the
kernel to misinterpret what the sender meant. If the sender happens to
send a payload with a specific shape, this could in the worst case lead
to the receiver being able to privilege escalate into the sender.

The intent is that gaining the ability to change the read-only vma of
your own process should not be exploitable, so remove this TOCTOU read
even though it's unexploitable without another Binder bug.

Cc: stable <stable@kernel.org>
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Link: https://patch.msgid.link/20260218-binder-vma-check-v2-2-60f9d695a990@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/android/binder/thread.rs |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -1018,12 +1018,9 @@ impl Thread {
 
         // Copy offsets if there are any.
         if offsets_size > 0 {
-            {
-                let mut reader =
-                    UserSlice::new(UserPtr::from_addr(trd_data_ptr.offsets as _), offsets_size)
-                        .reader();
-                alloc.copy_into(&mut reader, aligned_data_size, offsets_size)?;
-            }
+            let mut offsets_reader =
+                UserSlice::new(UserPtr::from_addr(trd_data_ptr.offsets as _), offsets_size)
+                    .reader();
 
             let offsets_start = aligned_data_size;
             let offsets_end = aligned_data_size + offsets_size;
@@ -1044,11 +1041,9 @@ impl Thread {
                 .step_by(size_of::<u64>())
                 .enumerate()
             {
-                let offset: usize = view
-                    .alloc
-                    .read::<u64>(index_offset)?
-                    .try_into()
-                    .map_err(|_| EINVAL)?;
+                let offset = offsets_reader.read::<u64>()?;
+                view.alloc.write(index_offset, &offset)?;
+                let offset: usize = offset.try_into().map_err(|_| EINVAL)?;
 
                 if offset < end_of_previous_object || !is_aligned(offset, size_of::<u32>()) {
                     pr_warn!("Got transaction with invalid offset.");



