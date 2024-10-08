Return-Path: <stable+bounces-83082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C703995580
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 19:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E31BB23D50
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 17:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85041F9AB7;
	Tue,  8 Oct 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="mQ00Gu2B"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42CE1F9AAC;
	Tue,  8 Oct 2024 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408032; cv=none; b=ZRdiWshMku3DwbWj9OJHKzMAZTi4ygTm6+kknfhwLcu0RXg++fcazhOtOzjKGW7JtQIJczk+qpHGP8L6Aga++GdbVQzKg5jGV9vCKveSWYyHLtbSMhNzGdQiTsOXi/CKkPyDu/V0fl0sRVfh/feixo3bJeF5RDHxhw3X8z7RgBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408032; c=relaxed/simple;
	bh=zkakeVk022Yr4cBUEuckFYvxBnhAU80fw2PSmj2+w08=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ud6NfTfr0ExQSO2HvyEm5Vrc/MWMBqALog90o/EBSchNwSNtWmdnl0vPeL6y+AoZJpoqQxOrvFDcWmdSsxngcI7inYEgKBMw98flJM2u1kAoc7lRV+C7/4grIUiTOXQnL98jXmhUeUfwyrrWq0g4mUdqBAmLgI9F2yVJd95tpiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=mQ00Gu2B; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Tue, 8 Oct 2024 19:13:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1728407624;
	bh=zkakeVk022Yr4cBUEuckFYvxBnhAU80fw2PSmj2+w08=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 references:reply-to:Sender:Subject:Subject:To:To;
	b=mQ00Gu2BTl8n1CYg4RsBatX7TZNWqZ4KGym+6rpFu+dvvKNmISjAJcOE+2UVWCGVA
	 h8mLJJiceo4q5xg/DXu8n8oKaxDkwNaAjYeW3Nm18hGhzEgW4FWe/J/qHKzCP9GRaI
	 nHFW3IviU3xnpboYNKl1hIMy30gjP+DIikkfGERhmR6H3PKU124l6mcxOqOQeVowdV
	 nDePwhoCvbKRFHOjDhdgzjNVXNRxHoZUi0s6Jo9oqBUfXQhElheaPFdF645b0aTASX
	 xOtQG0+/CxQbegwyimrZTw/aVAUilYrWNEUwV0osJCY2IYfpzX87CvxEwRimVpzel9
	 FeSBzpcnyKU/g==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.11 000/558] 6.11.3-rc1 review
Message-ID: <20241008171343.GA736@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241008115702.214071228@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.11.3 release.
> There are 558 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.

Hi Greg

6.11.3-rc1 compiles, boots and runs here on x86_64
(AMD Ryzen 5 PRO 4650G, Slackware64-15.0)

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

