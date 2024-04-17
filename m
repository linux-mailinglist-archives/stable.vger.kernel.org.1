Return-Path: <stable+bounces-40064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F718A7C75
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 08:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2847DB20F68
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 06:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1062065BA8;
	Wed, 17 Apr 2024 06:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ldbH2g43"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46A3657DE
	for <stable@vger.kernel.org>; Wed, 17 Apr 2024 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336247; cv=none; b=SU6OAHYS+2eSrfP6AeQBsGxZt5e9rZexhxs5NwgbcGUfiRC5X238uOYkJyJPw5WzSd0QoetO6UeKviK6ho/szPlholJ3nxw68Nzp4P5tbVSN45BQ2c2bUDlNEIAlIdaCQfQDZPW5iUPmzwe1Xi5HnZyspYmUy+8UrwzRD5S5Omk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336247; c=relaxed/simple;
	bh=6VDUMV9OlCTam4dtYFh5wXQBvBFljS/8pu3K39YKym0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkU9tgmm1+UTlZK1ec8I9z2A6KUKcoN0BL3hWTaRa5fiI0ErR8P33qIP97On3mYelAzg+VsCRYD5vvlKjQ1llp2PweXyKcntsoXzloewFDfP4/rxbwODPVeyiOeCo9DxcDgb1xvfggUR3v0m2WQpL3ZgXwrVQpCP3sDyxjbDueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ldbH2g43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23C1C072AA;
	Wed, 17 Apr 2024 06:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713336247;
	bh=6VDUMV9OlCTam4dtYFh5wXQBvBFljS/8pu3K39YKym0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ldbH2g434sT2kSDsPom62i93FBEQGqLQO6YJjrRFkOZaVvRwx1RVVbaMGdgajT8/J
	 6piNKCN8i/DXzxr4jdRuykqX++eRp83eZxC96Mq++60UzKZ9gMPnCTdCV7K0WZ/jGd
	 L2QvIxUpqRFO/P2smoH0CJuM9+LupiRrNP42r3q0=
Date: Wed, 17 Apr 2024 08:44:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Bo Ye =?utf-8?B?KOWPtuazoik=?= <Bo.Ye@mediatek.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Chuan Chen =?utf-8?B?KOmZiOW3nSk=?= <chuan.chen@mediatek.com>,
	Yugang Wang =?utf-8?B?KOeOi+eOieWImik=?= <Yugang.Wang@mediatek.com>,
	Yongdong Zhang =?utf-8?B?KOW8oOawuOS4nCk=?= <Yongdong.Zhang@mediatek.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: =?utf-8?B?5pKk5ZueOiBbUmVxdWVzdA==?= =?utf-8?Q?=5D?= backport a
 mainline patch to Linux kernel-5.10 stable tree
Message-ID: <2024041755-probation-disparity-d466@gregkh>
References: <SEYPR03MB6531DF0562A355EF4AAEE7AF940F2@SEYPR03MB6531.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SEYPR03MB6531DF0562A355EF4AAEE7AF940F2@SEYPR03MB6531.apcprd03.prod.outlook.com>

On Wed, Apr 17, 2024 at 06:29:59AM +0000, Bo Ye (叶波) wrote:
> Bo Ye (叶波) 将撤回邮件“[Request] backport a mainline patch to Linux kernel-5.10 stable tree”。

Request what?

