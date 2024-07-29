Return-Path: <stable+bounces-62571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DFB93F7E0
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 16:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83EFA1C21EB4
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 14:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2252615574C;
	Mon, 29 Jul 2024 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cXNIqzwI"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546C6155A25
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262977; cv=none; b=SeqbgBwua5wtHmRQOiRZat7Evsv1HCcTvL+epWyIcgAeIJe+jYiodESZQ98yWQP7njU0XRkS+LDLTwKJbiuK5GRtmsk+vXRBhns/+polainr3bddQNvaEKNMVmE52C3mr5+FS+LacDQoud9mvLAeRzGWWl1I9sgeytzLoVTY5aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262977; c=relaxed/simple;
	bh=2yHObFkJeb9NEav9vRlfQtesacysurvHNX3D+BY5baw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fQ21F3b/2HV6oH1cLLSNFuIaJoFhK3ApwpVYbYtWiECFZW9gz8Ay5uv3tvJrKg0VFfaxcidF+aDoaSsJvo3mz9gnSEOeTDhwnKNNc4NbGSZDW7UMcnfr2G4GOTVCIUR7gBuLjYcghFNkxVlb7CZuct8+wssbhUK+W4y+H8Ybgs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cXNIqzwI; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02a4de4f4eso4467360276.1
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722262975; x=1722867775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9DpUuNFRf2+mlmUFGNhBkhPfCr6X6cUQBVac6+mnEhY=;
        b=cXNIqzwIiwENKxHXS7CcAIwZp8Nm+rSA50HMYtg1GCSzx2YO/GkGWgXwcT69OFxUXF
         4JT3aSXrOniV/puAyHAOsLXxA+QLP4d3TubUpGNbRrns2QoTOa/P5HmItJwOl9V9EpBc
         U4/s8P79zZkf+rB4G5xFgN+j+XZjBmsQuqsrCDFijBqoKAp1Ih+gAd3rruQ08P26j0lH
         nNAq1apOXKykUfwS3B2NajpJSQA6ttKtqGiaiKELhxTH9zVxCOYeFib2UBtzYdGMFuLY
         RVCkOByACQ58dTMo9kngi3/RLu8j7Y3Tqu0FlZiFXZimPt/leDGk87WMFuugIUQ5PvZ7
         e7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722262975; x=1722867775;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9DpUuNFRf2+mlmUFGNhBkhPfCr6X6cUQBVac6+mnEhY=;
        b=uD0halSidtwr8IX4hCXFlHZC4fWRGIxHqhcwOErdE0uBXN4rFxqBFRHjDTVb1aD2UE
         r0PIDxW6YKTENL80BTEGfZEzSyOEfxiQnUNywgdMRtAdSrvrvWRpsdmzXwbaOhtaOzC7
         Kj2gA4yaYnwPC/us61S6uwR1mX7mZEPgMGxiFfCwal4jUv42M4+bcow4yUWbYHH62sI3
         E6eb0CYA+Uhg680Pibs5FcsA0Qnf64cPWGb3izIn1wKC6sfjzmgftyIx5KgDQeS4o6uR
         ric3Exqm82cP37CjjW+yyaVcl7aR5hFyphMSQ27KPVFIfzkFR/5OUAA+Y2h6DEoc3OGM
         cs3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXd+0hK07y4iGCpNU3hHStUaRhlrbpVgjOpV/7CqnCTbXAsJx2hV/KpAgV6uLudCDyZHUS5tfajpMiI3fDBwK+LCG+AMEfH
X-Gm-Message-State: AOJu0Yy0s8PifjWpIYKVMc/7Un6EQbzTR3yg8QSHDvMnyimagJfZ9xZU
	Xx/k4I2EkNMcS5+L3CfIphnFcJZhBypuF1teYti/G6F2B1FfiaDlFrpvPMXZK/9GWg9MFexTMb8
	7vD/gLtLyNQADOA==
X-Google-Smtp-Source: AGHT+IHfm2z3cnxf5rBSU2H+Uri2dnZaiTSIEU2LtrOMYhl6ATkrl7+v9uMdvMFxQmpUJEdl57Dg5BT1CgybIUk=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:c04:b0:e0b:6a6a:e82 with SMTP
 id 3f1490d57ef6-e0b6a6a11c0mr10938276.2.1722262975188; Mon, 29 Jul 2024
 07:22:55 -0700 (PDT)
