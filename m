Return-Path: <stable+bounces-5269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD7780C484
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 10:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 958B1B20FAB
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 09:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF182134D;
	Mon, 11 Dec 2023 09:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="uSuylglE"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF45106
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 01:26:30 -0800 (PST)
Message-ID: <aee3e5a0-94b5-4c19-88e4-bb6a8d1fafe3@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1702286789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dk4m9tb0yqbMoB0vzRQNwXWy8GajbLWDXjwZENFkbbo=;
	b=uSuylglEraADPZLwoHATrHHBWH3J9DrHZoPwJAWKMyDQ9ZEdj8LVngzz3akGte0afxW2qy
	X4kSFLybiBeKWlp8e/Ef67a3PAfiwCmmM876/tIWT3PO/CJelfuThLgZNUuv0s/BmSlDOu
	oRO3YPWc0mDtepzcN0kVwFDqNKPbrTMBbs31YKQ9HrpexMr282J8i6uX+hKvXfQ5t6ocUx
	Z+X9azxkLBvS3S2tQYZVFE1OOpjIszAmqRs4zFRCcEBOLXzXyE9lOaE1QKSxh9nnvnhulD
	hWmro+JQ38KmMqm7zoVn5bFgCSPVAeu5CYt13tPI4wcbcoQcmZHIRNpSEMZQzA==
Date: Mon, 11 Dec 2023 16:26:26 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Regression] 6.1.66, 6.6.5 - wifi: cfg80211: fix CQM for
 non-range use
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johannes Berg <johannes.berg@intel.com>, stable@vger.kernel.org
References: <e374bb16-5b13-44cc-b11a-2f4eefb1ecf5@manjaro.org>
 <2023121139-scrunch-smilingly-54f4@gregkh>
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <2023121139-scrunch-smilingly-54f4@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 11.12.23 16:25, Greg Kroah-Hartman wrote:
> On Mon, Dec 11, 2023 at 04:02:11PM +0700, Philip Müller wrote:
>> Hi Johannes, hi Greg,
>>
>> Any tree that back-ported 7e7efdda6adb wifi: cfg80211: fix CQM for non-range
>> use that does not contain 076fc8775daf wifi: cfg80211: remove wdev mutex
>> (which does not apply cleanly to 6.6.y or 6.6.1) will be affected.
>>
>> You can find a downstream bug report at Arch Linux:
>>
>> https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/17
>>
>> So we should either revert 7e7efdda6adb or backport the needed to those
>> kernel series. 6.7.y is reported to work with 6.7.0-rc4.
> 
> Yeah, this looks bad, I'll go just revert this for now and push out a
> new release with the fix as lots of people are hitting it.
> 
> thanks,
> 
> greg k-h


Hi Greg,

there is actually a fix for it:

https://www.spinics.net/lists/stable/msg703040.html


-- 
Best, Philip


