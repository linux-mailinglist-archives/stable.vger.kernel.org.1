Return-Path: <stable+bounces-88979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 832259B2BB9
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 10:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77271C21494
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 09:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84274192D70;
	Mon, 28 Oct 2024 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XySPgQVi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D2A28DA1
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108627; cv=none; b=l/pF/8+sMX76u2WhI/qNqf4e2Ls6YC+UzCm1b/c8WVSZZbj1tJwaGZQtg7TfcUoDXIQLO/RyzYs5QndHEdpLCIW1OOEcOtIZCUAARj3Vqgs1TL/AYeBe79gnBf6IZblfx0CYhH+ZN37c16ctYtqaiJ/VFKb6BrL6D+Oc3FVykCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108627; c=relaxed/simple;
	bh=Ljlt5q3KQ2yHtMQmpJWWTex/rqGzGR+C2qcLr0bKQhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rhFJeKkAyMz3I5s3XyyZYuTP6JBv4a8QMcdH9+Pt/gTJGQPH7hzgsBAJJQ8FQoHXWZ+ZGudTXEPKHYJ5LHdayfLjleBlBA7F/0okSRo+Rx3so8cbBOCMExIdq8rTRVLHjMDDW53ix0r36dEaJ5aLrYmnn2AvdQKova4Xbzs7Djo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XySPgQVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD55BC4CEC3;
	Mon, 28 Oct 2024 09:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730108626;
	bh=Ljlt5q3KQ2yHtMQmpJWWTex/rqGzGR+C2qcLr0bKQhQ=;
	h=Date:From:To:Cc:Subject:From;
	b=XySPgQVicfFkPOs53n5MAlY3sGWNqy+MXKy6BrBobFiaEc1Acs1a+C0jIcqZkCTqG
	 kezl+HMZTnlud6xlHsPLAsCv9zKLKnCbw+7/wZVCbRQ4vdp47BRmAjm22HXyKtgY24
	 /ep8t84sPHwF2yNid9zCPKa6LUonqGimTqdbXREJ/upwpeY91u9byRfllOR0noQecW
	 YiGgzp4e0wOVBlBdupfDH9esiXRsS7cpDk9SNvxj5lQHuG8oBj/sknGmPe1F/lb0kq
	 oc/BaJ0gsDj2qTrMcrP6aniCqs3sZM8n2cT9OIE/JJwMslVe6wUL2YpN7Ht3cWdCX1
	 m3JEvGibvOyOQ==
Received: by pali.im (Postfix)
	id 682EFA58; Mon, 28 Oct 2024 10:43:39 +0100 (CET)
Date: Mon, 28 Oct 2024 10:43:39 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: stable@vger.kernel.org
Cc: Steve French <stfrench@microsoft.com>,
	Paulo Alcantara <pc@manguebit.com>
Subject: Backport smb client char/block fixes
Message-ID: <20241028094339.zrywdlzguj6udyg7@pali>
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

I would like to propose backporting these two commits into stable:
* 663f295e3559 ("smb: client: fix parsing of device numbers")
* a9de67336a4a ("smb: client: set correct device number on nfs reparse points")

Linux SMB client without these two recent fixes swaps device major and
minor numbers, which makes basically char/block device nodes unusable.

Commit 663f295e3559 ("smb: client: fix parsing of device numbers")
should have had following Fixes line:
Fixes: 45e724022e27 ("smb: client: set correct file type from NFS reparse points")

And commit a9de67336a4a ("smb: client: set correct device number on nfs
reparse points") should have contained line:
Fixes: 102466f303ff ("smb: client: allow creating special files via reparse points")

Pali

