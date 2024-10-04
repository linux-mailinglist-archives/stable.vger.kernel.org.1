Return-Path: <stable+bounces-81141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DA699129B
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 01:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CDC1F23B04
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 23:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6821714830D;
	Fri,  4 Oct 2024 23:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aaront.org header.i=@aaront.org header.b="gBjjXSUs";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="PIKjtK6q"
X-Original-To: stable@vger.kernel.org
Received: from a27-57.smtp-out.us-west-2.amazonses.com (a27-57.smtp-out.us-west-2.amazonses.com [54.240.27.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B6B139590;
	Fri,  4 Oct 2024 23:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.27.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728082897; cv=none; b=FSNnSjAR6L2NUihP1ibo2ZTi5DrzzpAXfGqq16pk4BhaQNdAduTER1TJpK16OJeJdbnA4NEYYnUiQ3uHQtOdP9H5zCd75a6vD9cNRoGD6UP7Rz0K7XhlLYgH/Q5GfX3nP55ktWgsjbJZN7prcVReOKhKCORS+bEE/rH5EIPj0yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728082897; c=relaxed/simple;
	bh=1Dl575V0wsuPTalg0wXqgivRD05gI/oK5+dCZ+uJADA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmR4dmSVclzlZHAol4POSxsO/++Zkl1iyy900DXwCBVd9sKzwy03Airp2NHimVQWxIFo45P96cEM+DMalH0gYMRR814aPNiAKDDnpn8QbvGQpdKGZsWj+FAtMOhmL48uM9gHcsSiGkxIBuekPujWfZbPU+4YGd56ZvWy9wDbp4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aaront.org; spf=pass smtp.mailfrom=ses-us-west-2.bounces.aaront.org; dkim=pass (1024-bit key) header.d=aaront.org header.i=@aaront.org header.b=gBjjXSUs; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=PIKjtK6q; arc=none smtp.client-ip=54.240.27.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aaront.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ses-us-west-2.bounces.aaront.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=hnpv7wyf3seapxrj4k4fhpgkc6n7n3bh; d=aaront.org; t=1728082894;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=1Dl575V0wsuPTalg0wXqgivRD05gI/oK5+dCZ+uJADA=;
	b=gBjjXSUsDWX2Rtb9TrMpvrch2sejESRtidSIx/TfjG0WDICDHe1XoaJpuwnaI2kS
	xVGalovWutQdwlSfHT6U23GExmJ4EzyUFNtD7Du0JRJUmzs27QFRNxnWYxo7sdXaA5p
	gXy7pof7Uy7Uxrs7UbEUMCYG+NcP+2iBHGp+5wcg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=7v7vs6w47njt4pimodk5mmttbegzsi6n; d=amazonses.com; t=1728082894;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=1Dl575V0wsuPTalg0wXqgivRD05gI/oK5+dCZ+uJADA=;
	b=PIKjtK6qpHbLo6K5XGSDGmhCjmQTuA92m5aYKVe35b3q7SO6cpPUWBCyznRDYdJm
	CpEGJT4yBXZvpctOphJlQkXJaJUqtbqV4s/bzipF50tOUlgF+aiuOzvkQXVB5p9Gpyb
	+JZCaqdOTVnfZ4EpIvE+IH4RyKAh8o+1MY0NB/+A=
Message-ID: <0101019259c45edc-189b998f-1617-427e-b5dd-398bd8931b5f-000000@us-west-2.amazonses.com>
Date: Fri, 4 Oct 2024 23:01:34 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] Bluetooth: Call iso_exit() on module unload
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
References: <20241004003030.160721-1-dev@aaront.org>
 <20241004003030.160721-3-dev@aaront.org>
 <CABBYNZ+gOZ36CJpq5Z7zXSNnruRpGrau9gXWo-cXKwU814ybvg@mail.gmail.com>
Content-Language: en-US
From: Aaron Thompson <dev@aaront.org>
In-Reply-To: <CABBYNZ+gOZ36CJpq5Z7zXSNnruRpGrau9gXWo-cXKwU814ybvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.us-west-2.OwdjDcIoZWY+bZWuVZYzryiuW455iyNkDEZFeL97Dng=:AmazonSES
X-SES-Outgoing: 2024.10.04-54.240.27.57

Hi Luiz,

On 10/4/24 12:30, Luiz Augusto von Dentz wrote:
> 
> I had it under bt_exit with the rest of the exit functions so that we
> don't have to move it once ISO sockets become stable.
> 

Sure thing. I was just guessing based on where the call to iso_init() 
is. Thanks for the review!

-- Aaron


