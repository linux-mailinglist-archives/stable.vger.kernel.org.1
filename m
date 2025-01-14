Return-Path: <stable+bounces-108581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C1DA1033E
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 10:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7DDE1886B45
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 09:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1031D5AB2;
	Tue, 14 Jan 2025 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsKJKt0A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DBB22DC44;
	Tue, 14 Jan 2025 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736848053; cv=none; b=d1HFrCopaC6rYlcenjtQuuEer9QgM9XnKL7vb5yQep9rIuNINSTYFdoVzUk9OQF5nrvb02XMq0OkNnJUut1SxHGmrbpp9v1R9eTQB3Up5WJFsFWbYE/hXatTdjhe/QHCI+wfqMsOvidqEABjG5Ds5ux/z6tOiGmeQErPQ4/54ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736848053; c=relaxed/simple;
	bh=uFK1aCAdK2LWsZ3I+hdcpNoU5yY7rp2oFkjXxqh/b7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tS5qR0IF3tcFXaLVr1HCmLDz59ax+b/VqS0ceQmpPIqSr/xcoEfdlac+LGE9I2Q8AM7hZ4zM9YaoE/l3VcOcll5i3kl+A2BS5XCM438GuvNN3tjy5V3hrdT4l3L71KSzDHKVLnVCfHlm91JREOTC1cssMJGguAFaCz86Zp7s5DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsKJKt0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61507C4CEDD;
	Tue, 14 Jan 2025 09:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736848052;
	bh=uFK1aCAdK2LWsZ3I+hdcpNoU5yY7rp2oFkjXxqh/b7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UsKJKt0A2JOVyX+mnSCCo7zFqs7zZDsc4OAaptkuJhXJYRqDO+slZnOJ3YnWiSIAi
	 7LG2dqLfFE+oYYI3n/kB1qF+KNTQR7k9vLtLszdzgSw0FIj4OdcplLDJEiAoaf4m94
	 nesgUktaymN6VQ45pQ6YCjaFPPbpv08X2r9FJvZV1MDq6XP/vkH36ItwBhiJWzoUaw
	 ZbljUIJkITWruPxOa732DjCGzY8XNEQVhzJGHzZBvTEguEBECznecproMr0mTe9ZTu
	 mTtaF3Ig2CmzfhERNozT/oVEvvXdOJmTL6Muby0bnI2xLgClo7pWi3d0JaWhrtWfkH
	 XNdeXrNjKrpTw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tXdWH-000000007PO-2c1q;
	Tue, 14 Jan 2025 10:47:34 +0100
Date: Tue, 14 Jan 2025 10:47:33 +0100
From: Johan Hovold <johan@kernel.org>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot <syzbot+506479ebf12fe435d01a@syzkaller.appspotmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] USB: serial: quatech2: Fix null-ptr-deref in
 qt2_process_read_urb()
Message-ID: <Z4YytXjBXBTk4G1a@hovoldconsulting.com>
References: <20250113180034.17063-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113180034.17063-1-qasdev00@gmail.com>

On Mon, Jan 13, 2025 at 06:00:34PM +0000, Qasim Ijaz wrote:
> This patch addresses a null-ptr-deref in qt2_process_read_urb() due to
> an incorrect bounds check in the following:
> 
>        if (newport > serial->num_ports) {
>                dev_err(&port->dev,
>                        "%s - port change to invalid port: %i\n",
>                        __func__, newport);
>                break;
>        }
> 
> The condition doesn't account for the valid range of the serial->port
> buffer, which is from 0 to serial->num_ports - 1. When newport is equal
> to serial->num_ports, the assignment of "port" in the
> following code is out-of-bounds and NULL:
> 
>        serial_priv->current_port = newport;
>        port = serial->port[serial_priv->current_port];
> 
> The fix checks if newport is greater than or equal to serial->num_ports
> indicating it is out-of-bounds.
> 
> Reported-by: syzbot <syzbot+506479ebf12fe435d01a@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=506479ebf12fe435d01a
> Fixes: f7a33e608d9a ("USB: serial: add quatech2 usb to serial driver")
> Cc: <stable@vger.kernel.org>      # 3.5
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> ---

Thanks for the update. I've applied the patch now after adding Greg's
Reviewed-by tag (for v2).

For your future contributions, try to remember to include any
Reviewed-by or Tested-by tags when updating the patch unless the changes
are non-trivial.

There should typically also be a short change log here under the ---
line to indicate what changes from previous versions.

It is also encouraged to write the commit message in imperative mood
(add, change, fix) and to avoid the phrase "this patch". There are some
more details in

	Documentation/process/submitting-patches.rst

Something to keep in mind for the future, but this patch already looks
really good.

Johan

