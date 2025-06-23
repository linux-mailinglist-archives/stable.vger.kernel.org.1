Return-Path: <stable+bounces-155318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBFAAE3845
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 10:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55D53A7174
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 08:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3181FF7BC;
	Mon, 23 Jun 2025 08:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAHh93B+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C18611E;
	Mon, 23 Jun 2025 08:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666931; cv=none; b=dZlO17XB51TnzCUaG2bOsrBr/n+SGSkeD6MOrqmjSNLkeu4uCqSeOfJR6hv09JWOVAvPTRNIOC0hSmnvKHdq4Ow6xm1DxhGzrPvfJbtUPQkQWH6if7JT7/OViqyIPdwLZb8EKSC5xKpqLnBfLxybY3kSHchqaUlhfNEFBNdkQ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666931; c=relaxed/simple;
	bh=Ubg3uBrGtm9rhbpYvMjR4OcVkcz/J41Ya6OIKHFIasE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHue4dWT7ZUvOdoMNK/3NEsLWjvj7ChL7tIcmBDrxjiT05vQVRboiUMU+RUgllT8vrhFu/swObqiKj2sVlgERX4TWihZdMWcxXkYtjacuuF++daxWHrY08D9afWyVyob/PkIwOtrA6y1RdGD7OmOkZnPIzvTZcC6k23zowiUKqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAHh93B+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB620C4CEED;
	Mon, 23 Jun 2025 08:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750666931;
	bh=Ubg3uBrGtm9rhbpYvMjR4OcVkcz/J41Ya6OIKHFIasE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YAHh93B+WYP6jDttJqicgaAEHaEb+WtN47TBmFJ/i2eIB+IZJCNZL/rDnvyu3fR+v
	 GAmzB1mTTqdOxkTnMJYzkPxanC2IOhQKALOaLJjE1heCS1C7TfyE8HJAMhXmzQD1hr
	 hnackkS5YdsVoggWr89831fOoeoH8nJft8Fkk/8fgvCJ5zsaoYskRCumzcidka7Br/
	 aZ0+XowQ5S7gOptRfqum0nybP2bQ3gEYoLeiN2dqgN5W7NZO0b6JQMEGj1jjA7pX9Y
	 IabA29z1Dse6Pzjm5z2O+R+W/XHygxmmRbgSxx8/bIuMi3S5PDTtR+EEU7Ej8813Hn
	 Y5v+mm5UaplKA==
Date: Mon, 23 Jun 2025 16:22:01 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] usb: cdnsp: Fix issue with CV Bad Descriptor test
Message-ID: <20250623082201.GA53043@nchen-desktop>
References: <20250620074306.2278838-1-pawell@cadence.com>
 <PH7PR07MB95382CCD50549DABAEFD6156DD7CA@PH7PR07MB9538.namprd07.prod.outlook.com>
 <20250621003643.GA41153@nchen-desktop>
 <PH7PR07MB953862997AC245FB4ADEE60FDD79A@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB953862997AC245FB4ADEE60FDD79A@PH7PR07MB9538.namprd07.prod.outlook.com>

