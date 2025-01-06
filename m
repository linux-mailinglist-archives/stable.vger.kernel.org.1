Return-Path: <stable+bounces-107723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 906DFA02DEB
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 17:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D54163B25
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D661922F6;
	Mon,  6 Jan 2025 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="j3wIh7QD"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8911448F2;
	Mon,  6 Jan 2025 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181678; cv=none; b=Vbyol97T2Kw+GMevBnbjseZPhhYPfsbLXkQqRGpWMFGuKhGEQzGbP95UVuDkU5NkDOkcj+M9MrZ575IrxGX6W4QLAZgtA7kZnQ2DA3ep1P6taSwqyGmoEg4OkaO8tqNv1D94NN/Z/Ik5a8jymsI+KMNw9YGjxLecJ80RBoWcHBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181678; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t3E1Lzj9XboQsVI4dMzYQHA9n4Ui0nv7ga9NFyekcOkUD+Pl6UxlWuMbvJmwTNCHSIxdpPGcP6umfmP1wclKQBQ8h84D7swAuGD6ADzMVS05RE12xDgob8X6D+UP/IOEdLyYLNcoijEpi0uYvewcj+UxChHTTjBgESBQ0LmA494=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=j3wIh7QD; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1736181673; x=1736786473; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=j3wIh7QDqJqHJEdI0CfxzVRTxt78vyptu5Ls/tZakbMunhkIaNZjE0cxrSr4xq57
	 fSLfjoWiLz2IPSuaR+F5tWPmTXFE2Y39Jm8b2KikzoswsHusePmVrHAMQXw7hutUK
	 xAAgZtR5X6wwHhUlrvJekUA+mehr5+tp5CWxQDgbFJukhcG6xRhG9Q5HPnQH1D6cF
	 UT4OXARAcTOvJiuTraVO1WtYRw8eKEeYumK2+9bI2nNV9X9zVM0WCGzVOzYChaxXh
	 1cttCfRhISeZ1ohp7e5xXkBzzZzuXyZIzb6SSzocvduc5qqkYRO/mAw9yyy1RRxx+
	 Ye3jEq9+Rm6xnMP1fA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.32.208]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N17UQ-1tcEj444CI-011AQ9; Mon, 06
 Jan 2025 17:41:13 +0100
Message-ID: <1a6c1d61-4139-4cf2-a121-39479a5814d2@gmx.de>
Date: Mon, 6 Jan 2025 17:41:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/156] 6.12.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20250106151141.738050441@linuxfoundation.org>
From: Ronald Warsow <rwarsow@gmx.de>
Content-Language: de-DE, en-US
In-Reply-To: <20250106151141.738050441@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:UqZVxLMWLwj4IOFIxYoxRb/a3Wj1lINg9TNUhumOZc5wHINrZlc
 b1FLc/+KWzxgI5Kapj9tEAQt14lKTLr1ZgWHs3nt+mE/gMXciWQtDqzs/mfX5fI5hktmWXl
 Qzd6sULJFw2j4gLKQilkZHqQmJSsrKKrpqu0s03AljLS55DL+MTY5eb9b+COxhZWMIpcYMn
 e2M0jRlbvghCQoKH4FV5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UMYFphQ/4RU=;+mHn55bp4/aQuEJHvpS7/9TjarU
 G+G8PAfE4XXHQ9OV3TMaclAf0E/AC4PWTu9ay8LO7SZFIqkQ/fB9/TZ5fRkvN0J0fnFiZMOQQ
 sKJecEcQozAddM4oVXGjAHc3/wn5Q29zmP+JMoxL8v4kpPJJgsVt1h5qg2PFHR35OEpnSxirB
 owLlVrWdGPmVLLBVsJzaQHR+KeC4/suFrpGxtxlzS48swEsOVgPJq0R4xLlg9GoeU9dAv8e9J
 EhP9gNpYesnKWqDt6wknzjxaTQJXtpGUa/2aC7mewJQGZKzMDEIDD86YJRGXGEuYbXC3DbDR4
 pJ69ANxPP5tvAUYEpVw2Xj5zFeDmFrmVYdD+8DHBndmSMjHQffQjONrZiRMWgJmGPWH1vwk4O
 SfkCkj3OPvG8x8Wv0dlXqC6Q75sQ3YnPowwW3OhMv7rfvM3d2J4lUpBCrZCPQotHfo/rp5Ue+
 uJz85WrMuI963VJKNLxRQty2Y4o3Dcyn6NCrxYpXYKl6Yoyb0jHtAZfSWiyBLC2woImIldXyh
 kTUvkKmTk0tnv6bNkHC2bbFzKSxunHP6bhaKz8kUbxPZArfy65inEjwhcXtxeH3iGFS9SQhBg
 BwmIYxIi2EtneMV7ZGVhN5d8j+6tIKSlX3NAtKFZx6hzcLtAD2HLVRlaEMdcHET4kKqyfQBIe
 VESLVlEsmerjkDa2UMpKRFq/nZuh4biF0w7WvFMsdFDCBh9HfnKv/R7JM4DmiH8CXuGIr7lbJ
 YHi+icP/H1CkWfr8VTvG+ZcQX2oxtKQol3MZsY0Q6xKtP9xfNolT3D5YvLirD1Rjdyl1+R2pr
 352tyZBPMtc2M4SHhqWSeYGxh04EjLmG2lmsg6DT85rK3uVVcHtW4KtgQqmpoNFBi2qS/S4ra
 e5BNY+xXG9cay0k1AG5xCMhtPF+JwiiNlESC1BDkDLCLnvhjwh/x5Oig7Fk1ilnA6MJ3HnvSU
 hJDUhN8HyC4jGfcnDVbNr4UbLATtRX7VOeWEjsHFYtmIt/0RWsxYsnNMdB++Kk1Vknt3XyyFO
 b4cJthFlzzBDlcMpC+uVnpcGHAK6qscoRQhYCb0S87WmWG1IeqBDGt3Jdr8nyBHZatbT4PLTC
 iwSxs3aPI=

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

