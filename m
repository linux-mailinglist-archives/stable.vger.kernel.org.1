Return-Path: <stable+bounces-106766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A103DA01986
	for <lists+stable@lfdr.de>; Sun,  5 Jan 2025 14:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6343A2DD0
	for <lists+stable@lfdr.de>; Sun,  5 Jan 2025 13:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8089815383A;
	Sun,  5 Jan 2025 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PsUqOI5S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED990149C51;
	Sun,  5 Jan 2025 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736082027; cv=none; b=g8+PksBv4bPEgLxNYsFpzUKfPZZt/3oYFniC0QapGi4GEukCQ+M3/cBmosz0Sq22miWkhwHyDpRad93FTObe99rdne87ao31mdL+ElS32do475xFh3nTD7zEergmIG6U7fBG0Xq0EcLA+cIU6trgn5ius2usE2MbMzWd7cFLOfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736082027; c=relaxed/simple;
	bh=SbHv4rY/P3mlVE7HDDdC8RO/Pm4j4+0hHPWTQj8Q+vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZGbc4p/UKjbnp/0pFQA643BJevSJyKU7rocGmZugygY0tP76fHZJqLNsBDRcD8IhYFUCQgcSTmOi1Glpivqu8bYnHKnIvFhcAkNCnhixJ6eoPZKYRKIQtdWawaFBGIJzxM8ayJNAiy/uxh5OoZsEo/7vQzPHRh3PRcXN7cGykw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PsUqOI5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412D9C4CED0;
	Sun,  5 Jan 2025 13:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736082026;
	bh=SbHv4rY/P3mlVE7HDDdC8RO/Pm4j4+0hHPWTQj8Q+vY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PsUqOI5SP4ruYNavHmLC6C6UaqslZBZMbBk6KU7dx/13uskDkbUslMNZh0UDFLlaG
	 ETVCCMS+PtVJIMIOICMkgWJdYOM3FNFs9PbxlWW+yQVLKusDb+yjQka4OTdxU2bTC/
	 kWN7jngSyUkVY70otVRz0SO3pcM9tjcTDnhkCP/I=
Date: Sun, 5 Jan 2025 13:59:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: joswang <joswang1221@gmail.com>
Cc: heikki.krogerus@linux.intel.com, dmitry.baryshkov@linaro.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: pd: fix the SenderResponseTimer conform to
 specification
Message-ID: <2025010520-pod-material-75c4@gregkh>
References: <20250105125251.5190-1-joswang1221@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250105125251.5190-1-joswang1221@gmail.com>

On Sun, Jan 05, 2025 at 08:52:51PM +0800, joswang wrote:
> From: Jos Wang <joswang@lenovo.com>
> 
> According to the USB PD3 CTS specification
> (https://usb.org/document-library/
> usb-power-delivery-compliance-test-specification-0/
> USB_PD3_CTS_Q4_2024_OR.zip), the requirements for

Please put urls on one line so that they can be linked to correctly.

> tSenderResponse are different in PD2 and PD3 modes, see
> Table 19 Timing Table & Calculations. For PD2 mode, the
> tSenderResponse min 24ms and max 30ms; for PD3 mode, the
> tSenderResponse min 27ms and max 33ms.
> 
> For the "TEST.PD.PROT.SRC.2 Get_Source_Cap No Request" test
> item, after receiving the Source_Capabilities Message sent by
> the UUT, the tester deliberately does not send a Request Message
> in order to force the SenderResponse timer on the Source UUT to
> timeout. The Tester checks that a Hard Reset is detected between
> tSenderResponse min and max，the delay is between the last bit of
> the GoodCRC Message EOP has been sent and the first bit of Hard
> Reset SOP has been received. The current code does not distinguish
> between PD2 and PD3 modes, and tSenderResponse defaults to 60ms.
> This will cause this test item and the following tests to fail:
> TEST.PD.PROT.SRC3.2 SenderResponseTimer Timeout
> TEST.PD.PROT.SNK.6 SenderResponseTimer Timeout
> 
> Set the SenderResponseTimer timeout to 27ms to meet the PD2
> and PD3 mode requirements.
> 
> Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jos Wang <joswang@lenovo.com>
> ---
>  include/linux/usb/pd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index 3068c3084eb6..99ca49bbf376 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -475,7 +475,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
>  #define PD_T_NO_RESPONSE	5000	/* 4.5 - 5.5 seconds */
>  #define PD_T_DB_DETECT		10000	/* 10 - 15 seconds */
>  #define PD_T_SEND_SOURCE_CAP	150	/* 100 - 200 ms */
> -#define PD_T_SENDER_RESPONSE	60	/* 24 - 30 ms, relaxed */
> +#define PD_T_SENDER_RESPONSE	27	/* 24 - 30 ms */

Why 27 and not 30?  The comment seems odd here, right?

thanks,

greg k-h

