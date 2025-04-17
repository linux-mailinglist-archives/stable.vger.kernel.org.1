Return-Path: <stable+bounces-133202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6F6A91FEF
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 16:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA54160DE3
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 14:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04632252288;
	Thu, 17 Apr 2025 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="BG7gUTR0"
X-Original-To: stable@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A9325178D;
	Thu, 17 Apr 2025 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900669; cv=none; b=Atn+xEAQsejJ08Q2OHRjvsMXmcK0uB3sBMRl//HUSUtiVEEK0bIa9QZuQ2DBfotOG74eRebE0sw6449y5DQXt6d2eHJarMUuFDRdyJzo3p0BL3f15d8fXdr5841bPFnAmG/b9+iYE1HCkXsDxD1P1dYq2T3hhFuAgn43PbVAH3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900669; c=relaxed/simple;
	bh=TUnWqrGCNuu0kp3HQLe+J7RkhciGbYiemq03Z4bFMzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpiK1nzhnivu5QLKa9Izz9bcThm5GnT0rMw5vTdSK5+P/ZHn/nYDb7rtjW5Shd3ozZeRG51yUi9v3jxTYx79gIEq0F3qiYjrpjFYp2Cl0xv5mTJ7KJD7Nmu1c+Cb6sog2W+O6TlTf0wj0L/wOQz9chkKfjllVmAgQjyZ/+1kLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=BG7gUTR0; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E58A648667;
	Thu, 17 Apr 2025 16:37:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1744900667;
	bh=TUnWqrGCNuu0kp3HQLe+J7RkhciGbYiemq03Z4bFMzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BG7gUTR09SCxCajindITMjvEuNZ4CXxJdHqSfSMCjxaN/FQm0HgQKq1r+H7qcg9Se
	 kzYfWcW7QkjpgTF0Cq1lYxy0V1BxzDQosNFwQ19E3SD/eTOHH0a+sOOnvlHpdyU+nM
	 bfu1bBgsBiTmQPOjsb/rpRiwz7ywlCo2SaSCa4X2j7Qoh4+Djy/ek8VR+ruUThlM8B
	 WFOypkOAuRdtwi+BVM3KTjIviNwcFvpDFXh7iLUFan7p/y0+kjpm3M4y4YC3qdklaV
	 BW6wp5kAnSRM7gcEJ+48J3GUWS2SmMZ8q2o35dTTALhJD1k92IWbUX5cFk+fXxNN1F
	 hdgAREQj1RGZA==
Date: Thu, 17 Apr 2025 16:37:45 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Pavel Paklov <Pavel.Paklov@cyberprotect.ru>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Wan Zongshun <Vincent.Wan@amd.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Fix potential buffer overflow in
 parse_ivrs_acpihid
Message-ID: <aAESOQ5xlTZewgo5@8bytes.org>
References: <20250325092259.392844-1-Pavel.Paklov@cyberprotect.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325092259.392844-1-Pavel.Paklov@cyberprotect.ru>

On Tue, Mar 25, 2025 at 09:22:44AM +0000, Pavel Paklov wrote:
> Fixes: ca3bf5d47cec ("iommu/amd: Introduces ivrs_acpihid kernel parameter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavel Paklov <Pavel.Paklov@cyberprotect.ru>
> ---
>  drivers/iommu/amd/init.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied for -rc, thanks.

