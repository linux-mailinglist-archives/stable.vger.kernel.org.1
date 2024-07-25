Return-Path: <stable+bounces-61341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDFB93BB37
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 05:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB35C1C225A1
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 03:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C7914A84;
	Thu, 25 Jul 2024 03:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcURaIH/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0751BC44;
	Thu, 25 Jul 2024 03:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721878018; cv=none; b=pcFJ+WkVlCaTjlizcntHxn1bP0rLWgvY9WTRq+bsJ3u+Wi3k48sn8iNWRji56qcmlizxKpAVxxHKb5HDyZgIvHO/LFmK9Kcm192fUcOhBDdgRTJgL5tLSmdOzIzxUVjOcEqIwf7JA8mq/+F2sJ58XA0JcYjHZlNOJjE/wXYjCa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721878018; c=relaxed/simple;
	bh=gGwMIdCOYRfy/mM7Bd/IbD8r8Bjgo53wbELW0P1EN4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZV2C9dCrbrlehfc+BIfEChalFfgd8Ovd0s1J+2Mm4eFHZi5PzHOxPxeOFS1IE9va65GGcxBo3Y8o6clcDhGqQKI2r7wTQetsiy7dtSvD2JdPCtul0h3NsE2HwquUWMnhP301t7NiQxXUeEUgN1fh8YS0fSfPNCiWSSd7UjN3L4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcURaIH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC83BC116B1;
	Thu, 25 Jul 2024 03:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721878018;
	bh=gGwMIdCOYRfy/mM7Bd/IbD8r8Bjgo53wbELW0P1EN4E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hcURaIH/dxLxM4HNR1i5CX64gLcFYJpQ3+lgsyCvxDlnGHC5RL2Dr/MRxIU238YU/
	 5TVCsR1jWszBpgPqXdDYjBKvtMh413aZ50JJfV4hBFebevAH47FbBDzVPaBIweiLU4
	 puC0PFumvsgx0eLr+RfVTG0529zXw+FpFE9sA7WxnD7oF0STxxR/uVTa19r9LDXpnK
	 KvpkTXHSwmWHH10B+uGhdZjvKK4DUZiBKa9ZdX1A+bpxcdu7D2u6XrvD55N4Nbyok5
	 Dmi6TFoU5GbSTu7a58U/1wCM4uK3UdXtpdqiJieA272spJNcYSPbDLFeKlyrFYOEez
	 AOZxTo9irnOcQ==
Message-ID: <cc2ec27b-783e-486b-9f7d-5b9c2d67520d@kernel.org>
Date: Thu, 25 Jul 2024 11:26:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: avoid potential int overflow in
 sanity_check_area_boundary()
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
References: <20240724175158.11928-1-n.zhandarovich@fintech.ru>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240724175158.11928-1-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/25 1:51, Nikita Zhandarovich wrote:
> While calculating the end addresses of main area and segment 0, u32
> may be not enough to hold the result without the danger of int
> overflow.
> 
> Just in case, play it safe and cast one of the operands to a
> wider type (u64).
>   
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
> 
> Fixes: fd694733d523 ("f2fs: cover large section in sanity check of super")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

