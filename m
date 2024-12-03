Return-Path: <stable+bounces-98150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F186D9E2A7E
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 19:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9081165E03
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8CA1FC7DB;
	Tue,  3 Dec 2024 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTyC+z7C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F411F8901
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249600; cv=none; b=juuzXdAcAiIrjzM6yWctmgHwVJMd5s0xQT58/CR3i7VZ6V6teHOnekymSiMwiB8/0M1c4NF55RDoteyvgs9kGFZGowe8x0oHmYifTaG/Q5Vnv79lz7BB2c3zHoBa5BNuxoSVradxR7n+CIK6RP5qmTpFIWsyRKXrAPr1KH6y52g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249600; c=relaxed/simple;
	bh=yCJy5BAA8yusizlIMS9EKTlF/QWwZqyGGGGDN76PSv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxCpop3g7QFhrowaA6wy1qamNOdo4OWX8rB5iHzyqFji6Y+uDLfCRFOWlAvRVEk2slqE8sYUKbcexVB37GrVHF8gD1krufDJ+zqahduCMGU0zPim1f+LHs0tiVGKXfgjCu3i+AYEgtOXiMuENvHCzI5jDT0vtE7hs7a5NTWGgiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTyC+z7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3108FC4CECF;
	Tue,  3 Dec 2024 18:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733249600;
	bh=yCJy5BAA8yusizlIMS9EKTlF/QWwZqyGGGGDN76PSv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JTyC+z7CknjyO9uEVOIJ+uRdh0mIPE0GHSbLIJwE/aROQcWya5JLE5sTifC91bjFq
	 LzizQwnUAquJJ7SDhPy23VmwonV3jxgarD1rHBZ1rRrER5Btd7JRnDzumEkG/hFbJ3
	 IPDEJQnbMGay7Jbq5Kd9B2dgqjAxb5gx56Y3/ek/XJdcUdfRrcs1UjMP5JDorRhI7O
	 fBLqplgTkLe8cnZmXy5mSK1Y+1agjOcZR3/pSdVPsm3RYltY4IxK44lPhedX9//27D
	 ww/cJKjaCt+o0kPOsfOeRRqZ8U1ZduKkZVeq4rRfinnRsT0lBqndnzVkqDEKwY/pQr
	 GZe9mKGgjdqvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 v4 1/3] dt-bindings: net: fec: add pps channel property
Date: Tue,  3 Dec 2024 13:13:18 -0500
Message-ID: <20241203124239-cdd2714c3fdf7d20@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241203102932.3581093-2-csokas.bence@prolan.hu>
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

Found matching upstream commit: 1aa772be0444a2bd06957f6d31865e80e6ae4244

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1aa772be0444a ! 1:  b962a1f97bf92 dt-bindings: net: fec: add pps channel property
    @@ Commit message
         Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
         Acked-by: Conor Dooley <conor.dooley@microchip.com>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    (cherry picked from commit 1aa772be0444a2bd06957f6d31865e80e6ae4244)
    +    Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
     
      ## Documentation/devicetree/bindings/net/fsl,fec.yaml ##
     @@ Documentation/devicetree/bindings/net/fsl,fec.yaml: properties:
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

