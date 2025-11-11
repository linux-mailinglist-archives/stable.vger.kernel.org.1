Return-Path: <stable+bounces-194495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C269C4E78D
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 15:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC53189ADFB
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 14:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60482FFDF5;
	Tue, 11 Nov 2025 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NKzj566x"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDDB2D9ECB
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871027; cv=none; b=BPZphP+AWVK0JH29MFM5yCTbLsl+fH0bFWn9AuYMLR7m0nGKzWE3mEuBU2V15QSGnBGztrT9DNA4l5NujWoA+7Fu1O4oK/BoukouurdPHgbP6dm/OtuVY6T/j6fknCtnKEPTunHmml1zI04wX0VSIBmjflF2K2QP65F8Gv0n0ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871027; c=relaxed/simple;
	bh=e5GVvwwNh3mt36KCRc8l8SS+jQ/Eyzi0ZnDOF/cdYMk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nMGOFx3qrByZL9A8ztFv0SY6V8BHrxTERxv1lj7yH7bRWsLQHSaJ0TCZI5i2jUUhAx8yVG3tgTHUZ2Ao3bmpOm4uskW6WcLrKsSRvKS3uVKwfX8zNFqPYRunoWpKH1X8wkCfSxw3Xrp6/trLNv628wm1aaZkxhS2PaLj2rL9dL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NKzj566x; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-42b366a76ffso1181957f8f.1
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 06:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762871024; x=1763475824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V0YnbncW7/D7B63+yYbX+qVCVwE/BIYX0SzfhRNXW+4=;
        b=NKzj566x+I/qc2FIhreES/EwnrLrDunetvoOiDC+fgZ5F1rtu5Pu+vYaj9EK2as+xU
         ZGvqxMmSRbA9e0nmzHV3vqplmGlq++tQQ/aMJ5WqZ+aHYL9mMuvMsK1McDnww+PLvPWL
         6DxKPjdnycRsq/rLNZzQD4ZeN3wt0PM6govVl7jaNRciydT3w+UpI2/DKypU/rbwO5rg
         HCSANLc26ujktlEsuZPYyFHUbkmwdyvA8bbsnYcGj9uYmoY3Xa7CNZ2RZlz3G4KVwU4K
         DADpxFnz7PXt+0aC2PeFHI5Ecg68v2qALUYcSCY6A7qMQuCpWmXUMXZi3FrIBVRzrP1i
         zllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762871024; x=1763475824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0YnbncW7/D7B63+yYbX+qVCVwE/BIYX0SzfhRNXW+4=;
        b=hJZsMNEO0iOM78LgCNO6013XElpasn/OeOvIjSGY2FkN3zz+AgWyW7hZ585tvETiKW
         +zpXMxD2gvcX0f6EkY9rpamyXt/Oxmi+dk3x+sFQyPQJmVlbH2F+53EP3/iOCFG8XML/
         XOiaDULtPgPa/4QcrCyiNqfuGJi2DeYIZIGBlYPJBdH3v4bPqWGhxjiMkPBVOYA8HoA7
         FxWTCLiIg0eqJNKyaBE1f17hmjW97yihQyV7ovUlrq0fn8YJ4QoqRXcaZBo0IWmTaUkr
         FlL782ssHVQStcsC1KuTqDhBd/PTD53LGyQM78VgKsu2BNzyvL9JBBpfRq657KvJhK7v
         sufg==
X-Forwarded-Encrypted: i=1; AJvYcCVQsOcOU3cVTz5AEdxjcTB4egnQ8aek/RZYwiAhjKuPws/4qzQX0a4I7wVMwBcQhlyQG5m0x5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrBF7M/RD2sfjcFFlEaAEHsdFPThWD5F56I1fMCC/fe8c+ec5O
	MGz2ux1hCUdKbeJU1NMTx5qE39PUNXZyispiRC9rmiizKjyflZdQbi4TNzT4bsL1F6GKn4UJ+8D
	PKTLgghSjiDwYPFHvyw==
