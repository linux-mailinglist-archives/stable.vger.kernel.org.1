Return-Path: <stable+bounces-194587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F05C3C51755
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 10:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22AC018990B4
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 09:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782183002A9;
	Wed, 12 Nov 2025 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u0wjOha7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA2B2EA732
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940946; cv=none; b=JEW8d03gIyUtPB4R3eOm7tvFMYuM5pq3433bwjuo66yTVVGhTWHQZ2YNU3BzoOuHmfKAGca3MMg+cG3ryEW+NR0Sgtti+n3XzwF+tIDUigxm9+zVzXNFURzudRcDGzd/IWXkHatLddynEqIbJvjNObAm8EIlym0e8jYUgvvc4KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940946; c=relaxed/simple;
	bh=2smKaxaGfjA3jN7eoywJ/ubfJHjD6vhxAHb95I8iC70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=leC/02pjGUwteJjuKOEOfB0RJsvB7JmRsZJpGts8hefep+ojmBnPsHJx7dWdWeQrA99ujQzUkyu066fofTZRr2mkoOCZsXNSF6t0mrkbvlI/pYQ7VUBd2gmvBarKtF5ma8ekFZTPPntvURKXGGUplx1+c5rXMD537VnHvOrh4oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u0wjOha7; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e39567579so3264695e9.0
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 01:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762940942; x=1763545742; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qrl17OppxeBSym1ajwaqJ7MA3ZvBOcIwprPXcbomgws=;
        b=u0wjOha7XNjUCu/9Wmep3giD3DSk6kLtXHH+ZClbID3Lv2+z7ilkAUCtnO98BebPyN
         Ajvf8mPpnjeQqnQB3yWC6g9eq4Rmn6Yq2EElirWIaIostYqPmB65/GpVXrmQxOkA5LXl
         wk6syxly/Z5he1lC/cvrykFI8CX9C0hWCWpiSi4koR9F7KitXYThH+OXk8gxBwomhSFQ
         ReDhiLDbXKCpgX2nkJ2y88vKoA1yVSUguPbAsDL6l1hMZEfTGSXKZ2Bv/iZwjsRwGzD6
         t71dB38QtJh2TV2hPfuUni9brTo/tjRElpduNh9THK2j42Bl/bLQ/2Hp/1NbUfkskFxR
         J7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940942; x=1763545742;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qrl17OppxeBSym1ajwaqJ7MA3ZvBOcIwprPXcbomgws=;
        b=aOJEb3cRCuYdLusZyGYFA3qsmanO8rwoeAiTZNiIUTbWkGNp8wNLC2V/KIKo608oH5
         HEe4GQ7ZZPs7Djmk3yPeIWj9v8h5+AxrHEIw2TfUueYqOA4YDroP+guYjCvr8I9wFq6o
         RO8QMUKtsktiAjgUJtxAY/PfO1+htN6gqnpIWty9UbS0bS8N+RlWoH5r1avX2L7ag5UF
         C/DV+qA3Jptkr4rW1FllZ90IfgaqJu5RiOBtBb97/CRr3dSidk3M0Xe88lI4HgaXFYW0
         66WND4D4eo6MM1kyye3/LprvgluX7kHuGKh4WyjLTpJXy/Cuf4rZlLWODprRwWwD2pA/
         wl9w==
X-Forwarded-Encrypted: i=1; AJvYcCUuq6frdq5MW7pkBxZAnnNeIrSEA8NNFskN1Wl0RAQeUFZD0yXYWAmF8ixvds3Pct+f5yIJLWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxbolg5F6l57WCnTkIxW8uWFjyqFaIWaxfgAJS7Vu/uS6rdtyY
	38j8A1apgADFZgrM9FkvUT6+OaznHfT9O80EOFuKV4gFwBG7iXPm8R+Ir9t7dlwpmv0YMIpOhyD
	V10ZHNK227GwO3cxfEQ==
