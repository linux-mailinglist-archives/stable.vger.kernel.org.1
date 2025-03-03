Return-Path: <stable+bounces-120176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 086F4A4C9FA
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 18:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C32F18820E5
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5F1246333;
	Mon,  3 Mar 2025 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAvZhyXU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F6023ED77;
	Mon,  3 Mar 2025 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022901; cv=none; b=S1qNbITFftw82dYiJvMwW36P3HRUZV6SVYPawoP3iAk4n1ZycBUWk5FRd0iK0XTNjUqx58ZgCGaIfjM0IDf2WFYUp0DoNZSHtN+oEnvrCPYfqZkmVXkt6ldtfRhidj5hx1mywfFBMG+KOiUrP4hiOz/bqBXfcguylkkuL0Q2NOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022901; c=relaxed/simple;
	bh=w+aYBFd1yyjBGZl85eEPaiutvJd3Gu4Lwg3DHkxOFew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cv8R+M1ElfzmbxZuDF+2l2NdjjzG4jkkYSNgsjpiNT0WgAJ2nQJh3H9DT72MxpTfedQM7vKpx45bGLSBT0BeGmZ7iovpk6pZPU5adiH2WP+Eq6x5w0TjKW12sdpXABZ+KYNFeCtc/2zGegSGwvmEd9FQuX0shKvDfE9vhglGTuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAvZhyXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B16C4CED6;
	Mon,  3 Mar 2025 17:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741022900;
	bh=w+aYBFd1yyjBGZl85eEPaiutvJd3Gu4Lwg3DHkxOFew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fAvZhyXUNX+tsAkt5ThNu8oSjR+fS73KCRtiC9qmxMYecSP8Bqq6eEL4c8IrMiR5+
	 84dkKBNQMmRjtE2M/SDRUYF7t1o+M6asAQSRz8GbQN5FZTa+1V9qyRezEzqeAj+e+l
	 RVlnCD6HB6Vb+c/E/B2S0mMPfA6BzJjpbh2g5HXbJXghakyHHLc9tli3BDw2CLC+Wk
	 OUd+7slBUfY9h/MpAWmCgTLiMJlVIFVGTYUWCddEw8FY7USbkMnM/lT9FRMRafSeUM
	 jD9EdD5K0kHjeljnVw6EwHQ4qzB75LVGzXEIrT34KPn670z/bdnm/L+55l/gL1eIPN
	 1P0kDzshnM2Ew==
Date: Mon, 3 Mar 2025 18:28:15 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] rust: remove leftover mentions of the `alloc` crate
Message-ID: <Z8Xmr9SySQT_ImW6@cassiopeiae>
References: <20250303171030.1081134-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303171030.1081134-1-ojeda@kernel.org>

On Mon, Mar 03, 2025 at 06:10:30PM +0100, Miguel Ojeda wrote:
> In commit 392e34b6bc22 ("kbuild: rust: remove the `alloc` crate and
> `GlobalAlloc`") we stopped using the upstream `alloc` crate.
> 
> Thus remove a few leftover mentions treewide.
> 
> Cc: stable@vger.kernel.org # Also to 6.12.y after the `alloc` backport lands
> Fixes: 392e34b6bc22 ("kbuild: rust: remove the `alloc` crate and `GlobalAlloc`")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Good catch,

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

