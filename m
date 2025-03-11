Return-Path: <stable+bounces-123154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8E3A5B995
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 08:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BE61893D56
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 07:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A627D2206A7;
	Tue, 11 Mar 2025 07:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d0ldyDUU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645122557C
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 07:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741677162; cv=none; b=S21MHXgYZtbMW/gi6jVLeTUiBUzILEUVpAILxUcFEqK6MX3Vm6EMgYQfcoKUQrX3RIFfpFp4gM6FbiwzYkFU0BudANM0Nkwd4WutJM06HLjbuN4qUn7jec44fQFABfSJOVTCpJ1Tv0nYMogi3Na17wREbR7CeD47h1xI2XtGH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741677162; c=relaxed/simple;
	bh=0/51X6XS6qrPeyNE/lPdFsS1TH+Tm+Rgb2UQXo8o4aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLEzFwqU9Q3ZGVLiWxLm5vgyKsfqiapMa7tEDfMgNQ5lErjvl94bs7C5WNIL+c5WaSPDP2YkI0wfWd4i9c7QOaZHSK6IPwBy4w+At4aW9ORpM7h+l4W0qo9S627tnaZdFVZClXUItTNN7RtWJ16LY2SL5W52HG6mWEsSsrPlix0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d0ldyDUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F9CC4CEE9;
	Tue, 11 Mar 2025 07:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741677160;
	bh=0/51X6XS6qrPeyNE/lPdFsS1TH+Tm+Rgb2UQXo8o4aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d0ldyDUUWUKVrBMOWvZxSzpN4EIVUCD6ZlJcZJ8YBrU+GdJ7Y+pzbto6s72YwL2DT
	 1kyQPwex+4xZhvvbIBE1RRh9nplhT09TY8a4QcmqLRWi11YNF13jXvvcIqXZmx6m+l
	 EYk0Y9ERk6lG/OfONkNYZmrepy638e3XqPONkJxk=
Date: Tue, 11 Mar 2025 08:11:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Cameron Williams <cang1@live.co.uk>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] parport: Add Brainboxes XC cards.
Message-ID: <2025031116-dripping-regress-c41f@gregkh>
References: <DB7PR02MB38021759513B50CAED9A939BC4D62@DB7PR02MB3802.eurprd02.prod.outlook.com>
 <AM0PR02MB3793DA7AF377B7525CAD6B1CC4D12@AM0PR02MB3793.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR02MB3793DA7AF377B7525CAD6B1CC4D12@AM0PR02MB3793.eurprd02.prod.outlook.com>

On Tue, Mar 11, 2025 at 06:58:23AM +0000, Cameron Williams wrote:
> Cc'ing stable
> 
> Cc: stable@vger.kernel.org


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

