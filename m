Return-Path: <stable+bounces-134695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC466A9433F
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021CF3B006F
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EA01D5CE8;
	Sat, 19 Apr 2025 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kP9miJMv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559481A254C
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063424; cv=none; b=DCDTIhKfAcfCuJMKiiVu6V/3mrnomQtmrk1wyT4QJP5huKz/WnL0c9NXlL+kMgwX0SbeWaiBO9REj5bhdGyf+QwBT7w5TWfaECCMS2UZ2pCTatotVYrfyhOnQpYg9r/CagNFOpq4jzmXe+w37JwV8478lSnDSvIjZ6znwoNwiEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063424; c=relaxed/simple;
	bh=aR8hd6v5bKT+GjHSl5iYnQQmOxTw5XQT5bYypPuSFiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZgxeNZAdF26QcKymSPwP7jQoq9eTKo2ogNGu3O38eLXdC7WnGc6ySSYYN1yVmFY7Cud+NAGb0ciDmBineMWOnHJGS6W6400goarM6RJjc6Hbc8d8X4asU6Tjdx5hiqhw7u+MYR6/KFTKYLLw8etiKQ4gGRfP31l/fUZe6waNHxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kP9miJMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6C2C4CEE7;
	Sat, 19 Apr 2025 11:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063423;
	bh=aR8hd6v5bKT+GjHSl5iYnQQmOxTw5XQT5bYypPuSFiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kP9miJMv4xgDyHZ7Q9WPnrByLfpRvG4hknzUJ/mVlPDAkVtghmlNNdjLeTXDCtbIz
	 Ua3LYw1LGeG9oTPSeSO5PP/AOOA3//lG4GENOIZ77ORf443F4EWfJc1GYPMhX/jSzC
	 gAvv7BAPJITrPvbly+ixnX1eHsEzBTfb6YkJ2l9fVoWSzeqFwr6bY0qF1zE+KEgS5l
	 5NOJNTP3ThOxni7L64QOrn1yonCYPY9/KLPhojdf9TyblYOLRQHGRk9WPku+Pjz5qu
	 A1fgH9PXbkE3vvDVLJI37l56KN7zS5XZBlYglUihO2prhoVCD82NNc3Q+Z3lhnknTR
	 bhYH3Yk6sg7Hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hayashi.kunihiko@socionext.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
Date: Sat, 19 Apr 2025 07:50:21 -0400
Message-Id: <20250418192023-999567bc7c9a1104@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418120525.2019434-1-hayashi.kunihiko@socionext.com>
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

Found matching upstream commit: f6cb7828c8e17520d4f5afb416515d3fae1af9a9

Status in newer kernel trees:
6.14.y | Present (different SHA1: 501ef7ee1f76)
6.13.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f6cb7828c8e17 < -:  ------------- misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
-:  ------------- > 1:  d904bf2999323 misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

