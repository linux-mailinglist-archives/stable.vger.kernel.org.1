Return-Path: <stable+bounces-98959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 860F09E6A1C
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 10:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9CDA18846CA
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 09:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B0D1E1322;
	Fri,  6 Dec 2024 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="EEoW/GfW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4qHJNk0R"
X-Original-To: stable@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9731EF0A5
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477387; cv=none; b=A08InwM2qbv+LX7IeyYCYbU4h+PMb6PQFy07rbtOmIl7XUEBFRlsxrfwgHWpPdFXzei9yhHqgbMYZZIfDlU81UEh2b+Xvlt5JyyIQE7m39N5PYfppYtAYy34OFe5l6IjoK0zqa5uOlR2RGWTliPwKdl3wQfqTeR0SEFA6ykUFbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477387; c=relaxed/simple;
	bh=2mmStkyZzykA3jf7Po5iUPX3B2sZNrB3NbTaybv/5Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kETkDB64rjqC5buSU9b3d+Rp8IMEW4MAoMbuGjq7hY5d9YqLm3qoDnRrfriutF3NgeVPpcqmaAxzi+7pBo1mGzGsRwgqD1tYQdXyOzPPjn0t8cJaOl+6H5lwDykLHWJ0kDYX7/gNGHbqO4/nCjo44ENbEdMKUJAA/c1qt3v1s9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=EEoW/GfW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4qHJNk0R; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 968CF1382127;
	Fri,  6 Dec 2024 04:29:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 06 Dec 2024 04:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733477383; x=1733563783; bh=t2V/VbO5Bn
	oQ4W03sKzro9P9Qrywr74YjqZNJwuWV08=; b=EEoW/GfW/q6g7HoWNwe1RCAgDu
	zgM2+OH90WgtaLaPzWiBQdGewhlkuqnaC25Yj92C65ei4z3HiGRbDgT3wN/iBChj
	U1D4kky1W4iU1pCtPq679F1NU5AHXTo1QdNu5ECTdqVg8WYCX25SgjvP9A+gfGQy
	d6oH7fyb7Rvfb3VUcjwpyGUipB09IWPns3/ySLS20JSyAI2/OYgKAOv0qhJIhO1I
	xrOfB4DfrePV7jJyPGbGP2Ow0lsMPcOgn2LNWqaXL0jNB41kkCJV7AhPQfThBNlg
	kx3sxMqYUuX4JoFms9GnQWRNx+fXLdyYMbmQ+VnbE+uRsL6G5CZr3Wv2QDIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733477383; x=1733563783; bh=t2V/VbO5BnoQ4W03sKzro9P9Qrywr74YjqZ
	NJwuWV08=; b=4qHJNk0RMpaojSJV72JSOf82Rlcunw8Ba+PbhOGdU1HTIVI84uK
	PwmOR+5krjSFRABKySThFuSCfkl370tzHPqySOOj/tYmjLIuaBYX07fHdLshVGDL
	QpyMfzNbmsITSlx1KTf1u/yr+XQcLPaNY7YV6Wkfetq2vxDUEsn5gMPnb7NqCSis
	1wRYquPku9ddOerjGdMyMcRfjZNsWv5dheMCS7jK12HZdLIgM7Pe+aSi6WV2hXtr
	9I+43DFhxAt9908n+miCOGHneKq7AWsg33nlABIRbHVRtDvB3Bi0wNIZTD7mwpZw
	FdrywIcXjMFEaQxeLPb47Yyz1/d3TrOOWdg==
X-ME-Sender: <xms:B8RSZ9YX4SOhLSF7ZzpWjUta72IcR9uHGYER5ONaegGwovX9uCA9Nw>
    <xme:B8RSZ0aGf1dHUD2AXh_u0_lphNVA987RvAcAaDDBo4vcvXzkruQ7dvTTJWAgUpM9j
    2NOp4586NPp1A>
