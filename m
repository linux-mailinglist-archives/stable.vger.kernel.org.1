Return-Path: <stable+bounces-202899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3762BCC9819
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 21:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D886E300E3DE
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 20:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FB730B509;
	Wed, 17 Dec 2025 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yrYiaNA2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED31C2C3276
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 20:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766003991; cv=none; b=cGnIipu5cVJloNDAoR6BXA9DGrhwjxF4GPdMk8eTGKwVgnt+JDeOkVJQbeyHGapXcyHC1GYe4Y31z1cPd0VyTyl030rFMCrhu7HldcT3f3wGBh6K0eLaLPTg81iHeGsBmEQd/kublHQrRhqJvEuYf4oGXnSeAxOrKTcQyfApAMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766003991; c=relaxed/simple;
	bh=/uBNnphXU0rjVmgr2q4UmXoMHsYzPtaEbSgh0Iw1axk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eJ2PuYtpCSfATYoHjjze0pLjXAfVKh26XTnKW8syE5Qgo7A2YE7yEC7X2BwtHG8N2sgXp9MC9zDDM8+X67gHsvb9s8Fqe4cBGT+myAh5syZamPTWq6azZqgm2dJkm0wjc9FK3sGxrKzCft1/P0JkTy66Quj5nOT2rDbXBqqZzmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yrYiaNA2; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b79fddf8e75so623578566b.3
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 12:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766003988; x=1766608788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Um2cszXZJr/pG1Mv1V8QtZtgxoz6p014sDFB55pUeE=;
        b=yrYiaNA2J+jqIEFAd0mUPodho4075I17O+GIQOmgxl2UNf6cFqQl6mwsoaxcZPybNV
         M7bguExcWkwtH3XjFPcR51+HkU/Jt5rmSLF9wV3y4xLUykI9BWmxbTtZ3vpJAD7T1WrF
         zzeyRXnfsyEPiJ2tF02ArR7KY+BzUrFkBP9fwEEkOtCQMUjKj59MsNx/EClfoLeOPcgQ
         IWMsloHlBY33gssgOuDxheIdQzZd63LF6+cMJ+cywa8yXpTTRmobyGOYlMGpRi+P2Hqe
         ACFj/6WqgWB0znc114fvys9kbnvjOUVtHwsewOquEhVKaFf64uuRdaOqszKA38gjD0FQ
         XUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766003988; x=1766608788;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Um2cszXZJr/pG1Mv1V8QtZtgxoz6p014sDFB55pUeE=;
        b=Z7L5UxtZGIFT6nipxjzoaI+j0aHM+BNKODdaTYaF3FQ11jTZgNoIadKMQoORgKdegN
         Ib80Peoiqo8rjbp2IjLUeS/tCxq6A9AT4K7N/DeFf/tCVK3kOpP6QPl28Y+WP4X0ISg5
         jHVMepCAwlAqe1woYkK3KyNDZDKzzxFEuTO9vWJOTD/vu3sosSoLMOFlnUhvKne1fvuT
         nD1tuAQ+ZstYe9AVW724lzEkEHzo6+xxmgGysX6yRXywgcO7QQiRpa48qrv7DkOQJvmS
         VTXRqUpauQtvDgCgAmXLjbH1/LIlSM+jKvBQiTeRvzYmY1k7YcRbG5Rg+V4SH7EAZHHR
         h3MA==
X-Forwarded-Encrypted: i=1; AJvYcCWZYh2/9MDNBxBddgCI7ID2S3HEp8YPBmmuRhzBcvPkPtw8zL2MO+4wh8/E/AQXy4CJM0SzzN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUokS77JgPjXZkmhQTz+37qTEUyu3meIEUioiDrhO9dPOmnsSd
	nvhghmu2eBra2x3SD1eXN9mac7wtqVHG9ho5GECZXla1UD2Cvy6y7wqtxnxZs/5CkD7ST5CHtds
	12w43KFvFBMn+HNPlbw==
X-Google-Smtp-Source: AGHT+IF5FgPrVLQko51RhPdl0jo/OMBpR+5bDwGGAuE8Pom6j72aqaHt53eSQ849fUmu8aFbhndwKK1ISeHaDKw=
X-Received: from ejcsq16.prod.google.com ([2002:a17:907:3890:b0:b6d:7849:5800])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3d92:b0:b76:4c8f:2cd8 with SMTP id a640c23a62f3a-b7d23a6db3bmr1995360166b.55.1766003988340;
 Wed, 17 Dec 2025 12:39:48 -0800 (PST)
Date: Wed, 17 Dec 2025 20:39:47 +0000
In-Reply-To: <JH0PR01MB55140AA42EB3AAF96EF7F3E8ECAEA@JH0PR01MB5514.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <JH0PR01MB55140AA42EB3AAF96EF7F3E8ECAEA@JH0PR01MB5514.apcprd01.prod.exchangelabs.com>
Message-ID: <aUMVE7ZbiDREijFl@google.com>
Subject: Re: [PATCH] docs: rust: rbtree: fix incorrect description for `peek_next`
From: Alice Ryhl <aliceryhl@google.com>
To: WeiKang Guo <guoweikang.kernel@outlook.com>
Cc: ojeda@kernel.org, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, akr@kernel.org, mattgilbride@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Dec 12, 2025 at 05:31:10PM +0800, WeiKang Guo wrote:
> The documentation for `Cursor::peek_next` incorrectly describes it as
> "Access the previous node without moving the cursor" when it actually
> accesses the next node. Update the description to correctly state
> "Access the next node without moving the cursor" to match the function
> name and implementation.
> 
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1205
> Fixes: 98c14e40e07a0 ("rust: rbtree: add cursor")
> Cc: stable@vger.kernel.org
> Signed-off-by: WeiKang Guo <guoweikang.kernel@outlook.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

