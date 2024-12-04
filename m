Return-Path: <stable+bounces-98322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9569E411B
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5BC6B2BC74
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00ED1B85D2;
	Wed,  4 Dec 2024 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jO/2g/kP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06291E519
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331189; cv=none; b=tCr6bhou9cb4fgoltKpjaCKFWK9CtVOSb/PT3XFM9C/XRLyuDLQ8SG9g1CnwSdRtPcpBbX2PnDEOhusk2qo+SWkNg9V8d2zYWAyPUqznTkeUitE2OzQnCtdjqXqWSlEzylVzZnBve2S0tfDtS3/+EfblRziC8m3WN7vRYyqi+d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331189; c=relaxed/simple;
	bh=MFIiNJmyBHMSKbsD5SQGqIoECy1BSCRrS2gSe1x8Z/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B16W+YD1SojfrZ3J3wEsOAquwwxUhnF2D3roQ30Vb91UWWpW+nH2f+ERYKjojVGSh+KZISPCvDLp3FHusBiR2IZFnYm+U2RzMPFCviRTeCzWGp6FRZPjIn1H2A0Vqtd8BskjTQbhKOuDh10rRZmC+GFm79wW7fsh9we/uakZank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jO/2g/kP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7890C4CECD;
	Wed,  4 Dec 2024 16:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331189;
	bh=MFIiNJmyBHMSKbsD5SQGqIoECy1BSCRrS2gSe1x8Z/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jO/2g/kPrrdtcsX/zQXtr43GQX93izsKqzy7B4y7N304zXyt54xYCXvSKRtjVUzX3
	 zWnZ2iquEcDt0WJ7Tj4tubd9favxSxGT7EpOVvb54cmjBx4fZeDHVdDmDS8F63V7wv
	 bzUHxzMKWAxWcnsDzh9fBm3RPyLuhlFeGMF8BdckoQw73sQraXT4t8zz+vgt5F1v2X
	 K0tiJpkOCu6I1B09DZHNGTaCCB7wqROvdOsRoMm83eNfcAgOw2csck+0Gnw4Ykr3Wy
	 lgtbdpC8Swd5pjSIeIrgz1oJcNSsDVLO5Rd/7/AlYSY/HFtWLYkwLYKzcvwII8YfV1
	 5TtUOO0sUq3pQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jakub Acs <acsjakub@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.1] udf: Fold udf_getblk() into udf_bread()
Date: Wed,  4 Dec 2024 10:41:49 -0500
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

