Return-Path: <stable+bounces-161779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A482BB0319A
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 16:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC0F168596
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 14:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF79275B1C;
	Sun, 13 Jul 2025 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZXRGG3gs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1F38836
	for <stable@vger.kernel.org>; Sun, 13 Jul 2025 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752417639; cv=none; b=pX3Zn5OHnQjgtfRc2/dJtMIQAfdtn4QPNNsYjPNnzfOokzlVQW/CRkdQ3/MM/GFxR/SKeLNczU6Yx/gxZymFZHzsuMb4gmKWUMvhlUdAsed2ENVX33LB3OH2/QYITHdBiDd7Y/M+O3uSScJFP+VfXMMW87T6G+1u8NYpj1Ck9Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752417639; c=relaxed/simple;
	bh=7SqjEGCYQX+9A/ppf0Distjh4dcvuyFCxKbbORwGnSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJUshconhJQ7eItHQc2VeCQO8+LvzdGU1i+c8ID3Gl1qh1ghKxYUy+EMU+Tsdd5xX27uyNP2wVn5XITZ6kvp2x7KWIKSeC1bUA1Od9hJxy7cwn+Rkv90QWVX1GXR7m4m4XSPYJn0Fbc65dYSrlcwUZA/+PhHwJO+gRTGtMS9zho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZXRGG3gs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DFFC4CEE3;
	Sun, 13 Jul 2025 14:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752417637;
	bh=7SqjEGCYQX+9A/ppf0Distjh4dcvuyFCxKbbORwGnSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZXRGG3gsYfHQI4fZyxXW2YPIcvZ7rOfMekqIqHd5vbmrpk/lVlq1wUdmP4UfupneT
	 6fc66abs9XhZFv5dR/9Imdi2Bc0kjih6GwnMymllPIiT2YJH8GsSucUPmHPBct5Iy1
	 o2CxLCClf6pgkT0wzHKKueAKiCvDY0yZM2oYoCdc=
Date: Sun, 13 Jul 2025 16:40:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] pwm: mediatek: Ensure to disable clocks
 in error path" failed to apply to 5.4-stable tree
Message-ID: <2025071326-ablaze-unadorned-8a10@gregkh>
References: <2025071236-generous-jazz-41e4@gregkh>
 <ensabnoqktuudz4ohh3kyi57p7us2f3td3vascmtkvknspnpyg@jqpgnwokd3tu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ensabnoqktuudz4ohh3kyi57p7us2f3td3vascmtkvknspnpyg@jqpgnwokd3tu>

On Sat, Jul 12, 2025 at 11:00:16PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Sat, Jul 12, 2025 at 04:00:36PM +0200, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.4-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 505b730ede7f5c4083ff212aa955155b5b92e574
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025071236-generous-jazz-41e4@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..
> 
> the patch I just sent for 5.15 applies fine on 5.4.y. I assume this is
> good enough and someone will tell me if not.

All now queued up, thanks for the backports.

greg k-h

