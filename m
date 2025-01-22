Return-Path: <stable+bounces-110220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2786AA198D7
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 19:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01747188DB0E
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 18:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA182215196;
	Wed, 22 Jan 2025 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="y82+cU5U"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C453D2B9A4;
	Wed, 22 Jan 2025 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737572123; cv=none; b=kkGVxJjQB3PJlhFpDTYicfmOuK5Bw8qP/eoBJlwk7i8JnEHhUO1JWaaBI4hm0INA+WTlpDuJpf1ar5FQDAW+uTyM/qxyFZ7X0RbOPd3vK02L4RTqMnOMuFXfrjJ1btMKU1qOB6KmavIdMSLN/6Sb9JqlIRjvdPsTLMfSr1je0rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737572123; c=relaxed/simple;
	bh=u5Ip2cC4LEbwx9uNGffXvenauW238yz8ppKfFiGmzXk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sowcRXCR/QFg8tV7/tUtGyLN5oJ6LOlzqg84lh+HYOS6NEX4H9w6VNMJmMtYwq2+OhgrodVx6JSy+VVtWOS4cEFT/qrLnmw8w0vTDtrXJK4UWnA0ulNdBvzydLhKiqx9qY2gdRSmoia/5VdMNqaAxx6OVGudAMQ96JxcVPIUXLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=y82+cU5U; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Wed, 22 Jan 2025 19:49:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1737571773;
	bh=u5Ip2cC4LEbwx9uNGffXvenauW238yz8ppKfFiGmzXk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=y82+cU5UiZmGcO2WwnOplYerSkBhOjxfsYvngINwMMXlALJq48mxJoYvOWDCLTgHU
	 HHD9wChsPojYFexuHc9G1mw5HDrarXRthwF5vmjxTUiR7zFvStilQW17WDV+0oqmY4
	 86LVyVEUoXeg785BY7tXQAloudTq2OhJP8gWHIRMqdIUuL8kfAqhhW/70/kCsE7N/M
	 O83IRKsQsPWSg8VPiP3ZhIChZwXHTQtp/vypZAoVH2H2HkvZEkhXBZrSTw5arCtAFh
	 2Jv9TgL8gX2mY6i9aKlxDG+45ArAjlBsrCKfJWQExaStMt1IK8CcuINSQnelOpA7l/
	 mfB9u7vzE4AFQ==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12 000/121] 6.12.11-rc2 review
Message-ID: <20250122184932.GA1153@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250122093007.141759421@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122093007.141759421@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.12.11 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Jan 2025 09:29:33 +0000.
> Anything received after that time might be too late.

Hi Greg

6.12.11-rc2 compiles, boots and runs here on x86_64
(AMD Ryzen 5 PRO 4650G, Slackware64-15.0)

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

