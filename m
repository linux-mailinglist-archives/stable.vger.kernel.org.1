Return-Path: <stable+bounces-145810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D48ABF260
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 13:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B0D4E56CD
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 11:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFF425FA0B;
	Wed, 21 May 2025 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Otq9pjOo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E46E2367D4;
	Wed, 21 May 2025 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747825610; cv=none; b=t1iBDJZHGXT5q9XadiOocHDy9ZQ1llthBlCRZd8Is90295oGSsx167Mdj/OkxVnyKhSIEt6eDTyzmAJNAwBlgNw4Y1tr6A7L3amgS5zMT+Qw3lbgLJfo2VlRrehbArR02AVXJdtHXKbyPMrbSCjg1Db8Mh9e/9FbdJII9gcf3jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747825610; c=relaxed/simple;
	bh=KZqZ4g3Cpai/Kr1odPYNf50eKT339ne4HQqp95+qyXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1iTnt6OACH2Zk788CupLYVl/WrbxfmQpmumH3vmaava52GY0Ro+uEZp4OYnd2w/u2HQK1tXurBnn/n/+cls+WwikWWR977Ek58SAMEUJld/CLDL8OYb90ITZmfuAhzsN95YnhI9/XhHnUV0rgw+6jxNWmpzaZd/TqKNibKAVG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Otq9pjOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22360C4CEE4;
	Wed, 21 May 2025 11:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747825609;
	bh=KZqZ4g3Cpai/Kr1odPYNf50eKT339ne4HQqp95+qyXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Otq9pjOo4+67E4MPFU32l+QDPGSbZWs8RzkoAG0w1RJzipTpcVBUC/gpSKQpfRtqD
	 CxAA30p2YxnQp+BJ+zLvl+hU8ERjO01or52j7dnQ7Jp2ZVnCVQoIPlSk/re4Spc+wf
	 N09UO2TeVO2AHUbjbdyuBiVuSz/tXP7saUE/A0e8=
Date: Wed, 21 May 2025 13:06:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: RD Babiera <rdbabiera@google.com>
Cc: heikki.krogerus@linux.intel.com, badhri@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: tcpm: apply vbus before data bringup in
 tcpm_src_attach
Message-ID: <2025052122-puzzle-certainly-952e@gregkh>
References: <20250515014003.1681068-2-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515014003.1681068-2-rdbabiera@google.com>

On Thu, May 15, 2025 at 01:40:02AM +0000, RD Babiera wrote:
> This patch fixes Type-C compliance test TD 4.7.6 - Try.SNK DRP Connect
> SNKAS.
> 
> tVbusON has a limit of 275ms when entering SRC_ATTACHED. Compliance
> testers can interpret the TryWait.Src to Attached.Src transition after
> Try.Snk as being in Attached.Src the entire time, so ~170ms is lost
> to the debounce timer.
> 
> Setting the data role can be a costly operation in host mode, and when
> completed after 100ms can cause Type-C compliance test check TD 4.7.5.V.4
> to fail.
> 
> Turn VBUS on before tcpm_set_roles to meet timing requirement.
> 
> Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
> Changes since v1:
> * Rebased on top of usb-linus for v6.15

This needs to go into 6.16-rc1 given the lateness of it, sorry.  And it
doesn't apply at all to my usb-next branch :(

thanks,

greg k-h

