Return-Path: <stable+bounces-100036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E499E7EBF
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 08:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7227B284684
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 07:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BDB823DE;
	Sat,  7 Dec 2024 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZ2g4AfS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1776D22C6E3;
	Sat,  7 Dec 2024 07:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733557549; cv=none; b=Pkh/t6NlyLa4Gp//n6NlW67kaAZ7NVeCvvZOJs8Se5TEUDuLwG6zRHGxwU3dOQgCdUWXmfVPKl/hS8k68iADHKi5PU+hR8VSVXD1I8stZbT5UfgG5GFF5jRFk1tVTLBKv8wxAKSlYAw+8ZHcRlVIp/YkJCD77oVtF/d4Hb02Lmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733557549; c=relaxed/simple;
	bh=a88x8f60dtnCM+RV3nG2J+MnbK12fsObWZFZLq9PC4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAYzqeLA6ummLCGzoQX913pJtdpo3yYbm+a0ryzMYQthkG39ZmmSGC92sIkISDKSUVOnAKbqRfY57iOk98FdJ6w0xFsaKUA8bGLLV+4lOTP+4ryXSf1NIoqL/3fnpc3OGHKD5pegYKw/ZVsmRgqXJL7B1ZU8Fo3f8B3Q7LDjPsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZ2g4AfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73680C4CECD;
	Sat,  7 Dec 2024 07:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733557548;
	bh=a88x8f60dtnCM+RV3nG2J+MnbK12fsObWZFZLq9PC4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hZ2g4AfSkamRYfBm83sisoe+XMSSDYlDajh8zKx/BFypHYCISNInttSvwhN/fwWJd
	 7A8wpjTe1S+WoTHdvpfKyYQMMk10ybFN8HBQ8w4r5iNk1OXKs+4Bn3H3LOwoCa4uqK
	 LXtVLxZK76bPqg/ORml4ZVDfsPxBEjTL75lc37c7k9+g5Tfjv+xeESFmm8HTMEuLYp
	 U4GNRnjHClxyQNwQNkZd1f7SvSPG8neE+tUD3Ej+uM+rVtkMVrlAIDmkExSpP094ih
	 2e1naNjBY9g7UMJ7kZ9V+b3CS/Sply70EQzkmzPWOdHHgsJB9Q96S3WeeXLSAm46O3
	 JW/NDZosSXGlw==
Date: Sat, 7 Dec 2024 07:45:47 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] tools: hv: Fix a complier warning in the fcopy uio daemon
Message-ID: <Z1P9KzNG9IHXIRwI@liuwe-devbox-debian-v2>
References: <20240910004433.50254-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910004433.50254-1-decui@microsoft.com>

On Tue, Sep 10, 2024 at 12:44:32AM +0000, Dexuan Cui wrote:
> hv_fcopy_uio_daemon.c:436:53: warning: '%s' directive output may be truncated
> writing up to 14 bytes into a region of size 10 [-Wformat-truncation=]
>   436 |  snprintf(uio_dev_path, sizeof(uio_dev_path), "/dev/%s", uio_name);
> 
> Also added 'static' for the array 'desc[]'.
> 
> Fixes: 82b0945ce2c2 ("tools: hv: Add new fcopy application based on uio driver")
> Cc: stable@vger.kernel.org # 6.10+
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Applied to hyperv-fixes. Thanks.

