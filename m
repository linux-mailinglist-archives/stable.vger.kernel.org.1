Return-Path: <stable+bounces-124854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB82A67DCF
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 21:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E32AC7A2597
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 20:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B28212B1E;
	Tue, 18 Mar 2025 20:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSCvDMGq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A33211A1E
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328765; cv=none; b=cbnuYB7e90v1qj7XEPDjFI10iK+DlUSMrQXAq1HVmAJEOViF8HEP6rpUmy+EBLIC4cuEyQ368+QEcpSSPsATPP66yumxSIvqGUqyaZGVr8pH3Fh/MsgD2QB1YpP75EeRkU1Z9+LHiG4qQ3BmIc7DORwi8IP+rf2RKCDspQuxBAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328765; c=relaxed/simple;
	bh=JaXiC45stZ1fgz57BBLihEuZqwGPIZ3Sq+SxVTcRm0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoAbGfoveqBDMkq+71i3RWjwvu3TNiuxOuOhmJERnQ7KyhgNfX6sa/pBIE7C31H3ryLLCYSlijSuiyU2GwuB6OGCySz5m8jTba8HyVEB28soiwZrezqde7Tt3iSFhpJ8kWI3LlAUSfvRtZ25ftLYkcCn6nAIbFAck7tXEE+7WTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSCvDMGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D318C4CEEE;
	Tue, 18 Mar 2025 20:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742328764;
	bh=JaXiC45stZ1fgz57BBLihEuZqwGPIZ3Sq+SxVTcRm0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dSCvDMGqJ3lTrRGxOekBeI2Kz8a2TOzscLEtQfm7pww6pNKynkDbo5CgcdQG+ytgj
	 I9Tqgqc/t5wvt3cCf3XMkU64sKFS0gzET2lRi+Oavp3f82TilC8Xdh36DecNkzFdGb
	 y1Iq76Z61UJPShfSS9MCOBucPX5kjPFrAs98CItPDZSGIrNlwkBluNQdK3g5hHgyEW
	 02nIwSeAtMTzDCD10IGHjpIIHMJU+FtJvj2gWEtt2vJgsU8Ibg0Q0N40lgJ7Wiuoll
	 pi48JgsGj7uioel/mmD9RoG3FRdzC0sv3NSaoATQviWX1w5H3RYOKmDm547RPFFGOc
	 H9qtAyIFNV1ww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	boqun.feng@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] rust: lockdep: Remove support for dynamically allocated LockClassKeys
Date: Tue, 18 Mar 2025 16:12:41 -0400
Message-Id: <20250318160404-df5cff5d101acbb2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250318180447.4958-1-boqun.feng@gmail.com>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 966944f3711665db13e214fef6d02982c49bb972

WARNING: Author mismatch between patch and found commit:
Backport author: Boqun Feng<boqun.feng@gmail.com>
Commit author: Mitchell Levy<levymitchell0@gmail.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: 3e5d366aabae)
6.12.y | Present (different SHA1: c5b195dd9564)

Note: The patch differs from the upstream commit:
---
1:  966944f371166 ! 1:  b037a70e0eccb rust: lockdep: Remove support for dynamically allocated LockClassKeys
    @@ Commit message
         Reviewed-by: Benno Lossin <benno.lossin@proton.me>
         Cc: stable@vger.kernel.org
         Link: https://lore.kernel.org/r/20250307232717.1759087-11-boqun.feng@gmail.com
    +    (cherry picked from commit 966944f3711665db13e214fef6d02982c49bb972)
    +    Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
     
      ## rust/kernel/sync.rs ##
     @@
    @@ rust/kernel/sync.rs
          pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
              self.0.get()
          }
    - }
    - 
    --impl Default for LockClassKey {
    --    fn default() -> Self {
    --        Self::new()
    --    }
    --}
    --
    - /// Defines a new static lock class and returns a pointer to it.
    - #[doc(hidden)]
    +@@ rust/kernel/sync.rs: pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
      #[macro_export]
      macro_rules! static_lock_class {
          () => {{
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

