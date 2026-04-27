Return-Path: <stable+bounces-241249-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICLFEccT72mU5QAAu9opvQ
	(envelope-from <stable+bounces-241249-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:44:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D16D46E86A
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 942153004D9E
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 07:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD87C3890E2;
	Mon, 27 Apr 2026 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JihA3WW2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AAF379987
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777275827; cv=none; b=g+4McQpv+5bpx6eVWhEkQu1e15OW2+pU1uXaovKCGF29/PAWyArHBPhlcQ+HUII1e7kA/WQZOTgRcXZdLpVF0fYx8iR3E+COnACkOFYbFlO+5/qKfVrAgZiFin4AfTlqWKHfgtzlSfWW9aTNArxxDGtO0uM2zyQAVIpcft2Si8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777275827; c=relaxed/simple;
	bh=FrIZu2R1KDrbgHqzV82kms2t/+/LtuQRXNfEiYRT6S0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U67ArVGg91GIn67g4B/f148K6yAhrrbImOD20gQhPMnbR/HrYBIdcw0/4mUHEmtZ2qslrnsYoXmyZSI47TfL1ZeMjhe/jonJdaUqkRDPunTr4rF8A9Z7+Bs45skPj37QlLYF8XO8Cy7/CieTX2I8DzSWayVO2wvVGM7n/CgjzmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JihA3WW2; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-488be33b7a6so67047095e9.0
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 00:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777275824; x=1777880624; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4b7VOyMdZQukSg5b3dCqDlxQJhNiVZbNyWvcteXyu/4=;
        b=JihA3WW2nijtr+2UTdTnrs3mcXou46izXwIEEv/UdLH7tq2kpwvw2XjB510LIASHL4
         UoynqdUvu8dD5Y9rW8OKaWzLnE+hrTf1NiHcO14r1rO1cpHoWotDc5q1zc5IgBrFDznf
         NIJY6ZNIa/eKW4sPCpjtXcXP2kQ9h7NTzkwPlW04nPlAZNjEWFiGPiuTh3YCqoSpXrre
         fDCrag/jQg3BPCVImfLiM+IdeprUYAdJROvAB+wy8A3TQxU/mKFdtGTU4yftkgevOxew
         DKpcYX89VZ7/JeXpE5VViSOMitWqWxbio31wL3pENhL+aC56D7frbWTKyw1Fj++ThzV6
         KUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777275824; x=1777880624;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4b7VOyMdZQukSg5b3dCqDlxQJhNiVZbNyWvcteXyu/4=;
        b=Iz0BhnkJ5yzTJuomF3GFbLkvPlFKf4u2eeAJ7DeS08M3GB6f4DnCi+xwVxXkpR6xAM
         WOxYdy6gNfO8b1TZ7fpwHlXi+2nclQlqxPDn/sXXbPUk+2AITmZElNqIEN2CSkho6u8x
         F/aUlJi7zPd4jMonIv3Ql/TcRIZR5RVM2jLysl16GVbWefVLELnmJeeWb3c+Vz+RvY75
         RB4VV2ZZktXwy0VUNbL28ONv9Zas3CEZsRPYi0Vhu29i7qeep/xL0sqfpJCocL+SdrjF
         y4+HD83jrRq4WM6gEk3l6oFS2y47es7v7+wKSStX1WPIxob4GJlPV3KuytX9VtKzbRh7
         dhZA==
X-Forwarded-Encrypted: i=1; AFNElJ/RVm2SySCDOpZOHFaut7I5icrCNV9A/wJl0yE0brWNT4qoSeDnGiNN6Qv4bRDRmhNi8o1YvlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyriiN02M2MmSAtiC/sncT1ZcbYtk1qoPZDAb+J4A8I9k7hD9J0
	g/z8Z2GMq3smgcczsTzgUln2YIKgcYGwwufhki6+KvQrhc9/HiWrgVQP06SLISdHdxrP7Vz3qVT
	ZNcGoGVTJ8tQGFdiXRA==
X-Received: from wmf23.prod.google.com ([2002:a05:600c:2297:b0:489:1f67:5a75])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8592:b0:485:3ec6:e634 with SMTP id 5b1f17b1804b1-488fb779acbmr422779885e9.15.1777275824524;
 Mon, 27 Apr 2026 00:43:44 -0700 (PDT)
Date: Mon, 27 Apr 2026 07:43:42 +0000
In-Reply-To: <20260423-pin-init-fix-v2-1-ee3081093a0e@garyguo.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423-pin-init-fix-v2-0-ee3081093a0e@garyguo.net> <20260423-pin-init-fix-v2-1-ee3081093a0e@garyguo.net>
Message-ID: <ae8Trmjs8Ke5wp-g@google.com>
Subject: Re: [PATCH v2 1/2] rust: pin-init: internal: move alignment check to `make_field_check`
From: Alice Ryhl <aliceryhl@google.com>
To: Gary Guo <gary@garyguo.net>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 4D16D46E86A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241249-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,protonmail.com,umich.edu,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Thu, Apr 23, 2026 at 03:51:49PM +0100, Gary Guo wrote:
> Instead of having the reference creation serving dual-purpose as both for
> let bindings and alignment check, detangle them so that the alignment check
> is done explicitly in `make_field_check`. This is more robust again
> refactors that may change the way let bindings are created.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

