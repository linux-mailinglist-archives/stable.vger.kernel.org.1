Return-Path: <stable+bounces-146449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6A0AC515D
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A593ADC68
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 14:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE95278E5A;
	Tue, 27 May 2025 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fwT54fW9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9E42741CD
	for <stable@vger.kernel.org>; Tue, 27 May 2025 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357690; cv=none; b=CVotcMEXWKhhKc4rMsPNrBYZ9X1hMPmTgtT7+XVzvlLVfLSMQDAeWLss5QVb1xaztcOQP28b7UAftDj0FU9Xzo3NYlaxIohX3G3ATZXbxJD2t+ogeh2VmxBRkEMnUe+DLfHXwDd+8CAt9lHZ9vCck3ORJUVt0lv4PGzUxeUZUq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357690; c=relaxed/simple;
	bh=NmHVZux+2Ahnf+fOyIq1h4c3lFfoALsxJErBSm0i//U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oi+F6Tex0BN0IQwyGZCPk2rHsBtaRNbLKO3JsGsnVbov+Ho3GsTlwaVf+LLyekecYZmzE+tdffbQkP/wRNvpxfZBY5ednbMkbSlot2f4Z3T/PgfTjkKuuacrQl5IyYMOviOzy4Gxk9jponbUijP1jp8/mPYu+DxVd86c8kuWHxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fwT54fW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A29C4CEEB;
	Tue, 27 May 2025 14:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748357689;
	bh=NmHVZux+2Ahnf+fOyIq1h4c3lFfoALsxJErBSm0i//U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fwT54fW9t+FdcMIDyInev1YNvoVarYzheD9nQPbiSYFANP5BEoX1DVsIs/R3IaF1K
	 EizUKfcFCMh3q8p1wx1kjX1YjsxCzy7VWsO+OZih+haLfYYN0DWyP37qzkq37yHCMn
	 G0VLMyTCGe/XluTwIUKP6Fy3rkQrpv/ejXkr82Oo=
Date: Tue, 27 May 2025 16:54:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matti =?iso-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: About patch "remoteproc: qcom_wcnss: Handle platforms with only
 single power domain" in stable queue
Message-ID: <2025052732-enquirer-mushily-498f@gregkh>
References: <30d4c161-1367-4013-9603-3ee3081a1ebf@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30d4c161-1367-4013-9603-3ee3081a1ebf@gmail.com>

On Fri, May 23, 2025 at 02:54:35PM +0300, Matti Lehtimäki wrote:
> Hi
> 
> Patch "remoteproc: qcom_wcnss: Handle platforms with only single power
> domain" was added to stable queue for 6.14, 6.12, 6.6, 6.1 and 5.15 but the
> patch has an issue which was fixed in upstream commit
> 4ca45af0a56d00b86285d6fdd720dca3215059a7 (https://lore.kernel.org/linux-arm-msm/20250511234026.94735-1-matti.lehtimaki@gmail.com/).
> Either the patch"remoteproc: qcom_wcnss: Handle platforms with only single
> power domain" should not be included in stable releases or the fix should be
> included as well.

The fix is already included in the queues too, thanks for the review.

greg k-h

