Return-Path: <stable+bounces-227343-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOJgLJ8qvGn4twIAu9opvQ
	(envelope-from <stable+bounces-227343-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 17:55:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B85612CF357
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 17:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C3153019394
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 16:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A29437A484;
	Thu, 19 Mar 2026 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCbu2UKM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A093EDAD9
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938760; cv=none; b=T7b6TzBH2qn/aWyVMXS9Aw0d73Bc7+0kGQk+XbMOxAKcoz4miD2jmCARMiMZvo6TQN6MqUscJoljzb088E0Tl4/i51ARlMqqaehnXqa+c83ui3kZ/ytChzhfjYoFda0ikK5zK4LKm08llYjYN21/aZeBAPkn5oFPpTB7TYVwMOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938760; c=relaxed/simple;
	bh=PFWy5EOPKIGfWdVuBoHVr9k1xwFmTb1ZFIvrQBSACgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmqej6qbbsXV4WmLeRakwj+D7gSpH8ykrxdB3zZqFHsxkRF/+RL2O14us0GQsZoPdaxUHGGErNjYYOj5M4CjBZQYKZlkOpCg5zxMEKbFv1ggwOAQjppCreRd/b0tHdRBWGG0KZkYvCI2QnhIojYFU7fRhgy267nlYfx9GZERJgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCbu2UKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E50C2BCAF;
	Thu, 19 Mar 2026 16:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773938759;
	bh=PFWy5EOPKIGfWdVuBoHVr9k1xwFmTb1ZFIvrQBSACgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hCbu2UKMKuA6xbrbbt8Lz1G3ViF2kJcmp+nncX53kbV0ZuXwikOA3Mbcaqxt1X0u5
	 NzfCuBKmQVvIxOaakZlL9yN9cQu6r4qojH60XnoTd9FoJn7XxsL/bJEBCnNIURne+i
	 GJgljvdO+V4fWA5d3y1wAlRDdp/Tot+3MDHdWZPgNItzhdwOp4ALbrq8HQJQp2AdaJ
	 VywugJxI2s4IQi5hFKrZbiGJ9CvogbWiT1+9W6221bweChhLRuaz4NUI0hpe6TCtpj
	 ANcsul/jz6gU7WACe4gUFKqGG9DZFeHWczLsmyCgGRNPig0JQ5Lj+a1ijrUTvXZk5f
	 W+aaQGaXl4zjg==
Date: Thu, 19 Mar 2026 12:45:58 -0400
From: Sasha Levin <sashal@kernel.org>
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Cc: stable@vger.kernel.org,
	Jakub Staniszewski <jakub.staniszewski@linux.intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rinitha S <sx.rinitha@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH 6.1.y 3/3] ice: reintroduce retry mechanism for indirect
 AQ
Message-ID: <abwoRsrQ-dOKp8TF@laps>
References: <2026031701-reapprove-dollar-1839@gregkh>
 <20260318000947.379271-1-sashal@kernel.org>
 <20260318000947.379271-3-sashal@kernel.org>
 <fd3ab8b8-708f-43a6-84be-e6cf98fb2463@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fd3ab8b8-708f-43a6-84be-e6cf98fb2463@linux.intel.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227343-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mpg.de:email]
X-Rspamd-Queue-Id: B85612CF357
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 04:49:56PM +0100, Dawid Osuchowski wrote:
>On 2026-03-18 1:09 AM, Sasha Levin wrote:
>>From: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>
>>
>>[ Upstream commit 326256c0a72d4877cec1d4df85357da106233128 ]
>>
>>Add retry mechanism for indirect Admin Queue (AQ) commands. To do so we
>>need to keep the command buffer.
>>
>>This technically reverts commit 43a630e37e25
>>("ice: remove unused buffer copy code in ice_sq_send_cmd_retry()"),
>>but combines it with a fix in the logic by using a kmemdup() call,
>>making it more robust and less likely to break in the future due to
>>programmer error.
>>
>>Cc: Michal Schmidt <mschmidt@redhat.com>
>>Cc: stable@vger.kernel.org
>>Fixes: 3056df93f7a8 ("ice: Re-send some AQ commands, as result of EBUSY AQ error")
>>Signed-off-by: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>
>>Co-developed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
>>Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
>>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
>>Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>>Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Hey Sasha,
>
>Thank you for trying to reapply this patch. Unfortunately for 
>6.1.167-rc1 this will not work, we tried this with my colleague Jakub 
>Staniszewski and got the following output:
>
># git am sasha_levin_ice_6_1_y.mbox
>Applying: ice: reintroduce retry mechanism for indirect AQ

I think that your mbox is missing the first two patches in this series :)

-- 
Thanks,
Sasha

