Return-Path: <stable+bounces-62814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF452941396
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 15:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75EF283FD2
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 13:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7762C1A08D3;
	Tue, 30 Jul 2024 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="asVWk0Uf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3101D1A073B;
	Tue, 30 Jul 2024 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347369; cv=none; b=ISDfQ3HyuhGk0ItjO8cn5H05CxCl1MBWNgT9UqnwCqJFOQsPlQXZ+hV9NN4lduO+uiISBoImSJcygEZeAmBkXS35N5RG0Gxk8TfQGv6cS0ltBG5pZn2W5dKgK9hOTe1o8C9v6psfx3m0dR85Z5ZQXNYVDecGxSvQy6zvxwOqUvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347369; c=relaxed/simple;
	bh=amjIIwFgAe0g/a2ZTSnZPN6SIxz3Wru/Js4SizhjMhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u82v9WfGBGVPcZ+rC6ubMx2qZlQ96M6BWj3xmOgAfzbwO2ecrSQ2qmk5RyZH2mVK2S23sn5z4XCzeyrhpeD67LEkPdR7FQSE2eQRyi3WrgI21NdSgb4vx9BlqiDOabrFxJK3nJQoIs8rE8G1jxwaA+ykCDr5IZwMPyzvF0Qy7fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=asVWk0Uf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B312C32782;
	Tue, 30 Jul 2024 13:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722347368;
	bh=amjIIwFgAe0g/a2ZTSnZPN6SIxz3Wru/Js4SizhjMhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asVWk0Uf1yLp+85h7sLOcZzcwleOc1g/KilC9tku4FpKUwsbulMmdK8I84U0DYvg5
	 UjV1N90Bb0R0VRQPtSaB/8pjPPaU/e0wgyetir2ndoWdYc0hJHblHV6rM5yCZONJCf
	 tSEi8Pz9KCql/mz60ZMTtXnYw8grIlW2PanpNbOg=
Date: Tue, 30 Jul 2024 15:49:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Erpeng Xu <xuerpeng@uniontech.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, hildawu@realtek.com,
	wangyuli@uniontech.com, jagan@edgeble.ai, marcel@holtmann.org,
	luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, guanwentao@uniontech.com,
	luiz.von.dentz@intel.com
Subject: Re: [PATCH 6.1 3/3] Bluetooth: btusb: Add Realtek RTL8852BE support
 ID 0x13d3:0x3591
Message-ID: <2024073020-sushi-stained-89d8@gregkh>
References: <20240729034247.16448-1-xuerpeng@uniontech.com>
 <283C6F6C7E72DF06+20240729034247.16448-3-xuerpeng@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <283C6F6C7E72DF06+20240729034247.16448-3-xuerpeng@uniontech.com>

On Mon, Jul 29, 2024 at 11:42:32AM +0800, Erpeng Xu wrote:
> From: WangYuli <wangyuli@uniontech.com>
> 
> commit 601b68544c21333cfcf1db15075cc17e0329b843 upstrem
> 

Not a valid git id.

