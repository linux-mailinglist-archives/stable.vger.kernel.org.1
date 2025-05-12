Return-Path: <stable+bounces-144041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FE6AB46B7
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 23:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA67D18876C2
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD4A22338;
	Mon, 12 May 2025 21:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7mjdWco"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD8D299AB4
	for <stable@vger.kernel.org>; Mon, 12 May 2025 21:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086696; cv=none; b=kNPALZytvcYTPLHhWB+RQMcgmfYTgOY1e54gSDK1x1qBw7lLHK5aRjFM+hOTbbJ5QOloYnL5DSRPkRGREdllFX087SEDfScZpqfrMJ7IV9Nq9y9Nxf0WLL8Gg4ltoA/heJyy2xlrPDmIhh5ebBg/xzelbG1CTUsigpI7w3ZUZZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086696; c=relaxed/simple;
	bh=Fgx0CxBQ7A9JJZ5l/EwJoE0AfvRlg77klVPRljWFIBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMpBB9aUadg3U7UN+2nkN4I7LlRLthrXkzhYKEzbqfrRFUC93MvWZFACi3/3+H1pegDGaN171Ck4UnCyg+a0zuC1ZWb/brjhrZ7cKsIAr1bz1uq4AxKgHp3UnppRTiYBC00I+zMX27fNpjzssZlLfOvXI3R+4haNz5X25ClZIn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7mjdWco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7E4C4CEF4;
	Mon, 12 May 2025 21:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747086694;
	bh=Fgx0CxBQ7A9JJZ5l/EwJoE0AfvRlg77klVPRljWFIBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S7mjdWcoiss3kJIloOwoFnS0YvhMi5rm23snL6/fMfp3BjwDh7lCygdxQ+T/rJizT
	 G6m0kT3OpGmXaad2hUYlwTmkaKh4VAqZU6U90KLAGqOd+Tb+QG6wfV0Jp/4ZcVDBw/
	 okj8OLi+s51aVTRsw0RVbFkbVpVTdhasxrm3TcW//XOvb+w8uXFydR9NsOzxmAZp3U
	 GpIR92O+C/VX4T6H0APQ+4zbIgQvfgDteVtKGVJTQ8TnyLFxzsXh2wc/ureibmx77r
	 MSWwPdOCgkogkbwJEePmlxuFXFryPk9hgv3hdsNe1iHOju6IIR+8H21h1rcK12yKAH
	 zZ/8Enf5rHo7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ojeda@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] rust: allow Rust 1.87.0's `clippy::ptr_eq` lint
Date: Mon, 12 May 2025 17:51:30 -0400
Message-Id: <20250512160856-f366c9d30f1aa319@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512124247.1401815-1-ojeda@kernel.org>
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

Status in newer kernel trees:
6.14.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a39f308709271 ! 1:  1872bc81b5295 rust: allow Rust 1.87.0's `clippy::ptr_eq` lint
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
| stable/linux-6.12.y       |  Success    |  Success   |

