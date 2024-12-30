Return-Path: <stable+bounces-106285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC649FE6F2
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E611882408
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 14:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89181A9B3D;
	Mon, 30 Dec 2024 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dWDaOGs1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABBC1A83FA
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568232; cv=none; b=SKRXTaywgWNklUl7zGbqS4l1HlxLLIPbeNlh0Zm1DgfmoMldaslsq5mQwXvNYuwNNlulj6obxPBOl7xxKhA47zYVWfaFc1wwpFyRY8Y9L4LcYRbdo3Zio51Q6n3RYCvHZhd1Fm4UaRYegOttMV7y/tk6SUNJ2q2XDzyteIDG9bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568232; c=relaxed/simple;
	bh=zNBFk8TTTDsqJLI9KoKTTzxyLrG+qS44xVVB5xWNMNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIMqe+hJ2lL/Z3u7nHZVydCG/QTm/8xCQROcuTakEM21/8NtTisM3XDGiSI9KhkZ2Cknlmbo5gpM3AwhyGEltstWjK6wXF64xXKFFFw7eZfPQoM2okahDIONyOwnPzGEERS4UuVVo57Y+qiWuQl3nJL3COOh0R2lUGbZ6f4WJ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dWDaOGs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772C8C4CED0;
	Mon, 30 Dec 2024 14:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735568231;
	bh=zNBFk8TTTDsqJLI9KoKTTzxyLrG+qS44xVVB5xWNMNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dWDaOGs12JJsZPcJhvau/68uNzgF72CHTpT9DsJDjyLetw6iJ16BWxUuJ9wg+rli+
	 Cfd6R96utNfWBmBsUOnz2hJQyzyzBQ93GrTgur7SbLwsMIK7f9aUk1AwHaH9mVbJny
	 9Yp8arKZNVIV4Yxz9wbHD3Kv1is1wpWmpeQQrfAk=
Date: Mon, 30 Dec 2024 15:17:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Fedor Pchelkin <boddah8794@gmail.com>
Cc: stable@vger.kernel.org, Chris Lu <chris.lu@mediatek.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	linux-mediatek@lists.infradead.org
Subject: Re: Request to backport fixes for crash in hci_unregister_dev() to
 6.12.y
Message-ID: <2024123059-luckily-baking-e397@gregkh>
References: <ky2pwjrcwd42h24rkvlanyj3ty53orpyirm34hpo74lehhpg3n@3mnfibfr6yxm>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ky2pwjrcwd42h24rkvlanyj3ty53orpyirm34hpo74lehhpg3n@3mnfibfr6yxm>

On Mon, Dec 30, 2024 at 01:51:58PM +0300, Fedor Pchelkin wrote:
> On 6.12 there is a kernel crash during the release of btusb Mediatek
> device.
> 
> list_del corruption, ffff8aae1f024000->next is LIST_POISON1 (dead000000000100)
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:56!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 3 UID: 0 PID: 3770 Comm: qemu-system-x86 Tainted: G        W          6.12.5-200.fc41.x86_64 #1
> Tainted: [W]=WARN
> Hardware name: ASUS System Product Name/PRIME X670E-PRO WIFI, BIOS 3035 09/05/2024
> RIP: 0010:__list_del_entry_valid_or_report.cold+0x5c/0x6f
> Call Trace:
> <TASK>
> hci_unregister_dev+0x46/0x1f0 [bluetooth]
> btusb_disconnect+0x67/0x170 [btusb]
> usb_unbind_interface+0x95/0x2d0
> device_release_driver_internal+0x19c/0x200
> proc_ioctl+0x1be/0x230
> usbdev_ioctl+0x6bd/0x1430
> __x64_sys_ioctl+0x91/0xd0
> do_syscall_64+0x82/0x160
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Note: Taint is due to the amdgpu warnings, totally unrelated to the
> issue.
> 
> The bug has been fixed "silently" in upstream with the following series
> of 4 commits [1]:
> 
> ad0c6f603bb0 ("Bluetooth: btusb: mediatek: move Bluetooth power off command position")
> cea1805f165c ("Bluetooth: btusb: mediatek: add callback function in btusb_disconnect")
> 489304e67087 ("Bluetooth: btusb: mediatek: add intf release flow when usb disconnect")
> defc33b5541e ("Bluetooth: btusb: mediatek: change the conditions for ISO interface")
> 
> These commits can be cleanly cherry-picked to 6.12.y and I may confirm
> they fix the problem.
> 
> FWIW, the offending commit is ceac1cb0259d ("Bluetooth: btusb: mediatek:
> add ISO data transmission functions") and it is present in 6.11.y and
> 6.12.y.
> 
> 6.11.y is EOL, so please apply the patches to 6.12.y.

All now queued up, thanks.

greg k-h

