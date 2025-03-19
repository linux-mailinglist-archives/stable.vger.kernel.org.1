Return-Path: <stable+bounces-124903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB11A68A0E
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 11:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06D24226EB
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 10:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C58253F3C;
	Wed, 19 Mar 2025 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9BD6aTV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3320F253B45
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381659; cv=none; b=iQFahY0XSCZCTPaU/6sd0jPM9sPy9KB0ttWNTsk6jpGxX5LK/KF8WRkuDIZoqlr7Zkjl7TxjxwszB8QsA8TwWzCg6Z10OIezirfWFIYp4giKL2RcOBfhKj0cW5qmCdnGXMEUdkaT4oVkYxpfEkR+CKL7kxishge1X5yTKlZpmVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381659; c=relaxed/simple;
	bh=oLbnHjliWbkty6LtJ3RFU20AbmZRgvyYkBSTAf14nwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rx9wrXWp+Fn5y7DKRWxYfqqMKuBz4hEO8b/0nP/1Fa7sZEHioz027/8Qf+G2HtksDCJAvRBT5+qeqvPMhrZy0fIIhxphjwFHBg35esdGAxKL9kZ49exbEG2Sh9W/L/1MIsFfm5VPGL5l2JsVjyOE/ad0FoV/00kfrrO/J7NggtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9BD6aTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3877DC4CEEA;
	Wed, 19 Mar 2025 10:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742381658;
	bh=oLbnHjliWbkty6LtJ3RFU20AbmZRgvyYkBSTAf14nwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9BD6aTVYufhui0D17Tt/waLTNJLK5uKzkKxSAvAqEe4YDQQsbS6BtmmTiD1BIBbz
	 SlzJhIJPViLNrJMhEkmKPWnrb10mSu3UhDRKh0/jcZMQiAWGeTPv5yUfnKp9bX2VxH
	 a63jCLFe6cXcW2hv+dJoStbu2cuMB5/NlREdp5gRUWFGwGL+y3Oo6JGiZT1joENEtI
	 O0gPzXZYm+/T0TiNVDVGu6hNpEPkI26ChKHTQItBxjB326GQlKX57JofWfm3wwRMrT
	 oh2RW56uxaxIRoO0kURjENXXrzRbDnnzZLb4gUmOFuNU/spfAg5dZk+VX63ZIGDMFl
	 t9GbFlUAnlaQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1&6.6 V3 2/3] sign-file,extract-cert: avoid using deprecated ERR_get_error_line()
Date: Wed, 19 Mar 2025 06:54:16 -0400
Message-Id: <20250319052404-ae1188427081473a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250319064031.2971073-3-chenhuacai@loongson.cn>
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

The upstream commit SHA1 provided is correct: 467d60eddf55588add232feda325da7215ddaf30

WARNING: Author mismatch between patch and upstream commit:
Backport author: Huacai Chen<chenhuacai@loongson.cn>
Commit author: Jan Stancek<jstancek@redhat.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  467d60eddf555 ! 1:  9c23463f15459 sign-file,extract-cert: avoid using deprecated ERR_get_error_line()
    @@ Metadata
      ## Commit message ##
         sign-file,extract-cert: avoid using deprecated ERR_get_error_line()
     
    +    commit 467d60eddf55588add232feda325da7215ddaf30 upstream.
    +
         ERR_get_error_line() is deprecated since OpenSSL 3.0.
     
         Use ERR_peek_error_line() instead, and combine display_openssl_errors()
    @@ Commit message
         Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
         Reviewed-by: Neal Gompa <neal@gompa.dev>
         Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
    +    Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
     
      ## certs/extract-cert.c ##
     @@ certs/extract-cert.c: int main(int argc, char **argv)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| Current branch            |  Success    |  Success   |