X-ME-Received: <xmr:B8RSZ_9n10cr5SqOBh3vnaSK0rpGTyngFdr5i4MvBdQCh52n_NHcUV93mNezSOWar_ws4KOBsmILDButagbBiKJWWREctpHmIhnOsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegheeuhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleev
    tddtvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhn
    sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrughrih
    grnhdrhhhunhhtvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhtrggslhgvsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:B8RSZ7rNHWRoSWW117JXQVXcGx6A0FgFCyq6SKIBDJhhgcmB0gDXlw>
    <xmx:B8RSZ4p4QZfCJinldvlyMXrxQ7JW4BWCaMd4vexwdgb7FTBCLpAfJw>
    <xmx:B8RSZxTrSoXGnxCs6ETRlcpqgV_13OMFX42d-wpbFjbCjKyaiWZSog>
    <xmx:B8RSZwqhJ5F1XWJHNJyHzvJ4XqASFVjjqlX3xpGnBXbLVchIWkWr6w>
    <xmx:B8RSZxmHhCQJP-6j1hNSskkwdztB_YBHqhXR36pDLg15G-MpZuskuKZc>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 04:29:42 -0500 (EST)
Date: Fri, 6 Dec 2024 10:29:40 +0100
From: Greg KH <greg@kroah.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 4.19] perf/x86/intel/pt: Fix buffer full but size is 0
 case
Message-ID: <2024120630-retinal-drizzle-009a@gregkh>
References: <2024120221-raft-bully-e091@gregkh>
 <20241204181126.61934-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204181126.61934-1-adrian.hunter@intel.com>

On Wed, Dec 04, 2024 at 08:11:26PM +0200, Adrian Hunter wrote:
> commit 5b590160d2cf776b304eb054afafea2bd55e3620 upstream.
> 
> If the trace data buffer becomes full, a truncated flag [T] is reported
> in PERF_RECORD_AUX.  In some cases, the size reported is 0, even though
> data must have been added to make the buffer full.
> 
> That happens when the buffer fills up from empty to full before the
> Intel PT driver has updated the buffer position.  Then the driver
> calculates the new buffer position before calculating the data size.
> If the old and new positions are the same, the data size is reported
> as 0, even though it is really the whole buffer size.
> 
> Fix by detecting when the buffer position is wrapped, and adjust the
> data size calculation accordingly.
> 
> Example
> 
>   Use a very small buffer size (8K) and observe the size of truncated [T]
>   data. Before the fix, it is possible to see records of 0 size.
> 
>   Before:
> 
>     $ perf record -m,8K -e intel_pt// uname
>     Linux
>     [ perf record: Woken up 2 times to write data ]
>     [ perf record: Captured and wrote 0.105 MB perf.data ]
>     $ perf script -D --no-itrace | grep AUX | grep -F '[T]'
>     Warning:
>     AUX data lost 2 times out of 3!
> 
>     5 19462712368111 0x19710 [0x40]: PERF_RECORD_AUX offset: 0 size: 0 flags: 0x1 [T]
>     5 19462712700046 0x19ba8 [0x40]: PERF_RECORD_AUX offset: 0x170 size: 0xe90 flags: 0x1 [T]
> 
>  After:
> 
>     $ perf record -m,8K -e intel_pt// uname
>     Linux
>     [ perf record: Woken up 3 times to write data ]
>     [ perf record: Captured and wrote 0.040 MB perf.data ]
>     $ perf script -D --no-itrace | grep AUX | grep -F '[T]'
>     Warning:
>     AUX data lost 2 times out of 3!
> 
>     1 113720802995 0x4948 [0x40]: PERF_RECORD_AUX offset: 0 size: 0x2000 flags: 0x1 [T]
>     1 113720979812 0x6b10 [0x40]: PERF_RECORD_AUX offset: 0x2000 size: 0x2000 flags: 0x1 [T]
> 
> Fixes: 52ca9ced3f70 ("perf/x86/intel/pt: Add Intel PT PMU driver")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: stable@vger.kernel.org
> Link: https://lkml.kernel.org/r/20241022155920.17511-2-adrian.hunter@intel.com
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  arch/x86/events/intel/pt.c | 11 ++++++++---
>  arch/x86/events/intel/pt.h |  2 ++
>  2 files changed, 10 insertions(+), 3 deletions(-)

Sorry, but 4.19.y is now end-of-life.

