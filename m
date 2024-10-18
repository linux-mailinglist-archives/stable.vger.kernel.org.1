Return-Path: <stable+bounces-86811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E339A3B8B
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 12:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6AF1C24057
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 10:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409AA2010FB;
	Fri, 18 Oct 2024 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MI6ZdORb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E667520103B;
	Fri, 18 Oct 2024 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247374; cv=none; b=QuTE+LVTfF2rEDSM/tUAUUqNKe3m9MWh7+Yhz0H1tePCOvwnPWhVizpiQR/CJf2/U6jrA6Q9jAWeCwnj7D5ALiYdoZ6HtAhs/vKcU42ArzaSjBHAe5Um7+JajUAp8pHbaAw7fK4W+RKNUnzbrLC+ZnibSia2eZkX1I7VueyXvOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247374; c=relaxed/simple;
	bh=KxC407iqGQu5Kl3AgihBTSCL5x5o2hiNEM47kDNTr1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rT0i2mBC4ilorERMzzGPUB8H502SynTIHZ0rOA3qYM1QWQ3Wh1ccqfGE5Wgiw7FanbgOlKXXenO5PHwuF9nWisydiN6wSgsuSfV6nlvMogmrG1kSqWYkvOiJSMk2NBQ6IhGyGV+ZPsu5/Gz3+bStT6JNW1Itdq4X0ygFmq1KMAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MI6ZdORb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51A1C4CEC6;
	Fri, 18 Oct 2024 10:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729247373;
	bh=KxC407iqGQu5Kl3AgihBTSCL5x5o2hiNEM47kDNTr1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MI6ZdORb9N9BOF0U/VKTXzSMLqJ+anzjZ+So4A2L3JqC4xjuA9WMDMkZuEQLnK0ZR
	 1k6SzddLo/gy9ZuykSi9lhplTfj15j8fSAHixzb7+XptzxySxVzcwZYKjhpBi74pW+
	 UsQlmLd97Y8GWRAUxvM8jRvm6ATh5uPPawwu5p/s=
Date: Fri, 18 Oct 2024 12:29:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	syzbot+d1bff73460e33101f0e7@syzkaller.appspotmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.11.y] tcp: fix mptcp DSS corruption due to large pmtu
 xmit
Message-ID: <2024101823-tartar-chaplain-f675@gregkh>
References: <2024101432-shucking-snagged-7c42@gregkh>
 <20241017143218.1428691-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017143218.1428691-2-matttbe@kernel.org>

On Thu, Oct 17, 2024 at 04:32:19PM +0200, Matthieu Baerts (NGI0) wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> commit 4dabcdf581217e60690467a37c956a5b8dbc6bd9 upstream.

Now queued up, thanks.

greg k-h

