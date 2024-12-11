Return-Path: <stable+bounces-100558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE1F9EC6D6
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A74281176
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C490A1C549D;
	Wed, 11 Dec 2024 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VnHtuwA6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8389D3C17
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904992; cv=none; b=p23BQKrtZI2G3+5qObaYGUT+mCDkpV+FE/jxoLL3poLRD3O0H1AQRbMR3KwVFsmeg0Lnm6V000KOjavSxxh+zKcRCFf70aDvLRK2hCvhIuJaJq3SuuZgHJX/ea2LsJD3KXfnMkyZN5hig+0Wun/PAYioL9OAGwjbgLLFOaGvnv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904992; c=relaxed/simple;
	bh=g5oFlOTX9gXOUh4W9wkxACChxHRVyXT9tb6jU+2TLEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZyb9k2sZiqxbeP4eRqrY4Rsqo12V8SN+XRwpezMsWIdDOJyteA/G6NgAWSESfnosTbUyJ5PYSD/PW5NsMb77h6E/XJKsuQvQ5gI/ifvGHyYh/SZzES7WHqycZphbvMVMiMiKv/jA0Mgd4aa010TbAdZLDvjEyKu+iSLgU9Bre4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VnHtuwA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1535CC4CED2;
	Wed, 11 Dec 2024 08:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733904992;
	bh=g5oFlOTX9gXOUh4W9wkxACChxHRVyXT9tb6jU+2TLEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VnHtuwA6Mv8Bu6nct3NwQMRtO0WxDM1+aHBee3B/rnKqxaB6Pwvqk1t+p8RHKwU8j
	 qFEJiB723Hv3hdQ0NHfrTdjZhyvx1C0eRGO+f676eF/bcDoQT8UrlfbFsLX8FVyYSP
	 kzFTZtbJS8J2DlcBLGy/OJxM+Q8CTB0ZSXn1cudE=
Date: Wed, 11 Dec 2024 09:15:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jianqi.ren.cn@windriver.com
Cc: kory.maincent@bootlin.com, stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] dmaengine: dw-edma: eDMA: Add sync read before
 starting the DMA transfer in remote setup
Message-ID: <2024121152-upchuck-royal-b3bb@gregkh>
References: <20241205093758.2163649-1-jianqi.ren.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205093758.2163649-1-jianqi.ren.cn@windriver.com>

On Thu, Dec 05, 2024 at 05:37:58PM +0800, jianqi.ren.cn@windriver.com wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> [ Upstream commit bbcc1c83f343e580c3aa1f2a8593343bf7b55bba ]

Please cc: all relevant people on backports.

