Return-Path: <stable+bounces-107824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECE2A03C8C
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 11:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2B03A57C2
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 10:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F531E9B32;
	Tue,  7 Jan 2025 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OAoUi5g6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BAE1E766E;
	Tue,  7 Jan 2025 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736246132; cv=none; b=nliPBVFHcJ+4SGLRft2tKXEAF6WyGMJTAMy/Z+ILeELeYVLkZLRZOA2vXlF9QuV+rMhbPjeFmhqImDrlRFYB2OYkzlS3zUA2jy8ZRuDcCRAFFeiRqqQ9j3lqssRuvRUPpqiPbRBOQLi/3Zx9b++fAdiGK83DlUy94eroVZCrV7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736246132; c=relaxed/simple;
	bh=u9de6E9Ud8KeMJqAICMAoUexsB3WGUffkDDAl0Qqzvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hL/LdhRbVju+fb8mNjksaQ+Bm+slluhN51bQ8R8YB/NpMiySaMQ2FhoDrZn6jxmajBq5NH7SKP2IEGNIstFdNr6t9mWA8btgFVU/HjolVb6eCL+L0T5h2EAq3AI642fAwtGTJHa6HaJncbNlEm3oMsyUatfy26ELJHP23N4bALA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OAoUi5g6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6BFC4CED6;
	Tue,  7 Jan 2025 10:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736246131;
	bh=u9de6E9Ud8KeMJqAICMAoUexsB3WGUffkDDAl0Qqzvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OAoUi5g6wLO964Cph7BpesD136J77uVqE/LrgoGSQiB6zk7gZ00FzJkfFgc2HBVlo
	 ls8m9NO8VVAQUk6R3/EswqZI6nXTWFhb9GhVMnhZcEjIqBnw70iLdFPxA23FSOtR3N
	 MKQj9Md8w8Gx3u7PTNNIVbyv8wRZLBXCJGNSRr8Q=
Date: Tue, 7 Jan 2025 11:35:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jos Wang <joswang1221@gmail.com>
Cc: heikki.krogerus@linux.intel.com, dmitry.baryshkov@linaro.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: pd: fix the SenderResponseTimer conform to
 specification
Message-ID: <2025010756-parlor-twirl-0803@gregkh>
References: <20250105125251.5190-1-joswang1221@gmail.com>
 <2025010520-pod-material-75c4@gregkh>
 <CAMtoTm2jEWQHKp2hOO7ngG1KosqH4sxgG=fg7qoHqe7Ei5DuHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMtoTm2jEWQHKp2hOO7ngG1KosqH4sxgG=fg7qoHqe7Ei5DuHQ@mail.gmail.com>

On Mon, Jan 06, 2025 at 09:25:17PM +0800, Jos Wang wrote:
> On Sun, Jan 5, 2025 at 9:00 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Jan 05, 2025 at 08:52:51PM +0800, joswang wrote:
> > > From: Jos Wang <joswang@lenovo.com>
> > >
> > > According to the USB PD3 CTS specification
> > > (https://usb.org/document-library/
> > > usb-power-delivery-compliance-test-specification-0/
> > > USB_PD3_CTS_Q4_2024_OR.zip), the requirements for
> >
> > Please put urls on one line so that they can be linked to correctly.
> >
> 
> OK，Thanks
> 
> > > tSenderResponse are different in PD2 and PD3 modes, see
> > > Table 19 Timing Table & Calculations. For PD2 mode, the
> > > tSenderResponse min 24ms and max 30ms; for PD3 mode, the
> > > tSenderResponse min 27ms and max 33ms.
> > >
> > > For the "TEST.PD.PROT.SRC.2 Get_Source_Cap No Request" test
> > > item, after receiving the Source_Capabilities Message sent by
> > > the UUT, the tester deliberately does not send a Request Message
> > > in order to force the SenderResponse timer on the Source UUT to
> > > timeout. The Tester checks that a Hard Reset is detected between
> > > tSenderResponse min and max，the delay is between the last bit of
> > > the GoodCRC Message EOP has been sent and the first bit of Hard
> > > Reset SOP has been received. The current code does not distinguish
> > > between PD2 and PD3 modes, and tSenderResponse defaults to 60ms.
> > > This will cause this test item and the following tests to fail:
> > > TEST.PD.PROT.SRC3.2 SenderResponseTimer Timeout
> > > TEST.PD.PROT.SNK.6 SenderResponseTimer Timeout
> > >
> > > Set the SenderResponseTimer timeout to 27ms to meet the PD2
> > > and PD3 mode requirements.
> > >
> > > Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > > ---
> > >  include/linux/usb/pd.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> > > index 3068c3084eb6..99ca49bbf376 100644
> > > --- a/include/linux/usb/pd.h
> > > +++ b/include/linux/usb/pd.h
> > > @@ -475,7 +475,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
> > >  #define PD_T_NO_RESPONSE     5000    /* 4.5 - 5.5 seconds */
> > >  #define PD_T_DB_DETECT               10000   /* 10 - 15 seconds */
> > >  #define PD_T_SEND_SOURCE_CAP 150     /* 100 - 200 ms */
> > > -#define PD_T_SENDER_RESPONSE 60      /* 24 - 30 ms, relaxed */
> > > +#define PD_T_SENDER_RESPONSE 27      /* 24 - 30 ms */
> >
> > Why 27 and not 30?  The comment seems odd here, right?
> >
> 
> 1、As mentioned in the commit message, "TEST.PD.PROT.SRC.2
> Get_Source_Cap No Request" test item, after receiving the
> Source_Capabilities Message sent by the UUT, the tester deliberately
> does not send a Request Message in order to force the SenderResponse
> timer on the Source UUT to timeout. The Tester checks that a Hard
> Reset is detected between tSenderResponse min and max. Since it takes
> time for the tcpm framework layer to initiate a Hard Reset (writing
> the PD PHY register through I2C operation), setting tSenderResponse to
> 30ms (PD2.0 spec max) will cause this test item to fail in PD2.0 mode.
> 
> 2、The comments here are indeed unreasonable, how about modifying it like this?
> +#define PD_T_SENDER_RESPONSE 27 /* PD2.0 spec 24ms -30ms, PD3.1 spec
> 27ms - 33ms, setting 27ms meets the requirements of PD2.0 and PD3.1.
> */

As it is, it needs to be changed to something else, so please pick
something that you would want to see if you were reading this code.

thanks,

greg k-h

