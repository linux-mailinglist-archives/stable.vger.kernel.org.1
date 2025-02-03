Return-Path: <stable+bounces-111991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D8FA254A7
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 09:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6731886FC4
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 08:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF351FC7DC;
	Mon,  3 Feb 2025 08:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ENa2pt1V"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B111FBCB9
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572072; cv=none; b=co15q3cyBSH88HUDH86ToVTAeh6iTo4q6PiGg7b4Eg+T09c2H6ZOEaIfMyBLkqRY/nf+++DCDHirFdgfL4h0L4bpvCStqP0juyqeTZHUkUFSkvyuWpp1ynXghhRVqCFcHmYMpBaIuFKL02EjbQ4mE6MHbQMyJlZu/ZjnM2hQjoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572072; c=relaxed/simple;
	bh=77gwvmMi/WmTmBIVTvybK9+anHR4PuaeyO7yxM3i/As=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IbRcMHHqQcaxzsOjV7px/jzrPDXUX+zgMQZrxQEVtGKFdi7YbMBLZuto+erQ8VfteJ3vGXV2IbYi+tMKStd8h/LzXR/X+cKzlj+nt1EualRE1XrN2bX71Ou28FODRnEnUfYwlYkQ1pNBbVPHVASTHYQCMFigIZUkuujIBbusne8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ENa2pt1V; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d3d2cccbe4so4320992a12.3
        for <stable@vger.kernel.org>; Mon, 03 Feb 2025 00:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738572068; x=1739176868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mk6V2a1OKehUwhksSUOJsYXjthaAUvB8G0tqW4qNGVk=;
        b=ENa2pt1VCBLqjMXjj7JEbDlrpc7PGs4XoBtxk7z57UZcxLghPiOO2pLoggfYEg2u7p
         CwONrvDtHMDTfWh3KMpi4oqzOuWRpp9nezY0Jm/vB3sbco4adxbQrlM7OoOC19eFCykT
         yvK58eRhy0RHNCBgy4cVMdqx0trZgm5yVIzRgD5ZoMxAdw5l+Vtj5FRETIifUxwUrj6d
         yj8E3vOYrVAfsADrLbvnAvn4uWuScxZLzF41i31a3YKe+lAYVPBNa6fyNbAa+xLa/9B8
         vNBZfx/lmhyR3Qfov+aV9FP5BJ/nrVNwuGffpcbwkDumOZYqJf1HLVfSyslN0upmzOMF
         UF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738572068; x=1739176868;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mk6V2a1OKehUwhksSUOJsYXjthaAUvB8G0tqW4qNGVk=;
        b=SFURB3mSNijgU5+ffAUwNQQlz0LkLvmZlJLQWe9op7dtbQQBniTFHIoppsiIRhsqQi
         uRHqNPs7+VlRjgWpUunNk0alSly5ok3UGoL/L0JtdjuDyKbNuhKOqdKMgmwK8SG44ssu
         e/dMJ95p1iPSkDcB81hORNylaNBGb/ooHBDSsgmRN0MOfHWzyK5x1pemCUtoDFVwJ1a3
         diexWPBk2isYGaoLaYg8uPEe/WwLev+TsZtYQqhxIHEV5Hx/VCIO0SWhNTzRtmWoan6Z
         ovfYbhgu+jRgLrJj43AD8G9TVVzArX6OWpn/tUePc2yZC2L5YhXkasjj5Ad+URl2YYel
         OdWA==
X-Forwarded-Encrypted: i=1; AJvYcCWiTzs9KkGyUEYirJlZ+bma2FRTZjnLbmSsxs7Voaaluh6Iawogx4sMm4pZJo/VxdybVHsecXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHGr5TVe7Ji0pevJ8VCoNZolmnFxWsggOh71C5Gf0pofSafqk4
	hxmk4bE24bNnYoOyhctfomkeqK1pbfr5lUfIc+sIuyec1qOcaj2lV18A1blMZFxGvHj7b3WoS3X
	xlLmTQuaX8+MdOA==
