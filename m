Return-Path: <stable+bounces-110735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA88A1CBF4
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1346B7A2713
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65821AA1FF;
	Sun, 26 Jan 2025 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cq8c+0Ko"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C05517E00E
	for <stable@vger.kernel.org>; Sun, 26 Jan 2025 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903969; cv=none; b=S/BFe8RkN/ojI+oVnEm48Lb9qtsIq/9hZNWFwJ7INDD7R6tNepM6CBM1ynfzYUsk0rVTd6pCr78Bzy3Fa0wq5W55UDjZVcLg2+DmHKjjIfwrDn655MBiJ4STMap37zb0hxN8VCvYe91HLaa/uy9SsURehjzLWjp4UO/FGIFMPuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903969; c=relaxed/simple;
	bh=AhMHOBy2k6ooxS4/j9zmHlSxlFPycCqhNLD0yupxzN8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HVXlYiTYHw1pLtw8Bwg+uwVt53/lv7MAeajO3McJV9opq1lZZ00TcvpvJBzkoMGZUGDYBprIjBMVCDaBpYbHIK5zJ3P71+qbXndR1tPwRwYSQa8aB/7hLgfq/Awrt0TPs9r5XT+ywhTFuAhZquCL3E3RQyISCio483ph37TZvE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cq8c+0Ko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C54FC4CED3;
	Sun, 26 Jan 2025 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903969;
	bh=AhMHOBy2k6ooxS4/j9zmHlSxlFPycCqhNLD0yupxzN8=;
	h=Date:From:To:Cc:Subject:From;
	b=cq8c+0KoMN5c59qSxGaQ7ulorbjzxB8U/tS1Hu8wl20UfPfF5tdlwrrwSaNT1ewSA
	 wz9B65PrplGVghN4B+PLefGzSiw48YEWqiRKCXIhbJ9EVj7VW3ebGg/UsCor2UHT0Q
	 1gWFzYrQMSgyC+rMjFHiLsH5HFmWlAjqGyDRgP5jnzfPf5tez45P3XBJKT7q618o/5
	 jtiQJZJbZVtWk1VrMV6Ocl20UpxM8oX7KrmKZTf+waLglYC0+BaG/tAbB9/4flm/mH
	 D6RLfo6t9GH2XzLZg/qAy2nXcPydUEfLjNEMrHx/e53KnUS7Fp1HXuvJr5ykVL521V
	 qz+wPRIZoV7xg==
Received: by pali.im (Postfix)
	id 8874346D; Sun, 26 Jan 2025 16:05:58 +0100 (CET)
Date: Sun, 26 Jan 2025 16:05:58 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: stable@vger.kernel.org
Cc: Steve French <stfrench@microsoft.com>,
	Paulo Alcantara <pc@manguebit.com>
Subject: Backport smb client fix for special files
Message-ID: <20250126150558.qybkjdcx3qbhmgcb@pali>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716

Hello,

I would like to propose backporting this commit to stable releases:
https://git.kernel.org/torvalds/c/3681c74d342db75b0d641ba60de27bf73e16e66b
smb: client: handle lack of EA support in smb2_query_path_info()

It is fixing support for querying special files (fifo/socket/block/char)
over SMB2+ servers which do not support extended attributes and reparse
point at the same time on one inode, which applied for older Windows
servers (pre-Win10).

I think that commit should have line:
Fixes: ea41367b2a60 ("smb: client: introduce SMB2_OP_QUERY_WSL_EA")

Note that the mention commit depends on:
ca4b2c460743 ("fs/smb/client: avoid querying SMB2_OP_QUERY_WSL_EA for SMB3 POSIX")

Pali

