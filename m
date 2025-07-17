Return-Path: <stable+bounces-163276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36250B09261
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 18:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4C54E734D
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 16:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A872FCFFE;
	Thu, 17 Jul 2025 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dVA5jxos"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CA92FD592
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771433; cv=none; b=bFoAywr0X0uxINrRSX0Qs6YTCRKTkH5+kxE4W/ZOpx7m/Npl2eXTsMyDNo2k6m1QRFqo80ilGkf7Ax4Ro00Bd7YuxbtgE23jVUsgkZiWjyXJ3hVaLLlJGDMw2r/afL1PU9OqDfT2vw/qN38zArie9untFN1+XVNGMKBqqE8K8TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771433; c=relaxed/simple;
	bh=LQHCkxGzYQeVdvXkh+j6JApAZCmOD2+O5o89yFKx4eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vfs/7ea2m1nv7ZhK5L/kocYaRMdbjphlkzBjYaGzM2Un90ILQcI+nzPK8tukdjWxRwGX5aoSkEIPq8dKBhta6iC91TqRtB1MLNA9m4aK9dhs5qMELmyvtvLqpJn+tj230fcPIBrTTLAZNjnqsSSFAVBE2sOOOD35e7oYOlDjdZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dVA5jxos; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C43C4CEE3;
	Thu, 17 Jul 2025 16:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752771433;
	bh=LQHCkxGzYQeVdvXkh+j6JApAZCmOD2+O5o89yFKx4eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVA5jxostuj16FRQrcCLWZlwB3TsRsfxYvXpLyd+VJUbNnOsioWtX95JHYHl++okU
	 FWRKHUqQRCeatMO4Mk8ykh6qz5c6FsL6KGs7Sai/9B94rp93Z9IRa21QldF6GY1qNF
	 B7Ei0MI/gWy9sYokaNM+re+3VaHqvZRQpP0WRZdk=
Date: Thu, 17 Jul 2025 18:57:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: He Zhe <zhe.he@windriver.com>
Cc: cve@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH vulns] CVE-2022-49501: Fix affected versions
Message-ID: <2025071702-compel-refueling-35e9@gregkh>
References: <20250717103808.2094047-1-zhe.he@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717103808.2094047-1-zhe.he@windriver.com>

On Thu, Jul 17, 2025 at 06:38:08PM +0800, He Zhe wrote:
> As mentioned in the commit log of the fix, it is
> commit 2c9d6c2b871d ("usbnet: run unbind() before unregister_netdev()")
> that causes this CVE.
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  cve/published/2022/CVE-2022-49501.vulnerable | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 cve/published/2022/CVE-2022-49501.vulnerable
> 
> diff --git a/cve/published/2022/CVE-2022-49501.vulnerable b/cve/published/2022/CVE-2022-49501.vulnerable
> new file mode 100644
> index 000000000..138b53caf
> --- /dev/null
> +++ b/cve/published/2022/CVE-2022-49501.vulnerable
> @@ -0,0 +1 @@
> +2c9d6c2b871d5841ce26ede3e81fd37e2e33c42c
> -- 
> 2.34.1
> 
> 

Applied and the record updated, thanks!

greg k-h