Date: Mon, 29 Jul 2024 14:22:48 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALilp2YC/33OzQ6CMAzA8VchO1uzLyB48j2Mh7IVWERmGEEN4
 d0dXNRIPP6b9NdOLFDvKLBDMrGeRhec72LoXcJMg11N4GxsJrnUXHENoUHr72CwbSEMaC5QGFH
 kqFUmbMHi3q2nyj1W83SO3bgw+P65nhjFMv2njQIEVDxNCSvNUZpj7X3d0t74K1u4UX4S6RYhI 2HyUqOqtM1E9kOoN5Fvf6GAgxXC5JhRSYp/EfM8vwB4HGVLOQEAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=2yHObFkJeb9NEav9vRlfQtesacysurvHNX3D+BY5baw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmp6W6s4LF7RmNmh8S6tgM6zU7PrBFJ6NKJRNNB
 raevcnq3BOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZqelugAKCRAEWL7uWMY5
 RjNyEACHO3fz7GpCUYlcQp0AFizoXymbKkd/k8ZmfkQ9lYve29IWgplrTHgvWCO6fCSpdZrVqwp
 Syiw68Lpk0GYHZj8ijTXdmuC74aKI5mi7dBu5IaKNBN6psmHOJZ3VQMyAng2W1bbEFPc7iWB6Lo
 1l7ZjqkyR9zCLRFMufytLMz1+7W5DF5bgpfAhvCa5q1SoKYwnlPFPulGOyazvriUkX5x6V833Pw
 VHRRBvhhBv+5eCh88pjV7mJqr6DOgMrFNKOjPyQtVc7PytmICMg8vrCNfR+d+tjB11BAYMLNTn+
 qdyCGg/I6AY8SdAcWKLN8xJ7euXxOWpVNKYsNoltAphFMIEAaSuk4Da2UziFzocsFif/ZeXeewo
 vqTCNFtYgW+rTA1H+KN1DkdpdHE4J10fVEZAEfbjb2/SCpgJPHQJLvd8v+N+dSpLEVMwvuaovtg
 wOqvu6ab9W/wESJpscxJ1GtwP92wPUmp3w8obGUFonivqTdu8vvrI+HN+7/0jtYpgb1RvTZ1faE
 RSGq84BdUekyGVwbNVawI3mVA+gQxc9aevQ+Oy2bFs3StiR6HCAdSXbEmEk1c31oXKlxUNW5+RC
 3OW3JgXuFHzzwBfrZ4EuXtZ2hZ4QiQ1qZ/cw+nFwMQBOi0iYgM2xIZf30Wg4piY08GOYDyvh5Ku zIl6rzmu8xMs5rA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240729-shadow-call-stack-v4-0-2a664b082ea4@google.com>
Subject: [PATCH v4 0/2] Rust and the shadow call stack sanitizer
From: Alice Ryhl <aliceryhl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mark Brown <broonie@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Valentin Obst <kernel@valentinobst.de>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Kees Cook <kees@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

This patch series makes it possible to use Rust together with the shadow
call stack sanitizer. The first patch is intended to be backported to
ensure that people don't try to use SCS with Rust on older kernel
versions. The second patch makes it possible to use Rust with the shadow
call stack sanitizer.

The second patch in this series depends on the next version of [1],
which Miguel will send soon.

Link: https://lore.kernel.org/rust-for-linux/20240709160615.998336-12-ojeda@kernel.org/ [1]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v4:
- Move `depends on` to CONFIG_RUST.
- Rewrite commit messages to include more context.
- Link to v3: https://lore.kernel.org/r/20240704-shadow-call-stack-v3-0-d11c7a6ebe30@google.com

Changes in v3:
- Use -Zfixed-x18.
- Add logic to reject unsupported rustc versions.
- Also include a fix to be backported.
- Link to v2: https://lore.kernel.org/rust-for-linux/20240305-shadow-call-stack-v2-1-c7b4a3f4d616@google.com/

Changes in v2:
- Add -Cforce-unwind-tables flag.
- Link to v1: https://lore.kernel.org/rust-for-linux/20240304-shadow-call-stack-v1-1-f055eaf40a2c@google.com/

---
Alice Ryhl (2):
      rust: SHADOW_CALL_STACK is incompatible with Rust
      rust: support for shadow call stack sanitizer

 Makefile            | 1 +
 arch/arm64/Makefile | 3 +++
 init/Kconfig        | 1 +
 3 files changed, 5 insertions(+)
---
base-commit: 9cde54ad2f7ac3cf84f65df605570c5a00afc82f
change-id: 20240304-shadow-call-stack-9c197a4361d9

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


