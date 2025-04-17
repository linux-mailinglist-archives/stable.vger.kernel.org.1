Return-Path: <stable+bounces-133103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9BAA91DF1
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3371894F3F
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E5824339C;
	Thu, 17 Apr 2025 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QRFD6oCV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7174250F8
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896413; cv=none; b=UUZlbnurzjaeZBNgmXJwYX6yBkqXdLVhebbVGYzBpKSPxl7E+BTAKF3o5gtVj+Z34LtFyBkDv9v1hx+KdLPyLuDPnYeqHKpfb79PQ2mpAR2SRiLsSE33miOimjm6PUiUCW5E0IUewKwBgSEnHeKoQs+dKXJUsg3wBGrd5kg3P30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896413; c=relaxed/simple;
	bh=dGuQO3oqrl63nDHXQzvKdEKMxTK4H4LhzbbU6yEH0zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJgIBLsrC24A78PqY3GJLjVlRke0Z5Qc51uejCq2V6Vwtypy27HPVk7pgL2+ya8iS6YPZaccUyxx032NRlxKG2BqAfGOd+e9CnkEBY6nQd89bMmKrXrsJB/cXpZdqRIlq4ga9OMJi1wCRdHtBPWk3e+yNLqx1nBsxBoVkL5hanY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QRFD6oCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20F0C4CEEA;
	Thu, 17 Apr 2025 13:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744896413;
	bh=dGuQO3oqrl63nDHXQzvKdEKMxTK4H4LhzbbU6yEH0zI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QRFD6oCV8LlpK095p04GvcvUqVQxM9yh9JVdO8iYCUm6lZk0bvZEC2tsKR5eOj9FX
	 mLjEzqoXHZX/VDh3N4UBJ2+XnJlqfi8zmW+khYZTwHMhAm4Dm2NgN31cDdspO/KV4E
	 N+wVxYI48RZND+x7eRDUMRUZPkg2yDVuWWRhDGbI=
Date: Thu, 17 Apr 2025 15:18:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: He Zhe <zhe.he@windriver.com>
Cc: cve@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH vulns 1/2] CVE-2024-36912: Fix affected versions
Message-ID: <2025041724-snowbound-enjoyably-3d63@gregkh>
References: <20250417113737.273764-1-zhe.he@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417113737.273764-1-zhe.he@windriver.com>

On Thu, Apr 17, 2025 at 07:37:36PM +0800, He Zhe wrote:
> Link: https://lore.kernel.org/stable/SN6PR02MB415791F29F01716CCB1A23FAD4B72@SN6PR02MB4157.namprd02.prod.outlook.com/
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---

Please provide at least a valid changelog text.  A random link does
not really describe anything, sorry.

thanks,

greg k-h