X-Google-Smtp-Source: AGHT+IFlmYhkLotEbVpBhIRfNq6n9bdvG2YLXC9Yuy8WZpthzfYTPHRt4svcZ54roRarvC6nzzaDm8ihzrXnPDM=
X-Received: from wrbeg3.prod.google.com ([2002:a05:6000:21c3:b0:42b:29df:cc2c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5d0f:0:b0:429:b1e4:1f79 with SMTP id ffacd0b85a97d-42b2dc6b007mr11121777f8f.58.1762871024258;
 Tue, 11 Nov 2025 06:23:44 -0800 (PST)
Date: Tue, 11 Nov 2025 14:23:32 +0000
In-Reply-To: <20251111-binder-fix-list-remove-v1-0-8ed14a0da63d@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111-binder-fix-list-remove-v1-0-8ed14a0da63d@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4858; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=e5GVvwwNh3mt36KCRc8l8SS+jQ/Eyzi0ZnDOF/cdYMk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpE0btTcI2L2I7+d+hvoAPqWdivJqIImxiqp03G
 PPLKdoMyk2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRNG7QAKCRAEWL7uWMY5
 RgHxEACFvNzsgm7XSu3byU7bh78e7MqurtYIV7+8BcO6t/ZFWtq1GBKe32Cbyf00j9RPkFDMg9q
 3VbENh5o2JtcHWUxJlwzO+Po8JG699/Q6+qFeA50+0jvFizuvZ26CCQg76jXy4egIgZVRlYdxcw
 oztrlwOoV8hXV1k1RvJpZJji9naqmQQfArA+i9W0O5+XnaIuQ/vzc5AjbukyHS8z0bDqic1Cw7T
 D1KDZ11xfkQtSMo9/crjqD451+QPrDHHFpYDNatV9BdsNPdJ+/Zlvhwc78/QWwUD7MlXWglTP8W
 hZTMpHxP6FUJ//Op0vBtZq4+7FDvpsTOgVPrA/jfMz76gTN1SEXq+0eeO4+FZEc0/dv8A0VB9XD
 +3RbYYDja0U7lC9aukqlChSzeZK7MoDfQ6Aj4kLMTexZJsq9Or1Cu5JCW2tIWuEYpu8OYFtpyI4
 cOxd3aN1Zd317gf1UcyIvObS2A1YPd3B8pvNw6iX6zYFISkSEPFNlbGiqPAZ0G+2cv5yHtT+LDC
 icXupfhOwY2UeGARP888XWTPENWyP2SG8fa/RnAJh8Mb2R90uJWRIm0xO1bVqT30FOkr/Sq+2Gh
 jVQrVXZPwpesgr+Hroi32cUFbrXFLSMJDvcO25a6qjB0E5FfqY0l2dS0VWR5EutYJ0+AGz+Y9na MnO24HmNi8yvThw==
X-Mailer: b4 0.14.2
Message-ID: <20251111-binder-fix-list-remove-v1-1-8ed14a0da63d@google.com>
Subject: [PATCH 1/3] rust_binder: fix race condition on death_list
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>
Cc: "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

Rust Binder contains the following unsafe operation:

	// SAFETY: A `NodeDeath` is never inserted into the death list
	// of any node other than its owner, so it is either in this
	// death list or in no death list.
	unsafe { node_inner.death_list.remove(self) };

This operation is unsafe because when touching the prev/next pointers of
a list element, we have to ensure that no other thread is also touching
them in parallel. If the node is present in the list that `remove` is
called on, then that is fine because we have exclusive access to that
list. If the node is not in any list, then it's also ok. But if it's
present in a different list that may be accessed in parallel, then that
may be a data race on the prev/next pointers.

And unfortunately that is exactly what is happening here. In
Node::release, we:

 1. Take the lock.
 2. Move all items to a local list on the stack.
 3. Drop the lock.
 4. Iterate the local list on the stack.

Combined with threads using the unsafe remove method on the original
list, this leads to memory corruption of the prev/next pointers. This
leads to crashes like this one:

	Unable to handle kernel paging request at virtual address 000bb9841bcac70e
	Mem abort info:
	  ESR = 0x0000000096000044
	  EC = 0x25: DABT (current EL), IL = 32 bits
	  SET = 0, FnV = 0
	  EA = 0, S1PTW = 0
	  FSC = 0x04: level 0 translation fault
	Data abort info:
	  ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
	  CM = 0, WnR = 1, TnD = 0, TagAccess = 0
	  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
	[000bb9841bcac70e] address between user and kernel address ranges
	Internal error: Oops: 0000000096000044 [#1] PREEMPT SMP
	google-cdd 538c004.gcdd: context saved(CPU:1)
	item - log_kevents is disabled
	Modules linked in: ... rust_binder
	CPU: 1 UID: 0 PID: 2092 Comm: kworker/1:178 Tainted: G S      W  OE      6.12.52-android16-5-g98debd5df505-4k #1 f94a6367396c5488d635708e43ee0c888d230b0b
	Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
	Hardware name: MUSTANG PVT 1.0 based on LGA (DT)
	Workqueue: events _RNvXs6_NtCsdfZWD8DztAw_6kernel9workqueueINtNtNtB7_4sync3arc3ArcNtNtCs8QPsHWIn21X_16rust_binder_main7process7ProcessEINtB5_15WorkItemPointerKy0_E3runB13_ [rust_binder]
	pstate: 23400005 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
	pc : _RNvXs3_NtCs8QPsHWIn21X_16rust_binder_main7processNtB5_7ProcessNtNtCsdfZWD8DztAw_6kernel9workqueue8WorkItem3run+0x450/0x11f8 [rust_binder]
	lr : _RNvXs3_NtCs8QPsHWIn21X_16rust_binder_main7processNtB5_7ProcessNtNtCsdfZWD8DztAw_6kernel9workqueue8WorkItem3run+0x464/0x11f8 [rust_binder]
	sp : ffffffc09b433ac0
	x29: ffffffc09b433d30 x28: ffffff8821690000 x27: ffffffd40cbaa448
	x26: ffffff8821690000 x25: 00000000ffffffff x24: ffffff88d0376578
	x23: 0000000000000001 x22: ffffffc09b433c78 x21: ffffff88e8f9bf40
	x20: ffffff88e8f9bf40 x19: ffffff882692b000 x18: ffffffd40f10bf00
	x17: 00000000c006287d x16: 00000000c006287d x15: 00000000000003b0
	x14: 0000000000000100 x13: 000000201cb79ae0 x12: fffffffffffffff0
	x11: 0000000000000000 x10: 0000000000000001 x9 : 0000000000000000
	x8 : b80bb9841bcac706 x7 : 0000000000000001 x6 : fffffffebee63f30
	x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
	x2 : 0000000000004c31 x1 : ffffff88216900c0 x0 : ffffff88e8f9bf00
	Call trace:
	 _RNvXs3_NtCs8QPsHWIn21X_16rust_binder_main7processNtB5_7ProcessNtNtCsdfZWD8DztAw_6kernel9workqueue8WorkItem3run+0x450/0x11f8 [rust_binder bbc172b53665bbc815363b22e97e3f7e3fe971fc]
	 process_scheduled_works+0x1c4/0x45c
	 worker_thread+0x32c/0x3e8
	 kthread+0x11c/0x1c8
	 ret_from_fork+0x10/0x20
	Code: 94218d85 b4000155 a94026a8 d10102a0 (f9000509)
	---[ end trace 0000000000000000 ]---

Thus, modify Node::release to pop items directly off the original list.

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/node.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder/node.rs b/drivers/android/binder/node.rs
index ade895ef791ec5746f9f5c1bfc15f47d59829455..107e08a3ba782225c0f8e03add247ec667a970d6 100644
--- a/drivers/android/binder/node.rs
+++ b/drivers/android/binder/node.rs
@@ -541,10 +541,10 @@ pub(crate) fn release(&self) {
             guard = self.owner.inner.lock();
         }
 
-        let death_list = core::mem::take(&mut self.inner.access_mut(&mut guard).death_list);
-        drop(guard);
-        for death in death_list {
+        while let Some(death) = self.inner.access_mut(&mut guard).death_list.pop_front() {
+            drop(guard);
             death.into_arc().set_dead();
+            guard = self.owner.inner.lock();
         }
     }
 

-- 
2.51.2.1041.gc1ab5b90ca-goog


