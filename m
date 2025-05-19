Return-Path: <stable+bounces-144792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D0AABBD8D
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9950E17D43D
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042E8278164;
	Mon, 19 May 2025 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o7TGT9Ky"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666BE24676D;
	Mon, 19 May 2025 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747657042; cv=none; b=G29UKGWv2VHG5ORQDR020JxEtS4+nTJSmH11ATjcGg/Od8ApeqiW7zGreKYH3U9Q+svywjPVE3g8O52uN4xyzCx+1R5oyqnqgr0Q2dbnNHCnJBg0zCxkZPPigplQRIQ5ZqATbjexmzSyuCSDWCHshE4SHI6oZEZ3Z4pB60hT78M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747657042; c=relaxed/simple;
	bh=k0xV1VkDQ3B536csRC+jiMRyNVQ0qgRkWYlYUKKdAQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRyD67YMFgubzdNbm8rks87akBu2uzNdpCY20RupdbWjtAa3WU4LVTWulxWC5uol/8o/Bwe3LusWtR2FjKwTvk3cwa/w9xeKGVgehkVRIMtBE3T8wGM9P6IsL3QRA1tVN5qei71d6hEM+FdNexDvIZOLTUL3I9UI/m/MOspPrZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=o7TGT9Ky; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p3Jk7mrRxc72y5w6oSHqx0DIyvPhGZeH42P6iahSphU=; b=o7TGT9KyomAL0hZUq0KqSv+eZM
	OIQ4RN+onf9BV2skg969AE7PhZONZXIkvkwQwjA/t6T//5OtR2Uz/fTiq7l0B7UvQeyBinybhui78
	jCI9VhIJX88lQtOrPEjyP1FtZzbwUEDrtvnQsJ+lrzEUOQ6m4JrolTP110inEy85gwBg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uGzQX-00D19r-Ng; Mon, 19 May 2025 14:17:05 +0200
Date: Mon, 19 May 2025 14:17:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: irusskikh@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: atlantic: Add error handling in
 set_raw_ingress_record()
Message-ID: <9ce386ad-72f2-4a8e-8055-1fc7906dd916@lunn.ch>
References: <20250519102132.2089-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519102132.2089-1-vulab@iscas.ac.cn>

On Mon, May 19, 2025 at 06:21:32PM +0800, Wentao Liang wrote:
> The set_raw_ingress_record() calls aq_mss_mdio_write() but does not
> check the return value. A proper implementation can be found in
> get_raw_ingress_record().
> 
> Add error handling for aq_mss_mdio_write(). If the write fails,
> return immediately.
> 
> Fixes: b8f8a0b7b5cb ("net: atlantic: MACSec ingress offload HW bindings")
> Cc: stable@vger.kernel.org # v5.7
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  .../aquantia/atlantic/macsec/macsec_api.c         | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/aquantia/atlantic/macsec/macsec_api.c b/drivers/net/ethernet/aquantia/atlantic/macsec/macsec_api.c
> index 431924959520..5e87f8b749c5 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/macsec/macsec_api.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/macsec/macsec_api.c
> @@ -62,6 +62,7 @@ static int set_raw_ingress_record(struct aq_hw_s *hw, u16 *packed_record,
>  {
>  	struct mss_ingress_lut_addr_ctl_register lut_sel_reg;
>  	struct mss_ingress_lut_ctl_register lut_op_reg;
> +	int ret;
>  
>  	unsigned int i;
>  
> @@ -105,11 +106,15 @@ static int set_raw_ingress_record(struct aq_hw_s *hw, u16 *packed_record,
>  	lut_op_reg.bits_0.lut_read = 0;
>  	lut_op_reg.bits_0.lut_write = 1;
>  
> -	aq_mss_mdio_write(hw, MDIO_MMD_VEND1,
> -			  MSS_INGRESS_LUT_ADDR_CTL_REGISTER_ADDR,
> -			  lut_sel_reg.word_0);
> -	aq_mss_mdio_write(hw, MDIO_MMD_VEND1, MSS_INGRESS_LUT_CTL_REGISTER_ADDR,
> -			  lut_op_reg.word_0);
> +	ret = aq_mss_mdio_write(hw, MDIO_MMD_VEND1,
> +				MSS_INGRESS_LUT_ADDR_CTL_REGISTER_ADDR,
> +				lut_sel_reg.word_0);
> +	if (unlikely(ret))
> +		return ret;

What about the comment above:

	/* NOTE: MSS registers must always be read/written as adjacent pairs.
	 * For instance, to write either or both 1E.80A0 and 80A1, we have to:
	 * 1. Write 1E.80A0 first
	 * 2. Then write 1E.80A1

If the first write where to fail, is it better to perform the second
write anyway, just to keep to this rule?

	Andrew

