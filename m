Return-Path: <stable+bounces-139167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1722EAA4C86
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 15:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A653BFE26
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 13:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6245025B66D;
	Wed, 30 Apr 2025 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="gwZUrSn3";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="OrYFiAs/"
X-Original-To: stable@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F002C2AE8B
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746018023; cv=none; b=MdtMRHwXrufrvdDU/rtROiwRN5BTsHkj6l/1jgoWqmN0y4djem6rcrCBtb8u7jII5wpbcUHm+hby61SxNAn6bDuBxzkpYT+t3beDKDEzLOA2yicM2+uiL3HPtprkZkHcgxuteL2Eel9tASXDaa13kpfV4DHs1EMwwlGgEICynnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746018023; c=relaxed/simple;
	bh=UfNIy3x2jjoQoRPx+gx9seJMZKBmJ3imkS+H6drHy1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYsaZxlqpEW5udmOVqG+ra8tjPIiReUbrc3IfJvzNzbGVvk+6DZsXREUel/YB/C9WAEF8fxxSZzkOqgR1qk1lOG80dU4CNmVE2IIdPMSc5Bt4OjZRZPMAk8ohCcLFCOM6f/Dx+lddbRuoDslHagfTPpXI4XOokVVgh7yR04fuq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=gwZUrSn3 reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=OrYFiAs/; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1746018920; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=O+2SKE6Xcv8x1uf3Am8vN4RBUrgGMfKxPGi0oSJmOAI=; b=gwZUrSn3upujNha/6L8vCF8xk/
	/2KAIgFKfECUWeo/8GvGC9m3wDtFAYzILqd4xNrcqacSciRsGaU7NOzCe4QC4kP7uxcuPLyLGzlbn
	YqIOWf92KqeEUIXnE5IVvSgI3Bi3q8xBndtTgSy0K68r077xmlWpuCNPrwFeGlurT2FgzGUvYZ6/r
	nTf7sZuH3S1zgQTCw5y61Ymy0kGbMMlGN0YuAO7rW/B/IuzpDsejJehpQ9M4Zre2mB5J0NRvNVC+d
	H4P62l10hGYGzkndCSpQoK6Oz5/m3iavCWMVxJb5Fm3maWNtz+sfynKk5K5h09J1lK/JpMdZADNc+
	1mlS7nkA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1746018020; h=from : subject
 : to : message-id : date;
 bh=O+2SKE6Xcv8x1uf3Am8vN4RBUrgGMfKxPGi0oSJmOAI=;
 b=OrYFiAs/IW0/wUMAWm5q/eHmE417YqE+LFyJ5WD5UCyogkHAK760jyp75dkYNjXqkb9Dx
 CfPtI00vF8V8BmthEsdWpqrV9FhqdhV03sHyobkWnhcur0U0CzeBO/QgTcC2DR8SiDDIPka
 pIMQM4du0wOO3oOoerQpH7q9csUNlbCXw4kfg0/U/0S9JJtLjlirUDxa07Clptq1PUypSs9
 pOqkfompcuYSWcFbHxGG4nKyzqBZldnotX82ptRLAQyhww3SfUZSsvnW459ethpAOwNWMhH
 qsevxFF8k+NABCN4R4nHHvyXdTprF0DhAdrxB/44R1vel2jWACkeQCXhbFYw==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uA72t-TRk73a-Ae; Wed, 30 Apr 2025 13:00:15 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uA72t-FnQW0hQ0MaB-kGqs; Wed, 30 Apr 2025 13:00:15 +0000
Date: Wed, 30 Apr 2025 14:53:00 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 Johannes Berg <johannes.berg@intel.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 128/373] wifi: mac80211: Update skbs control block
 key in ieee80211_tx_dequeue()
Message-ID: <aBIdLC9e4BR1U6mm@pilgrim>
References: <20250429161123.119104857@linuxfoundation.org>
 <20250429161128.436695769@linuxfoundation.org>
 <aBHkJ0v5UnXPlRWl@pilgrim>
 <2025043032-herself-rendition-b721@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025043032-herself-rendition-b721@gregkh>
X-Smtpcorp-Track: 4ogEn-UpTI1R.Q9T8DVWs2VZN.n5IFLgyInEY
Feedback-ID: 510616m:510616apGKSTK:510616susjtUlcmQ
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Wed, Apr 30, 2025 at 11:16:47AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 30, 2025 at 10:49:43AM +0200, Remi Pommarel wrote:
> > Hello,
> > 
> > On Tue, Apr 29, 2025 at 06:40:05PM +0200, Greg Kroah-Hartman wrote:
> > > 5.15-stable review patch.  If anyone has any objections, please let me know.
> > 
> > This patch should not be included in any stable version.
> 
> Why not?  It is documented to fix a bug, is that not correct?

This has been reverted later on as it introduced a regression in
mediatek driver.

But I missed that you also queued the revert for stable. So false alarm
here, you can keep the commit and its revert for stable or drop the two;
both scenario are fine with me.

Thanks.

-- 
Remi

