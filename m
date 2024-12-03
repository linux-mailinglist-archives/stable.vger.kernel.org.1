Return-Path: <stable+bounces-98152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A1F9E2D0E
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 21:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC8E3B3544E
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCE31FC7E4;
	Tue,  3 Dec 2024 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5MDaY87"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEA61F8901
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249605; cv=none; b=TAEcobUwAYWCh/Ba+7oi7QrC746raKSVrqAWcxHbGSxHzEDRvRMKQLAh74IVchIJmWs4N5sZItRhKqtsUp4J1oy3fv5N77tbrMzKjpOfpBCu1Rq1VVFijDu+e/En8M5aaDZ60Ye9P4Eg5NuOoXzqvmgDxzFXeaio/bKJ9GTTftk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249605; c=relaxed/simple;
	bh=wBjRmjy/zD0U8RWGhNEh7LKP2COBnNxxhTOe88OYDEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RiFe232Hl7miNRdmu9UxR1f8AXkO7tYPwEAV5d1ROCch3UgW3VKo2n/0u8QHqZerbp5bRmVjTF3WO+3ZT8smfxQczdB4NOAo4cKwugRYb8gACNI/RCWxknX4kA4+gBKtNYts3ngLmr6dz737e8zhwYyX1G3o+570GSBgZluz/Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5MDaY87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7456EC4CECF;
	Tue,  3 Dec 2024 18:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733249604;
	bh=wBjRmjy/zD0U8RWGhNEh7LKP2COBnNxxhTOe88OYDEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m5MDaY87nZVzRUtb5u6QCjOshakE+vGrc7P1CrSPB967hz5R6DWRjnis2kIEhRCUb
	 MZjL6En35nsBIXhIxG15UJW+D1ZILe6IDAk2YztZ/bljExBIvkDjCnBi0hvTTi7mYM
	 7LTZgbf4uMYyggV1u7lbZ9IMQgHDg8bmI+gMpv2dL0+vCS/BQ389XWXPMqwZrkHPqo
	 h/qI5EZObVQo2V8orpjOx81uQYifTwkfEt1VOQ/ywLGuAPOMnGpzEVRfR2N5+TJjHx
	 vPEp6idpNOrcwc1JoNrvx/lgvz3uAycFZ5Ke0Qmf6UawUIEQA6pf04JnTeytNRfEee
	 bi71yYc8YeAjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 v4 2/3] net: fec: refactor PPS channel configuration
Date: Tue,  3 Dec 2024 13:13:23 -0500
Message-ID: <20241203124503-6b8f3e645889bf89@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241203102932.3581093-3-csokas.bence@prolan.hu>
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
1:  bf8ca67e21671 ! 1:  1cb2bcc3eabdb net: fec: refactor PPS channel configuration
    @@ Commit message
         Reviewed-by: Frank Li <Frank.Li@nxp.com>
         Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    (cherry picked from commit bf8ca67e21671e7a56e31da45360480b28f185f1)
    +    Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
     
      ## drivers/net/ethernet/freescale/fec_ptp.c ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

