Return-Path: <stable+bounces-56073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D43E91C12C
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 16:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C6328747C
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 14:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59DB1C0073;
	Fri, 28 Jun 2024 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oM24mVoM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832381E53A;
	Fri, 28 Jun 2024 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585438; cv=none; b=VrlKjUTapirp+7fHUCXjqFajJ7FvCTrwub76+jFnD8PNPxST1xxzzxw7VJcqi26fGU6o4C507j2ow0ujdi1vWUEjHq22AQA+8dZgZ3nXzyzo7XqK9hXJzalch+mOVK6+6y29NWIvWOOduFZKtMKU/gsEvhw6RGEntdQ3e6PJl/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585438; c=relaxed/simple;
	bh=PZpO18EWZQ4Vy4o9Cad1oIdRUQC2DpqELeP5vseTrEg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UQB/3jeDZOvSMCo0h413Wjrn8zELGUsIlAbGUe49tQvmvssIfEpr+x0+S1n+6qNaYGOLQmA/FAbVJWZMZN0nZZthMDEkxXCOOWwvj54NazSbL/uy5NSek23JqwnHCkJovFwoobIX16RjEli3INJbJnO6oEfaSo4mn+PvWwTZjOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oM24mVoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2A4C32786;
	Fri, 28 Jun 2024 14:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719585438;
	bh=PZpO18EWZQ4Vy4o9Cad1oIdRUQC2DpqELeP5vseTrEg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oM24mVoM4AABGUYVMpS58M26WrhcR1asBBHM1udWb9f6MUbtcUgqUsWS2S51yJFV2
	 +5c5+1BeHHRnGPUBY+H6K2LYHv0gr+rxQ24+SBDbGpkZkojyMCwy8MmeBv/AE6QJuF
	 MXpjJeX5MAVTRrGuAKQrjhlwmSfT2Mkkl6CFCBWZQ5oPb45RkVBQPohCO7wEo/mw2t
	 oVUZXPx4ngynziSzGvC2BoKeAZOJWbfCLu1iYnwL6Bmwhkny2q9YX/Mm0Srt/2eiRA
	 jFZxnzUPqEGUPJqidHX72F10X3oZ/JDz99iDZwC5jVPYG6qvKRCaXICDcoHjP+QKUO
	 hRgFUAWWEYxmg==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, lp610mh@gmail.com, stable@vger.kernel.org, 
 Alessandro Maggio <alex.tkd.alex@gmail.com>
In-Reply-To: <20240627105551.4159447-2-cassel@kernel.org>
References: <20240627105551.4159447-2-cassel@kernel.org>
Subject: Re: [PATCH v2] ata: libata-core: Add ATA_HORKAGE_NOLPM for all
 Crucial BX SSD1 models
Message-Id: <171958543661.6159.6966596664105852496.b4-ty@kernel.org>
Date: Fri, 28 Jun 2024 16:37:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 27 Jun 2024 12:55:52 +0200, Niklas Cassel wrote:
> We got another report that CT1000BX500SSD1 does not work with LPM.
> 
> If you look in libata-core.c, we have six different Crucial devices that
> are marked with ATA_HORKAGE_NOLPM. This model would have been the seventh.
> (This quirk is used on Crucial models starting with both CT* and
> Crucial_CT*)
> 
> [...]

Applied to libata/linux.git (for-6.10-fixes), thanks!

[1/1] ata: libata-core: Add ATA_HORKAGE_NOLPM for all Crucial BX SSD1 models
      https://git.kernel.org/libata/linux/c/1066fe82

Kind regards,
Niklas


