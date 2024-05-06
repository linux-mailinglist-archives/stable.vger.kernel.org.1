Return-Path: <stable+bounces-43106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31188BC87E
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 09:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62BD71F21032
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 07:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE89E6CDBF;
	Mon,  6 May 2024 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoRgHXkF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699A42942A;
	Mon,  6 May 2024 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714981282; cv=none; b=qBpP1mGstX6UrOWcjOyTmQ3O+sAUVtHEGg6bhA87CVgogzdSwa2zJjxXKkBqHcH/m6u3ngkxW3t95BbRcPNfRgOA8JHNS7tg3afUiymugQ1GMMx27aVb4Kyy2AuEVQuG2qbBUyCgyn+kjh/c7+cesc3r89r3uJoAYPl0bu0aXVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714981282; c=relaxed/simple;
	bh=VmZZa8RI1oV3SMdrL2Z04dl8qUtOMvN5YvMTczM6/kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2+BlpjStM+9tVOd6UV/rQ5VzRUylIU1MZkEp+71h70+c9s820ST9cxQp1Lh3jWu9t69dHf/1d8UEPAUoVpoj067bYiCIV26mTw8chtT+0cebYhCMU3EMETSKiBTWro8Wbjgjla37QLVA/Yf9lkVKMHuDNf++vofZcFa5hU+vRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoRgHXkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1539C116B1;
	Mon,  6 May 2024 07:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714981282;
	bh=VmZZa8RI1oV3SMdrL2Z04dl8qUtOMvN5YvMTczM6/kI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FoRgHXkFO0fq3WJ2ZhalOtDfRvAbTlGyPGVa4rvzetbcyHHr42cqiBjLJpNuqRHRs
	 yxI2m/8JT5Iy0pEv3gjwMnU9iWelTf4HUKx6kKI7RYJdEanYe6OPPzI3K06VrHHaCK
	 FCFddE6x2N2FyFDQH7loqqJn5nUyxMx2Jvu2zFqr//+btpMRxLx/0XTTfDLNy0ut0g
	 QJMG3Vl6Mywgdhb4bXjEvQN4d/5NGJ4MYwH2JiYS/dtfMZtZDXr+wscTEnP53j/yC2
	 j0OQqhQgNsmMqQsmygC0sG6Mw6bIxMyg148OvmA+OVnBDzBoK+m1Zi0c1fHRLQm8kv
	 +2b9fCDl//Lxw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s3syQ-000000007gC-28XU;
	Mon, 06 May 2024 09:41:22 +0200
Date: Mon, 6 May 2024 09:41:22 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	johan+linaro@kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Patch "Bluetooth: qca: fix invalid device address check" has
 been added to the 6.8-stable tree
Message-ID: <ZjiJor4h2Cy1Pchi@hovoldconsulting.com>
References: <20240503163852.5938-1-sashal@kernel.org>
 <ZjUVBBVk_WHUUMli@hovoldconsulting.com>
 <CABBYNZLN3ULgxqv3MtS_U5DbMnmuuPFqC=zrabcEt0WChu-W0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLN3ULgxqv3MtS_U5DbMnmuuPFqC=zrabcEt0WChu-W0g@mail.gmail.com>

Hi Luiz,

On Fri, May 03, 2024 at 01:12:31PM -0400, Luiz Augusto von Dentz wrote:
> On Fri, May 3, 2024 at 12:47 PM Johan Hovold <johan@kernel.org> wrote:

> > Please drop this one temporarily from all stable queues as it needs to
> > be backported together with some follow-up fixes that are on their way
> > into mainline.
> >
> > > commit 2179ab410adb7c29e2feed5d1c15138e23b5e76e
> > > Author: Johan Hovold <johan+linaro@kernel.org>
> > > Date:   Tue Apr 16 11:15:09 2024 +0200
> > >
> > >     Bluetooth: qca: fix invalid device address check
> > >
> > >     [ Upstream commit 32868e126c78876a8a5ddfcb6ac8cb2fffcf4d27 ]

> Im preparing a pull-request which includes the following:
> 
> Johan Hovold (7):
>       Bluetooth: qca: fix wcn3991 device address check
>       Bluetooth: qca: add missing firmware sanity checks
>       Bluetooth: qca: fix NVM configuration parsing
>       Bluetooth: qca: generalise device address check
>       Bluetooth: qca: fix info leak when fetching fw build id
>       Bluetooth: qca: fix info leak when fetching board id
>       Bluetooth: qca: fix firmware check error path
> 
> Let me know if I'm missing anything.

That should be all of them, thanks.

Johan

