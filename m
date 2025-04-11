Return-Path: <stable+bounces-132258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD05A85FF5
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 16:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B949D462039
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 14:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCAE1F236E;
	Fri, 11 Apr 2025 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yMLR0hRc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C371F150B;
	Fri, 11 Apr 2025 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380271; cv=none; b=JMauP3yYbpjXVX7Veo5D6H7bbeYOdCDUTKC8xF2PKIteCC7iQcI5g0H1P3wepLcmXO3NHq3c3koYKDNGereggX0GTphftrH4On8vZW0+I92VyiwfBGFWGB5kCT8TXUvd+Xal3RFaj/MnuV1hvlJWPMUN492/wcdyqmNUvlfiUiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380271; c=relaxed/simple;
	bh=wWqWHZOrq1Qn5idsQv+wIOMUCzZhIhn1TOWFLusktZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RP+V5FObK+BjkSyKchS/fv6VgZW/z2k19diQCrTJmV+SY7Th2jFtIqJXLcRGWRdwgI9IAKU/Ku3gCSsl0EzuremzTVzKdtEFrT7MW3j3E3zRCLtMqAtnhS9FiSUeJ5wi//m//4fkvj/00ThN9H0rn4kwlPtWLB8cSql67iTLBhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yMLR0hRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2803C4CEE2;
	Fri, 11 Apr 2025 14:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744380270;
	bh=wWqWHZOrq1Qn5idsQv+wIOMUCzZhIhn1TOWFLusktZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yMLR0hRcR9ALRmn/LpQN+r+iLhxiIe4HVvgwxdV1VGkMkLejZE4umtFzExLAiZZit
	 GXUdw8pgsEIVUJ957Yu/gGaISq5M+9kN3+CIdSTQ0Ry8mj63OsdmcFbeeCbrggP3m3
	 7kmlHuYGydSjZ0nv7rJN1Ka0Dub9Ui8DjdKmMwlU=
Date: Fri, 11 Apr 2025 16:04:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chance Yang <chance.yang@kneron.us>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, morgan.chang@kneron.us,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: common: usb-conn-gpio: use a unique name for usb
 connector device
Message-ID: <2025041154-perfume-demote-2fef@gregkh>
References: <20250411-work-next-v3-1-7cd9aa80190c@kneron.us>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411-work-next-v3-1-7cd9aa80190c@kneron.us>

On Fri, Apr 11, 2025 at 04:33:26PM +0800, Chance Yang wrote:
> The current implementation of the usb-conn-gpio driver uses a fixed
> "usb-charger" name for all USB connector devices. This causes conflicts
> in the power supply subsystem when multiple USB connectors are present,
> as duplicate names are not allowed.
> 
> Use IDA to manage unique IDs for naming usb connectors (e.g.,
> usb-charger-0, usb-charger-1).
> 
> Fixes: 880287910b189 ("usb: common: usb-conn-gpio: fix NULL pointer dereference of charger")

This isn't a "fix" it is a "new feature to support multiple devices in
the same system".

So I'll drop the stable stuff here when applying it, thanks.

greg k-h

