Return-Path: <stable+bounces-172450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E61AB31CD4
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BAE583945
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E8730EF9B;
	Fri, 22 Aug 2025 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="EtrI+I5f"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FA92FFDEB;
	Fri, 22 Aug 2025 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874186; cv=none; b=SlkvHW7Uww+sj8ZIegNW+7qAwoLLeQLgRTZlU60T1GbyWqL4PuF+S02ywXLZlouOTnVdkKFwafCMDNCDhKA+zBMNjNDDdnEtpbswA5Wugt5M2sHCCnL3KFUA60d57yfBUxjGtvnuuhMIJAk54D4pSS6iIeCJ1xH1ASagMZCBJyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874186; c=relaxed/simple;
	bh=GIDIl+j0MQNyBJElXtNqrbuR0HomtwPGNlTw2Z4Kp3I=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwsg9IRe9VTZwTakMPQObHSqrJDsRquccnpwoxn/NHZIpbMd0iVz8gsOwMcjZIoreUO6bkuD4UdT4oRBilq2PpGoocYtjkt2dlUgl+1MPp36I7hnwqCnAX2xQxMV9cEOvrE5+uNL/fhJqboJ+Sb1sA71ZzUqY/yRUBT1YEidKOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=EtrI+I5f; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Fri, 22 Aug 2025 16:49:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1755874175;
	bh=GIDIl+j0MQNyBJElXtNqrbuR0HomtwPGNlTw2Z4Kp3I=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=EtrI+I5fEJR1agQyd9XRn/HwGvo02Pq/OtNFMIiWl3UQMaC9lTZSnxlB5OZULnacy
	 KVwiEEnHNIfZUOg21GgeJmw8p61S7LrwOEi4tO/ktDvw5hg2k+WfEBDniKlYE4/86e
	 65kicedZKmvgWdg5lDtY2BNnNZZZKeh5dHl3ZzNIQv2EiIpXsBobLf+aui7vSxb9nZ
	 d0sDlosgg4/2k/EWTkzqMDg2p8VEaYF4IJBr3xYzP5F44PmnbR17801Azfe5lU1Ieu
	 Fv7xhowUz8M+XrYNv1XjIDRUPqfALLuntQY9VZXgrdOpjcl3f4jx1OMmK1O3sYG+RL
	 EwUFJTjjYIReg==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.16 0/9] 6.16.3-rc1 review
Message-ID: <20250822144937.GF2771@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250822123516.780248736@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822123516.780248736@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.16.3 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Hi Greg

6.16.3-rc1 compiles on x86_64 (Xeon E5-1620 v2, Slackware64-15.0),
and boots & runs on x86_64 (AMD Ryzen 5 7520U, Slackware64-current).

No regressions observed, apart from the one already mentioned for
6.16.2-rc1.
Thus I tested 6.16.3-rc1 with V3 of the patch and it seems to work ok:
https://lore.kernel.org/stable/20250821105806.1453833-1-wangzijie1@honor.com/

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>



