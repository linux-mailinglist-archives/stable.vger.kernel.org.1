Return-Path: <stable+bounces-216838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFsnNuB5lGkfFAIAu9opvQ
	(envelope-from <stable+bounces-216838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:23:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C9414D1B4
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A96F73029AC9
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 14:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8C536C0D3;
	Tue, 17 Feb 2026 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8bmpgT4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5392212FB9
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338175; cv=none; b=F03Aehh7OjRdPBBv1lmMfbJzHj3OlvX/+cw7HYfFiEFv7lElYVzlUzvm2YytVI/61MQtUSp0nnLhFe7iZsBJBzyqrjViyec1AG1ymdkBtePItfDieVaWBLFagwkmrk5m4qwvAqammUnHDHRzwzZ8Q3htluVRNxgk4D5QJGWa5Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338175; c=relaxed/simple;
	bh=Uxj6c/az0LdP8dZc8T2qUy7YzybZMS/bT4hkQ1PgX0M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cpxIiEht30zlKaMRK8+LhXnXNFcDdwihagUk/JPOmeR1SG2TCQWQ1JxHl3WhP3VVVHZcAn/YuI3U0KRGPqyqhPnLIQQ78LX0BCMDbC/hICdFkLKvEX69B0yD9cBdWgqw5V8Gsp5Z244lwq86+aKECcZu8d7lo/Wf5NA3/NEU+zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8bmpgT4; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso21942585e9.1
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 06:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771338171; x=1771942971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9toli3up5J45j2dd4uhudMM/Hy4EA7BHUmvoc7k8+8Y=;
        b=o8bmpgT4GlJTrrP+ml3OISE/lilgUgN2XmY1wBJu0IZRZyKu6syc/sOskz22C52ZRI
         Ebt5f6SrtZ3+x0HjEcC3pr7oypmGuOA9SyFlxH/QBX/zlZh0WhiLwbdU8UJNsK7InOp1
         A/xr0NBYpjET2YPsPTTVqHfhIfY8teihu92ym3xtugFN3TNbpGWDLQud0SgdXP9l3W7I
         BtC8oBdswjabFAR7rzFd1COMdkjJw1Wat5nHffIlW1IbWdARI2oeIv01NSIDRmiNARMm
         Ct6efWvPwPa3WTSqp/Zj40WjfF2hgyoagqI7Ek8ND5MHMrE5h/ykByqKPeDtgqYMx9AQ
         sqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771338171; x=1771942971;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9toli3up5J45j2dd4uhudMM/Hy4EA7BHUmvoc7k8+8Y=;
        b=iUcrRG8kc+CDVit2Hzl3lvjEt74KtGlExc+kU4ya+Ji1FY67wL8kOCS4xx2Cf0+TMr
         mLLCV5e6dE/G4Q5eCpBbQOXbmHCKb6yA3myx33RZsZD/4NSpzWu1fx8mUNGnuOfKyKSL
         BIiduGi4ynyWxeXKEvV+kSPz0edzfR8z4HaoEzQ5CA3OwCvj8xgxOdDYWwImUE3bf8Al
         gc8QSHxeK9SY41UKpD2IR55FWiDEIUitIlDC4J1I2I/7hqOVMUtG8ZHwPqiajgrgmq95
         iyvz8JdKiiB3fnVZ8tDUq58wyMDAffZ2Z24uIe6jDfYdWklEf/OxE92YOrImc7IrNyA1
         Nf4w==
X-Forwarded-Encrypted: i=1; AJvYcCV+7YDQpoaf2RoT/BTf5njgEPoxYbn2op7tKvEj7W/6wtdfj8ZIEVjGwr5mg3NcqZLy9H4wDRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypBzUryzsgmQEXUML8RdNrFirYD0p1mxnWednZAczmsMcHGUVl
	X/T5Kymiltzqw0JfDlMyNadYwMD+8D8JdhpepbkT+ii0is1psNoUNnsm3j/9P32+RXwdB8pBmCJ
	LUP9TndJoyDU9LeYjsA==
X-Received: from wmhp19.prod.google.com ([2002:a05:600c:4193:b0:47e:e414:b8fa])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c25:b0:47d:3ead:7440 with SMTP id 5b1f17b1804b1-48379c14606mr166623145e9.32.1771338170924;
 Tue, 17 Feb 2026 06:22:50 -0800 (PST)
Date: Tue, 17 Feb 2026 14:22:37 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAK15lGkC/x3MTQqAIBBA4avIrBtICfu5SrSwacohslCIILx70
 vJbvPdC4iicYFAvRL4lyRkKdKWAvAsboyzFYGpja6NbnCUsHPE+HJJn2nG2K7nGcN9ZgpJdkVd 5/uU45fwBLWfJ0WIAAAA=
X-Change-Id: 20260217-binder-vma-check-b6fca42e986c
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=785; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Uxj6c/az0LdP8dZc8T2qUy7YzybZMS/bT4hkQ1PgX0M=;
 b=kA0DAAoBBFi+7ljGOUYByyZiAGmUebChDZjcwqWd8ZRbjOtAua4kbQQ1RMjHoMr3X+QKWSs7w
 IkCMwQAAQoAHRYhBIOSopRNZAcK8Ui9sgRYvu5YxjlGBQJplHmwAAoJEARYvu5YxjlGryIP/320
 NWn4fxONCqcMTOqDq7viBcZ3G6cxX5lNXZSB9kDxtKeq7LDW4cLWm9VX6fr1A56iPtfHeln2qUw
 pGXpgDCEASmiabi+l3mJ6/IK1BXXtjwvoOrtmestBi8xAHM/iHsbuLYMedwUJNoMt+PgfXy5mFU
 /epRzgdGg771b5ltgKB2pablfJ+KX4qP7bYGrVfBzBq6hC2ngTCndBsvlE8pDKnSimggXz80Vzk
 Ukm2TczsIRVTYjAOdOhlcSJgdH4WKBwZgp59FVHfQqcEqFS41t8+ESMTuCM60Ct4vgfLXebEzRc
 Zi9iZK/pDfTxfTaPHvR4ubu1GhP+RQ0bsJ+lA0zm5DSoWHJqY8rM+j140oTdjG3wIJN6aSdNJNo
 Qrf8h8aVTIA/WoP6UH/J1e8Hwgcm5lUCLvikrcxPNMOnm1C33GWY7YulmlHNkB91OOPT9l2RilC
 +lm+PPMBXh6baCKzAePnHDwoz6vVdAwrNW/koNi0ar3PmB+FMWcL/tWtiM7svIlCZHp4ttGGmfa
 PXMGPYPXwKIR9UXSg57HSKuSK/QTHGqaPQjRzPCH0L+3Hi6aXnWkFAINwen5CdEdoLAKI1G1f5U
 fg1F23FGI67l3+WChvssHlymiiakrGek7YMGUvW3VokUGzsn2gfQjMU76NnEYD0A2LfWM4HfgD1 6+PNs
X-Mailer: b4 0.14.2
Message-ID: <20260217-binder-vma-check-v1-0-1a2b37f7b762@google.com>
Subject: [PATCH 0/2] Fix VMA confusion in Rust Binder
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Jann Horn <jannh@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216838-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,oracle.com,vger.kernel.org,kvack.org,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 36C9414D1B4
X-Rspamd-Action: no action

This series contains two bugfixes for Rust Binder. I'd like to follow
them up with better solutions by changing the VMA api, but as an
immediate fix this should work.

See the first commit for an explanation of the actual bug.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (2):
      rust_binder: check ownership before using vma
      rust_binder: avoid reading the written value in offsets array

 drivers/android/binder/page_range.rs | 78 +++++++++++++++++++++++++++---------
 drivers/android/binder/thread.rs     | 17 +++-----
 2 files changed, 64 insertions(+), 31 deletions(-)
---
base-commit: 0f2acd3148e0ef42bdacbd477f90e8533f96b2ac
change-id: 20260217-binder-vma-check-b6fca42e986c

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


