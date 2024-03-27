Return-Path: <stable+bounces-33012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAFA88EBAA
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 17:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7F01F22C2B
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53583149C70;
	Wed, 27 Mar 2024 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="17pu6OjO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BFB132804
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558368; cv=none; b=Q+CcYJVUijdmBx/r16bkQISdOxLicE4wl3hT+ksdvFFnz6YDZeq9acIrwW/2vYBCtabxf1L9j5QxBVm6sAnSZy7MLrlBKxr9E2WN6eudKwUfs9YUB40JCW1RndajEmijhEH+9hv0E8+0S1c36zMfAmrZpw3Wsy2yK2G+9Zj0dxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558368; c=relaxed/simple;
	bh=CjyzYC8YA0H7p0e9+8ivFjiP3xTl2Gvz5yiKSTC+UVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovkEUI/BPB1PlOgCXnPDEdRMx244ME1gJHfLotmqTr5lBDhL+fIzK86TGuX6/vpye+uZfw1oWI18497bxkbZpmNsxoA0SrYIaVGN60nhs4pqdls8Rq8G6nqvuaWfQN31V/zqcIqle2X64xTb3wLaPUePkRQSZ5FHJwWMYXcdGB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=17pu6OjO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1589AC433F1;
	Wed, 27 Mar 2024 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711558367;
	bh=CjyzYC8YA0H7p0e9+8ivFjiP3xTl2Gvz5yiKSTC+UVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=17pu6OjOvmb4XrPGMQ4dWnELDCTYHT7JgUhqSAdp4D5VH8QfMbCKagTAOpp6graQM
	 aa5BUkBItWHk7PGvFmjwN5r/FLWsue9FvECAWbtnwDgESACU6pq77Z/0wSm1wR1zkH
	 zMpaJKUxP6RZxZorRl9Ych9WzrWvaIyzfRt70VI4=
Date: Wed, 27 Mar 2024 17:52:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: stable@vger.kernel.org
Subject: Re: Please backport commit 13e3a512a290 (i2c: smbus: Support up to 8
 SPD EEPROMs)
Message-ID: <2024032713-atom-saxophone-0c15@gregkh>
References: <3bea11ec-32fe-4288-bc03-8c3ba63979f6@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bea11ec-32fe-4288-bc03-8c3ba63979f6@molgen.mpg.de>

On Wed, Mar 27, 2024 at 04:13:26PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Please apply commit 13e3a512a290 (i2c: smbus: Support up to 8 SPD EEPROMs)
> [1] to the stable series to get rid of a warning and to support more SPDs.
> That commit is present since v6.8-rc1.

How far back?  But isn't this a new feature, why is it needed in older
kernels?  It's not a fix for a regression.

thanks,

greg k-h

