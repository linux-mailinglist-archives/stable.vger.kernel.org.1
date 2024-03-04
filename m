Return-Path: <stable+bounces-25962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334C28708D8
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 18:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6573D1C208B5
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 17:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF67E612FB;
	Mon,  4 Mar 2024 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RhOItGgl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7656760253;
	Mon,  4 Mar 2024 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575034; cv=none; b=utwm9HSX8h+xA2sotf+pA0s7rrpH1GJk/iXETbQp4r8REOyWijywKlwgRMZvL0s9vaXuK/lzaXXIEGDxmY4oDmNhFMrs0nHR+umhnon/WWqg1auCx3TbmGKvBzGYtvidAKaPI0n1HJxn3g4sXiF62SeOV/JjKrsyyU8r9jqhbj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575034; c=relaxed/simple;
	bh=kFF0uxKntWUeCAAnxG9IrXAeqbOgKgw2MB01AwULtHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7UJYEMzuruUNiWaCVHZL+4ecbES2Mv779G//QLLdMWrNnI92jrvv227WGjrdZ3Ig9kkyMHQLfn5S7Znh2sx6ZY74AEuAjQTd27NS5j3iNrv1HCAX6Pan35iJFmgWUuAX2tEKSehxAb8Lu5zfB/XUWLZ1Vl5ave9uicwiuWsiA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RhOItGgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E46C433F1;
	Mon,  4 Mar 2024 17:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709575034;
	bh=kFF0uxKntWUeCAAnxG9IrXAeqbOgKgw2MB01AwULtHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RhOItGglIp1UomYdHodTWY8failYNgFoF+6qKglNnPVK2r1eNM4NtLU2OKGr1o90Q
	 jwu/DVN2IjKO8knVM0cKnro6YA3c5KbIfeg7K2C+MLEcp8VVnxGYRGyv+MwwaFWSK7
	 RQMx0o5wBC248HqoKMSTcLEap5/JivbMLEEe7oao=
Date: Mon, 4 Mar 2024 18:57:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Davide Caratti <dcaratti@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5.10.y] mptcp: fix double-free on socket dismantle
Message-ID: <2024030454-failing-undrilled-cc1a@gregkh>
References: <2024030455-plausible-harmonics-a964@gregkh>
 <20240304170614.2608800-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304170614.2608800-2-matttbe@kernel.org>

On Mon, Mar 04, 2024 at 06:06:15PM +0100, Matthieu Baerts (NGI0) wrote:
> From: Davide Caratti <dcaratti@redhat.com>

Now queued up, thanks.

greg k-h

