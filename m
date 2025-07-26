Return-Path: <stable+bounces-164806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B007CB127FB
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 02:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF91AC200F
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 00:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F110B3594C;
	Sat, 26 Jul 2025 00:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rh+qPxNw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C9328FD
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 00:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753489507; cv=none; b=ADTRb26oKANounuzHvOnGLNc/M/EK6D5Y4RuSuDJBoMXipNYMFZLiOJtF6lYddVpF6BmLCcQAHm6rGBzoeyoOfe0zksS7mp8/xAzHmlUfyqIrZb7fdwCzNi9MgmHI7Fx22drEugDRvExQG96iGPegNWSKl92yOUAu0GcMAqvQas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753489507; c=relaxed/simple;
	bh=Ys5xfJqLyfujq5ydqlsOfUqDM4mzQ34yGXA5N4VQklw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwnr5Vev2s/S3FydK2pODGwyPwuc55hvvcXfqo8xw2z2dGh5sQzUqppePWFMnPXZeOmR2S6Bs4x4SYiEWJ7XZGPN6qjJbe2dDcgFrCP/NjleO61ZrVpv2a34nfvjlX/XhERe7FQMuXzVMFs9HncuzjSkEhKrl85WkhRehDUX0tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rh+qPxNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CD9C4CEE7;
	Sat, 26 Jul 2025 00:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753489506;
	bh=Ys5xfJqLyfujq5ydqlsOfUqDM4mzQ34yGXA5N4VQklw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rh+qPxNwxDwFek00igOLqWio1+9QBXaC17QinYGF7d2ignzPL3SHeh/KkGRItrj62
	 1j9TT+CwUwxALqzGoSW9+cOS8W2ftB+En0/wHRBOxVr3SKpGDdJdFUBepCP4x/Tlrc
	 coxe8Q2gwkBY5kwxO2izDnz4J/nyS5UdYajzCQM+cYYnYDhFCM92vC3wlQNP2LdsWo
	 MZCppnkvv/jH/NVXf2dnjjCH5J2nXHQvGuTxnVUFryp0UvRDiMQRRvPVzDb2hzs8yP
	 HrlalEBWQbgw1cXQzSFwmtF5lUZKJVW+VCF9No9sQPg0Co4wz9N54rPDp6YRCkubtk
	 6MRORina+B+lA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] comedi: aio_iiro_16: Fix bit shift out of bounds
Date: Fri, 25 Jul 2025 20:25:03 -0400
Message-Id: <1753472425-97cbe725@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724181646.291939-5-abbotti@mev.co.uk>
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

Found matching upstream commit: 66acb1586737a22dd7b78abc63213b1bcaa100e4

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  66acb1586737 ! 1:  44a9fc6c6f51 comedi: aio_iiro_16: Fix bit shift out of bounds
    @@ Commit message
         Link: https://lore.kernel.org/r/20250707134622.75403-1-abbotti@mev.co.uk
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
     
    - ## drivers/comedi/drivers/aio_iiro_16.c ##
    -@@ drivers/comedi/drivers/aio_iiro_16.c: static int aio_iiro_16_attach(struct comedi_device *dev,
    + ## drivers/staging/comedi/drivers/aio_iiro_16.c ##
    +@@ drivers/staging/comedi/drivers/aio_iiro_16.c: static int aio_iiro_16_attach(struct comedi_device *dev,
      	 * Digital input change of state interrupts are optionally supported
      	 * using IRQ 2-7, 10-12, 14, or 15.
      	 */

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.10.y       | Success     | Success    |

