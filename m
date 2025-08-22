Return-Path: <stable+bounces-172312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6949EB30F46
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 08:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 396D04E443A
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 06:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8561F2E54DA;
	Fri, 22 Aug 2025 06:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="cAMlxM5E"
X-Original-To: stable@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E669E2E54CB
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 06:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845027; cv=none; b=ARq9Fuu73UdWqaj9RFLJWbx7ZZJ1LlqVmCLuN1flAeRvggWepVdij62vUiDUAcXzR4mTlfIK41xyliJSAtPJ4McR9BQnTXD4z0sRn1hwI/t6ln7CuBBuGXeajmhNrQHQJaliicZzPM9qy/1TSapIws5xsqtpd5652cbx6qNvQlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845027; c=relaxed/simple;
	bh=H7hBBPY9xoVuf360iUYnrHv0WuRlXYJyICa1M43VrY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBm/3szEehGMTbAR34RsndcO5lnvp1xB8lvwnaDbRS4fdpgQDBbzlSU6l6gLeG7zsPee17rWFbmas62GpwmsatO9NUYj1DAooReDycRTzF8dNIj7gCXjPouNlgYB4+tSZR7hKX68MePVpbDpfBBS5nDOemJY/WSfvhdIgQDv+IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=cAMlxM5E; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id BAB1453456;
	Fri, 22 Aug 2025 08:43:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1755845024;
	bh=H7hBBPY9xoVuf360iUYnrHv0WuRlXYJyICa1M43VrY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cAMlxM5EBgUHsB/n3bpltjMDK9TO1eqOrDF7tUMr6oUjJDZJceEuqfadbf34nyEju
	 RkwIVXRXHdNj7Sd0dOUPcfYQrvkcyhCk5RdskVvmhd1n+UJYjfEYNw5rIgxoLC2zis
	 C3OTWekm6KudXJaHxUSfKOog2unEhnWHEFWrm5oUUxN4Nsiyxtf0cagaGu+VCBXW6i
	 GDUrSIY/KdHNaQKk1sJ0529Who1Y4XvrG42eLtM4RVMXFr3CAUTIEbujgbkjj44QBN
	 LIDVtOlsyCzi6SipMgvDVPIQMVuLVZXPCOOT3SU9y1Ybn2GNRxAOD0xHyfgeTsSRde
	 ebzFEV7whfHDg==
Date: Fri, 22 Aug 2025 08:43:43 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, jean-philippe@linaro.org, iommu@lists.linux.dev,
	virtualization@lists.linux.dev, eric.auger@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] iommu/virtio: Make instance lookup robust
Message-ID: <aKgRnzLZiUI9pWI8@8bytes.org>
References: <308911aaa1f5be32a3a709996c7bd6cf71d30f33.1755190036.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <308911aaa1f5be32a3a709996c7bd6cf71d30f33.1755190036.git.robin.murphy@arm.com>

On Thu, Aug 14, 2025 at 05:47:16PM +0100, Robin Murphy wrote:
>  drivers/iommu/virtio-iommu.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Applied for -rc, thanks Robin.

