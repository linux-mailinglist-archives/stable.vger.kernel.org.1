Return-Path: <stable+bounces-121629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E79A58883
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 22:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80534188C5F6
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 21:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E88190485;
	Sun,  9 Mar 2025 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HszNPvjX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5182D3208
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741555314; cv=none; b=bmIH2a3xOLUcuF8D9M+iff5KfoOAYtQpRS0v7QnyiLzY1e2xX9cvoKct+ndHhhLkq3IIu0AFk+HzygryHKdp0824cYQKmhqviKbKhNHG2oFP1QT1j5H7LSu4QGlqdh73smZmbp42lXIT2fMPGJz4OXVM/yHCrUqyPWSQdoSWAVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741555314; c=relaxed/simple;
	bh=J+8vf1P3h3DTdiVgaUH8ygL7lxc/26flPB3UDuBIAUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdbCi/JkuQA752KXT8lCxFaIeF0skd4cCaam6RnyOkFB6QbgbMxwwsYTM6uoD6j1Db4KaJ4CzIrVNNhib1rZQOeI6TLy3icq/aZgqxogftLCUBTgYWObs7eZkGBIQNdSuYNKupIImnOHgbI1hc6cWLtbQK7tDou3MwEHfh7wSPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HszNPvjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94173C4CEEB;
	Sun,  9 Mar 2025 21:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741555313;
	bh=J+8vf1P3h3DTdiVgaUH8ygL7lxc/26flPB3UDuBIAUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HszNPvjXwWLcY2bBEm0txede0WnepGRQHFiN1k7FoMyO3rOw/0hWhaGwpjTfrLiga
	 LqimcBFWuwAaWpnIau6amg3kpUJR79KJGJsS5XQn0T/RtXJPX/twnTjwEZzu/1QiWm
	 EH+cEM9UlwXlQcNdZYByn8IS5GzocysGD/O6yl+A=
Date: Sun, 9 Mar 2025 22:21:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?Q?Micha=C5=82?= Pecio <michal.pecio@gmail.com>
Cc: mathias.nyman@linux.intel.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] usb: xhci: Enable the TRB overfetch quirk
 on VIA VL805" failed to apply to 5.15-stable tree
Message-ID: <2025030921-blank-obscurity-1a26@gregkh>
References: <2025030900-slaw-onstage-6b47@gregkh>
 <20250309220918.26951f03@foxbook>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250309220918.26951f03@foxbook>

On Sun, Mar 09, 2025 at 10:09:18PM +0100, Michał Pecio wrote:
> On Sun, 09 Mar 2025 21:22:00 +0100, gregkh@linuxfoundation.org wrote:
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git
> > commit id to <stable@vger.kernel.org>.
> 
> Hi Greg,
> 
> For 5.15 and later, the sole conflict appears to be
> 
> 0309ed83791c xhci: pci: Fix indentation in the PCI device ID definitions
> 
> 
> Would you still like a backport, or pull this small whitespace cleanup
> to keep PCI IDs in sync with mainline?

I took the dependent patch now, but 5.10.y and 5.4.y still do not apply
cleanly.  Ify ou need/want this there, can you provide a working
backport?

thanks,

greg k-h

