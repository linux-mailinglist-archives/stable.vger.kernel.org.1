Return-Path: <stable+bounces-75798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D27B974BB0
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 09:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D397B25D96
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 07:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6792C137772;
	Wed, 11 Sep 2024 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yDWLPNG7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC03577102;
	Wed, 11 Sep 2024 07:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040601; cv=none; b=XYBji6fLNqL2xPOFXjPqOlKGqzMVoPXPgMyKW2AAzZsObrEiPFUumXpcAQJuASvVt2BuZE7eoC0TTZJGBOHiZXzCgJjDBFyM+rFSYkcIrR0XkNrqPKSBKnNQaFjgPR0ZVU8G540zTunE98PUaUo5apG47yF06U1aep2JBKmq7gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040601; c=relaxed/simple;
	bh=MS9VaQ2tFaTw50X0RtN34DqEi4zcvQJQk9GezXitBx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBwd5wOc0fSMTWvnuh22rvJA4k81pib7Uipajs1VXc9BC81s8nS6Nmttp/4ZZnfT2n+XyHLPjUqXqlRm2GyG5zhy37KZig+friY+eQZp3uOj4UYR/7Te8vDYmWTZTVoHLV/jZfs6Z+P3yFB4JRLL6w/Yd+5GpYbSxdD5abhUZ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yDWLPNG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CF7C4CEC5;
	Wed, 11 Sep 2024 07:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726040600;
	bh=MS9VaQ2tFaTw50X0RtN34DqEi4zcvQJQk9GezXitBx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yDWLPNG7ZT4YR2MLkojGNOCQgNpg6TtEJWqYeVle82mj4Pkc29NOQI8RguUz6NGlB
	 HnTVBe68N4z0IAvgdSAhCk+ur137lan6p7DHkmIi93WfWgbK+NeysP6SzTl8xBrOmg
	 WONRORWFymDgGYVMiWuI9lU6rkuYf8p4tcorc1yQ=
Date: Wed, 11 Sep 2024 09:43:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian Theune <christian@theune.cc>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>, regressions@lists.linux.dev,
	stable@vger.kernel.org, netdev@vger.kernel.org,
	mathieu.tortuyaux@gmail.com
Subject: Re: Follow-up to "net: drop bad gso csum_start and offset in
 virtio_net_hdr" - backport for 5.15 needed
Message-ID: <2024091110-winter-cornflake-efa0@gregkh>
References: <89503333-86C5-4E1E-8CD8-3B882864334A@theune.cc>
 <2024090309-affair-smitten-1e62@gregkh>
 <CA+FuTSdqnNq1sPMOUZAtH+zZy+Fx-z3pL-DUBcVbhc0DZmRWGQ@mail.gmail.com>
 <2024090952-grope-carol-537b@gregkh>
 <66df3fb5a228e_3d03029498@willemb.c.googlers.com.notmuch>
 <0B75F6BF-0E0E-4BCC-8557-95A5D8D80038@theune.cc>
 <66df5b684b1ea_7296f29460@willemb.c.googlers.com.notmuch>
 <8348AEDD-236F-49E3-B2E3-FFD81F757DD9@theune.cc>
 <AD8BDB95-0B4A-435F-9813-5727305CA515@theune.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AD8BDB95-0B4A-435F-9813-5727305CA515@theune.cc>

On Wed, Sep 11, 2024 at 09:39:01AM +0200, Christian Theune wrote:
> Hi,
> 
> I just took 5.15.166 + the 4 patches by Willem as they’re currently in the queue. The applied cleanly (which you already tested) and I can demonstrate the known error (bad gso: type: 4, size: 1428) on 5.15.166 without the patches and it’s gone on 5.15.166 with the patches.

Thanks for testing!

