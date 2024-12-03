Return-Path: <stable+bounces-96219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 986389E17F5
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93932B2242E
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57391DE3C9;
	Tue,  3 Dec 2024 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KLrD1Xju"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A01DB922
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217059; cv=none; b=K6Qbb9Fs0F5K7Iq92xWQIZDe/NHUTUjMh7T2E7/5B9b6DU1pqdyby6m5NVDIbfEbymfQxXwbbB4zSL5GYxVewSvCMFmAQWcBssCERX1rul+sRq5MUC7lM1XpP8OFZVn193Kt/a4hKbWWqPzRjshQXO0Omv7DxsiVhIkAm9bJF9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217059; c=relaxed/simple;
	bh=EXRAGgwcX3jOuoixKjespRO5K59hivSKudrort8xLUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OO3vyCOxKrNinpXncELx2EF1WrHIC1Gv2wW14O86aUEHM84dx9KkqG1MfQ4491clL69YJjgP3f7MGlQZp9X3luXCgnVCVdREPhE8JYS4n7Bqojss8sc+3xWbIqIv6qndTPzM9zuhkLJFL6CokVX/7BGB6pDikX+KbfX6S8j8g1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KLrD1Xju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A663DC4CECF;
	Tue,  3 Dec 2024 09:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733217059;
	bh=EXRAGgwcX3jOuoixKjespRO5K59hivSKudrort8xLUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KLrD1Xju9mROEULsAevZY9o0WaxfmK583y+oZazUDRpy3K3R4WzR+SrzAI0PQ/atT
	 OrY3DG2PKVoz8x2+yEmltkcfZEkk8BSU9CA7Ca1GaMxX6ZhV/CUWbmPgvQ9CvcFLQL
	 BgPCzN+7oEf2GeQ9HU3Hb5x+m6y/JaD//PnuSJqo=
Date: Tue, 3 Dec 2024 10:10:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: stable@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Sasha Levin <sashal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.11 v3 2/3] net: fec: refactor PPS channel configuration
Message-ID: <2024120348-amusing-irritably-2b1a@gregkh>
References: <20241202155713.3564460-1-csokas.bence@prolan.hu>
 <20241202155713.3564460-3-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241202155713.3564460-3-csokas.bence@prolan.hu>

On Mon, Dec 02, 2024 at 04:57:12PM +0100, Csókás, Bence wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Preparation patch to allow for PPS channel configuration, no functional
> change intended.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> (cherry picked from commit bf8ca67e21671e7a56e31da45360480b28f185f1)
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>

Again, no blank lines please.


