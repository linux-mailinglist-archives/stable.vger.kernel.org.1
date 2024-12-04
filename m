Return-Path: <stable+bounces-98569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C909E48A4
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE1C16262C
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA4B1F03FF;
	Wed,  4 Dec 2024 23:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KW/CTtqO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0997019DF66
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354568; cv=none; b=cGP6hBGii+WZZNkyGg2j5xhz2LsFYaJg9N9q097aDyqOLeDFjzRVOEOCVksIQtiKHI31Zxsuw0g82dxOIcCwfui81RbRxQAFS2b4BejzsCx1lEb2T3E2amq9tzGfiAtmZrdpPtkEr134ULxx9wMnvEIEw8J+zRyatdRAptRvaSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354568; c=relaxed/simple;
	bh=MFIiNJmyBHMSKbsD5SQGqIoECy1BSCRrS2gSe1x8Z/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEpR2OcjnYPNBzU8jIMZ6UGL9VNtTYxWgUPPYKExCLAVgutuWfIv6w+2sBosoTCgKUMBZq0otAMesCk3RfNxOjo/UcwneF4UC5rCR5U+gFONdfXwXGnsG5LYmExSjrKtCyyZIBpCMlYAu/HG2xzFXygR/2C+GP6Hu8Lbd92EPAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KW/CTtqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CF0C4CECD;
	Wed,  4 Dec 2024 23:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354567;
	bh=MFIiNJmyBHMSKbsD5SQGqIoECy1BSCRrS2gSe1x8Z/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KW/CTtqOwJmjzjqfTbfaxJroD6DFd8m/MsQzg1fqAXZZWKX9nJ6E8LcVzcsD5IZ15
	 fb903iIIUsFGH3rkCnAzfqGoiyZhvkMMHTKQy6bYixENeUKva1chCB1QUXvjc3kITi
	 vlw9Zk1cNkTFPeU4ujyXdq978mxy35QwQ8XYQGrAbD7HKLBhgiQfH7utarLDALgPis
	 NEjUf8gfOk6mWFcdvzuPxEsdC0W42Hay2dysXyiPsncdB87B0aRkNzC7wMiabdkFS4
	 yzY/RkK3KDCnar//mBmnaqQTTADZUmxq7z4xVV31Ygy9ieqTDHJXRZPGrhYaE66zJ0
	 kGq+Ma9x9rtNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jakub Acs <acsjakub@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.1] udf: Fold udf_getblk() into udf_bread()
Date: Wed,  4 Dec 2024 17:11:27 -0500
Message-ID: <20241204065657-de0ff92045247001@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204093226.60654-1-acsjakub@amazon.com>
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

The upstream commit SHA1 provided is correct: 32f123a3f34283f9c6446de87861696f0502b02e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jakub Acs <acsjakub@amazon.com>
Commit author: Jan Kara <jack@suse.cz>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  32f123a3f3428 < -:  ------------- udf: Fold udf_getblk() into udf_bread()
-:  ------------- > 1:  9087b1856465c udf: Fold udf_getblk() into udf_bread()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.1.y:
    fs/udf/inode.c: In function 'udf_bread':
    fs/udf/inode.c:1097:9: error: expected ';' before 'bh'
     1097 |         bh = sb_getblk(inode->i_sb, dummy.b_blocknr);
          |         ^~
    make[3]: *** [scripts/Makefile.build:250: fs/udf/inode.o] Error 1
    make[3]: Target 'fs/udf/' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:503: fs/udf] Error 2
    make[2]: Target 'fs/' not remade because of errors.
    make[1]: *** [scripts/Makefile.build:503: fs] Error 2
    make[1]: Target './' not remade because of errors.
    make: *** [Makefile:2009: .] Error 2
    make: Target '__all' not remade because of errors.

