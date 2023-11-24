Return-Path: <stable+bounces-311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0A87F78C7
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 17:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02EA1C208B8
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 16:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BF433CE1;
	Fri, 24 Nov 2023 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AbVD42dz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAED6208BD
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 16:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9C8C433C7;
	Fri, 24 Nov 2023 16:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700842790;
	bh=ftQY7lXOppMsPxdBnwFyeU5/E7vZ6i2a4CeKzJxtgsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AbVD42dzRaBrr5CLE+JEFLdUd7pfHlZvjKL08kPaCw+QCPVaTMryXGtXNTMdUqffS
	 gHcjfBWJJga3h0CfQELlMxvDoYPEVaCH0wijGmQCesET5ue5EOJS7YDUoZoJNVq1mO
	 6UR2Q/zImLd83uUZ2kNVTQ+lewPzKYuvzFXoCwiY=
Date: Fri, 24 Nov 2023 16:19:48 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Victor Shih <victorshihgli@gmail.com>
Cc: stable@vger.kernel.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kai-Heng Feng <kai.heng.geng@canonical.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 6.1.y] mmc: sdhci-pci-gli: GL9755: Mask the replay timer
 timeout of AER
Message-ID: <2023112439-dealer-partridge-f568@gregkh>
References: <2023112041-creasing-democrat-d805@gregkh>
 <20231122082351.5574-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122082351.5574-1-victorshihgli@gmail.com>

On Wed, Nov 22, 2023 at 04:23:51PM +0800, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Due to a flaw in the hardware design, the GL9755 replay timer frequently
> times out when ASPM is enabled. As a result, the warning messages will
> often appear in the system log when the system accesses the GL9755
> PCI config. Therefore, the replay timer timeout must be masked.
> 
> Fixes: 36ed2fd32b2c ("mmc: sdhci-pci-gli: A workaround to allow GL9755 to enter ASPM L1.2")
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Acked-by: Kai-Heng Feng <kai.heng.geng@canonical.com>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20231107095741.8832-3-victorshihgli@gmail.com
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> (cherry picked from commit 85dd3af64965c1c0eb7373b340a1b1f7773586b0)
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Thanks, now queued up.

greg k-h

