Return-Path: <stable+bounces-192919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396A8C4589D
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 10:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29D63B0CC5
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 09:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7F82FE04D;
	Mon, 10 Nov 2025 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojw/iH7y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7771A2E8B8A;
	Mon, 10 Nov 2025 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765965; cv=none; b=qbdE9LHulNifK+i0RLAoDD6ETv45sfF6ZSS+aDBkWXmgXpFTJBUTkEfd0/AE1ROLjDkwlN/Li0FZQF6mAEOsNxT2jwoeMhVsSbwsRHhzYY8wuorjwqJ9CytKE4PscwyUr+FSYWkUSVbEOeL1CR5v1P130Y6lOE410a5TURhiQgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765965; c=relaxed/simple;
	bh=RKR9TJk/YCtpuDpz3O/iln8sLRNX40vYIfxcPiagOXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjfQYhdEqPGR8LxV55XkCVCeUp5vBGICr/kmyZCsS4hHy0sqngHui+R2K3KevMqj58BpjwGpUo/dhWVizWv+ARCnKZs05j52DUNwrpZH7XAdLWpxw0k31JI0r+EQa13hThkpIY+Bx9CXemMn4AJMCzZp+i1z3ZvCK92uMmU3si0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojw/iH7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F218AC116D0;
	Mon, 10 Nov 2025 09:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762765965;
	bh=RKR9TJk/YCtpuDpz3O/iln8sLRNX40vYIfxcPiagOXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ojw/iH7y98/7WYICJ2J+SGVHv3fs9WK6ZrSShEx9oQPqU6g70zCsTuhJsw2lQOO55
	 EVq0Kpi53Z5qnD7ZZmrotmCQCDSD7bPeCFhVJRCDAc8skjLGkQp+w7Ibu8YSu4TUpX
	 niYSM0nQSROrfRpV6R6pvWFAmwu3EuOtUuC0uJLcZBMeECpodYgSe48AfQl4uLXtFE
	 dn7MxS3mv+Hl+Ay1GXdGfehgulYkxWC2NannTRI2j67yR5VQmHg+uRQuk9bxDyFT1n
	 gOoU0XgxFVDOcm+qAEuWO0FIg/OwfkIxG9/FyDthuCRxJRYfPx4XzRI1TQP6s65tvP
	 ENbvi1YR0h3gA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vINx6-000000008EK-3EEf;
	Mon, 10 Nov 2025 10:12:44 +0100
Date: Mon, 10 Nov 2025 10:12:44 +0100
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?utf-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>
Subject: Re: [PATCH] phy: broadcom: bcm63xx-usbh: fix section mismatches
Message-ID: <aRGsjF_IjnjdG6KB@hovoldconsulting.com>
References: <20251017054537.6884-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251017054537.6884-1-johan@kernel.org>

On Fri, Oct 17, 2025 at 07:45:37AM +0200, Johan Hovold wrote:
> Platform drivers can be probed after their init sections have been
> discarded (e.g. on probe deferral or manual rebind through sysfs) so the
> probe function and match table must not live in init.
> 
> Fixes: 783f6d3dcf35 ("phy: bcm63xx-usbh: Add BCM63xx USBH driver")
> Cc: stable@vger.kernel.org	# 5.9
> Cc: Álvaro Fernández Rojas <noltari@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Can this one be picked up for 6.19?

Johan

