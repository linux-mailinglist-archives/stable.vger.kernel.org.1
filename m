Return-Path: <stable+bounces-107866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 451BAA0451E
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 16:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3EFE18877E6
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 15:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6B51F37A2;
	Tue,  7 Jan 2025 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="aM/1tUnR"
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA89A1F2385
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264901; cv=none; b=qmjoM5qTtSVWZPMGSO7zYeD6Kv0dk1jcIF0yb6KKviuZFqbgwlfaAppSyT97C3g2A/fGEhy3odnoadBjyH7uYoDeMUqUWR7ef/a1eK7yaoR6vdPtbuM55SZDaygbg1q/v2n9pijgBMdf3g4NvmUtS9NGg1vG/jY62DJInEhGxNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264901; c=relaxed/simple;
	bh=arw4+eIVMSjyHfkBpsvPWs5ofGbKcylUPm+oR9cKgDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opDqKQ+b6A1wwjObogfL+g4hLvVodmPJhmnD6iDSAi4RF5WjYR1SDt5q6vF+5+Vr+kkBEFJctY1OgFTkONKAqNQ5jPkA5sKVZw8c83FA4QcBaL3s9CH0zUpGX12j2Ys02h3Ei8FkCQZGi/whjQZ7CNYI854Pkiru1CqYz0rAbjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=aM/1tUnR; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-117-112.bstnma.fios.verizon.net [173.48.117.112])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 507FlQQE014374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 10:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1736264851; bh=pTkPnRIivp/J3hHqJubO2HwG8q7UId1odX55pklegn0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=aM/1tUnRmEKja7cvfzjDVcZVAUPNWac7IAXZoCFBm67NaqORVqD67R3dgnIin4qo+
	 A3FRcsOR+AGS8V10kLbz9IB1bhbeRjfXLJKc0WJBPY2bSweukS1mRKBpXWNeKz5ksg
	 uIQ0bGMUVRiGAPcVvzeC+l3Ofsk7Y7dEp0Onatq4Yxf5zyHpk2ZKHOEu/u2E4Mtd7v
	 RV8Dj/jDJsUfIPZO3E7Sb3qZhqABjSrctjfLe6kaQFtmW3sCTiKHsSLps0BL91rPPy
	 burmFCOxD0NJRHrLJOGe37pxcekkP5V5Y7VSjoWp1xuZaydqIiL+MOAm7T+81AQaKt
	 NqSuW7Zz2FBXg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E798F15C0108; Tue, 07 Jan 2025 10:47:25 -0500 (EST)
Date: Tue, 7 Jan 2025 10:47:25 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 000/156] 6.12.9-rc1 review
Message-ID: <20250107154725.GA1419052@mit.edu>
References: <20250106151141.738050441@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106151141.738050441@linuxfoundation.org>

On Mon, Jan 06, 2025 at 04:14:46PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.9 release.
> There are 156 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

No problems noted for ext4 with 6.12.9-rc1.  I don't speak officially
for xfs, but I didn't notice any new problems there either.

Cheers,

					- Ted

