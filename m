Return-Path: <stable+bounces-132269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9651CA86077
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 16:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C221416DF73
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 14:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC191F1516;
	Fri, 11 Apr 2025 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ykrbSkiF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881061C3BEB;
	Fri, 11 Apr 2025 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381423; cv=none; b=r5NxglBr4DJ/S+ETtACa3JFTzM6QpCTR0OJz8lJDvKTPn2fgTOK7CZ9joNXZCRhWXLP2mIeQVfwagAIO/fXiZ2cacyYOGOyaeTbQJRdEesQJBXXb3Ko87HeBjbYyLkdYcIJ65h8vGi/+ueQ3XUlDZPOqURn7WHIo8FcQ4Z+PxQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381423; c=relaxed/simple;
	bh=GJX49r3BKpYaA7bCwqkvzU5fTQ0dfWOuIUAYjRLKwrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWhUcJPDLu58KM1+CVnnQq1hsBPgsvnc4lK+iDVA4j5KRgHuW0eTUAyWIW79g/gLdaBnYU/au2s0/nzhzeVq7faanGySxJij1wXi8na+WhbHsqQ0f16PhnDXjDtouAO6jm7OZRhHU+4WD3/Mz45R+ex0O0TL3H6ttH4+76ZvaoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ykrbSkiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D59FC4CEE2;
	Fri, 11 Apr 2025 14:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744381423;
	bh=GJX49r3BKpYaA7bCwqkvzU5fTQ0dfWOuIUAYjRLKwrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ykrbSkiFYCTU78cv7nHZ/NKfAWj8GpkCFCqBKjO0j0/eisI7B3hvs/K9YlpPNiFdI
	 YBc9iW4tTH96iD8Aj0DArHvuOhdVqUZ6hcMZbNMFs+Mbon2Y2pQXU3fjbOnuz9NvaI
	 Y5wPUpg3gdByrBIFKnOun9nT+lOg20Mieq7XkzIs=
Date: Fri, 11 Apr 2025 16:23:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuen-Han Tsai <khtsai@google.com>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: dwc3: Abort suspend on soft disconnect failure
Message-ID: <2025041149-krypton-rejoice-bced@gregkh>
References: <20250327133233.2566528-1-khtsai@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327133233.2566528-1-khtsai@google.com>

On Thu, Mar 27, 2025 at 09:32:16PM +0800, Kuen-Han Tsai wrote:
> When dwc3_gadget_soft_disconnect() fails, dwc3_suspend_common() keeps
> going with the suspend, resulting in a period where the power domain is
> off, but the gadget driver remains connected.  Within this time frame,
> invoking vbus_event_work() will cause an error as it attempts to access
> DWC3 registers for endpoint disabling after the power domain has been
> completely shut down.
> 
> Abort the suspend sequence when dwc3_gadget_suspend() cannot halt the
> controller and proceeds with a soft connect.
> 
> Fixes: 9f8a67b65a49 ("usb: dwc3: gadget: fix gadget suspend/resume")
> CC: stable@vger.kernel.org
> Signed-off-by: Kuen-Han Tsai <khtsai@google.com>

Always test your patches before submitting them so you don't get emails
from grumpy maintainers telling you to test your patches so that they
don't break the build :(


