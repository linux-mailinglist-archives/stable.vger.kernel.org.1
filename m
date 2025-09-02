Return-Path: <stable+bounces-176959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC115B3FA79
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 11:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E265170649
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 09:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D332EB85F;
	Tue,  2 Sep 2025 09:33:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DA42EB845;
	Tue,  2 Sep 2025 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805622; cv=none; b=MF4mG78avpPn9G5XiYhQ7fq4UheOKPz3dEXIPO03GR9uFK4eoPcwx7jCnTJZERF4Q99R6p60Wy7fVnVeyR3i4WsHrmtmvRVkwljtCY7L1gB097EqhhTwgWJGMSDR3H9WI+xgdbyOTjcdlYHFhRI2wCP/0iWsHDdDgIF+ZaaJJBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805622; c=relaxed/simple;
	bh=bbIWtaRapTz4x6+Wf9RWlPmzpKW3MH8iyuTakHp1rQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAIdGwcgMVedABNyhFRD7maVUvly5WUF7KxLVhJ6C9yTgcxRUIFffP7WBHZ34IB3FzBhjdf070mbo//yNSl4I7VDkagOQzLb4sjrKIDVM3X1aQItbEXJeuPuBD54uOh5xwTdBnfe9EQpoqxkpYLnkQbv5PqkaAOIK1LDqFizLTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Tue, 2 Sep 2025 11:33:22 +0200
From: Brett Sheffield <bacs@librecast.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Oscar Maes <oscmaes92@gmail.com>, netdev@vger.kernel.org,
	bacs@librecast.net, kuba@kernel.org, davem@davemloft.net,
	dsahern@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v4] selftests: net: add test for destination in
 broadcast packets
Message-ID: <aLa54kZLIV3zbi2v@karahi.gladserv.com>
References: <20250828114242.6433-1-oscmaes92@gmail.com>
 <03991134-4007-422b-b25a-003a85c1edb0@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03991134-4007-422b-b25a-003a85c1edb0@redhat.com>

On 2025-09-02 10:49, Paolo Abeni wrote:
> On 8/28/25 1:42 PM, Oscar Maes wrote:
> > Add test to check the broadcast ethernet destination field is set
> > correctly.
> > 
> > This test sends a broadcast ping, captures it using tcpdump and
> > ensures that all bits of the 6 octet ethernet destination address
> > are correctly set by examining the output capture file.
> > 
> > Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> > Co-authored-by: Brett A C Sheffield <bacs@librecast.net>
> 
> I'm sorry for nit-picking, but the sob/tag-chain is wrong, please have a
> look at:
> 
> https://elixir.bootlin.com/linux/v6.16.4/source/Documentation/process/submitting-patches.rst#L516

Thanks Paolo. So, something like:

Co-developed-by: Brett A C Sheffield <bacs@librecast.net>
Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
Co-developed-by: Oscar Maes <oscmaes92@gmail.com>
Signed-off-by: Oscar Maes <oscmaes92@gmail.com>

with the last sign-off by Oscar because he is submitting?


Brett

