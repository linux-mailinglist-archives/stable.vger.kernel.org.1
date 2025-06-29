Return-Path: <stable+bounces-158833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E5CAECC23
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 12:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4783B36CB
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 10:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303201E521A;
	Sun, 29 Jun 2025 10:22:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA661F92A
	for <stable@vger.kernel.org>; Sun, 29 Jun 2025 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751192576; cv=none; b=QxhpU7aZdw1mIv+hhEy0NmS52mHQp+XmMLJ96+bovmQKv8Pj2RLKv6SJ6DIpbwDBCl/N0Q6KR6/NjdNOBeqPqKRhIUOtt5DsiqfDy1ZmkGjpKcPawCgdGEVQGI3ZRFTF0SG2rfKkQWF/WeREI2WkcdLoo88q5UdIkHvWvpgE0MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751192576; c=relaxed/simple;
	bh=v30gh3v501dYGeVQ6MFyO9DBNjT29wkZT0DkM2z8IUw=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type:In-Reply-To:Cc; b=KVIxjHKeUYVB326VIUWFtHPkRaYf+SklidTo/2EzyS3/R7r2RGQVZwbpEXH4wqLMAUCnR5noX9ujvh0sxQksCKldzRTLywaNqDDfUamrsSRl+VArwCaQP4xzoMI2yY43Ox1Hof+00YL09zNRX/YLZB9ZOapXmcHaib64l0M2nQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glks-stable4@m.gmane-mx.org>)
	id 1uVpBU-0007JH-AN
	for stable@vger.kernel.org; Sun, 29 Jun 2025 12:22:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: stable@vger.kernel.org
From: =?UTF-8?Q?J=C3=B6rg-Volker_Peetz?= <jvpeetz@web.de>
Subject: Re: Linux 6.15.4
Date: Sun, 29 Jun 2025 12:22:47 +0200
Message-ID: <a17ab649-82ab-4fe9-a9f3-eca67e7d5953@web.de>
References: <2025062732-negate-landless-3de0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <2025062732-negate-landless-3de0@gregkh>
Cc: linux-kernel@vger.kernel.org

Hi,

upgrading from linux kernel 6.14.9 to 6.15.2 and still with 6.15.4 I noticed 
that on my system  with cpufreq scaling driver amd-pstate the frequencies 
scaling_min_freq and scaling_max_freq increased, the min from 400 to 422.334 
MHz, the max from 4,673 to 4,673.823 MHz. The CPU is an AMD Ryzen 7 5700G.

Has anybody else noticed?

Is it intended?

Regards,
Jörg



