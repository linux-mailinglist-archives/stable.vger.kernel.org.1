Return-Path: <stable+bounces-143274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD177AB39CA
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 15:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE6D179AB6
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 13:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74001DF27D;
	Mon, 12 May 2025 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UzeKIk6W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944111DEFDB;
	Mon, 12 May 2025 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058199; cv=none; b=iCH/PBiQ4Pp1QtqNqSw2hP7FbsvtLQ7YhJbTPZk4X9sckbvcp4WaxpCD2FU3O8n9IUUt24bpMvKMuY9SHXguNBQsULZbDu4bpmbN/H4YpUYn9a3AcAzq+VP5TIeBgXf2BYkhtSKu/pSC/iVPqfp31ZuqIstIpI3cNBCbIOpMQ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058199; c=relaxed/simple;
	bh=kezKBS9Dk1cbmIxbDkii/VwWC0mvb03jDrGa2r1fyPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtkRR4291MA+ye7BYWNeaXzXqL1WzM7M4vQV2/i4HWpdndKXaB7z7XcXXhXrrQuRFrnhNv2JssIZKLLZ9tpeN/W6o1CBZdMBjf1ujppOdCUolj1EphyQfOyNLsmvmI7GvulxWOjFfZM3WVeabCMOZpC13zKASn2rnHBS4Y1P1ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UzeKIk6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E04C4CEE7;
	Mon, 12 May 2025 13:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747058199;
	bh=kezKBS9Dk1cbmIxbDkii/VwWC0mvb03jDrGa2r1fyPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UzeKIk6WEkVezKjNwQ/qDow3QjjmbclEYQhK6rg3AkGO1pf+FDa1wtqa0Oy9n+BQy
	 nxlBJ5u7GmCjHkHOaJDJwuAgKGmLAYYNf6qq+Dt8uYdAAg10YS/YA9N3u1id/22f0U
	 Ktigq+wSc5G+MUXhC0vbQJs7grImjWr83jzg+TBs=
Date: Mon, 12 May 2025 15:56:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Geoffrey D. Bennett" <g@b4.vu>
Cc: stable@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Hao Qin <hao.qin@mediatek.com>, linux-bluetooth@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>, linux-sound@vger.kernel.org,
	Benedikt Ziemons <ben@rs485.network>, pmenzel@molgen.mpg.de,
	tiwai@suse.de, geraldogabriel@gmail.com,
	regressions@lists.linux.dev
Subject: Re: [STABLE 6.12/6.14] Bluetooth MediaTek controller reset fixes
Message-ID: <2025051222-obnoxious-blurred-cbcc@gregkh>
References: <Z+W6dmZFfC7SBhza@m.b4.vu>
 <Z+XN2a3141NpZKcb@m.b4.vu>
 <aBxdpIabalg073AU@m.b4.vu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBxdpIabalg073AU@m.b4.vu>

On Thu, May 08, 2025 at 05:00:44PM +0930, Geoffrey D. Bennett wrote:
> Hi stable@vger.kernel.org,
> 
> Could you please apply:
> 
> 1. Commit a7208610761ae ("Bluetooth: btmtk: Remove resetting mt7921
> before downloading the fw") to v6.12.x (it's already in
> v6.14).
> 
> 2. Commit 33634e2ab7c6 ("Bluetooth: btmtk: Remove the resetting step
> before downloading the fw") to v6.12.x and v6.14.x.
> 
> These fixes address an issue with some audio interfaces failing to
> initialise during boot on kernels 6.11+. As noted in my original
> analysis below, the MediaTek Bluetooth controller reset increases the
> device setup time from ~200ms to ~20s and can interfere with other USB
> devices on the bus.

Now queued up, thanks.

greg k-h