X-Google-Smtp-Source: AGHT+IFgfRdiETtZBMuEEeQV1/e16m9nbwfES9yKMQDXNq+I0fbO181QnlPznYn6q52iu9mDVagMFJqy6rI6XJU=
X-Received: from edat28.prod.google.com ([2002:a05:6402:241c:b0:5d6:6918:bd9d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:51d1:b0:5db:f52c:806c with SMTP id 4fb4d7f45d1cf-5dc5efebd64mr20562017a12.20.1738572068190;
 Mon, 03 Feb 2025 00:41:08 -0800 (PST)
Date: Mon, 03 Feb 2025 08:40:57 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABiBoGcC/x2MywqEMAwAf0VyNhDr21+RPWg31YBYaaoI4r9v2
 cMc5jDzgHIQVhiyBwJfouL3JEWegV2nfWGUb3IwZGoyVGI4NVossGvwTqh30W1+ikhz35ZUV7a aLaT8COzk/q/Hz/v+AG0FjRBqAAAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2479; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=77gwvmMi/WmTmBIVTvybK9+anHR4PuaeyO7yxM3i/As=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnoIEhvIO6g0w1Cm4GRlTNlZ0bc66QxjR1smp/t
 b0Iu2NyHymJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ6CBIQAKCRAEWL7uWMY5
 RgkgEACztrFdagGYWFuJsQ1ltsSEumNssm25/HC2foapuWKTd7jDzagC0pC/1Oq0Uy0/77/1PMO
 Ej6ZgrtH2SF9rYP00+JadJEoLpm/WVrzpzPaixK7YMqDYYoIxse5dFa7ZR+1VEom9oOIdm1H6xl
 cDv+9KVZkbcEZN0+ROPUN2bfN2Ba8Unz/7mUOGCD44ilBfdtVIDk47NQOMSFItqJlV8Y0LxbU+s
 SHRR2pGNZ9IX9icdFqMLUOJ7Mq42GA1ivndSP5YAZLkoeiDKFyFUhbo0ddewSKvC3huM8njSnGn
 nV+5FHcpZdsAm+y9ZzhUxxwFWOfFFfmR/c8vOc3qCO6sjrRaAMQUvFmiFkj1kKhMNXjw4F8w2wr
 iIVJ9SIt6DGbh6EpBuRqSUEvUwagz5nA9G7xAv4+lqvRTYYa4nobW/JGhmtdV6+7Vz66tyXrq2f
 2JCSC/EvK3fJcPBGtRe5erbdswWwsN9YY6zHbZNbh1x97Z0I4T6azL92ES3GpqsYcmukvCTSBdt
 814Uy4GBkJJcIDbU1w1RnUiEdpmUY8A1UXbX7vzOpApH7v3/VCP0v+1VkcQbsskuWzPn0v1DplK
 RKEL2ThIpSFGcXe2iyr1xwxIc/Lli2bEljSekIJADoJ00IrgaP5uhCSBbqBnuZ9LkSAfOiGZXh6 a2FMTP6pu8qxHLQ==
X-Mailer: b4 0.13.0
Message-ID: <20250203-rustc-1-86-x86-softfloat-v1-1-220a72a5003e@google.com>
Subject: [PATCH] x86: rust: set rustc-abi=x86-softfloat on rustc>=1.86.0
From: Alice Ryhl <aliceryhl@google.com>
To: x86@kernel.org, rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

When using Rust on the x86 architecture, we are currently using the
unstable target.json feature to specify the compilation target. Rustc is
going to change how softfloat is specified in the target.json file on
x86, thus update generate_rust_target.rs to specify softfloat using the
new option.

Note that if you enable this parameter with a compiler that does not
recognize it, then that triggers a warning but it does not break the
build.

Cc: stable@vger.kernel.org # for 6.12.y
Link: https://github.com/rust-lang/rust/pull/136146
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 scripts/generate_rust_target.rs | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
index 0d00ac3723b5..4fd6b6ab3e32 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -165,6 +165,18 @@ fn has(&self, option: &str) -> bool {
         let option = "CONFIG_".to_owned() + option;
         self.0.contains_key(&option)
     }
+
+    /// Is the rustc version at least `major.minor.patch`?
+    fn rustc_version_atleast(&self, major: u32, minor: u32, patch: u32) -> bool {
+        let check_version = 100000 * major + 100 * minor + patch;
+        let actual_version = self
+            .0
+            .get("CONFIG_RUSTC_VERSION")
+            .unwrap()
+            .parse::<u32>()
+            .unwrap();
+        check_version <= actual_version
+    }
 }
 
 fn main() {
@@ -182,6 +194,9 @@ fn main() {
         }
     } else if cfg.has("X86_64") {
         ts.push("arch", "x86_64");
+        if cfg.rustc_version_atleast(1, 86, 0) {
+            ts.push("rustc-abi", "x86-softfloat");
+        }
         ts.push(
             "data-layout",
             "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128",
@@ -215,6 +230,9 @@ fn main() {
             panic!("32-bit x86 only works under UML");
         }
         ts.push("arch", "x86");
+        if cfg.rustc_version_atleast(1, 86, 0) {
+            ts.push("rustc-abi", "x86-softfloat");
+        }
         ts.push(
             "data-layout",
             "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-i128:128-f64:32:64-f80:32-n8:16:32-S128",

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20250203-rustc-1-86-x86-softfloat-0b973054c4bc

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


