Return-Path: <stable+bounces-169576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD5EB26A2F
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 16:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470D3A2517D
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 14:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06D420B803;
	Thu, 14 Aug 2025 14:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Q2L5HE0Y"
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048962040BF
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182947; cv=none; b=YqqqWz+773Txq64nWKPBHto5iTzJyOBWzzGt9Aih9Bds8MA/oGK7eRidIpOfyn82XqM4gr21UxTYXHssoPlKQtKV4MpeLqdhYw7eUd/KRrM4Rr0NOn0XOtHo04WFop2t/Th5SZG8N9W0wK8r708A9Ab5Wc/I73E00AyNtt45HIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182947; c=relaxed/simple;
	bh=lKbd0cIx3YD9yCwnJw9keUJDz6kc5VrH3W8yk6SYWLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLox4RH9K6BItRNBxZaaEcCLNExyhsd1ewJFiEKYRS6Dsy9Q5Snw3vlAWjsIWVDYEsiU28HCvSpWvqz2C5tMVLJXkDHl+2cfzDwzY6nwBKYGPwvR8iSSgBYurnrFBOp2hYuE/oqzSgMJ2pCUkz5tcnuIJUTXLiHdxDCVtUVQbYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Q2L5HE0Y; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-254.bstnma.fios.verizon.net [173.48.113.254])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57EEmmF1028538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 10:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1755182931; bh=fC9hMt9kzc35oEPyqxOv1HVhoaocx86HahTaXPHFxOc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Q2L5HE0Y86dnQH5SCo52Ozv12cmAXqoCNJm5fflJHlK5J6UvzwGkelbT4D8OXEylq
	 L5T+XKnbMN0VxZOalpMtLbpLpIsW6iXRRnFOfcW9PRO1qHOJE11/lvk7mHyoZ63PMd
	 rXAw6R06ZQ9MU+lfAoJcoVR3Jctrb6Y6xtkwScAe2vIih53kvzZFW0kjjpEqXDwnyR
	 gvuD613Bmg0VC3LPsCkmYH8rKCVZy6Qm4FGSOE+qw00Su/2ncovGz1LnZ5yJ1TAgHC
	 sv1hHkexHQGVhW/q5ZZF0LlJz0Ql3AVNkZNpfJD9C9H9qVCntc6wPjz/Rbwsjp+kiN
	 mnNYAx2oixqyg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C40192E00D6; Thu, 14 Aug 2025 10:48:48 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger@dilger.ca>
Cc: "Theodore Ts'o" <tytso@mit.edu>, stable@vger.kernel.org,
        Andreas Dilger <adilger@whamcloud.com>,
        Li Dongyang <dongyangli@ddn.com>, Alex Zhuravlev <bzzz@whamcloud.com>,
        Oleg Drokin <green@whamcloud.com>
Subject: Re: [PATCH] ext4: check fast symlink for ea_inode correctly
Date: Thu, 14 Aug 2025 10:48:39 -0400
Message-ID: <175518289074.1126827.15003843586124325207.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250717063709.757077-1-adilger@dilger.ca>
References: <20250717063709.757077-1-adilger@dilger.ca>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 16 Jul 2025 19:36:42 -0600, Andreas Dilger wrote:
> The check for a fast symlink in the presence of only an
> external xattr inode is incorrect.  If a fast symlink does
> not have an xattr block (i_file_acl == 0), but does have
> an external xattr inode that increases inode i_blocks, then
> the check for a fast symlink will incorrectly fail and
> __ext4_iget()->ext4_ind_check_inode() will report the inode
> is corrupt when it "validates" i_data[] on the next read:
> 
> [...]

Applied, thanks!

[1/1] ext4: check fast symlink for ea_inode correctly
      commit: b4cc4a4077268522e3d0d34de4b2dc144e2330fa

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

