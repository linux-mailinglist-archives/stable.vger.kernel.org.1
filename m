Return-Path: <stable+bounces-3981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A00C8042F6
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 00:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96DA2813C3
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 23:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFEB3A28B;
	Mon,  4 Dec 2023 23:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EqwgX+hN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5540393
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 23:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B813C433C8;
	Mon,  4 Dec 2023 23:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701734250;
	bh=JuuEUKt7FDn7ky2yHHNp/ndh/o25TgakSquo7yCGZUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EqwgX+hNtNNynmS30vnPwXZjHcY5855UY0sbZMt+TC1LkLNcRUaFC7eIq7ZqUBUaK
	 Ay37juFtraL7LctMMs1dn8fl0X0Z9tok0Qmcu4Y4k9eW8V38oftDdBZYwR+XkkZX9D
	 /d1JC7sPWDIjh8NMiiBXXwNKUtX7dKTi3o3MDaME=
Date: Tue, 5 Dec 2023 08:57:27 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: den@valinux.co.jp, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/apic/msi: Fix misconfigured
 non-maskable MSI quirk" failed to apply to 6.1-stable tree
Message-ID: <2023120518-pessimism-imitation-afb6@gregkh>
References: <2023112040-sudden-savanna-4847@gregkh>
 <878r6axrpj.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r6axrpj.ffs@tglx>

On Mon, Dec 04, 2023 at 10:06:00AM +0100, Thomas Gleixner wrote:
> On Mon, Nov 20 2023 at 16:28, gregkh@linuxfoundation.org wrote:
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> See below.

Thanks, now queued up.

greg k-h

