Return-Path: <stable+bounces-135161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ECEA97337
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811D4440A30
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 17:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8B129616D;
	Tue, 22 Apr 2025 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEHmbD23"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0096296156
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745341200; cv=none; b=GmjmCI3c6p8xKihLas2nXFa5uyyRTM+r0vrA95KKP8szCsgMbYgQpr4Z8iqsLAbkWhsqz6twc5WYAqNZwHNwp3+pfaaVMr8OfDUQWBlkFB1K7X/M7Kp/0ieQ8aqe6LU3/WKsYzzVLM1tfW5phzlz8xp2gH6DEccbfqzhudgysu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745341200; c=relaxed/simple;
	bh=L1Y5+g7sQbuGvVs29aGs1erOSMv4u9t6Bdy2S7ENltU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZMO5RV6zy5Be4j/TNwI0TBBYH0Jc+AHvmjv6slF16sGea0BZzkmO0FKDiAfckiSvt32han6yybJTE3c/D4RNZUqamWysESep06GhGjjD1azICKniZjhIj4vMP/6qElaR5gLK+qYTkuL6NPWtmEbHjfKD3p9fUNzbtQiJFbLomM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEHmbD23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C59C4CEE9;
	Tue, 22 Apr 2025 16:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745341199;
	bh=L1Y5+g7sQbuGvVs29aGs1erOSMv4u9t6Bdy2S7ENltU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fEHmbD23ApHaTeDVkLi7/GHbrnMRubSrfQhJBLCMGzN7Gih7sDn2kNc2jgi6imudU
	 MqL8MIFUi1H60K47fMQrSNwAYTvVULkfSTLxeLeXYslAFzW28a0/Sh8PcDJcZ0Dhlx
	 jxMYlnu1LsL7o2JOMWTVH3ChuXEuQq7zDruBPPmyOGJ8BR3U1uFa+eg8Fdj10N9ZZX
	 szf77UdvkJ6aogfcSkcD5Iz4R9hEyoX8FHKUCXZmZtGZ1d7KYvEQfgtgL2pluRD+iz
	 4MTiycrg8QiKxCTRM2tjywQLtvhB9F2BtzW6uXvLXNqk4V/h6K21BJLGYaab0ZvUek
	 bJ1VYocJxDbkg==
Date: Tue, 22 Apr 2025 09:59:56 -0700
From: Kees Cook <kees@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>, sashal@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.12] lib/Kconfig.ubsan: Remove 'default UBSAN' from
 UBSAN_INTEGER_WRAP
Message-ID: <202504220959.6DA84FAD@keescook>
References: <2025042120-backward-waged-41cf@gregkh>
 <20250421153918.3248505-2-nathan@kernel.org>
 <2025042243-cadillac-turbulent-1e8b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025042243-cadillac-turbulent-1e8b@gregkh>

On Tue, Apr 22, 2025 at 09:20:50AM +0200, Greg KH wrote:
> On Mon, Apr 21, 2025 at 08:39:19AM -0700, Nathan Chancellor wrote:
> > commit ed2b548f1017586c44f50654ef9febb42d491f31 upstream.
> 
> Wrong git id :(

Same as for 6.14:

Should be cdc2e1d9d929d7f7009b3a5edca52388a2b0891f

(ed2b548f1017586c44f50654ef9febb42d491f31 is what was fixed, I assume a
paste-o)

-- 
Kees Cook

