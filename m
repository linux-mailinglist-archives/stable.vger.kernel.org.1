Return-Path: <stable+bounces-96158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DD79E0CED
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 21:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26CCDB481DC
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 19:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577B31DE3BB;
	Mon,  2 Dec 2024 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeEJczg6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C961DE2A0
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166966; cv=none; b=RIBrAtQSF7x926ZcP0rKHiBH8b0P5CKh5n0J/keTNEyJPkPg51xjts6qxeBC6KhS8cvU6+qAjpgJ4k8D+/CdHXCLZfwOp2bSkfnIpDqtowhnMoQtmYLcBH8futtx8k5L4j2LhURVvt3FuOV2/K5A2Df/eIW/PG8Q7eMWx9BMirc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166966; c=relaxed/simple;
	bh=qyGiwptkESZqOcrcdSsgb0wWefGfSB8D+7FW+S/t/Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eAPEAzj4ntijoRnckPYb5jqFeClXBnPucc8XMtlWbhO0mIVi1oWMwscqN4tmpq8Q92S39kO5sAPJ4hbKNZMd3QdrsFfFcyhdpJMLEl9qVNoLsd4AOB9LnOvsXc6c/9GjncTd9xFkfO2PSLw1F7jVKfSvAbXmk6qMgVVQe0i79gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeEJczg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B870C4CED1;
	Mon,  2 Dec 2024 19:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733166965;
	bh=qyGiwptkESZqOcrcdSsgb0wWefGfSB8D+7FW+S/t/Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UeEJczg62JVHnQL8zMNrRAItXRI8FTowdy11L1pYSId3zGkzH5QdHu072UqtI0axw
	 K88bMbne9wVbCMQOM9vd3LS+nUKR6CcwZGpyFxNCRls08Q1XSx5YOxY7JCQGCNYQv4
	 ourBVTG6qmUWq4drMAVDrijV4vJX0Z5kHdRmICcXxDOkA6kmQhlWODrfwUe3AsMeDh
	 h0HGs0L2hpqElcxbBdvkZEM1srawDB5veKuMvKk9+1/UEqcziaGdkbsguZlejYpkDA
	 JIwUkMiWmccgvng9dIL/qvyN0nYDNnQ2RQElcUgrOTynt9Ft7g9qkicRne5TEVvIc+
	 dEE72MjNqwdkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 v3 2/3] net: fec: refactor PPS channel configuration
Date: Mon,  2 Dec 2024 14:16:02 -0500
Message-ID: <20241202130945-a900ad2d7ca76def@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202155800.3564611-3-csokas.bence@prolan.hu>
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

Found matching upstream commit: bf8ca67e21671e7a56e31da45360480b28f185f1

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bf8ca67e21671 ! 1:  e7045250bbe8e net: fec: refactor PPS channel configuration
    @@ Commit message
         Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
     
    +    (cherry picked from commit bf8ca67e21671e7a56e31da45360480b28f185f1)
    +
      ## drivers/net/ethernet/freescale/fec_ptp.c ##
     @@
      #define FEC_CC_MULT	(1 << 31)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

