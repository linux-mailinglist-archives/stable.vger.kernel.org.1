Return-Path: <stable+bounces-219974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKMLBgawoWmMvgQAu9opvQ
	(envelope-from <stable+bounces-219974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 15:53:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B8B1B9486
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 15:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B84DF3015D98
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 14:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686C642983D;
	Fri, 27 Feb 2026 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rLQZtTyO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A64428845
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204015; cv=none; b=lweiP64Y2hkCxiqzwOGTkPVtBFbdtorH8daPA4ixTHX43D45qbIuUqkwKUrmMl22VxdVYeWj2lKrX6V0+6dj7X8umA4Jk8hOJA52X5zz+p58ZkSj/CS0HeORhomg/c59pvqkb4FDLR4r9R9Y+2Fj1n9rks0QPoRRg6lffn7Bm5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204015; c=relaxed/simple;
	bh=yDxsSoYlhvt8/nqAE9ByXZ75qfk4felvVjO0AMrM1Pk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=avkzWTQBi1VwiIwap6F5+mRsDL83u6UiDOe8qC8LqoShgdZI6lS46goWiWcNHwbfzlROLNK1qzGz3bzUsrShoNGrPk1BxBb8SF2jiaa5adAVCWK35NZlfKnOcer+wOHqFWhM/YWyZThy/BlsGTGqTrq2vijubIJmPytZll/aLAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rLQZtTyO; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4837cee2e9bso17918825e9.3
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 06:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772204012; x=1772808812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KXfI7W8bksPqBSfoemTKLA3SYFTP4LA/1uTiFeVinTI=;
        b=rLQZtTyO8Nsa5XnfC7Uypzv/wQbhduy5dHeazJnRGn93UqUFGXp6lEt5fIvVx7GfJ7
         qwG00C2lYmgl0jDPwGE+Hu4gNALsujg7LZyF2KPmmp1Y7M+ukZEqxeKK/8q9l5K3RIRG
         qJ9rGtIggAZ0KrECCYAwfzgqLtPIKO8KVxwRGRjvTjlfxwhBEY2djJgHcn7Da2gO0qSz
         v4s3v332vNdXyAfzjz0lfuZI1whHi1B84jx6cAhHSKfHEcVar8Uehhdm5NbDmbGZl5ax
         ZxfrYlecYaWxc5w9bOn2bTBw9Wp0D/8hCpt5YgGUj6yAGk6jSHaqP8Dum9Ck/Y6Zl5cH
         wQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772204012; x=1772808812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXfI7W8bksPqBSfoemTKLA3SYFTP4LA/1uTiFeVinTI=;
        b=mkhoO/mW4zrMKwlpFow2/Vu7LQmaomo1mLUwWD3qCpkoNssFyeEDeV2OVn1Fj79YB7
         8Gk2H7+Xd002CeiwfDF9SoZIz2iyBtdKa13G5Dy27zE/geWxmIAQFwYDt/3ZONPeGKLV
         ByzqFLpCMk7ayIf53z8P21z3OfAUc+nSA+JlS0ChRZDq0YRk7iZQooCsBXCiUtC4pnCZ
         +4rNwzWYPj+YXAi75h/uLJc6ftoZ3EyM4+XHuEiE1ThPvPYvW/mQ6FP14vkfjd25/8c9
         1bLJYDbhMz0okNSBMYs/z8MZFCKxE29rO+yUxPEE87yR/+Q2/HmCD3JD+c2ngRPZrwCp
         SbIA==
X-Forwarded-Encrypted: i=1; AJvYcCUSkXKWWv0SB79NbPEM8f/wP20DAXODCdgQiCtreEUaMbRXZy1W0rgNSniOIC7g+l970Zoj6+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQh1csscpTjunZDNyyXG6DYq5z+fAJOWQUzQ9vex4MyuIhwon+
	xV6vABMdzbU0egLJMMvQpWnMhdyQADc8OBLG9MlFNxXnl9sL9vcoTzzZfZBVofE5ejyRi27g8sR
	e31WAJxvUsFpf7xCqEg==
X-Received: from wmg8.prod.google.com ([2002:a05:600c:22c8:b0:480:3842:3532])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8108:b0:483:7907:ea02 with SMTP id 5b1f17b1804b1-483c9bfa9eamr46811205e9.16.1772204012100;
 Fri, 27 Feb 2026 06:53:32 -0800 (PST)
Date: Fri, 27 Feb 2026 14:53:20 +0000
In-Reply-To: <20260227-create-workqueue-v3-0-87de133f7849@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227-create-workqueue-v3-0-87de133f7849@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1495; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=yDxsSoYlhvt8/nqAE9ByXZ75qfk4felvVjO0AMrM1Pk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpoa/p20Fjs2UvY5IRSJHdxNcMQoq/BUepaV5Ll
 LaRPWHq/IWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaaGv6QAKCRAEWL7uWMY5
 RsPYD/99BnzEenVoWlpwhexSqpkrVJdEFSASAOlZ6aHKguqmEmMZujPdqnbxohk9mCc6w7DL5QR
 Lfqel3kcfOBiCLx0UO9HTXsBjuOODOezf3OxX0n8WAb0fJipBvngbKCmOhzro6JtmNbe9p+QZTd
 DSWa4IfKzdtiAoJrLu7sfLJDF9Z1ZqwNXhfmBDP4F/S25AlWIudoeXIZVrfZfWKMPG/MKX0n9bI
 K10vP1vc6NW71pqWJAUSL3kpagI1rlyz3lUhAyxpvpfXhKKBzQqH5lwYMM7xjLHbmkfrADJIm5y
 MzgrJxlaFy3CDZXupCn0kN5ma/J/Rc8j1oQl71dIhnXZ9k3lsR/bFKct/Z/+yV6s3ifXzK/QcQ4
 6Ow2ypZlERLBW4us8Xd4PvKo6omc7bkIfSQTSO1PzR3o/chMow1HBM+nSdCQcLsC3P6A9G7hINZ
 4k5K0MC585dXHOCEJQ9LjPnh1NpWbm1HzvDOjOMAe3+gTFPI0zKzeGsK+gnmuxwjFwk9ORx8n9N
 RCa30ADA9NiwtM8fEkA/OOf1gXZTDM41Z9vQYP4+yQxO7RcIdfU+6Dekca8xxkDhJjhvODAm66q
 86xMPA/k3OuBsj85DUAZhBA/CkK/fmG+LkbphUzxT/vQBqCJbmcqFpX91SkCiRMus1YxTA3SH2t 6zDiajrBUZlw+lQ==
X-Mailer: b4 0.14.3
Message-ID: <20260227-create-workqueue-v3-1-87de133f7849@google.com>
Subject: [PATCH v3 1/2] rust: workqueue: restrict delayed work to global wqs
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219974-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,garyguo.net,protonmail.com,kernel.org,umich.edu,collabora.com,nvidia.com,vger.kernel.org,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2B8B1B9486
X-Rspamd-Action: no action

When a workqueue is shut down, delayed work that is pending but not
scheduled does not get properly cleaned up, so it's not safe to use
`enqueue_delayed` on a workqueue that might be destroyed. To fix this,
restricted `enqueue_delayed` to static queues.

Cc: stable@vger.kernel.org
Fixes: 7c098cd5eaae ("workqueue: rust: add delayed work items")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/workqueue.rs | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 706e833e9702..1acd113c04ee 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -296,8 +296,15 @@ pub fn enqueue<W, const ID: u64>(&self, w: W) -> W::EnqueueOutput
     ///
     /// This may fail if the work item is already enqueued in a workqueue.
     ///
+    /// This is only valid for global workqueues (with static lifetimes) because those are the only
+    /// ones that outlive all possible delayed work items.
+    ///
     /// The work item will be submitted using `WORK_CPU_UNBOUND`.
-    pub fn enqueue_delayed<W, const ID: u64>(&self, w: W, delay: Jiffies) -> W::EnqueueOutput
+    pub fn enqueue_delayed<W, const ID: u64>(
+        &'static self,
+        w: W,
+        delay: Jiffies,
+    ) -> W::EnqueueOutput
     where
         W: RawDelayedWorkItem<ID> + Send + 'static,
     {

-- 
2.53.0.473.g4a7958ca14-goog


