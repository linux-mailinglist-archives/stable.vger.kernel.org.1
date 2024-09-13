Return-Path: <stable+bounces-76077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E871978046
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 14:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFB42845EE
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 12:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93301DA107;
	Fri, 13 Sep 2024 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H2+N+/os"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C16F1D6DA0;
	Fri, 13 Sep 2024 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231333; cv=none; b=biLo8qrcsWQGxpFhBcWWDetmutZgo8ncQDjT/vTHW8Y+Owry75a4hFsl5YVcIcxLd4Es01E55Lgu5G1FAV8JxRQy/38cb955t4mp5jhZuDYPzu8o4LDOtIB4VRl5QwgIgxMwnJ/93lJ/uzOxoUJnN5OiofmnMN/wOKFHxFPUoKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231333; c=relaxed/simple;
	bh=Z458e25P5sMZPiUvcMK90HVD/MY6/klAorNSKi5ld6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6uOQWgYDliFD9xmKxxfRcDqt4pFXCdTJiWfRvzhSrTbYc337vxRk/CL16Z3Lz3XhxoDVPX2BRX5N7OQjScVi8F04HvlE9uwiPg+vVJKn6TFtv2GJgFjvNdAvCFuZi6n+Fz+QJZZrmUNQC4sqbsUeedjXqMaxoRPEMyzAkJbCyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H2+N+/os; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903E7C4CEC0;
	Fri, 13 Sep 2024 12:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726231333;
	bh=Z458e25P5sMZPiUvcMK90HVD/MY6/klAorNSKi5ld6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H2+N+/osF+w+n9MBkQvfOimEr9WFWLtVerEqIJhlgpssLVWlplAJf0TOGfCZcbUZb
	 D35Tffti/f+NY4akk0mTKqJQTzMD6IL7FmSjfdQEI4UuLXQjwCYEF20f8lyeq7Gu19
	 e4h/+fFpgBHweao1PWY5GckFncMwGoyYlSHxhFa4=
Date: Fri, 13 Sep 2024 14:42:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, william.qiu@starfivetech.com,
	emil.renner.berthing@canonical.com, conor.dooley@microchip.com,
	xingyu.wu@starfivetech.com, walker.chen@starfivetech.com,
	robh@kernel.org, hal.feng@starfivetech.com, kernel@esmil.dk,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	richardcochran@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH 6.6 v2 1/4] riscv: dts: starfive: add assigned-clock* to
 limit frquency
Message-ID: <2024091350-lapdog-tarot-0130@gregkh>
References: <3A31C289BC240955+20240912025539.1928223-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A31C289BC240955+20240912025539.1928223-1-wangyuli@uniontech.com>

On Thu, Sep 12, 2024 at 10:55:05AM +0800, WangYuli wrote:
> From: William Qiu <william.qiu@starfivetech.com>
> 
> [ Upstream commit af571133f7ae028ec9b5fdab78f483af13bf28d3 ]
> 
> In JH7110 SoC, we need to go by-pass mode, so we need add the
> assigned-clock* properties to limit clock frquency.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  .../riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)

Please rework this series and send only what is needed here.

thanks,

greg k-h

