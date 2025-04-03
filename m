Return-Path: <stable+bounces-128156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFD8A7B1F0
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 00:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162C5178295
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6A71A5B84;
	Thu,  3 Apr 2025 22:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvgypFUP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1B41991B2;
	Thu,  3 Apr 2025 22:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743718657; cv=none; b=XLHo1iN/vwHkC+I0ckYwqajML7vAXa3zQcmquO+moS1Kh9UjlN2nZaXa6zrxuQGJHJneFYKgzn5/E76wEFWi+kXRqVl9zapNUYJjNYT8m84vKelxemZLyrfqpofBSIA0Pxaxw4rVbAMzLGY/EPhpeo5nkVNjEedZ369ccMMfvKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743718657; c=relaxed/simple;
	bh=Qc9xs8aBCh4S2XSnGUAkBLrpSCr+0wMSSZJ9N4kWjdw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDnVMto/hrDMVmV/1kY6BvYkKc7xn4fygMQ/gjtSKdHDK2rjfYNUyF971aXTIkpPMoKTV3v5TZLg9wFY2jpHLwgpA58EtyX1d4cjpKc/jErAk15NHrGDTkwF6PDVL2k0MKK7Eqp0ibnBoGCmOOzuyqzrcjB5kgjh6nyXrX5wMMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvgypFUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE380C4CEE8;
	Thu,  3 Apr 2025 22:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743718656;
	bh=Qc9xs8aBCh4S2XSnGUAkBLrpSCr+0wMSSZJ9N4kWjdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rvgypFUPU07YbtppVHN2tck4Kz/EUKCe5ZFGYhjygIStrSCWxaSOoM7NQyUr7S66g
	 KuA1iwCpAZHWa9R3lwflVRGDElQBr/gRoTMjZELx0o/6ZcwYjrQTpbw29/QOzaE65k
	 fEp4mM6vS+CbHNhyf6sMeDJYi02tT4imIPwHq1WS3BY0OGoSs4Piu/AjspFKqHtkxA
	 S00sITKk4Cxs27tPvDEUAsvjbvAlCXgES6oj3Wl0Nfm28DWE4Dbv0E2X0sbkgk5dT4
	 E9V/b0Mc74PiCFH7lXsx+K6WwUQ0FvDIasvW8quFe8P8yF9ynUNlfy8TJg9pvNtjBr
	 3Ppt2pBDiCOsA==
Date: Thu, 3 Apr 2025 15:17:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] sfc: Add error handling for
 devlink_info_serial_number_put()
Message-ID: <20250403151735.69461ade@kernel.org>
In-Reply-To: <20250401130557.2515-1-vulab@iscas.ac.cn>
References: <20250401130557.2515-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Apr 2025 21:05:57 +0800 Wentao Liang wrote:
>  	if (!rc) {
>  		snprintf(sn, EFX_MAX_SERIALNUM_LEN, "%pm", mac_address);
> -		devlink_info_serial_number_put(req, sn);
> +		err = devlink_info_serial_number_put(req, sn);
> +		if (err)
> +			return err;

Why are you introducing another variable? You can do this:

	if (rc)
		return rc;
	snprintf...
	return devlink_info..
-- 
pw-bot: cr

