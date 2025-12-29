Return-Path: <stable+bounces-203647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 984AFCE7368
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AEAE300F8AF
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A499D26CE2B;
	Mon, 29 Dec 2025 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VJmTvMB9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DD926E17F
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767022206; cv=none; b=bEplB7zNyz/olUgU3s4vOdy/Cwx3RFR5JBBAku41ZG5hg1/LOD54uvjKTDq6Awk3ZRWgI3lJaaf66zmOWRCwpvVRWqfhPNGupRdoJTOTQr6en4JZTm+MMuY4ZpAlx+v1BRDsjrdenYtb9KzlTp4WhGaQ1g9wwBrAJ+zMbYjjnE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767022206; c=relaxed/simple;
	bh=MvAeMSH9GwIBRMbu3/EjAQ51iseeW9W8Jb58T4RTRRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbGRaSv7200P1yl19cZ0EboJ1SoS1v8LvwAprdf4rZCjwPta6hO6m/77jAglBHCq+U4rnVTxaKjpQNvq5wkFuipx1PucUNUSlyU8nq/xvSpa+6n60WSKTeQKzu7VkBbMp+OI4VpdsDHOBYo7B8gIDCAZ1SyrkdG7mX673l2Ga2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VJmTvMB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EDFC4CEF7;
	Mon, 29 Dec 2025 15:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767022205;
	bh=MvAeMSH9GwIBRMbu3/EjAQ51iseeW9W8Jb58T4RTRRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJmTvMB9mM0ibJtCUm4udro4hmflVv78/nHyukxuQsJnwXY/+i8KnlqG1PPtRb+lI
	 oDv2UcUq2LuOf/rFk6OKln8eZMs6zRVmJX3W8+cgDQnkAfddOD3IQUIQIod3J5gSCM
	 tdL8N6Pl/qG4Qkqbo+I985Cl1LcIdYqjRFxDbCzI=
Date: Mon, 29 Dec 2025 16:30:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/poll: correctly handle
 io_poll_add() return value on" failed to apply to 6.1-stable tree
Message-ID: <2025122956-subscript-subscribe-7da7@gregkh>
References: <2025122905-unused-cash-520e@gregkh>
 <d8706721-d859-4040-8d24-aa9ffe876eab@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8706721-d859-4040-8d24-aa9ffe876eab@kernel.dk>

On Mon, Dec 29, 2025 at 07:16:46AM -0700, Jens Axboe wrote:
> On 12/29/25 4:34 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Here's one for 6.1-stable.

All now applied, thanks!

greg k-h

