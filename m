Return-Path: <stable+bounces-98156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F6B9E2A87
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 19:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29081284D5B
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2C01FC7C6;
	Tue,  3 Dec 2024 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2wlEK3Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAD31F8EE3
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249613; cv=none; b=Lh07YXbHatkA43UzsbWelhmexy7SjYwvK1nskQmMKABg6KvgA0s9lUKXhClwHABgOWscqpVRbtkqzkPtjPHrhcSLde6HXtRv4poRAf9cmDU6e9OHuv2w5P81de5F57MidM+Rwj4HuHEUI+ritdnXeu8fbTAPE1X6RW3zpH35Shc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249613; c=relaxed/simple;
	bh=2JQfZEpVKXQfu6STVgU0gIkMgOhhmDV8yAYWxFc4uUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=troRZmwXMHdc3RwXs9hbvp12jq1nvb4yTodO+bAkEGQZ9X0EeIeJb5qakRnDYzM8vo/Z7d8UpeJoI0c1SAwQBN44V3ZaAhWL8VG5VFR1u8QkJjCNi8yvdAhF0ZQxVi5EbhpzB+Fsw1pM0FuXFW/4arF/AJKgkK68Q8evT4oW9f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2wlEK3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115C3C4CECF;
	Tue,  3 Dec 2024 18:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733249613;
	bh=2JQfZEpVKXQfu6STVgU0gIkMgOhhmDV8yAYWxFc4uUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u2wlEK3Y2HXQ1AEANVsAAIk1cqmKywPe79Z5LRhGdY3OX0Aao0k0wU0rkjlTa1/m2
	 NrDVEViBQliJ8vDHlf9Q0b+ji2GXt2coy4eC31zpebnqBj1ke3tAoQTUaH/Ulv6OvD
	 3kbEezUNDxoyIbx65PWL9YiBfut6r/3+T4vOkDehZ6MZNq5oniyRZZ1ohbqDACX/7d
	 pgIv7lC9mwTvSKK9ffjwQYfT5SCAijGWIE4skWzrjZCCBS2WesawuIFeNHS0+BogZ4
	 B7urP7c3OfN9Wspn6ORrOoX2VX53zHp9wtawvZ2CZB13gSx6GZI9i3F7mTZ81gkq7Y
	 LWuDlHc20UJ/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 v3 1/3] dt-bindings: net: fec: add pps channel property
Date: Tue,  3 Dec 2024 13:13:31 -0500
Message-ID: <20241202130422-bb6b7d8bf77968a5@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202155800.3564611-2-csokas.bence@prolan.hu>
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

Found matching upstream commit: 1aa772be0444a2bd06957f6d31865e80e6ae4244

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1aa772be0444a ! 1:  a9e05f170d036 dt-bindings: net: fec: add pps channel property
    @@ Commit message
         Acked-by: Conor Dooley <conor.dooley@microchip.com>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
     
    +    (cherry picked from commit 1aa772be0444a2bd06957f6d31865e80e6ae4244)
    +
      ## Documentation/devicetree/bindings/net/fsl,fec.yaml ##
     @@ Documentation/devicetree/bindings/net/fsl,fec.yaml: properties:
          description:
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

