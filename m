Return-Path: <stable+bounces-54807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BDB91232B
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 13:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698D31F238DF
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 11:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC584172BC7;
	Fri, 21 Jun 2024 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3XnesmB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F89512D771;
	Fri, 21 Jun 2024 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718968730; cv=none; b=Evm81pmOFCUfzaPmH/jz80skvoPUZ0S7zJlCimdAH0yaGgWlOaJ/gUDJgHg2mvYI/qwKgLPBVvFsPPuhtn6ZVVTQ1d6RqJFtj8POzT9A543VfmbDgu40H6dxfS4wsEqjTOfu9U1JhCZM5OMfvZ2sunOAnkAQiWGkA1TGBDMzNvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718968730; c=relaxed/simple;
	bh=HfbIjyxVlOvSKRVZrwhoYszewBmElsV/Orv22ajzXTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXTkz+yWo0zG65hcl5fexg7B600UQh8UKe1lNuQXMiNVf+bb7q4RlrHJ5nJw5L6M3q2hlQj65pTm7VmRatAHwrCv8uf44+Jlz9KBU+wW1gRigPVmEYd04+eq481ZNPL6piM0JeKsEplu7/PTCwdV62Gz5ERdBuuEknXJiFJo9FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3XnesmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521D1C2BBFC;
	Fri, 21 Jun 2024 11:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718968730;
	bh=HfbIjyxVlOvSKRVZrwhoYszewBmElsV/Orv22ajzXTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V3XnesmB6GvSGy81HjBWiwKZRiakH/Nv4MMWhfuuuDRfGll8SrNhFJixdUTo6eAkw
	 wKP9vFPnADGFBn/FK2fbI8mqB3Z6i67e9P1oLF9uziC0g9+jxCP2XrZXqZFILVddz9
	 72n3iQxXJzq+oV5rKlyZYUW2JxgfyJ4+MyDfzGDvj0Mco5zOFFo0BCpvfXwIPUXw9Y
	 sY+PByyBurfV5pC5wZgysIiVXUs8QKSFYm19Q0l621ehinW0R+shJiX21K5l6gfMqw
	 ggF7LRo90wRoPwwbMLBstGTz+dHj9ifVQsa/0k8SiNKHNJDIWK83CJAeSAx9DrS1Ge
	 lWmLoaBEqKdTA==
Date: Fri, 21 Jun 2024 12:18:46 +0100
From: Simon Horman <horms@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: usb: ax88179_178a: improve link status logs
Message-ID: <20240621111846.GD1098275@kernel.org>
References: <20240620133439.102296-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620133439.102296-1-jtornosm@redhat.com>

On Thu, Jun 20, 2024 at 03:34:31PM +0200, Jose Ignacio Tornos Martinez wrote:
> Avoid spurious link status logs that may ultimately be wrong; for example,
> if the link is set to down with the cable plugged, then the cable is
> unplugged and after this the link is set to up, the last new log that is
> appearing is incorrectly telling that the link is up.
> 
> In order to avoid errors, show link status logs after link_reset
> processing, and in order to avoid spurious as much as possible, only show
> the link loss when some link status change is detected.
> 
> cc: stable@vger.kernel.org
> Fixes: e2ca90c276e1 ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver")
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


