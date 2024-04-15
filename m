Return-Path: <stable+bounces-39953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CD98A5966
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 19:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8604D1C22485
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 17:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1131332B7;
	Mon, 15 Apr 2024 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQ+aDlYJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E776033;
	Mon, 15 Apr 2024 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713203284; cv=none; b=ktR1gCu0nn7Kj1I8z3cCHRtBf6zadHvHSfQOwF7V1YGux91pbNxFSp/GeBJVRU8VBcqgGJiUUJV2Bhkg6ladx4F5no79DDMbCuJCLocl4I55h++sn+yC2RdfHl6e1O7cBbely1u2DN6cM6LnfTrzuNoaUv0m5biSMMqi2qPnQoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713203284; c=relaxed/simple;
	bh=aPShdw2DP64iiJ1YwOdHPMtTmJVIyo36jyERNxM2Bmg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcsweLFYknOvxwJxDR9a5j+v0AqQReF9bGitqWxeoWET2mcpTkblZ+y92H+KQ0cEg3Gl8L72FJvz5uxyiua/VlFFgrKZHRw2JtwemqL5t0JXjPNaopn8s1lbyA7p+V3BDjsSbxAa6fCmZWOBfWe5WaBN+L9qmuUpEPWQ/sNHzrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQ+aDlYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFD6C2BD11;
	Mon, 15 Apr 2024 17:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713203283;
	bh=aPShdw2DP64iiJ1YwOdHPMtTmJVIyo36jyERNxM2Bmg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oQ+aDlYJ1RtNc+up9pT4B1jjw8AsUys3NmpGqycmvUIfKkjGlKdNvZe6dUfEu4gpn
	 yTkctKYIR+V8pbXG/tzzvvrUpA+A2zvfHijap2aJmfjnQ8sV1GU30FRF0yJowywL8f
	 r+lLchMCMd2Nd6U6Rno0GYqsBuOdAa+dO9iFjZvfnjC++NWzuCxAE/bN+1QLvV2eMT
	 mG2l0QAB8wxaGyobPG7e7tl4JlOmNpitdmTugO5FuCK8ZiTi/qgZB2sNBzn5NYMqW0
	 dVnbh/Cdw05PVRy/jm0htwbycd+TIp1G0/P/edWhX5d2FMKQQGasMJk2laN7cDNENx
	 6325l6N7xrq8A==
Date: Mon, 15 Apr 2024 10:48:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, jarkko.palviainen@gmail.com,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH] net: usb: ax88179_178a: avoid writing the mac address
 before first reading
Message-ID: <20240415104802.6765bcdb@kernel.org>
In-Reply-To: <20240415072735.6135-1-jtornosm@redhat.com>
References: <20240411195129.69ff2bac@kernel.org>
	<20240415072735.6135-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 09:27:32 +0200 Jose Ignacio Tornos Martinez wrote:
> The issue happened at the initialization stage. At that moment, during
> normal rtnl_setlink call, the mac address is set and written in the device
> registers, but since the reset was not commanded previously, the mac
> address is not read from the device and without that, it always has the
> random address that is pre-generated just in case. 
> After this, during open operation, the reset is commanded and the mac
> address is read, but as the device registers were modified, it reads the
> pregenerated random mac address and not the default mac address for the
> device.

Oh, I see, why don't we issue the reset and probe time, then?

