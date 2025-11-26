Return-Path: <stable+bounces-197009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE8CC89B2E
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 13:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63F063522C6
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 12:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D768332039E;
	Wed, 26 Nov 2025 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgnMqquY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941D4236437
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764159104; cv=none; b=h87Llc/hf+sFdrLmgvUuIXl5k19qIDs5TpkeejZ3fRkV2+nX8WG7Aqrcl0nj/naEa7ecmDazDdgvEPBqqbQWkJwwbZbAm3E4E5Kln4PEtT0Q+zTS76AaUSn6D9XgdtGmZylPVxJxpx47S3SLF80zjCJqWfoYmlBqKeT0AUCJNzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764159104; c=relaxed/simple;
	bh=mxoLsL6MSPth+sVTtvtBTjT+sTY46t42w9pCB6SVnUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfjM8r1DD2nGitE4CHiF4fmTOoEwsZSF8TD7eWGPCCmL4SPzMPTrusoHnKHDW/7Gx60MP82XtsOgoSchDHEJ4mwTzBrv75zMBhjPC9E5MugPR6speDsaDCEdYgYv3uuIWG8UivHTnDeGt+7SFIdIHCT7Ut9ZDOJzgVDVvvJXhZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgnMqquY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9033C113D0;
	Wed, 26 Nov 2025 12:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764159104;
	bh=mxoLsL6MSPth+sVTtvtBTjT+sTY46t42w9pCB6SVnUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WgnMqquYEiieYD2DpO5K8VZLOnAIoIuJ7H6KKhYYwanPdYMvi2gF16DLF9qDwNw6A
	 ZieU+e5XFL24ZsKTUfmcXkYMJoChTxSqZ7aytjnIQK9zyjlzUATC4ItoZBabAiaoDz
	 JdN5ijLOni33EXPRztXNTWBwFGwQg4RXnwjEL5vw6XgLlNvwUXfnp/XU6wnCokrqa1
	 WBbivRwDZoo1vCWi5tvfiLpexSc8XHlIslICMU12HsISMzDFC3mUzsKLdZirfSFM+D
	 i1kY5J2MTdJgnmS1uVT45Cs5L8sMT9lUvEawKCwUeLALrskTHFn68u5ByeV/CjXPe2
	 QunBLIbo1Grbg==
From: Sasha Levin <sashal@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: stable@vger.kernel.org,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [PATCH 6.12.y] s390/mm: Fix __ptep_rdp() inline assembly
Date: Wed, 26 Nov 2025 07:11:42 -0500
Message-ID: <20251126121142.1359157-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125104636.996014-1-hca@linux.ibm.com>
References: <20251125104636.996014-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has been queued up for the 6.12 stable tree.

Subject: s390/mm: Fix __ptep_rdp() inline assembly
Queue: 6.12

Thanks for the backport!

