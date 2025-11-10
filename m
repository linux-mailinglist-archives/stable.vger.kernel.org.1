Return-Path: <stable+bounces-192946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 345B5C468AA
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 13:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD89B348966
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 12:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D255612DDA1;
	Mon, 10 Nov 2025 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfqGEC74"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8234117BA6
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776915; cv=none; b=N8CvWO9piWRQakjlBgYQUG3I5bwG4tld5SXRgGpsSOz1E3OQRdh0HY9d0/u3Du6t2myiWIxKg3KN5DXb9fPjSUzPBwUytU7+dIvdkCX6656zZjA3c2bSi69Elk0eR2XREXW2xGOwXFeTrz1c8CDMJoo30EKDjnP/J4/RxQlbVBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776915; c=relaxed/simple;
	bh=I94V3gKxKnHaHSC6awXrPIeo24oTsv8M1ICZoXpmVLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bq6zS0xxOPOM77zLDq0TiNFpUA0uPW+QTCD+sSkFrMLGExVdhHH7/Ts00u0h5mi4M7hj11u7MDttxIL2NvYzfQlP5JngWrbBTA64h3cOBmN2eUl2Odunnly9E21UwABFrCDIhacmxGV5G2UeY1J2athfHbdT7c3WnJilSWArm84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfqGEC74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB502C4CEFB;
	Mon, 10 Nov 2025 12:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762776914;
	bh=I94V3gKxKnHaHSC6awXrPIeo24oTsv8M1ICZoXpmVLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AfqGEC74HHiUHnyowsOkg3MXKlGeDCgYxyivMksLWR4SMuozvB6xnDSwdlggJhOcU
	 Z6qMoKzgMm3NwUAz6z6SfUymiLHuiWAqKU/n8A/LrAQW7e4rtwa52dn1u6vcK1IK8w
	 q8hOO0uxmc7S5+WSp28m978rBUNr+vYEDrzpadSjRNrjs7pjBDjspNms/vTU2GcLL6
	 YZzioMJu6JB12+gyhsrNsWmXLFeMHLTwZ6zjMvi7VI7H8OTs44iMlEM2+0pke4KNT+
	 qIuJW5o5O8G7JTHXV1EW8YsDkLWBGjMGYxbq0KU8rqPC10cEZPYFT8lL0GGc4ZdhcB
	 7CaNOUoPGKnVQ==
Date: Mon, 10 Nov 2025 07:15:12 -0500
From: Sasha Levin <sashal@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	"Justin M. Forbes" <jforbes@fedoraproject.org>
Subject: Re: [PATCH 6.12.y] rust: kbuild: workaround `rustdoc` doctests
 modifier bug
Message-ID: <aRHXUKkqKMwn7xvX@laps>
References: <2025110805-fame-viability-c333@gregkh>
 <20251108140352.127731-1-sashal@kernel.org>
 <CANiq72m3Rv+L8P1J+JZu4LnR6YUKqssQu0G0yMQa51xCQWK+-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72m3Rv+L8P1J+JZu4LnR6YUKqssQu0G0yMQa51xCQWK+-w@mail.gmail.com>

On Sun, Nov 09, 2025 at 06:21:19PM +0100, Miguel Ojeda wrote:
>On Sat, Nov 8, 2025 at 3:03 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> [ added --remap-path-prefix comments missing in stable branch ]
>
>Do you mean you added the patch that added that workaround? Which branch?
>
>The resolution below does not show the comments, so I am confused. The
>resolution itself seems OK, but that line on the log plus not seeing
>the comments in the diff that are supposedly added somewhere else
>seems odd.

Sorry, it should have been s/added/removed - there's a comment upstream about
--remap-path-prefix that doesn't exist in the 6.12 tree.

-- 
Thanks,
Sasha

