Return-Path: <stable+bounces-6440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AAC80EAB6
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 12:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AADE1C20C8E
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 11:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE895DF01;
	Tue, 12 Dec 2023 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lXTgqe/C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7905D4BD
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 11:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C651FC433C8;
	Tue, 12 Dec 2023 11:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702381443;
	bh=eqmQ3zCBD/6tpWUKuDbGF0pIhxZDCoYVmpZUroAh/4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lXTgqe/CGqYOqcSZKpN+ibMRTZeXxL3jEOEyGO/OLGNlm+qlJ54pG50vBysl/x5Bt
	 emuzBnQiOZEiZHkkO7NKWQNDTQWnxAqFjWP9zcB/noK83P4y2xszhRgD97vShSmR5n
	 EbEuX28etV3jsBitC08A+VVPr+CGz6O4NA56ZCrs=
Date: Tue, 12 Dec 2023 12:44:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Daniel Starke <daniel.starke@siemens.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Russ Gorby <russ.gorby@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH 5.10 0/3] tty: n_gsm: fix tty registration before control
 channel open
Message-ID: <2023121232-magenta-recall-2cec@gregkh>
References: <20231212111431.4064760-1-Ilia.Gavrilov@infotecs.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212111431.4064760-1-Ilia.Gavrilov@infotecs.ru>

On Tue, Dec 12, 2023 at 11:17:21AM +0000, Gavrilov Ilia wrote:
> Syzkaller reports memory leak issue at gsmld_attach_gsm() in
> 5.10 stable releases. The reproducer injects the memory allocation
> errors to tty_register_device(); as a result, tty_kref_get() isn't called
> after this error, which leads to tty_struct leak.
> The issue has been fixed by the following patches that can be cleanly
> applied to the 5.10 branch.
> 
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with Syzkaller

Do you actually have any hardware for this protocol running on the
5.10.y kernel?  How was this tested?  Why was just this specific set of
patches picked to be backported?

thanks,

greg k-h

