Return-Path: <stable+bounces-158598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB96AE85CB
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E321E178452
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C576266EFA;
	Wed, 25 Jun 2025 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rb6W2fju"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBC9264A86
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860550; cv=none; b=I3w82jyogKjmQu5cOyUqf38DTMrMAznf3WPUIs2DSyHPxtWuvg4A98djQWDzfQf5sClAkM5zcm4YdIQOJd044+ENVI00hdbpdM++CTRPF6DbHdoog2ztdpgaJQjOe1VlfcOX7N8Fx77qRLMe7Uz3PSihK+qEHjO2pwdwTBzrs74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860550; c=relaxed/simple;
	bh=54wFlrlVjMrsD7MN7CYto5267mWmrRrhOyjlNTXj8nY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+rqZFBHBbbrvv6d9eNYNiOVRTJffgdMXgnm6q7tmxIniGlSMnu98/Mw0pXFQVMPGjO1vPRu2yPezVnHPTpKGyDFhGzqwfhgcA3g515ysmaBnpR7WDvwKDq/PLzzt5MOHnEehVC3tUrqpzIlG5sJltmTg43Tc3XO3ZoOIOUaYp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rb6W2fju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6CAC4CEEB;
	Wed, 25 Jun 2025 14:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860549;
	bh=54wFlrlVjMrsD7MN7CYto5267mWmrRrhOyjlNTXj8nY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rb6W2fjuLm4c6tnXKQzlvw0EXHLd+vXOkg40mRB4e9yuRTyZxRdX0Om66wk+ijk4h
	 czl7kwmi52xh+7aklZJ4d/iaZEQbPBbLFzsx2IeYMMk6ZosKP0OAvgtcIPeYUjjLWf
	 BvXEoS9o3m9JMbt25xC5GdA5l4HwekFMUHLvXbTfuG7bVpmVDzIUNNZgXc4kC1SE/X
	 a18IRQ62oDpWSGJ2Tr7l0uxWuSsosj/bKeg8XZi7g1h33WxLqfWQaXrU2ZegjBRR3z
	 88jiXufj6iKfmnltM9UDin/0+8FLVSq7ZGDC+5ufsQrsdVlyCyOQ8rUvz4+aykX0nj
	 zwRO5l5EYGNbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4/4] rust: devres: do not dereference to the internal Revocable
Date: Wed, 25 Jun 2025 10:09:09 -0400
Message-Id: <20250625000020-eee23bb2602b3e90@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250624135856.60250-5-dakr@kernel.org>
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

The upstream commit SHA1 provided is correct: 20c96ed278e362ae4e324ed7d8c69fb48c508d3c

Note: The patch differs from the upstream commit:
---
1:  20c96ed278e36 ! 1:  c56dfa9d4bad7 rust: devres: do not dereference to the internal Revocable
    @@ Metadata
      ## Commit message ##
         rust: devres: do not dereference to the internal Revocable
     
    +    [ Upstream commit 20c96ed278e362ae4e324ed7d8c69fb48c508d3c ]
    +
         We can't expose direct access to the internal Revocable, since this
         allows users to directly revoke the internal Revocable without Devres
         having the chance to synchronize with the devres callback -- we have to
    @@ rust/kernel/devres.rs
      #[pin_data]
      struct DevresInner<T> {
          dev: ARef<Device>,
    -@@ rust/kernel/devres.rs: pub fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&'a T> {
    -         // SAFETY: `dev` being the same device as the device this `Devres` has been created for
    -         // proves that `self.0.data` hasn't been revoked and is guaranteed to not be revoked as
    -         // long as `dev` lives; `dev` lives at least as long as `self`.
    --        Ok(unsafe { self.deref().access() })
    -+        Ok(unsafe { self.0.data.access() })
    +@@ rust/kernel/devres.rs: pub fn new_foreign_owned(dev: &Device, data: T, flags: Flags) -> Result {
    + 
    +         Ok(())
          }
     -}
      
    @@ rust/kernel/devres.rs: pub fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Re
     +    pub fn try_access(&self) -> Option<RevocableGuard<'_, T>> {
     +        self.0.data.try_access()
     +    }
    -+
    -+    /// [`Devres`] accessor for [`Revocable::try_access_with`].
    -+    pub fn try_access_with<R, F: FnOnce(&T) -> R>(&self, f: F) -> Option<R> {
    -+        self.0.data.try_access_with(f)
    -+    }
      
     -    fn deref(&self) -> &Self::Target {
     -        &self.0.data
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

