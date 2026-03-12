Return-Path: <stable+bounces-224831-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FRPCQiGsml4NQAAu9opvQ
	(envelope-from <stable+bounces-224831-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 10:23:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5560B26F7BB
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 10:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1125B3059FFE
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 09:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACBB3AF65F;
	Thu, 12 Mar 2026 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NIje6bnK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E264538B135
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773307397; cv=none; b=MM9L2PNWWauvpnqeD4B9G8YjMh/Wj6XE179OJiiW4+AbQ3mMNMCHHrrBDHpTGgkLZ2F6CDJCCYZFBAM97NQKespsVYeqMaHgzaMZJr5gZHjiedGDHILz4jb+Cihf8fb24tUbJpaxFEn5A0O9rMSOFRgAr667CsWcfGP1sqBCriM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773307397; c=relaxed/simple;
	bh=pz+QK4kxfSdwEbArT7hXzuxcGTfKgY7syMJ6RBjmujs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Z6GTMtihfo3QDbpbqsyUK1JBGiCNUV9gRCyAITmegjuFmv7Vh91ouiHFch8dQK/aG9tK7MxQSVNBxHb6TcDyGpLJqezjM2WZ1PVxFO/9ZqJM+3Bc9SvQ24fuAQk2niz0+tUXUqIO8KM2uL6oWJMdx+I/AgMRybtLMn599gz4jI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NIje6bnK; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4853b0af42aso9841655e9.0
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 02:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773307394; x=1773912194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z5l0POW7ods92+Es4vxjYOIQBNcIz63tv3MO7mCRKzc=;
        b=NIje6bnKVko/Q5pbVGbY/b7AwIUdgEho7s1Tqy7GvGBr9xR8GC/Y5DjUQoLp8Qyavw
         +EJBBfOYPkTZrFy144vy+TPjwcNkb+Xjr6U23Tk2huhAXchFY+YyoiK8vVkJPOVGKhMO
         NsmlCfm37QocLFro3UKuNSCZIvuSFzevmHS47y/132hxHWU8ZhPs7+shXBpg1egtLrd/
         fMPBjhqL0zvHaGSv+suzNdkJZ/Nnh1UJrP7jvyhjf5430zz8P3QIaq02V3yYeOPIEDYK
         WUYDC/ZfqMyRPtFqP5gobTjq8ZEzt73Bcp0Xt8MS2OX4E8UvKrP57qHUnIyri/UiMl2o
         WOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773307394; x=1773912194;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z5l0POW7ods92+Es4vxjYOIQBNcIz63tv3MO7mCRKzc=;
        b=NKAxJBoiaavGpSfqrZTycruwp3jurGRQAKmL/Sc4PPGDzPNb3fUc0f8eKBaZeKmSRz
         ZwnME4DVEnYq+Nppsu/ua9J7l0UHYOQNESEAU75mdkL+LM04Jc17eCRUO77rrnsr87st
         IlRpsH5crBdZhIt2qclb8wVyK+wkzsUGU/uJuMyRDteBnyHLcTUNSnHI4viVJlB7USlZ
         aJJiixG47tJXE0a/3lZ2TugiG5pdKIdhR3qXCsmnyQ4hGkro0zWmSSV/t9ByUPgp0lhe
         NZIUCQKPxaRkNf5smSH+k83f5hK1383Ssf7TtuIC/cIO3ppI0P7K/BDA8X3Vh2/gZDWy
         eLbA==
X-Forwarded-Encrypted: i=1; AJvYcCUvqnuQnPf82RQnF1xhoDI7BYq3BxYtYBlFxcPaycPyuHvIU/1QHTS+XlV3Pwip9phHD8knkPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv8x9TN0lwcOvFUiOVfTuYBAxnotgonb2Usal1LbiBf32eiRLT
	9SZ+GKa/TjKTGJsOzArnsD74pNmaUAPQ0hgYeqv9sUtI7yvf2FNL+JcmNiv0lbu2q+2HJOH+m0g
	I5GrHUK2yHQOlfL3vFQ==
X-Received: from wmee13.prod.google.com ([2002:a05:600c:218d:b0:47e:e922:b080])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4710:b0:485:3471:cffb with SMTP id 5b1f17b1804b1-4854b0bfdf0mr97949495e9.15.1773307393959;
 Thu, 12 Mar 2026 02:23:13 -0700 (PDT)
Date: Thu, 12 Mar 2026 09:23:01 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPWFsmkC/33QywrCMBAF0F+RrI1k8jDVlf8hLtp00ga1selDR
 frvpr5ALC7vwJzhzo00GBw2ZD27kYC9a5yvYpDzGTFlWhVIXR4z4YwrJgGoCZi2SM8+7OsOO6Q
 5UwJUYnQqMxLXTgGtuzzI7S7m0jWtD9fHhR7G6R+sBwrU6jxDbQGZspvC++KAC+OPZNR6/hEAQ EwInDKaZFJxrQFWmfkRxFtYMs71hCBGQecIQlidyNWXMDwrBqy7+Kz21XMY7kdbH8xKAQAA
X-Change-Id: 20250411-create-workqueue-d053158c7a4b
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1516; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=pz+QK4kxfSdwEbArT7hXzuxcGTfKgY7syMJ6RBjmujs=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpsoX7sVc+5dfeKTxD79I5FaiH/jXI7I/LfHvhg
 RQ5DRJ3IZqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCabKF+wAKCRAEWL7uWMY5
 RlmtD/9BOySqzW4chGh+Mn1vEn+x9GVreG3tyOrlOz+KFGDhyW7EKXDhB7T8q1td/FKtg3sFyrT
 b10PULyxLi3s8C6nQxTOulFmImgvKQ21aEs4fRUut7+yf7Bc/xjbH894qnQxJdw/cR4fpXGAwO8
 pXitI7rKl9Xfc6yKe9zPiDJNYL0mO3OHfQ+QC8wbmH2R0PhinWsAI1+Eh7D9ZafMypRoSl+YT0e
 yqO1EhxlRqGbObIrqbnjFVE8Qg/VdNW/pV92V/TuanlohM4b9LdywNG9v7sNjdLORxm6NX/EmJh
 8ABXFi2uyVXt9h7Vpin8atjXuxC/ob4f9jsORDK19HcwSEImsMEAP44p6flxfLr+/tQErOyxqqw
 91WR/WtaUisEixvo67UWPkIvi+buGyG5o1CJBNZqxqIYnA1lnJvdEREgKvWDwH5Tc9oNulFy8ko
 zaYU8Vsps8ldFPBs/Faa+hB218DILz54Z4MpOVSTpg0JNMAy81p5D3SE1JxLy2t0HhD9zaXPd2h
 lqkEMe9mxwCjMKytqTCojxxsfDqxlbXeMJddHVFUNT0aZSAmc+l+IKHJ4C+Q2aSQB0sweO2uJmK
 ll48PUtSHZx2Fi0k0lEngZR0BobhB9Qj6JUw8XHpRyWgWE30G98GfCjtw4p4Bp/6NjswLWbBqI5 OfsIrfcYY1aGFIg==
X-Mailer: b4 0.14.3
Message-ID: <20260312-create-workqueue-v4-0-ea39c351c38f@google.com>
Subject: [PATCH v4 0/3] Creation of workqueues in Rust
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224831-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 5560B26F7BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

GPU drivers often need to create their own workqueues for various
reasons. Add the ability to do so.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v4:
- Add link to delayed work fix.
- Redo workqueue creation to prevent invalid configurations.
- Introduce a directory as workqueue.rs was getting really large.
- Link to v3: https://lore.kernel.org/r/20260227-create-workqueue-v3-0-87de133f7849@google.com

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
Alice Ryhl (3):
      rust: workqueue: restrict delayed work to global wqs
      rust: workqueue: create workqueue subdirectory
      rust: workqueue: add creation of workqueues

 MAINTAINERS                                    |   1 +
 rust/helpers/workqueue.c                       |   7 +
 rust/kernel/workqueue/builder.rs               | 380 +++++++++++++++++++++++++
 rust/kernel/{workqueue.rs => workqueue/mod.rs} |  53 +++-
 4 files changed, 437 insertions(+), 4 deletions(-)
---
base-commit: df9c51269a5e2a6fbca2884a756a4011a5e78748
change-id: 20250411-create-workqueue-d053158c7a4b

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


