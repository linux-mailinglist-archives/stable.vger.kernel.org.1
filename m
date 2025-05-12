Return-Path: <stable+bounces-143120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73914AB2DB2
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 05:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A3016F44D
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 03:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B91C24BC14;
	Mon, 12 May 2025 03:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrLwIqMZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E281A01B0;
	Mon, 12 May 2025 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747019065; cv=none; b=VQi+88GXjwKEM4v/Qe0l5MJTi/0LIOQJCJKzKwFtq0XY68MQUTU8wWoe7x5dXhZNuh2m0uwotm54GFvH6uYlfNr44KwrFs7f6XOxHZHxMXRn0YBwsBdJgU8bWO9EmVj2YXFQd20aaXY2zBITlEqdnEfILejFnKAAKm7v0vwAVOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747019065; c=relaxed/simple;
	bh=InXeKRc9Mii5BUUeNkOJOqHgXGYogocBtUFbeKA+AV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJBWXuARYQLo3rCtzsSK+JW9iaH1NkHoEzgwPZcclN0dF1+h374EwYim8KcjpN/YfH3AWYqk0SPYWTjnEkCEVUxO/GgRSsv14L6zmwR0RiwDUJQhobvOpnuZfIilXrm24vjEyIc3e/RtC5ThU2FLEob6yjgRFmKGJ33x+LGLpiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrLwIqMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B41BC4CEE4;
	Mon, 12 May 2025 03:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747019065;
	bh=InXeKRc9Mii5BUUeNkOJOqHgXGYogocBtUFbeKA+AV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MrLwIqMZWbgPYC7Bhk+H8p9kMMHrjRDY+SrxMGogQpiDxfkBZj8yaBVGUOMFpqrg4
	 74oWKuta6wHOj5I9ZskR7iv5OxfvYMO6JXOLvMXMypIjbw03V0ghzwT68Frkb1+sYQ
	 M76IJUxkxGV0s6wEgUuMuYtpV7al5VFIdWMuTMuI06sg7kvo1zFkGSCgvGTGoHViLD
	 /EGZwzSF/I3u++xhi4xD1rqYXzBbFNd8kbeYC0USZ4utUAmxVX6d8U8qkxlCHmz6is
	 xVCY+dODGkDeYjhrVjVeP+UPg1O86SENu02DOfyiNVAIDETWkfwwKgXPT+yOpmrYpn
	 oS2kAAlbq+XEQ==
Date: Mon, 12 May 2025 11:04:17 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: cdnsp: Fix issue with detecting command completion
 event
Message-ID: <20250512030417.GA208298@nchen-desktop>
References: <20250507063119.1914946-1-pawell@cadence.com>
 <PH7PR07MB953855E1D951721A143A83ADDD88A@PH7PR07MB9538.namprd07.prod.outlook.com>
 <PH7PR07MB953895BB387C725E701DCC0ADD8BA@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB953895BB387C725E701DCC0ADD8BA@PH7PR07MB9538.namprd07.prod.outlook.com>

On 25-05-08 06:44:20, Pawel Laszczak wrote:
> >In some cases, there is a small-time gap in which CMD_RING_BUSY can be
> >cleared by controller but adding command completion event to event ring will
> >be delayed. As the result driver will return error code.
> >This behavior has been detected on usbtest driver (test 9) with configuration
> >including ep1in/ep1out bulk and ep2in/ep2out isoc endpoint.
> >Probably this gap occurred because controller was busy with adding some
> >other events to event ring.
> >The CMD_RING_BUSY is cleared to '0' when the Command Descriptor has
> >been executed and not when command completion event has been added to
> >event ring.
> >
> >To fix this issue for this test the small delay is sufficient less than 10us) but to
> >make sure the problem doesn't happen again in the future the patch
> >introduce 3 retries to check with delay about 100us before returning error
> >code
> >
> >Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP
> >DRD Driver")
> >cc: stable@vger.kernel.org
> >Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> >---
> > drivers/usb/cdns3/cdnsp-gadget.c | 18 +++++++++++++++++-
> > 1 file changed, 17 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-
> >gadget.c
> >index f773518185c9..0eb11b5dd9d3 100644
> >--- a/drivers/usb/cdns3/cdnsp-gadget.c
> >+++ b/drivers/usb/cdns3/cdnsp-gadget.c
> >@@ -547,6 +547,7 @@ int cdnsp_wait_for_cmd_compl(struct cdnsp_device
> >*pdev)
> > 	dma_addr_t cmd_deq_dma;
> > 	union cdnsp_trb *event;
> > 	u32 cycle_state;
> >+	u32 retry = 3;
> > 	int ret, val;
> > 	u64 cmd_dma;
> > 	u32  flags;
> >@@ -578,8 +579,23 @@ int cdnsp_wait_for_cmd_compl(struct cdnsp_device
> >*pdev)
> > 		flags = le32_to_cpu(event->event_cmd.flags);
> >
> > 		/* Check the owner of the TRB. */
> >-		if ((flags & TRB_CYCLE) != cycle_state)
> >+		if ((flags & TRB_CYCLE) != cycle_state) {
> >+			/*
> >+			 *Give some extra time to get chance controller
> >+			 * to finish command before returning error code.
> >+			 * Checking CMD_RING_BUSY is not sufficient because
> >+			 * this bit is cleared to '0' when the Command
> >+			 * Descriptor has been executed by controller
> >+			 * and not when command completion event has
> >+			 * be added to event ring.
> >+			 */
> >+			if (retry--) {
> >+				usleep_range(90, 100);
> 
> I was guided by the warning from checkpatch.pl script and changed udelay to usleep_range.
> It was wrong. In this place must be used udelay. 
> I will give some time linux community for commenting  and  I will send it again in a few days.
> 

Hi Pawel,

In the normal guide, the udelay is used for the delay less than 10us. 
Checkpatch.pl may not check the execution environment (atomic vs
non-atomic), so you get that warning. 

Please increase retry counter, and decrease the udelay value, the
atomic environment is expected to exit as soon as possible once the
hardware status has changed.

-- 

Best regards,
Peter

