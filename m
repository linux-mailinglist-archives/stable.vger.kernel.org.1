Return-Path: <stable+bounces-194586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 044E4C518FF
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 11:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAA14215DC
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 09:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64E23002C3;
	Wed, 12 Nov 2025 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4XPkNhvG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C9A2FFF8B
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940944; cv=none; b=e3NZW8dGXRsZrAkJ7OOoRhiVBEINF8jhLBdqk/MbkDSh/tg+Adq3DYGTDVw8doweTjnGh93Oit6qZls04iiIA0xaHOwJc98TOjX6CofC+J/RrBkj6N5HHDsF2rNflQKciRNYGdwb5DmVyiH+BdhR2QJGXEdIStMWkCAZEq/zheM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940944; c=relaxed/simple;
	bh=QmvyXDXDVrsdfDM+yKnByFuQLV8gY2auM7CbdPaIBok=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aRbRfNzsbuAiC+gHww/Mwmq5KR9O2dZp1YkifcpTjUwxDta2PVg4dLwU8r3qsSP4OB3VfgWZ6jIATTdFQNnqFoZYbZsnVKYrBEdkYw66gSNUSFFWOYy19tSHgSGRLQQAgvWwsLqbWIP4J0gVETtRAGjwyr/8NvOWoJjRoiTDg8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4XPkNhvG; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-475c422fd70so5080645e9.2
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 01:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762940941; x=1763545741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Gv6xr0GGt0t3EpcKK4KiIfCoZCaOutnve9evDPKR/k=;
        b=4XPkNhvGOpG96My7uORsPKd6lDMEKmbAVliBbNzOXhdByoICFUvoIml8/a9ajP18fV
         UBwo7aluHz/8/VQaWXARcLFfvXXW/w1laGni3akMfc66j8ZzlLExyDbYut9nl09pozOq
         XM5GyZVuNPh3yMj9h6yP+ZWou/MaeZI11k2jYND4N/puNfsHhJx78yRDci8/HKnMO2NA
         hmsgH5afIDJPPrzwfbUCtBP0Hi5GWLRsyPNLy+KRKfnSmyj7CwtryBxqEbsw+sYg4nCv
         iK+n70BrPILFqxEgTvFbnaKBwPIq3g6BGTrnr098/CZTarFNCHrOJ+SGZhteTZh9qwGm
         SLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940941; x=1763545741;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Gv6xr0GGt0t3EpcKK4KiIfCoZCaOutnve9evDPKR/k=;
        b=rZb716NUc/YOyjV/sDayGmqasOyuvGO65z5HZrqdgZuXDtMXt0iIciqojpFLrM+okJ
         hP8tLlVT3G0MD0/jGmUDBq4dnzhrohGBF/eyrml9EF6LvXgrzxfxkO8ZEV1SRek/QigH
         KTDMuCRToztWj/bm+6McyD4XtbxGyLZiUqJWJ2UN+ZuYGDuiPkKpAx2ag2t4eGrw/Xvj
         l4L/ayO+KwBrGCpQKk/DbVFUFxYwK3Y5tfgAymlom64JCmNVIx5kxuTCZeiasqigHBlz
         c3DWSZbaNENycdR8rcAMfVZ8E3S8BDqzwqkZxy6b9vyUQKujdu5oNOxh1QYRUjLcfcnU
         qVfg==
X-Forwarded-Encrypted: i=1; AJvYcCWIkMK9c4EU/t7WS6RablgENIc4zE1xsHsjNyAt5UJBgSV/DJUQpNegpWRgEvEZdqFmx3e739E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCf63zqm7tGz2MHxSg6og4uJLMQeoniyuEjD/pPr/OwDq4w4Qf
	NI79RK5bEIlb7KSHrmTs5UbzQpAsmBabLKocEVE6AWMSQ07qJIGZda0Rg1+rA0kmfbuTauvOP5T
	3/6gOevbBWTyNPdY4nQ==
