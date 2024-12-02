Return-Path: <stable+bounces-96048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624E99E08F4
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 17:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 310BDB3CFB1
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58CC205ADB;
	Mon,  2 Dec 2024 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKtGT6Gw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648A62040A8
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149602; cv=none; b=krhreqnzGC7iotG1/SfbPX8/PISwqhXHefSjEHEqOfH2TGgDXj01HwdJyJzp/Bfh/t7o0FTYIdygtf7UEzCO6emxiu/UwoI4gIkvn3ZLQ/qmFCmwUXOyeo+OULymSDKjyt0B9vlZJe+J9xu8MTpO9ZRZ3uqBhb0Hpgl/+CxcPL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149602; c=relaxed/simple;
	bh=URk10dDtj4ycoyhOPmzMsReyUOCJeMnpT1nzTOYY0Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n98d4Cy+QMknpTZzQzi6/W8wmz2V9M2dCxeWSSVeu0jiSyBdTfktRQpsRUCGtfEOaGDJ2g6kRk9b9Da6gIqQiTivm0HdbIvY+NvNOA1NvLwlT5lU9yp0OKhGdbxJirFaPiEHl0HwCa0bHIcs0h3xe8IBZ6imS11FvtU7u+ZEFz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKtGT6Gw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33E4C4CED2;
	Mon,  2 Dec 2024 14:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149602;
	bh=URk10dDtj4ycoyhOPmzMsReyUOCJeMnpT1nzTOYY0Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hKtGT6Gww9WQ47v3mlTslg7Ub71/avc2MHP6FsuY/6p2ujKWvhNem64CR7JXkzZx2
	 mrYgDe1OAB4C+/50i4d9VDU7/VlRXSKX/y5mZp+CeR+3H5lzk7BhUFgOIC7GHZ44dQ
	 turN1imIiIBbOpTf4zff3+dsE6f3NCTyN3ft8tmrTpfxdaXfpc+JvbLPdijEv0MGdW
	 AyEJYZQWqDjrBsuUoUpMdBE4npmsPvhJfY/sBXfqKGjiD8+BJ9NJblsyJN3/Wyg3dI
	 0ybCKsRw9df+DBacASJshWS8LwlpuEa0XF0tqmDWpyGx1OtIs0Ocq/c3x1bQdn7IlF
	 G5764OKaZOpfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 1/2] Revert "arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled"
Date: Mon,  2 Dec 2024 09:26:40 -0500
Message-ID: <20241202075106-3ae738003ab36657@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202081624.156285-1-wenst@chromium.org>
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

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

