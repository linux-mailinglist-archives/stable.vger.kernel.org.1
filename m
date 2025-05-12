Return-Path: <stable+bounces-144048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD19AB46BE
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 23:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF9E461846
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395A9299A81;
	Mon, 12 May 2025 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qR20dBou"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E949029992B
	for <stable@vger.kernel.org>; Mon, 12 May 2025 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086727; cv=none; b=ZH5GnpXJybAXACj6AjyZFUlUimEGeO2bwMRKTMOzQCjZsLhCFHWzpTyDBBfwMdHd1Aki4jvb5L8fUrZhGPKS/JZTN0eD776s1HMPexpe21we/RpsI7bZI2A/XO600Uccljei4fEFjcjYc0oJxg+LUZr9UUp3w47aD4Mgo87CoaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086727; c=relaxed/simple;
	bh=bD6DKSdCo4SCZTTx92AdOutz2vpanjPT/X7PP0WQeCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNYN/ug4Csi+lSlgotSWPY8o7xdCeh5PjWNk/0a3dV2bsmZqAikaFWBNAE78QFpmL9t+tqsDL1wnaXjOUD9zwvfcS5quap+e08f1JAmkvRZjyJVlIawAZh7MamKlYdx4eblWVMdSOKgofmUogeLmkkLeiaFEMtsR/ENKueI5K68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qR20dBou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03510C4CEE7;
	Mon, 12 May 2025 21:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747086726;
	bh=bD6DKSdCo4SCZTTx92AdOutz2vpanjPT/X7PP0WQeCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qR20dBou3t+YporqNg6nsaVhjXRtPdGt3TKO8cpNjvtUS1grjl/RN1i1F1nt0ZNfs
	 dmXQjkHtubE3QTJQUWo2EKmRdYWoFQOptthsOQV83KC7BpXWZgvL3sPtjS1EIZFg5F
	 QYbGSKTRr+cYOPs5xDBN8RA7Zkucw/owD421uXqF0zXdN7oKPI1UKuJcWS9J0f717Z
	 V3Bu0GRxRM5xv268GfR+j5blX8cjV3yHxGcShzPXuYWadgt0+rX3i3QgXR537ZnVCX
	 jYnO1EGTZeqmujw4llfduc6I8/PHnZkkCKI79Plg9DAa4iuBYfpI/T8NBvunJuks9G
	 g6ZDgCIElB45A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ojeda@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y] rust: allow Rust 1.87.0's `clippy::ptr_eq` lint
Date: Mon, 12 May 2025 17:52:03 -0400
Message-Id: <20250512161203-42665e86cc8a03b7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512124718.1403201-1-ojeda@kernel.org>
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

Found matching upstream commit: a39f3087092716f2bd531d6fdc20403c3dc2a879

Note: The patch differs from the upstream commit:
---
1:  a39f308709271 ! 1:  f5e8bab8b025c rust: allow Rust 1.87.0's `clippy::ptr_eq` lint
    @@ Commit message
         Link: https://lore.kernel.org/r/20250502140237.1659624-3-ojeda@kernel.org
         [ Converted to `allow`s since backport was confirmed. - Miguel ]
         Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
    +    (cherry picked from commit a39f3087092716f2bd531d6fdc20403c3dc2a879)
    +    Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
     
      ## rust/kernel/alloc/kvec.rs ##
     @@
    @@ rust/kernel/list.rs
     +// May not be needed in Rust 1.87.0 (pending beta backport).
     +#![allow(clippy::ptr_eq)]
     +
    + use crate::init::PinInit;
      use crate::sync::ArcBorrow;
      use crate::types::Opaque;
    - use core::iter::{DoubleEndedIterator, FusedIterator};
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