X-Google-Smtp-Source: AGHT+IH2dS2PfgK5jUWA9Ng2M4W2Yq6xdnOBF1mJ4GATChiOA37Dbco0oRuZd8Strxz0EtvePc8l6EG3deFkh48=
X-Received: from wmsm13.prod.google.com ([2002:a05:600c:3b0d:b0:475:de6a:c2eb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3511:b0:477:54cd:2021 with SMTP id 5b1f17b1804b1-47787041346mr22179505e9.8.1762940941091;
 Wed, 12 Nov 2025 01:49:01 -0800 (PST)
Date: Wed, 12 Nov 2025 09:48:31 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAO9XFGkC/4WNQQ6CMBBFr0Jm7ZhOCRBceQ/DQtsBmihtOkhsS
 O9u5QIu30v++zsIR8cCl2qHyJsT55cC+lSBme/LxOhsYdBKN0Sqxcji39EwhjkJrimw5VGwtY+
 663VnqemhjEPk0X2O8G0oPDtZfUzHz0Y/+ze5ESpURrE1Xa3I8HXyfnry2fgXDDnnLxY5KjK9A AAA
X-Change-Id: 20251106-resource-phys-typedefs-6db37927d159
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1447; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=QmvyXDXDVrsdfDM+yKnByFuQLV8gY2auM7CbdPaIBok=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpFFgHx3cwOybF0VqfBGf60UP+BMu97heCo8Oad
 L+QNsSjXvGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRRYBwAKCRAEWL7uWMY5
 RlFcD/9zmqypMTbBEK4TFlukuZM28Zj2oKT+e+aZvfgWd0Inzg+K7c9n+IHif0zR+qlN2t4X2o0
 aHfY7UxibEFHdEvKFsgMtbhtwQ/z+JK0kttJ72s2n+PDcO9lzihrGeBAD85TE82P/kaeDopUtkh
 omNICZrSODCry5Mv/7iLPl4VjVoqLkelYvSy0OlisW/fDXqN0rS/8R951e/g8uzWb+AYbMmJjgc
 1/ygIl/IA4c3AJW41oOTWM27yHz5y2x2ztGwB+RqmLBpT99ga8mU/njL1uGCm4FQr0OQAkcZ3rI
 XRhy+yY8ylTMusX9ocpcFqBewH0KwchGINQiCHlBW1TpKZjWMOM/3G+c6JV3S5Nf+JhIOh3KXZO
 8YPrjhZb4j3nnjW2RSaLgQDozX2xgpXV+AQruHkd6DZrLMRbAomPLlBSus8qxigtzZfGXcuQjOd
 a9Rut9qAv2L+a89KrCuQdvv3sn1F8HSVWkqShw+EstS7r7c1nByQq4xzWNfHpG80PekfLNfauzd
 IWJTMK7h3aelFpZ0k/Ela+2vgsmDe8snkwwThtVXAskqkCBRIEeFkRQ2hzxlBOXkqr5MNioaEET
 xvZpwYS8XLVlW0UULAxbX1kwwMdTP0wpenV3UdsZfFX0EAJ8Vty7Mvd+UM+lZY7peXdZtl5q5+j NdJXJz77uqOh3IA==
X-Mailer: b4 0.14.2
Message-ID: <20251112-resource-phys-typedefs-v2-0-538307384f82@google.com>
Subject: [PATCH v2 0/4] Rust: Fix typedefs for resource_size_t and phys_addr_t
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

This changes ResourceSize to use the resource_size_t typedef (currently
ResourceSize is defined as phys_addr_t), and moves ResourceSize to
kernel::io and defines PhysAddr next to it. Any usage of ResourceSize or
bindings::phys_addr_t that references a physical address is updated to
use the new PhysAddr typedef.

I included some cc stable annotations because I think it is useful to
backport this to v6.18. This is to make backporting drivers to the 6.18
LTS easier as we will not have to worry about changing imports when
backporting.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Fix build error in last patch.
- Add cc stable.
- Link to v1: https://lore.kernel.org/r/20251106-resource-phys-typedefs-v1-0-0c0edc7301ce@google.com

---
Alice Ryhl (4):
      rust: io: define ResourceSize as resource_size_t
      rust: io: move ResourceSize to top-level io module
      rust: scatterlist: import ResourceSize from kernel::io
      rust: io: add typedef for phys_addr_t

 rust/kernel/devres.rs      | 18 +++++++++++++++---
 rust/kernel/io.rs          | 26 +++++++++++++++++++++++---
 rust/kernel/io/resource.rs | 13 ++++++-------
 rust/kernel/scatterlist.rs |  2 +-
 4 files changed, 45 insertions(+), 14 deletions(-)
---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251106-resource-phys-typedefs-6db37927d159

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


