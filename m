Return-Path: <stable+bounces-109451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29467A15DE5
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 17:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724B63A6E10
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 16:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C121199E9A;
	Sat, 18 Jan 2025 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yvk2WqNv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BA6192D97;
	Sat, 18 Jan 2025 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737216283; cv=none; b=pSaW95gcRKYm6ycPIib4BAe00Hg6CywgU2WtKGahqSXioX4L9evMg7BFpEh9MwkeQnhsj0D6K9xa2KbNC1829vJG+XT0bIOZh6gLLEoJ1Ia4wIFr77xjTMxe4HMNEyaBPjZzF2NzYFo1VFR6nSeLQeYijlKR/bZHwBXthmyMQqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737216283; c=relaxed/simple;
	bh=yHPeVYJ5WM0NnkY0i/OfEl3U1ikAdfYu58ntQw3Bg1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldVWVO7pOZEbWwai7TBhbUP1JA3Hd1yg8O0+6kz1TqBxyrdm9FBeT0KEB/WNU7aKhfrGM2Ojnl4HIRqfR0bk9bzB71VnXqlVlzvogCvpzfOaf+HVc5HyHfJNLZ/qbR2YKD9H+7R3KH+0kExWGDI5CZnebGCLgW951z9yDq+SjLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yvk2WqNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF826C4CED1;
	Sat, 18 Jan 2025 16:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737216282;
	bh=yHPeVYJ5WM0NnkY0i/OfEl3U1ikAdfYu58ntQw3Bg1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yvk2WqNvo/nr34TscE+WKQWPsYfOZkDnz8bvt9TNVNVuhGqhXTmUqry2YR6g3Igpe
	 6Ui/hTy04pOfYq1G98GqJJMZrN/yufLtGkOjYcnvP+36O65D+UHjukelRSgdX6dCLX
	 Tx9CapF69TbB149gPFBHLl7uLBwhzJyHfuLKpjnM=
Date: Sat, 18 Jan 2025 17:04:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	letux-kernel@openphoenux.org, stable@vger.kernel.org
Subject: Re: [PATCH] Revert v6.2-rc1 and later "ARM: dts: bcm2835-rpi: Use
 firmware clocks for display"
Message-ID: <2025011803-tactical-strangle-f6a5@gregkh>
References: <7ba92b281cea785358551c8de99845c6345a2391.1737214993.git.hns@goldelico.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ba92b281cea785358551c8de99845c6345a2391.1737214993.git.hns@goldelico.com>

On Sat, Jan 18, 2025 at 04:43:14PM +0100, H. Nikolaus Schaller wrote:
> This reverts commit d02f02c28f5561cf5b2345f8b4c910bd98d18553.

I don't see this git id anywhere in Linus's tree, where did it come
from?  It's also not in linux-next.

thanks,

greg k-h

