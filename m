Return-Path: <stable+bounces-158589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 321A1AE85C7
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 851347B58B9
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDCD264A8E;
	Wed, 25 Jun 2025 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/dWTo5i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C80264A9C
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860540; cv=none; b=otTITLC4e0pkm5oda7ylcoupnXOWc27ukc1BtLSM/bPEHNcN6Q8FaM0cfyKldgHmothAfaak1VmT7EXzS9EKzxFyjuAL2dP/UIN0Fozharle51Xd6Iw+QXVSRJYjMUaWKkZidi2npKFt3UPIFc+Pi5R9s/3KIbnwfLDwFX8ZMRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860540; c=relaxed/simple;
	bh=2lctFsxJfrTFkWF0rLQFmh892HnUEuKMlVq7uWBSpo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbiaDSeACmJOPYHE8dRS/ANZ/QIMsPo0IsqaoqSXEAclalrlBR3Tgk3nLuDP/O+s8mrfjS+qn+Ndl1A9abUoMcmbvNxbrPtEgBwwPio6DJJuofDFsbY5l/f+AmgJNUgBB81dolFJaZglkNt/EgrgAQLSy1XgW7c0RPad9BiV86Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/dWTo5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF847C4CEEA;
	Wed, 25 Jun 2025 14:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860539;
	bh=2lctFsxJfrTFkWF0rLQFmh892HnUEuKMlVq7uWBSpo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W/dWTo5i2LH5hyTLPbDcqjYJJTTe4C9ZdH6/QXyd7QsLoKCf2EZLsVzmGnVIPlZ1T
	 KhV1Gql93DET3vqX/Ux/misubG23kRa+8o5dpD6fbA00srKbaYYu7cktgF3IZt9LxA
	 aZTx7Mm2FryLdBjZN1gmaFoV+iql8zICRdgGMhrDfzGoaK2t7wFUsB0f+Lz6J5pN6v
	 i3WJ+ZID0mZroCyP3v/fg4iZe9cML/JICPCeLwXvsvKoKWPPMe+VIr+d/DUStDxb+C
	 7LodUvorYDOheZGhbmwu8j8X7/D9yQqGufOJ34a1j57oolUOV771uOjNqdCieNWx57
	 IO3QZOO3HMZQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 3/4] rust: devres: fix race in Devres::drop()
Date: Wed, 25 Jun 2025 10:08:59 -0400
Message-Id: <20250624235523-3665f5d1f21a2362@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250624135856.60250-4-dakr@kernel.org>
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

The upstream commit SHA1 provided is correct: f744201c6159fc7323c40936fd079525f7063598

Note: The patch differs from the upstream commit:
---
1:  f744201c6159f ! 1:  971cc4bebeda2 rust: devres: fix race in Devres::drop()
    @@ Metadata
      ## Commit message ##
         rust: devres: fix race in Devres::drop()
     
    +    [ Upstream commit f744201c6159fc7323c40936fd079525f7063598 ]
    +
         In Devres::drop() we first remove the devres action and then drop the
         wrapped device resource.
     
    @@ rust/kernel/devres.rs: struct DevresInner<T> {
      ///
      /// To achieve that [`Devres`] registers a devres callback on creation, which is called once the
      /// [`Device`] is unbound, revoking access to the encapsulated resource (see also [`Revocable`]).
    -@@ rust/kernel/devres.rs: fn new(dev: &Device<Bound>, data: T, flags: Flags) -> Result<Arc<DevresInner<T>>
    +@@ rust/kernel/devres.rs: fn new(dev: &Device, data: T, flags: Flags) -> Result<Arc<DevresInner<T>>> {
                      dev: dev.into(),
                      callback: Self::devres_callback,
                      data <- Revocable::new(data),
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