On 25-06-23 05:51:08, Pawel Laszczak wrote:
> >On 25-06-20 08:23:12, Pawel Laszczak wrote:
> >> The SSP2 controller has extra endpoint state preserve bit (ESP) which
> >> setting causes that endpoint state will be preserved during Halt
> >> Endpoint command. It is used only for EP0.
> >> Without this bit the Command Verifier "TD 9.10 Bad Descriptor Test"
> >> failed.
> >> Setting this bit doesn't have any impact for SSP controller.
> >>
> >> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence
> >> USBSSP DRD Driver")
> >> cc: stable@vger.kernel.org
> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> >> ---
> >> Changelog:
> >> v3:
> >> - removed else {}
> >>
> >> v2:
> >> - removed some typos
> >> - added pep variable initialization
> >> - updated TRB_ESP description
> >>
> >>  drivers/usb/cdns3/cdnsp-debug.h  |  5 +++--
> >>  drivers/usb/cdns3/cdnsp-ep0.c    | 18 +++++++++++++++---
> >>  drivers/usb/cdns3/cdnsp-gadget.h |  6 ++++++
> >>  drivers/usb/cdns3/cdnsp-ring.c   |  3 ++-
> >>  4 files changed, 26 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/usb/cdns3/cdnsp-debug.h
> >> b/drivers/usb/cdns3/cdnsp-debug.h index cd138acdcce1..86860686d836
> >> 100644
> >> --- a/drivers/usb/cdns3/cdnsp-debug.h
> >> +++ b/drivers/usb/cdns3/cdnsp-debug.h
> >> @@ -327,12 +327,13 @@ static inline const char *cdnsp_decode_trb(char
> >*str, size_t size, u32 field0,
> >>  	case TRB_RESET_EP:
> >>  	case TRB_HALT_ENDPOINT:
> >>  		ret = scnprintf(str, size,
> >> -				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags
> >%c",
> >> +				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags
> >%c %c",
> >>  				cdnsp_trb_type_string(type),
> >>  				ep_num, ep_id % 2 ? "out" : "in",
> >>  				TRB_TO_EP_INDEX(field3), field1, field0,
> >>  				TRB_TO_SLOT_ID(field3),
> >> -				field3 & TRB_CYCLE ? 'C' : 'c');
> >> +				field3 & TRB_CYCLE ? 'C' : 'c',
> >> +				field3 & TRB_ESP ? 'P' : 'p');
> >>  		break;
> >>  	case TRB_STOP_RING:
> >>  		ret = scnprintf(str, size,
> >> diff --git a/drivers/usb/cdns3/cdnsp-ep0.c
> >> b/drivers/usb/cdns3/cdnsp-ep0.c index f317d3c84781..5cd9b898ce97
> >> 100644
> >> --- a/drivers/usb/cdns3/cdnsp-ep0.c
> >> +++ b/drivers/usb/cdns3/cdnsp-ep0.c
> >> @@ -414,6 +414,7 @@ static int cdnsp_ep0_std_request(struct
> >> cdnsp_device *pdev,  void cdnsp_setup_analyze(struct cdnsp_device
> >> *pdev)  {
> >>  	struct usb_ctrlrequest *ctrl = &pdev->setup;
> >> +	struct cdnsp_ep *pep;
> >>  	int ret = -EINVAL;
> >>  	u16 len;
> >>
> >> @@ -427,10 +428,21 @@ void cdnsp_setup_analyze(struct cdnsp_device
> >*pdev)
> >>  		goto out;
> >>  	}
> >>
> >> +	pep = &pdev->eps[0];
> >> +
> >>  	/* Restore the ep0 to Stopped/Running state. */
> >> -	if (pdev->eps[0].ep_state & EP_HALTED) {
> >> -		trace_cdnsp_ep0_halted("Restore to normal state");
> >> -		cdnsp_halt_endpoint(pdev, &pdev->eps[0], 0);
> >> +	if (pep->ep_state & EP_HALTED) {
> >> +		if (GET_EP_CTX_STATE(pep->out_ctx) == EP_STATE_HALTED)
> >> +			cdnsp_halt_endpoint(pdev, pep, 0);

You mean above is only called for SSP? And below two lines needs to
be executed no matter cdnsp_halt_endpoint(pdev, pep, 0) is called?
	
pep->ep_state &= ~EP_HALTED;
pep->ep_state |= EP_STOPPED;

If it is the case, I am okay with this patch.

Peter

> >> +
> >> +		/*
> >> +		 * Halt Endpoint Command for SSP2 for ep0 preserve current
> >> +		 * endpoint state and driver has to synchronize the
> >> +		 * software endpoint state with endpoint output context
> >> +		 * state.
> >> +		 */
> >> +		pep->ep_state &= ~EP_HALTED;
> >> +		pep->ep_state |= EP_STOPPED;
> >
> >You do not reset endpoint by calling clear_halt, could we change ep_state
> >directly?
> 
> It's only "software" endpoint state and this code is related only with ep0.
> For SSP2 the state in pep->out_ctx - "hardware" endpoint state in this
> place will be in EP_STATE_STOPPED but "software" pep->ep_state
> will be EP_HALTED. 
> Driver only synchronizes pep->ep_state with this included in pep->out_ctx.
> 
> For SSP the state in pep->out_ctx - "hardware" endpoint state in this please
> will be in EP_STATE_HALTED, and "software" pep->ep_state will be
> EP_HALTED. For SSP driver will call cdnsp_halt_endpoint in which
> it changes the "hardware" and  "software" endpoint state
> to EP_STOPPED/EP_STATE_STOPPED.
> 
> So for SSP the extra code:
> 		pep->ep_state &= ~EP_HALTED;
> 		pep->ep_state |= EP_STOPPED;
> will not change anything
> 
> Pawel
> 
> >
> >Peter
> >>  	}
> >>
> >>  	/*
> >> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h
> >> b/drivers/usb/cdns3/cdnsp-gadget.h
> >> index 2afa3e558f85..a91cca509db0 100644
> >> --- a/drivers/usb/cdns3/cdnsp-gadget.h
> >> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
> >> @@ -987,6 +987,12 @@ enum cdnsp_setup_dev {
> >>  #define STREAM_ID_FOR_TRB(p)		((((p)) << 16) & GENMASK(31,
> >16))
> >>  #define SCT_FOR_TRB(p)			(((p) << 1) & 0x7)
> >>
> >> +/*
> >> + * Halt Endpoint Command TRB field.
> >> + * The ESP bit only exists in the SSP2 controller.
> >> + */
> >> +#define TRB_ESP				BIT(9)
> >> +
> >>  /* Link TRB specific fields. */
> >>  #define TRB_TC				BIT(1)
> >>
> >> diff --git a/drivers/usb/cdns3/cdnsp-ring.c
> >> b/drivers/usb/cdns3/cdnsp-ring.c index fd06cb85c4ea..d397d28efc6e
> >> 100644
> >> --- a/drivers/usb/cdns3/cdnsp-ring.c
> >> +++ b/drivers/usb/cdns3/cdnsp-ring.c
> >> @@ -2483,7 +2483,8 @@ void cdnsp_queue_halt_endpoint(struct
> >> cdnsp_device *pdev, unsigned int ep_index)  {
> >>  	cdnsp_queue_command(pdev, 0, 0, 0, TRB_TYPE(TRB_HALT_ENDPOINT)
> >|
> >>  			    SLOT_ID_FOR_TRB(pdev->slot_id) |
> >> -			    EP_ID_FOR_TRB(ep_index));
> >> +			    EP_ID_FOR_TRB(ep_index) |
> >> +			    (!ep_index ? TRB_ESP : 0));
> >>  }
> >>
> >>  void cdnsp_force_header_wakeup(struct cdnsp_device *pdev, int
> >> intf_num)
> >> --
> >> 2.43.0
> >>
> >
> >--
> >
> >Best regards,
> >Peter

-- 

Best regards,
Peter

