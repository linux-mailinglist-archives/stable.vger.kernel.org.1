Return-Path: <stable+bounces-219973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDDwF+KwoWmMvgQAu9opvQ
	(envelope-from <stable+bounces-219973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 15:57:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B60281B954E
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 15:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E85523193CD0
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 14:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398DA42982D;
	Fri, 27 Feb 2026 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FOtcFmu0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73EB33263A
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204015; cv=none; b=Yg2jNCg3BCYZPBsIVx97ueOyQcPDtDFJHI974zM9549LBv5e4Oyf2kOY1v7bebKcpy1eD0pxOtHkl5a4fJd3fi3AQoP9y96NmSkrTKitNvUHqFAgAL+sYAhmBxEFMnY9282Xa4ciEnvKiYc5TGRa3wvG10rrnYpy6+MKcABl5A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204015; c=relaxed/simple;
	bh=REJXHD8fbxWLkRYodPOjTlLG7wUtH3QXKgE0W+Go6HA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=A50++f5acRZZNB+mil7BrHlwuD4edrRmrdtmqVTGvuEj+7pHpA6UIiVrDyET9s7Mp3QmtylWjOqtv9LqPGY6UCNAuzeECbvOcvRZBqQazp7bA6k5jacypFDD2z6jxeW1ZTE3/PVrG3BgXG+4XPhS1+dzPeUr1lTFQPUSBhhFpoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FOtcFmu0; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b8fa5744b82so224984966b.3
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 06:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772204011; x=1772808811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J2k3DOMY9k3W8meWU1kjLtGmphyC+1lYcSe1PPIXuVo=;
        b=FOtcFmu0ETaN3LL8vkMyIQALH+9Lehke4bjf82ns1Mm0CGJu3DRPVgDlSedkpFXTM4
         d5AjReQeYsPLvHdIi7p7JQ9m8n7suTg96AezJH3JszihTc8dmblTe0cLSedcnLeEtRuV
         FZ+KPCAY8AiEgQY6Pm2EpxZbtNHGonjceBVvxjtAXsURSErjW6Q0yHQP3DrY+zMJVqqB
         EkUfAU6wQ0mEpBomPkKMD9nPMhggvRO964O/OMLFUyQogcBTzwOAZKaoGpHcNvdjYg2q
         1egyRP3fBGAcIOfsBoOa47/turb8AkGGD3EcGfEdu4Uj55QZ4uyfLLDMCk6QVDb6OzwE
         uiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772204011; x=1772808811;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J2k3DOMY9k3W8meWU1kjLtGmphyC+1lYcSe1PPIXuVo=;
        b=Ii8R+6FoabF87/ESmENRi9Vz4366QtZnv1vsyWRmjAFT1cM49eyAnvVz1e6Jr7BhrS
         ug1oUXL9vMJGiskUpPytJfWtThjyIrGaH93Lznvn7krXSof8s3S4VLM/YFuN6j2XNd+y
         bXVL/4bW1IfFtphhfSkpSZEaeB7JitHnB+Siso6NJXqIRLCVmGCFK1/dWFB5O2DLcEiy
         XewunwpSrcvu0KxwOx9tv8mFGMeshk05UHgAVmFo/ePghbxFERNBlqfbX3HhYTB7shX4
         LnpnpetsDUhqUnMZn0xgDjKZbg+Hy/fFCiqU03YQMVPDMMy659Z4P59GqscbNgOiE5G1
         ZTCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTy4yvsVhAaKvNZRKsHUAs6jyV4p0p2E93O6Fa0se3E6ryNvM7WcPQ5c6VZY5WVdSAcAU6YwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR7s7IHhql+BA9S0TZO8FZsXicK1TV5yzAZPsmbHmPNyj8GqTn
	s2fq0Cb+9o/Ap//jRdi2fR56uquaPyuwoHLxH4xrF9mVzSAfAxkilMLvxQxGaIeNNnpRKvfKCbg
	H4R6pHFSqREjyRB3SbA==
X-Received: from ejux16.prod.google.com ([2002:a17:906:4a90:b0:b90:1d93:58e5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7247:b0:b8e:3d49:25db with SMTP id a640c23a62f3a-b937659a34fmr207751366b.54.1772204010619;
 Fri, 27 Feb 2026 06:53:30 -0800 (PST)
Date: Fri, 27 Feb 2026 14:53:19 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAN+voWkC/33PQQrCMBAF0KtI1kYyaUOqK+8hLpp00ga1sUkbl
 dK7m1YRBHH5B+bNn5EE9BYD2a1G4jHaYF2bQrZeEd2UbY3UVikTzrhgOQDVHsse6c35UzfggLR
 iIgNRaFnmiqS1q0dj7wt5OKbc2NA7/1guRJinf7AIFKiRlUJpAJkw+9q5+owb7S5k1iL/CACQ/ RA4ZbRQueBSAmyV/hKmV0GP3ZBe7d8tp+kJWJ5iWQgBAAA=
X-Change-Id: 20250411-create-workqueue-d053158c7a4b
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1048; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=REJXHD8fbxWLkRYodPOjTlLG7wUtH3QXKgE0W+Go6HA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpoa/kroJSMp+JXOjFFe2lS0vUVez2lSp9hfTj9
 359GP6d/0mJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaaGv5AAKCRAEWL7uWMY5
 RhDHEACfCNXDN8CdbAyGFypT3+Eig1UwhapR/pUxPH7swml+HkWuevyEDiPdZGrP9EtOhbIZtk2
 Rl1gh6WBEdz819IIsAeKbo5GXY95T9UV7fONAQfoHSORO4E/thwoHoGaAM4KijCrtQQiyVThDCe
 uA8bDap7C/jXHnHKNjGAmLdkozFJv8BsMNkkyOj0a03atjIGhfVNy+PBQ3a2ISGaV4v0t1qcWfj
 4JaN4fJXnteUsaXl0fbk+jfZQm5GA4YqbxPvIC+Xd7L9VKzlkkG1pq88b642ig1dWdxUPwP03op
 Nk1py8rELAaX/v9Wvz0GJN+rbexxHDvfvfExvU8mj27nbC31gVKZ66Z0PkyFhJARWV2UY1W58LK
 UCc8+Cn+t1xm6/H8g1ERW2+eiuntdFsdMRoHwdX9KW+7j0V2HNH+exbyT8JUyPYo0rAVGeyocvs
 nyOKa6ShXiHTiMLTZwyEj1q5Ii201/IznHzk6plQK3vQxAaKwbXHYPcol/KV6WlTyWIS0ucc67u
 Hia/gGlp37NaaOfmzDgiP9Y59TiubT9IOmZFRk5mm0hOxWClSPUqwpTHS3HkwPiCF5/Bg6gFqw5
 S5rPDbDjo7KwI63/cnosP1W2AU1I+0zdOdz9FGfLo8RoY7/cwcCZuvehPD9/lmvCHohcN1aG94K /6hFKizTGdob8Cg==
X-Mailer: b4 0.14.3
Message-ID: <20260227-create-workqueue-v3-0-87de133f7849@google.com>
Subject: [PATCH v3 0/2] Creation of workqueues in Rust
From: Alice Ryhl <aliceryhl@google.com>
To: Tejun Heo <tj@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, John Hubbard <jhubbard@nvidia.com>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Boqun Feng <boqun@kernel.org>, Benno Lossin <lossin@kernel.org>, 
	Tamir Duberstein <tamird@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219973-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,garyguo.net,protonmail.com,kernel.org,umich.edu,collabora.com,nvidia.com,vger.kernel.org,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B60281B954E
X-Rspamd-Action: no action

GPU drivers often need to create their own workqueues for various
reasons. Add the ability to do so.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v3:
- Switch to builder pattern.
- Drop BH workqueues for now.
- Mark delayed wq change as fix.
- Link to v2: https://lore.kernel.org/r/20251113-create-workqueue-v2-0-8b45277119bc@google.com

Changes in v2:
- Redo how flagging works.
- Restrict delayed work to not be usable on custom workqueues.
- Link to v1: https://lore.kernel.org/r/20250411-create-workqueue-v1-1-f7dbe7f1e05f@google.com

---
Alice Ryhl (2):
      rust: workqueue: restrict delayed work to global wqs
      rust: workqueue: add creation of workqueues

 rust/helpers/workqueue.c |   7 ++
 rust/kernel/workqueue.rs | 199 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 202 insertions(+), 4 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20250411-create-workqueue-d053158c7a4b

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


