Return-Path: <stable+bounces-155215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAB2AE281B
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDC73BC1C9
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 08:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6049F1DE2A0;
	Sat, 21 Jun 2025 08:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2gU057n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FE5149C41
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750495903; cv=none; b=gruKem6EiF4DIMmHWbBfbLNG9G01ClwYUbE3SA9ZlB+FiuZ8MQtPuuXe+Bhpzd7UAqroLgxUpQCX4Zw9nIAma2152bEVdcLLfqf4aEPA/i9iETIR/URoZmVAC22SDZneEqYiUm+sltCXCEbPq8DV2eaJE/Sq+Kv4uPT5BCa97jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750495903; c=relaxed/simple;
	bh=SKNXueTMzsXNyuc+ZhrqgiVefqMNYHzZaQSKCeYS7O4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/roDD+kz3wIb6Z6Wk6zP1DAlN3nhURMpN3unanXvC89/wlP7HcQB0mPx+hfAWTRlO9YCLYqcG4eLZ225606DxlN24/0pHM9UuQt0P4Zot0BvrbL5dNChtm8U3S2V73UKppr7RF9WGMnpguiJSVYur8yrHnERrD09K/uUCqcpzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2gU057n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433A5C4CEE7;
	Sat, 21 Jun 2025 08:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750495901;
	bh=SKNXueTMzsXNyuc+ZhrqgiVefqMNYHzZaQSKCeYS7O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G2gU057ny9huiy25TJbON1+Vyw8EcwvcrfqCBjlDkb+ot7I/NazzE3nZvgu+G3zYc
	 IxzASMWsP3vfm5AqnNfw4l3hvs8Kh5dSk8iUAqlbt9z1dOm3oRg1hhxspfCX3Cj5hf
	 iPXSEjd4acILZl6xOpy0h8buXFrevRkkGPYBTea/vF0yV1rtTS6XbVghwHE9NFnB4I
	 WQl+hMOy7UaFRFGUQPmorTDKT/gJZoHHXKhfDRtyKo7FC3vWHn1zDFgG0/MzoM5tn9
	 ZNRS0FXA7qxihRRiM80EV3QxIx4XbEo0ou/pvtAuVPKj4h6Er1Zk49llCDWbO1oTU5
	 WXnqRxX3Sggow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: WangYuli <wangyuli@uniontech.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12/6.15] RDMA/hns: initialize db in update_srq_db()
Date: Sat, 21 Jun 2025 04:51:40 -0400
Message-Id: <20250621010510-04e553c3a43621ef@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <3FDAD147897E51E6+20250619093719.90186-1-wangyuli@uniontech.com>
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

The upstream commit SHA1 provided is correct: ffe1cee21f8b533ae27c3a31bfa56b8c1b27fa6e

WARNING: Author mismatch between patch and upstream commit:
Backport author: WangYuli<wangyuli@uniontech.com>
Commit author: Chen Linxuan<chenlinxuan@uniontech.com>

Status in newer kernel trees:
6.15.y | Present (different SHA1: b6b98ff26f24)

Note: The patch differs from the upstream commit:
---
1:  ffe1cee21f8b5 ! 1:  80cf60ce40cfd RDMA/hns: initialize db in update_srq_db()
    @@ Metadata
      ## Commit message ##
         RDMA/hns: initialize db in update_srq_db()
     
    +    [ Upstream commit ffe1cee21f8b533ae27c3a31bfa56b8c1b27fa6e ]
    +
         On x86_64 with gcc version 13.3.0, I compile
         drivers/infiniband/hw/hns/hns_roce_hw_v2.c with:
     
    @@ Commit message
         Signed-off-by: Winston Wen <wentao@uniontech.com>
         Link: https://patch.msgid.link/FF922C77946229B6+20250411105459.90782-5-chenlinxuan@uniontech.com
         Signed-off-by: Leon Romanovsky <leon@kernel.org>
    +    Signed-off-by: WangYuli <wangyuli@uniontech.com>
     
      ## drivers/infiniband/hw/hns/hns_roce_hw_v2.c ##
     @@ drivers/infiniband/hw/hns/hns_roce_hw_v2.c: static void fill_wqe_idx(struct hns_roce_srq *srq, unsigned int wqe_idx)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.15.y       |  Success    |  Success   |

