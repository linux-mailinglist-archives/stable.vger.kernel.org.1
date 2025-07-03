Return-Path: <stable+bounces-160110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D51CAF8042
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 20:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62265845FE
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 18:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228272F5C46;
	Thu,  3 Jul 2025 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKRx1LDC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E132F5C41
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 18:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567699; cv=none; b=bzprxVJ1jz8tR5Wi4IAPXvbX+Hnlgy4a0h90xVG0JZadltCjVBwKen5K2UUvXu3fSXthxzqeLzQwIDwzmHzr3pVs0eCeGgZZUPOS7VMeemhutb3XMGRIGbxyddQ23jxZK8/X91XxG17QLxDG4ue5Dk8/dFfTQvrGPB2FMP/954c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567699; c=relaxed/simple;
	bh=0mg75fDFcO8eqj1c2g/Iu7IlCgacNT6k4+bZkW5zE38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=haJi0uoOQ89iyf1bsrN2fHdZPoMg5RgKVQtbkqjqKRFUROdotq33oeJN7T3ltKsliLyS6Jl438cE+XCtGdrd6e1b+79y4qIo6voRy7hui7r0cqpJLrT9shpg60yqNU0UTuuEwCmT02hoIue3JzTebffjFa66ky0faD0cGi/Xs14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKRx1LDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D145DC4CEE3;
	Thu,  3 Jul 2025 18:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751567699;
	bh=0mg75fDFcO8eqj1c2g/Iu7IlCgacNT6k4+bZkW5zE38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GKRx1LDCt5i+ZIaTgCaQWMijvKPxUj1Kb/TVjBKdpQxB3uCpY7Txws8+zTZceeDpt
	 KKNshpaSdFDnbReLE2gmPd4/pLjZsw81xoJMRswxsEbstvO2fIfrY637cRYEIOMqb8
	 YpczjGnj32ZvK1QeD+obmaPwtKVTAIyTSrIdQ9QfdKtV27mMsKdB/lJOY67v750bBh
	 kxxMIS8izav9r6yW+MHk9jllM8TXU5Fhs8IUDI4fEafptBb+GCn7x4kY3LFeSO3Lqh
	 SoOLPTuiFW/g3AjDg5PZWy1IdrHSbKOnXQ2BsvyUrzJi3SNUkRAHlUO4/zIR8heh3n
	 6PET+Mg7WL7OA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Brett A C Sheffield <bacs@librecast.net>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] Revert "ipv6: save dontfrag in cork"
Date: Thu,  3 Jul 2025 14:34:57 -0400
Message-Id: <20250703113340-390954c6a3640fac@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250702113849.2401-2-bacs@librecast.net>
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

The upstream commit SHA1 provided is correct: a18dfa9925b9ef6107ea3aa5814ca3c704d34a8a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Brett A C Sheffield<bacs@librecast.net>
Commit author: Willem de Bruijn<willemb@google.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: c1502fc84d1c)
6.6.y | Present (different SHA1: 8ebf2709fe4d)
6.1.y | Present (different SHA1: 4f809be95d9f)

Note: The patch differs from the upstream commit:
---
1:  a18dfa9925b9e < -:  ------------- ipv6: save dontfrag in cork
-:  ------------- > 1:  ec9c7e9fdf2a2 Revert "ipv6: save dontfrag in cork"
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

