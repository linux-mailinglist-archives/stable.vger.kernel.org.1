Return-Path: <stable+bounces-70353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B43AF960B41
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B4328418C
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 13:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2910F1A0AFF;
	Tue, 27 Aug 2024 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vmJlN1+d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF6A19D076
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763922; cv=none; b=sUwCyLHSGl2JMB5lrgMNqlfHlEd1j12VRxnXRSw+EQ2WN9AahlVgWoLvTYS3b5DcVFBEXtZUQFInNe2Iw+RvAt8lAzw2qooDY6BWg+Irv/jvP19GGftvyV9miD4w9FZeNLlemnZ/QkSz8PvFxmPr+/IZMi0P2sPafccVbI80R6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763922; c=relaxed/simple;
	bh=P0Swy7BwQQwcjZZ5W3fOoTFk2s9bkiBboyxIdZ7rEtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxL7mBUYAgwiCu8wqQXt7cqNFhMyg6B7TZIY6SGnYL84GTsTSSb1C/b5O4puLdvvCBSsh6ir6YDGYNZ9lAJS7NtfB0FUiS/6N/QKYzHHuEzkSwXUT1VTtS04hZObVp5NZBf+wuOsQBQSFfGb/nxJ5DxU6BmlNHkyeSS+WtmwhkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vmJlN1+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE66C4FE13;
	Tue, 27 Aug 2024 13:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724763922;
	bh=P0Swy7BwQQwcjZZ5W3fOoTFk2s9bkiBboyxIdZ7rEtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vmJlN1+d39IIoxdKZ/mYgNZLaSvzaK2p96lyvydgntb9KCKCRKCTGQstuXsPt+IMy
	 ltMg2cirOl+IM9/CJFanrTPFghr9dcFhbf6Tdgm/VVrpRrnyecZlZdCTknDAB5IdpL
	 YoO2DeDet8Du5TEZXYz1PBlGGhXVUNAUoLV+JRVg=
Date: Tue, 27 Aug 2024 15:05:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	liam.merwick@oracle.com, vegard.nossum@oracle.com,
	dan.carpenter@linaro.org, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
	Yu Hao <yhao016@ucr.edu>, Weiteng Chen <wchen130@ucr.edu>,
	"Lee, Chun-Yi" <jlee@suse.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH 6.1.y 5.15.y 5.10.y 5.4.y 4.19.y] Bluetooth: hci_ldisc:
 check HCI_UART_PROTO_READY flag in HCIUARTGETPROTO
Message-ID: <2024082703-agreeing-banjo-133a@gregkh>
References: <20240802151133.2952070-1-harshit.m.mogalapalli@oracle.com>
 <d631a304-a532-40ce-927c-ad7939bd9477@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d631a304-a532-40ce-927c-ad7939bd9477@oracle.com>

On Tue, Aug 20, 2024 at 11:27:44AM +0530, Harshit Mogalapalli wrote:
> Hi,
> 
> Ping for this backport.

Sorry for the delay, this got lost in the mess.  I'll go apply it now...

greg k-h

