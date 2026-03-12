Return-Path: <stable+bounces-224832-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE97JDmGsml4NQAAu9opvQ
	(envelope-from <stable+bounces-224832-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 10:24:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F8126F7E1
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 10:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9F6030C843B
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DAB3B585C;
	Thu, 12 Mar 2026 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eniJemST"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9E23AF672
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773307399; cv=none; b=mpT5IwiVLhaF7f1p/SXynZXPANfoNBq5d/lKnlqI4mlvmI3zD0OBByhMivAcUgNSSvMGcBxD0J7rAS3S2KoRCQ1CABYKEMoStklCp4oRTliw5ajmeSozS5DuKq56uDcywNcjB9RwAOej49naFuyWciKpZjrthRpvVFXkKJvtcZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773307399; c=relaxed/simple;
	bh=HGRaRGYIp/2I1VCTP2/AvId3YATUkkj6n4gXWOYzK4A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PgIKHxWcTHPmg02BCWH3QolkYW80+VvtHf7FnCxPd2z725PcS9Blwtur1BmOWYfEQRlTCCN3y6SZN+Jzywa8K3LLajNF1ri7AUDjftrxhD8lovwhCVu3Gs8ibIzxiTlqSdIWx2zeS/k9Ds1zGU4zQ0AKQ7kdRVqeEx+eOoNbZ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eniJemST; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-663262142c0so626636a12.2
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 02:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773307396; x=1773912196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g0tQd8FbPi346llSLS3fx1+p0t2zeeyNV0n8zJlO0zs=;
        b=eniJemST2Gsmooqqc7041e53b5huuLXPL4hpRcrysLW4+f/fgI17dgx0srlWkfkmrd
         wzI3M8ZuzyhZCcgNbup4rzfL1nb6nO+kolYYvVTWD0QWHestWSf16ga9BQWKdp0x7REO
         TdyfbiYe+c0KrPH7kKgOMssRO5Ajft3b4yVZM9NpLvyPnNPUfVwMR+VgT4UpbMasMXa6
         F48lIHbYhltj+GZSliY+XAU2Yer5Op6Hz5UsksQeigu2c4kQPDDK871q+PwscJAyVgHB
         Niv3QUvS/1V0hXFn5Cj9cmkp3efTR/TPywnFlozOlH8EJgAceOETSDwssnCWe5hzNcH5
         daJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773307396; x=1773912196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0tQd8FbPi346llSLS3fx1+p0t2zeeyNV0n8zJlO0zs=;
        b=a3HJWOY4XMhcqNIP0xEQXWmubvWwF1sAh29lG1/vTZhPAGDznsKVhd9OD/y1wTFoIz
         S/RCbXnEDysKz0soPYaXtsSzF10n5FuU1mLajs40Xj6ydp+W7+792fpsImFRCBE3v5m/
         Fc18U4EkwnPh4x5QZ/L8nSddbedSfLxFYn7dTjNHU41KVkH2sefOX97U+AnLFlUHCEZQ
         NlzJ2CvzqIDRiQ81HcW4ZDguQ7S7WocUsY2sZr+K5KlnxViSk6QYQH5e4U9Q9FlpFkod
         ig00NEKy7N6WgUIrDnFOHiOn9AnB3IJrS7ZIjPunXzuTLVq0YQyO+ipR9+UHMIDOl5PQ
         wZDw==
X-Forwarded-Encrypted: i=1; AJvYcCWyzBepFfLZ0YTv0z6d+aWzo/sVSACPOCj4rurx2JPf9v1u7NTyrk7fBDYzE68VaQAbZj9oAKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzjqjQCltyC9Z41xSQ2MpkjaS9/lQo70KGIlN4UhHI2EBWMa/w
	whF9KVYBRavJwF4BJbk4nYoJfHtDGp9vxXodfchA9usr6fmnhyqZ9crE9xGwemAYA3X24FgX+7N
	+TOU/u6D10f63RxuRLw==
X-Received: from edsr1.prod.google.com ([2002:aa7:da01:0:b0:660:a402:c93b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3552:b0:662:ac65:19e1 with SMTP id 4fb4d7f45d1cf-66319bc7dc5mr3072407a12.12.1773307395717;
 Thu, 12 Mar 2026 02:23:15 -0700 (PDT)
Date: Thu, 12 Mar 2026 09:23:02 +0000
In-Reply-To: <20260312-create-workqueue-v4-0-ea39c351c38f@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260312-create-workqueue-v4-0-ea39c351c38f@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1759; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=HGRaRGYIp/2I1VCTP2/AvId3YATUkkj6n4gXWOYzK4A=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpsoYA0cmDxCYMoHbbLy2sfHV5bUhhXB6n5BYTs
 mh0uOrhrLmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCabKGAAAKCRAEWL7uWMY5
 RjrsEACqk+IzvK1DPpswLCFP86Y69YbF8A/IaxxZ1r/SHlssFKn6BWjIO1fkaSbN63iqosgZsLd
 DHrmnuRegh1mEFjpQV4rL1GwUGtjja2A1+dZwbFrQLIAqfD95ZbDsCktBFRKlZFX8+qYObi+sjq
 wMgxpSad4Y9S4zInE76l0FMTkpLLB0oVYms3nysnpeALtcmfNwfy2FfcYVXUcwVX7/R7Tc/S8jf
 DHwG9ivrVB/UNwSa+alahlMhfdhy8HcJ1DgstbV94+ktLB5rdHjuZPhGPvjbNJStfyX1IzHt+u9
 0Cc+beAZ+UPQG6i5c862V6KrtnNZo+Vw0VhU+vnH0EUPc4FELdZHXSYlxg116BWLa3sC6GCGEAf
 TW8uFtcIr3/RI/kCqxzQDwY8V1f+A83PVMxdJNCGZg+T/JAOLxvEjXyCJnfncd5b7yLeu2DWb2z
 3fcTX2FH9xAgJcjF92vXN/zbbMVtY0MpQW2hp3NBD0wHfQLu2zWw/1LA1E50a+2w1pGZdMB+U3n
 k1liSerLDb1+dv7BtqxNqxqMRy/+h4aChYHn+3Ci2FnDBZrixrdL6U5TiIMIf+RBwMlZx7n1i8I
 16Xw+2q13GpvS6VQe1tK0CzyvKcz5AV1toUtw6f1yO2uMvEQysreXRQriGqhygnvSq9Npi6T1zQ g6IXLDMPrNHjPSw==
X-Mailer: b4 0.14.3
Message-ID: <20260312-create-workqueue-v4-1-ea39c351c38f@google.com>
Subject: [PATCH v4 1/3] rust: workqueue: restrict delayed work to global wqs
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224832-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,garyguo.net,protonmail.com,kernel.org,umich.edu,collabora.com,nvidia.com,vger.kernel.org,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: E2F8126F7E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a workqueue is shut down, delayed work that is pending but not
scheduled does not get properly cleaned up, so it's not safe to use
`enqueue_delayed` on a workqueue that might be destroyed. To fix this,
restricted `enqueue_delayed` to static queues.

This may be fixed in the future by an approach along the lines of [1].

Cc: stable@vger.kernel.org
Fixes: 7c098cd5eaae ("workqueue: rust: add delayed work items")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/r/20250423-destroy-workqueue-flush-v1-1-3d74820780a5@google.com [1]
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


