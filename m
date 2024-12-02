Return-Path: <stable+bounces-96160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 586929E0BD8
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 20:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278541615FD
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 19:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD951DE2A0;
	Mon,  2 Dec 2024 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aev8Esia"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7581DACA7
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 19:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166970; cv=none; b=NQsG9w4hgfmPn+/tpT+KyLn90KPixcRNqXFGM+O7F85qOqlXACawWMnNRcQF8UVyTWfUILKAJ5b6Wt7+uZRdl0Wix2vYdWmIQZwsIt41hoaudtMNK3N0YHQsWiIp2iI5ISmguN/Tq+3MlEvNe5JX6Xg5FstrRmm+Jg54BibFu0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166970; c=relaxed/simple;
	bh=QE7guQLQc4TxHDnqpERptn9fD7pUqlsSSz+x4g/qnoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMpkSoQsjgkzQnG5I/q7rPFEO1FMxF9Xymhl7u07YaEMjHolesVbtWZ5gRVf6mbxZXr28HLZPPPPqtzWRn8x6R7aHuHvTNr86eHqW7VJkFHv6fK+nfSzLIE3ezTXQ+n96/obsEYbRI3k7clwhDHS7NiQxq4QxuyUIRdMEQ3538M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aev8Esia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8F3C4CED1;
	Mon,  2 Dec 2024 19:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733166969;
	bh=QE7guQLQc4TxHDnqpERptn9fD7pUqlsSSz+x4g/qnoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aev8EsiaWCs2TJsAZ/LI66QCpsKD02SD/csYmntJ20FRU6+2qtlc0iJknoTpt6p5V
	 M0Wi+2gfYMtSYnSlHWaprqDQn4TYpsZuyhkYTa1gKyezYTnDpiJOQVzmPd7EW2KQhW
	 uzJAeBiYcxBvNbFIYaTOUTJ5MCNoGhkrpOHH2NqaoONv5gMwzpkvFSRNMb2+wVUs0+
	 A2V9KvqlG8ULxySyitxL2xF91MCpHwrqg4eSzBHZL3umDLjHJWqkhbbdClLhSRTCEC
	 Ou8XCgtXosmLhUfIjXlFuoUtOBCJQoVDj9ExKmLjVJiIfM4SgJJROzFFdQOhoJPxUu
	 AiA6tYElFLz+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 v3 2/3] net: fec: refactor PPS channel configuration
Date: Mon,  2 Dec 2024 14:16:07 -0500
Message-ID: <20241202125000-0f3090187f6d8f1c@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202155713.3564460-3-csokas.bence@prolan.hu>
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
6.11.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bf8ca67e21671 ! 1:  6987e60828e70 net: fec: refactor PPS channel configuration
    @@ Commit message
         Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
     
    +    (cherry picked from commit bf8ca67e21671e7a56e31da45360480b28f185f1)
    +    Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
    +
      ## drivers/net/ethernet/freescale/fec_ptp.c ##
     @@
      #define FEC_CC_MULT	(1 << 31)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Success   |

