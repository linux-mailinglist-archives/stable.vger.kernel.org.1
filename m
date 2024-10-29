Return-Path: <stable+bounces-89160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 885219B40FA
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 04:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89D91C2202F
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 03:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC4C1F7565;
	Tue, 29 Oct 2024 03:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RY/y2lLM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582651D5AC7;
	Tue, 29 Oct 2024 03:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730172158; cv=none; b=iqHf0cm3cj8s/DYr5IrvU+2q5Mg2nWjXfJdiWbEnfyhM1GetrBsMzaxLoeGy5vjxcbXbmU9hxGFXKRdlirOEpXOM7lvo5znPpK7buK5prsZP4gvOZWlzVjRi3A4Ip7zfcRRBhQH7NrEYNzZsn3Ql1oUNlZmLlcEq/L+MPy7mxfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730172158; c=relaxed/simple;
	bh=/k/tpgMgvcJK0qeXQprTVVufODiHHKeph0BM3eC9Tfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QN1LowXk8TPI96gwEXdI7ScNv/ChgZnMERSXafT9uK9J0sk66l+MILn7w1gqSTBpBAJzImoNSQWmRQFjHNWAjt+JdZ/NH1E+7oijuH48Olv8ZvZze2z+9LDuWd5b+dBTmXhjh88Pz6xXd16sBkZS7kPID0M52I43baAXdPmvpv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RY/y2lLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F48C4CECD;
	Tue, 29 Oct 2024 03:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730172158;
	bh=/k/tpgMgvcJK0qeXQprTVVufODiHHKeph0BM3eC9Tfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RY/y2lLMIv5dOcsiGpbxRVCNeVJM4e6Qm3kTuCcrHdViD1efMSTylLiYbkogSscak
	 s/g++Ffyg6Y/aFpTO1V3H/C800mQOtJ5bzjmEtxl/7pZFpxfEe/k8dUzk1uV62zDwc
	 P4UkTMYjKhlxHRD6USSa/02tW8p9mWOl6iP6CAcU=
Date: Tue, 29 Oct 2024 04:22:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Faisal Hassan <quic_faisalh@quicinc.com>,
	Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] xhci: Fix Link TRB DMA in command ring stopped
 completion event
Message-ID: <2024102918-visiting-oboe-dc64@gregkh>
References: <20241022155631.1185-1-quic_faisalh@quicinc.com>
 <f9a2eb47-512e-4718-a83a-4742e09be85b@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9a2eb47-512e-4718-a83a-4742e09be85b@linux.intel.com>

On Thu, Oct 24, 2024 at 05:06:44PM +0300, Mathias Nyman wrote:
> On 22.10.2024 18.56, Faisal Hassan wrote:
> > During the aborting of a command, the software receives a command
> > completion event for the command ring stopped, with the TRB pointing
> > to the next TRB after the aborted command.
> > 
> > If the command we abort is located just before the Link TRB in the
> > command ring, then during the 'command ring stopped' completion event,
> > the xHC gives the Link TRB in the event's cmd DMA, which causes a
> > mismatch in handling command completion event.
> > 
> > To address this situation, move the 'command ring stopped' completion
> > event check slightly earlier, since the specific command it stopped
> > on isn't of significant concern.
> > 
> > Fixes: 7f84eef0dafb ("USB: xhci: No-op command queueing and irq handler.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Faisal Hassan <quic_faisalh@quicinc.com>
> 
> Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> 
> Greg, would you like to take this directly to usb-linus (6.12)?
> If not I'll send it as part of series to usb-next later

Sure, I'll take it now, thanks.

greg k-h

