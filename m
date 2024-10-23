Return-Path: <stable+bounces-87824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BED99AC965
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 13:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B8FBB216F7
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 11:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A6715B0E2;
	Wed, 23 Oct 2024 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfpW12Ax"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EB2156F28;
	Wed, 23 Oct 2024 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684088; cv=none; b=X4znuv9qTzPa+jah6fTUb8kS23q6/xpVvWOdi4X1AQOy/BfzbrJlipO4PUilBNtfBP/KTXYPdXMSdqloF8SG2oEVyp8NMTY9umcI5tjrwW0pwBJ6GtbYzD5ohZewxw60S4kxJUFSomKrm4I9dRanuRb6gAk+S3znneTuZIjfItE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684088; c=relaxed/simple;
	bh=fufSj9uNmtCZW6e1uUp1uS9ieOjlaYJGgwPykDuHx1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI1OzS+oFy+Fn5Fb/pceE7q6whlOHRY7Nyg7qspuG/nvoO7uqyZcGFsCVrzSun6bQ2r8Fhlx/aqwmYKAFeDtbmLkHTD/d4jCRFW/2OH0O3xwHvckXyRZHyMNG2Wi1Fm9vtNvdsA/FQxi3olNI5G5XDDSRVI3xnbNr7TygJyYH9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfpW12Ax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29559C4CEC6;
	Wed, 23 Oct 2024 11:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729684088;
	bh=fufSj9uNmtCZW6e1uUp1uS9ieOjlaYJGgwPykDuHx1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jfpW12AxPe0gc2ZAPqPvPSjLTfXWlAICTNJ2XLioA6T+e6AxPnoyNd6uyYHGktD6q
	 tIdEMtPGYdvjKb6d5dS3UoCEqpTh7xp+uv6sp1lgS2vQVqb5v0STJFaODPrOyeFaQv
	 3K9zj9bP+JRQchwFwrjq9ZlM7OEDpn89XomVNprQir9X/06DY481pg31mJQuf4XKz8
	 N11vulFYz7f9Yd45Oey6ZmRA4cfqxqZWVITsdSKsaXiVESwzO4csf/HTM2bXRnkaYB
	 mEsg/FbmjZlhxhLsGNaS9C4I6Zax6K7YOfSqaE5rIGF4xiLxkaEe7EwNl9hYDSCF65
	 87WiiePNrPkFA==
Date: Wed, 23 Oct 2024 07:48:05 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	Rodolfo Giometti <giometti@enneenne.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: Patch "tty/serial: Make ->dcd_change()+uart_handle_dcd_change()
 status bool active" has been added to the 6.1-stable tree
Message-ID: <ZxjidR9PG2vfB_De@sashalap>
References: <20241022175403.2844928-1-sashal@kernel.org>
 <a07de63f-1723-440d-802c-6bedefec7f24@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a07de63f-1723-440d-802c-6bedefec7f24@kernel.org>

On Wed, Oct 23, 2024 at 08:25:12AM +0200, Jiri Slaby wrote:
>On 22. 10. 24, 19:54, Sasha Levin wrote:
>>This is a note to let you know that I've just added the patch titled
>>
>>     tty/serial: Make ->dcd_change()+uart_handle_dcd_change() status bool active
>
>This is a cleanup, not needed in stable. (Unless something 
>context-depends on it.)

The 3 commits you've pointed out are a pre-req for 30c9ae5ece8e ("xhci:
dbc: honor usb transfer size boundaries.").

-- 
Thanks,
Sasha