X-Google-Smtp-Source: AGHT+IFrxZ/HZNWvjI/D7i6XJ+FEDkE7WUcw9QB+SlJhV209ssd6HjLYRjU3vmWWmQrGERlsO+5ydyGEBKOJzqo=
X-Received: from wmpr17.prod.google.com ([2002:a05:600c:3211:b0:475:dc85:436d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f08:b0:477:7cac:50a6 with SMTP id 5b1f17b1804b1-477871c3627mr19832815e9.33.1762940942341;
 Wed, 12 Nov 2025 01:49:02 -0800 (PST)
Date: Wed, 12 Nov 2025 09:48:32 +0000
In-Reply-To: <20251112-resource-phys-typedefs-v2-0-538307384f82@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112-resource-phys-typedefs-v2-0-538307384f82@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=2smKaxaGfjA3jN7eoywJ/ubfJHjD6vhxAHb95I8iC70=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpFFgL7xc1g0VGFv5zm16lCtR5MHYy9Tm5FjIST
 BlIJVvT4e2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRRYCwAKCRAEWL7uWMY5
 RhZbD/93rP79UMls8x5pRqpQZXFzZMxrGh1SLxliDxgWBgx39br9H8lVwbgvUjvPavRuoz+XDQV
 6T9gtmJFcwszgM9GKOKfxsZCpY711dvoWuqLPGxmBViAwQGJrFOPyugh1SSANTD6dYQMN3Uj0tO
 Y5I8BmfLs5MCRQJylCt9Jvx0rMV8U8TRbcca78lhiEcCMEddZi6RqWde0Y7oO1YqerJzfcMEGf5
 DMqWc1B4wpj4/H0ZvHkN+O25U62//CMcX2RDVp7JGcfn9s6xKrL8nn2XWQ+yMYPoImaEg3li0Mz
 ZBBMWwS2R97fnn7kc2IsZPPinXhZ0oyMIWu4Wktqir6Fz4tblbmPLMWqToL1HSmMLnwbIsWoYc+
 ybcqLa6je4lS3Op9gWHHGKTABEAuEteUC30uPZjPr0UxlkWF3EyAu8soaYVKkTfZO/bDa0atKxz
 Gib8EMDVK+K8yg7HCUIV4EcQtgF6G2458RhvnqyteTynNqga79ZCGvjD1ZXqdd749L8oWTDzaN4
 IlFkCKP/bye8+xt281kT41TPRqbkEw67H4UR/MdEuw8TZuLycXvR4ECEQMGUnGDnwlDmkKGkP4t
 wYEDaC+3v0WaSAueiIZVJdD2taqcAlWtet3Udlfj4K5dX5o18w6ar9sH8Rhy/OXt7FPiVlETmNC +V+q7kIo0YGi0qg==
X-Mailer: b4 0.14.2
Message-ID: <20251112-resource-phys-typedefs-v2-1-538307384f82@google.com>
Subject: [PATCH v2 1/4] rust: io: define ResourceSize as resource_size_t
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

These typedefs are always equivalent so this should not change anything,
but the code makes a lot more sense like this.

Cc: stable@vger.kernel.org # for v6.18
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/io/resource.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/io/resource.rs b/rust/kernel/io/resource.rs
index bea3ee0ed87b51816e2afb5a8a36fedee60d0e06..11b6bb9678b4e36603cc26fa2d6552c0a7e8276c 100644
--- a/rust/kernel/io/resource.rs
+++ b/rust/kernel/io/resource.rs
@@ -16,7 +16,7 @@
 ///
 /// This is a type alias to either `u32` or `u64` depending on the config option
 /// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit architectures.
-pub type ResourceSize = bindings::phys_addr_t;
+pub type ResourceSize = bindings::resource_size_t;
 
 /// A region allocated from a parent [`Resource`].
 ///

-- 
2.51.2.1041.gc1ab5b90ca-goog


