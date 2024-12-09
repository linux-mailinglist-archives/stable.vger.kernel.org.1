Return-Path: <stable+bounces-100211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C00D9E990C
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE412823C6
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47091B422E;
	Mon,  9 Dec 2024 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="th726dF9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952AC1B0413
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754947; cv=none; b=qcfjE1mhl0Xrv8WE+4suPcvLXoHglQsvQ9UPai8B8f1IJ4D8Yem7meaYCmkh4OsWiP9ucdyuFEd3/AFHnAzkJzzGYDCpvXK26J3cAIn2SufvFr3rKhqAj/thoEYRRa/sRI4FC49vKwuZsFiZQR+mVyaKrHSGP5bSyj0tytXrI64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754947; c=relaxed/simple;
	bh=YAoR6niG0WBAV0RUr5/yuLI4AuHLz+rRmbHkFo01+a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dA7Fb82NFzTEQLWb+GtjH5r8kzs3nAB1pmpC94zhbH7gjA+xLabUhoLRsLFxnKmvcyduUmjZN/W91TGnTeaEjJmdVp/4NyAvwUBeymeRLpTEBh7kkvJAFnJ2fsxo3ZOTkVhKxx49xUd4+AMc9pDdYMJ8Zv/BUldZuglE20UcumM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=th726dF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A83C4CED1;
	Mon,  9 Dec 2024 14:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754947;
	bh=YAoR6niG0WBAV0RUr5/yuLI4AuHLz+rRmbHkFo01+a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=th726dF95QyluACWFvGEKtp0idLhaacfu02VoOchTn72G/gv20AalGS6UJ3XhLjs9
	 A4fZOiwS0r7Nya22Q4MZPuj6gZFVdlN2d35IcamfwtX1ET8e2eQGuZVG/qDfHdeMSs
	 Tzc8wyuhUV0MqgD5AeieBDTEaKfjOwQrvFOVgu429sLdukkUupT7ypCaZ9xQTH3SAf
	 i1JKIXc24u43+04M4VwLWI//k+41LFgeraOQO6M01ea66/thWN1BbCSd5qNStGGy+k
	 AkR17hbTQl+BpeTAaJaji/Dm2MdsO8yOagQ4Kuyvrk6+8wYS3giCugbVb2LO7Un6f3
	 +Ng10M0Ix8T+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1.y 2/2] drm/ttm: Print the memory decryption status just once
Date: Mon,  9 Dec 2024 09:35:45 -0500
Message-ID: <20241209082853-3b9d771658d7cddd@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209094904.2547579-3-ajay.kaher@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 27906e5d78248b19bcdfdae72049338c828897bb

WARNING: Author mismatch between patch and upstream commit:
Backport author: Ajay Kaher <ajay.kaher@broadcom.com>
Commit author: Zack Rusin <zack.rusin@broadcom.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 306e99777886)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

