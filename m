Return-Path: <stable+bounces-23358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1F885FD34
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 16:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03F61C253BF
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 15:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE741468FB;
	Thu, 22 Feb 2024 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="nB0CSrmR"
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0890014E2E8
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617300; cv=none; b=M4TPLJj1g81ACMuFSqws33CMsJ0PRx/B6Nu1bd2SLvCdT0DnOwnRpkQJ2aoLi+I1nFzalfyfHyjl/XJGAo5dSnnF6ifBJul7aE4tiHsZteidiIOe5Y+OeKZMnGs2uihMfdYWPGE7FJw+zFgpXu/6mCjF0dSaog9VotNajFqxyZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617300; c=relaxed/simple;
	bh=3gudls+qOVnJJ2Z6I9k9ViRZ5gG6pFI5d3hFmaBqiQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bY9iJc+Bgg1/Jr2SFeXj/c7j81rncM++8dRULESr3teTj/B9W4JrQVEaTJwmNpPE94cM3wFe82sW8towaWINSBntsO50D9tCgQASKiVd75GI/npY7WdSsmqCoJdyZHKUxjbnDI8YyWXPYlb5uqTUDPlEUeSOPjr6ePQZnzfxdtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=nB0CSrmR; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-198.bstnma.fios.verizon.net [173.48.102.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41MFsecV030805
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 10:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1708617282; bh=4KEodA6HsyUJpOvCLWhuiNIE3cmXsNuj9MIhHoVGIbg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=nB0CSrmRqnuPeJ6MRMK9Lmu+KQ1kiW6i+QPDCS9EHP61D74dRvAl7ReMpf4OGR+ru
	 llQPE/s8QafEMOwvPx8PvsnPzYJBlYo3KGWa+sj1u6HKvMoUwwNHCv9HkaTZZ3bAm0
	 Sc7S30hAxxAakHQkj8Cwwj7lb9S8khafxxA0t7QKzP7jOkff70DOpFx9uVqUX+q6rv
	 q3UG3UZQaxXwuYq9D/OlD3qzC5SyBjccYz+8t+mHRzqgTAXQZ5cHbv+nQNiiZe0/Y+
	 pKHwQU8ThMPnPQkoXdE05idJjyCov2r54JFTF5w0bZJBmOru75B0pIEgojIqxaX5SW
	 pc0XEKO1Nu8bw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 3A90F15C1443; Thu, 22 Feb 2024 10:54:40 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Maximilian Heyne <mheyne@amazon.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>, ravib@amazon.com, stable@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Yongqiang Yang <xiaoqiangnk@gmail.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix corruption during on-line resize
Date: Thu, 22 Feb 2024 10:54:32 -0500
Message-ID: <170861726754.823885.5472128846628604301.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215155009.94493-1-mheyne@amazon.de>
References: <20240215155009.94493-1-mheyne@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 15 Feb 2024 15:50:09 +0000, Maximilian Heyne wrote:
> We observed a corruption during on-line resize of a file system that is
> larger than 16 TiB with 4k block size. With having more then 2^32 blocks
> resize_inode is turned off by default by mke2fs. The issue can be
> reproduced on a smaller file system for convenience by explicitly
> turning off resize_inode. An on-line resize across an 8 GiB boundary (the
> size of a meta block group in this setup) then leads to a corruption:
> 
> [...]

Applied, thanks!

[1/1] ext4: fix corruption during on-line resize
      commit: 3a944549dd26ccaf1f898a4be952e75a42bf37dd

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

