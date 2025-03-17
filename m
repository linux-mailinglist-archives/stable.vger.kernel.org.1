Return-Path: <stable+bounces-124634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 242FFA64EAF
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 13:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BBB016FF5B
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 12:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAE82397BE;
	Mon, 17 Mar 2025 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbJcI8/x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1F8238D5B
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214253; cv=none; b=gzlupQd4fhh1AexmhqkK3kxyOTPllM2fMxKESSxTQZ5X9n6+Z9GgofpumvC/BhSRTy+P96X3pyPCeDs5f8nruju0DDoXNfk8+nfGrXgC1XE78Pip5DDNvhHpkfUEdYjjr3t00boiheRojHmvRp+ez8KC4wuhdAqXmnbzWzAXz5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214253; c=relaxed/simple;
	bh=JkKYVgMHF0tJBrG7Xca+S3iFD9Y/WECXG6HoMRgz5HM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bb7uaVmlhlvc57I8Dv2EEWifgQuRjpz31ExhW5y97xWJdagyFPHKGMEpHyOEbm4/vsWqmaOfq3dE+T5nD7cQtfbmP8pkD/z7fO4jIuSpsEa9ymvssFmRQY30FMG9ovycKJ+smeqXyDQVTVr9tbGsGMlzHxRzMXhcdRYL++nfy1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbJcI8/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6803BC4CEF0;
	Mon, 17 Mar 2025 12:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742214252;
	bh=JkKYVgMHF0tJBrG7Xca+S3iFD9Y/WECXG6HoMRgz5HM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UbJcI8/xxhC4X4DGAbqPna5fwmsEZ+0XMjkeokq+y8eMSb0gv0bl02kNcKyoOLTFo
	 KuiEXaMkBCjP5FltW7UZ70U6Hq+Nj/XMgVoL42imAfxOlg4Uy2dNuiVruV+EWmLG1G
	 PVt2U/TujpMwM5wOHRUXNyuWOKH2dTTuYA//OX021otJ/d7mT8eLlXOwmY7N8dAhxX
	 DJ/KT/Qxr6C5KFEFDIcLQdGKVSFpnj3vd9NEa5gEIroRkEvNcG7tL7tWBAzdxzzh3q
	 cBhldTfsBocrSbsTbJs5dSm4oktyNQ7nW+55/Pf0Si2bvcAH8IXmrgpsisb9+vxWMv
	 DPsf7KfcoP2Fw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] rust: init: fix `Zeroable` implementation for `Option<NonNull<T>>` and `Option<Box<T>>`
Date: Mon, 17 Mar 2025 08:24:11 -0400
Message-Id: <20250316145020-a2ad4bf4b590b564@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250316160935.2407908-1-ojeda@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: df27cef153603b18a7d094b53cc3d5264ff32797

WARNING: Author mismatch between patch and upstream commit:
Backport author: Miguel Ojeda<ojeda@kernel.org>
Commit author: Benno Lossin<benno.lossin@proton.me>

Status in newer kernel trees:
6.13.y | Present (different SHA1: 1a1d0545f7a5)
6.12.y | Present (different SHA1: 0d876a8ae2cb)

Note: The patch differs from the upstream commit:
---
1:  df27cef153603 ! 1:  f87fa26b09a1f rust: init: fix `Zeroable` implementation for `Option<NonNull<T>>` and `Option<KBox<T>>`
    @@ Metadata
     Author: Benno Lossin <benno.lossin@proton.me>
     
      ## Commit message ##
    -    rust: init: fix `Zeroable` implementation for `Option<NonNull<T>>` and `Option<KBox<T>>`
    +    rust: init: fix `Zeroable` implementation for `Option<NonNull<T>>` and `Option<Box<T>>`
    +
    +    commit df27cef153603b18a7d094b53cc3d5264ff32797 upstream.
     
         According to [1], `NonNull<T>` and `#[repr(transparent)]` wrapper types
    -    such as our custom `KBox<T>` have the null pointer optimization only if
    -    `T: Sized`. Thus remove the `Zeroable` implementation for the unsized
    -    case.
    +    such as `Box<T>` have the null pointer optimization only if `T: Sized`.
    +    Thus remove the `Zeroable` implementation for the unsized case.
     
         Link: https://doc.rust-lang.org/stable/std/option/index.html#representation [1]
         Reported-by: Alice Ryhl <aliceryhl@google.com>
    @@ rust/kernel/init.rs: macro_rules! impl_zeroable {
     -    //
     -    // In this case we are allowed to use `T: ?Sized`, since all zeros is the `None` variant.
     -    {<T: ?Sized>} Option<NonNull<T>>,
    --    {<T: ?Sized>} Option<KBox<T>>,
    +-    {<T: ?Sized>} Option<Box<T>>,
     +    {<T>} Option<NonNull<T>>,
    -+    {<T>} Option<KBox<T>>,
    ++    {<T>} Option<Box<T>>,
      
          // SAFETY: `null` pointer is valid.
          //
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

