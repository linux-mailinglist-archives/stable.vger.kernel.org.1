Return-Path: <stable+bounces-100547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26EB9EC6AD
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36E1282876
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BC71CF5CE;
	Wed, 11 Dec 2024 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nu3DzqNG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9531A78F40
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904765; cv=none; b=GjjXkpsoQCKGSWCn+dwdb/s/wS5pb9+Bxd60e7U53iGOGbsuRB+JLEeVeKfuP+qa7qj8EzoyJaaqOHHHrAXAhzifEPhjB4RQbxRWLFdCnaW4wmtBudhUMRIdag/mNfdkb4serGozrSRxtFPKyb3MDUSNLgIw6Hbntu8k7PQpcIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904765; c=relaxed/simple;
	bh=1WXP7GfflID2caPoaljF6+EoU/r2BqYEymyrCrT6ijw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IL3j5g0/iZKgCT0hwrY6LqSIhb7Mw8/8SoFVsMqwoB+R+HigQ5628SaXAY3PPCsCPxApTqpA04Z2AXLJCXUIeOlvLDxMyEIwD5J5t2DXrp7bJxFDN3S3jhMbPiwOsOQvXTCkuN0Q9ZpVhlN+n4MKfx0Rmgcmac86kBKPraamozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nu3DzqNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD843C4CED2;
	Wed, 11 Dec 2024 08:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733904765;
	bh=1WXP7GfflID2caPoaljF6+EoU/r2BqYEymyrCrT6ijw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nu3DzqNGIntR6dPSxKDRngK7p2h8na4D5W4Zoaa6qeESIoyMQ4JSvGDsf2p+bGn0o
	 1C+lP+mu/vBjnmPbh+2ha22YTcyeSkE7aLE1Ubt6/Y0b+Cpl9pzkKUtSR/iPIhkL0X
	 1COm+Ae5toTGhBblCDX9EXeaMMH+xNHN1eqJsjg8=
Date: Wed, 11 Dec 2024 09:12:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: libo.chen.cn@windriver.com
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] fou: remove warn in gue_gro_receive on
 unsupported protocol
Message-ID: <2024121154-unison-unranked-f7ea@gregkh>
References: <20241210062550.1341881-1-libo.chen.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210062550.1341881-1-libo.chen.cn@windriver.com>

On Tue, Dec 10, 2024 at 02:25:50PM +0800, libo.chen.cn@windriver.com wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> [ Upstream commit dd89a81d850fa9a65f67b4527c0e420d15bf836c ]

Please cc: all relevant people on backports

