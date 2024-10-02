Return-Path: <stable+bounces-78603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B69198D094
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 11:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337AA1F21BC8
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 09:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB371E630D;
	Wed,  2 Oct 2024 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b="B6CtcBgV"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42BE1E500C
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727862962; cv=none; b=Lw6okTu7768VUs8imBIQMJ05sFCgrmFQHFK87GC4bQh8CQXhd+0X77sjw3XCNeHNr8SRSB9Ttk2xC8zmZr0gKJ0bLwu5YRWYLp2EeOa/2tK4AuQb2b6oikf9IAur5zSXwZn4zv4Kj1xN6A/IU7Vu9hOfXF5WH/zxgaxdHsggxUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727862962; c=relaxed/simple;
	bh=kprkkoRwy/gD4X7MinyLm2c5+ph18yp2cPiWRZGD/BQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Jk4nb5DcVRzcGVknPkwjZ56aH661robOebnGuj9rq/aiAw1S4Vny0fmkA61hSaHcXIT/FdE7niaRmhPlJkAO/yKlvCEILtf8L6AuiypDn/5lMQACwZhAsURxGaWwIDth7kTv3N9WzyPfKSHpzheN1BREjas7acxZY+WujJ3y5VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b=B6CtcBgV; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1727862952; x=1728467752; i=georgmueller@gmx.net;
	bh=kprkkoRwy/gD4X7MinyLm2c5+ph18yp2cPiWRZGD/BQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=B6CtcBgVeiFbIMgqtCEpKAZ5xbywFaNGfFo11sRNso4F/Tkz21o1YFOLucGI9LyJ
	 +zysKKFJz9AZF/52Ds5MF4RGne7kTWe5Y+7sJN6lxzeWM3bksYHMoT05UUFUIhsqR
	 0+HF5nqyCD4nPo0wCi1mpfgflcGdIPT/6maTkdZ+Lx61Bhe62O34nKLBXYMj5nMja
	 OQhYEvHa/3iBEL14mRnXDKLvNuwibVJ297uFsMMFkXkwxX8wp8TSWCu1Cf4Ypq3XL
	 2dGx7jY2t5iV9WmKclSxWij4/Z7XDP7rq4RAXQ1cf7A5vg4e1X7bhuAxhT5fJr0qt
	 qaP3YWsJejT5hBbS9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.41.16.31] ([80.153.205.84]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0X8u-1rzpgy2oL6-00sqoj; Wed, 02
 Oct 2024 11:55:52 +0200
Message-ID: <f520eda3-0831-4590-b337-3bfd85096922@gmx.net>
Date: Wed, 2 Oct 2024 11:55:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: stable@vger.kernel.org
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
From: =?UTF-8?Q?Georg_M=C3=BCller?= <georgmueller@gmx.net>
Subject: Stable request: wifi: mt76: do not run mt76_unregister_device() on
 unregistered hw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0CcYuf8v2IeIlhOyjl9tMDf+UH1VawnQHRtbIqfiQuTmLpoYhv3
 i+aU//s5udnacYrLBjeBrgJf0o3I3008zWX0Byeb3PR4d00HSfRFy3j9hpB6M1dleVf471a
 wGe9Py8qPFNkfWClOAXGLXpdZsaOyyYLUALm0ARRGCh75agx06V2KLi53GU099Smg3SeJb1
 tHBR4dice7HoCRn7iF7bQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gby7YB56vYk=;JMhnPX5Etb/XONjksdOI3lBwN0X
 NFJ2uoO4pkIkj+GG+o/Bkd+nBvxvpUZRHzqaqPrI2RbvvKa9eeyDzqildnqKKvHZjPlRI5GPm
 lNGOiUohlhMrCHQUM+nMaIMR64k2iozZavpS7YENlju4PbcT5XiwoKdQtciQ4a4+7Gfwf/QJ4
 RhpU9czGh7Aa7YOABozMUs9GQxH/HBl1trPDdFCMVg/fdAhMS9Prr5vzPYNe6p4RNtAtqUOiT
 X+SzCfJc8MaS10VjAt2fdi3bpzWYuDXTTgZZng7g2PjINgcATe6/jcuY3CTao3+qrGaQmdicV
 uOkfCbkzMZMpa9RKN33uq3KY8NuRvd2uJbz8sJCpX0tIHuFPdLGOItgVaANhUGFB/IuiAfmrn
 v41cfzVOq7gKWrlBTpVHfZ3+5/8rd/dbvCFnaGaNdc1kp2a7UDxg8zK97DYyUpgxKseR9qiWy
 iwHrUI83f9jdq5siDQBqUPc+nZwL0v9VrlpMxB7EVYyjfVkdgOSqeRVUEF7VLXy1yt0n78+s0
 UTF69FVlcbjt1P3Z0998hVVkX8JvEgAM7gUFwnRCKe7K4bfl/T30Cj4k3NdiCXxlg8/B5Le8Q
 nGLNLm2zYWvNsRw+5wG3ogDFRlngY3BXp8N6flezKWtl9RE/O+o+xb5hsv3n9YT9ycd/ewj3H
 xMYU+Uy4EIcxRqM4x45FN4CAfs5DaaBmGv3OciltfUgSi4tiHBZZafbE8WEYNcznN9h9bvUAv
 pt29loDdVhWUQ9KV+LlowaYogLXT+NdVlRGWWp3fhvu/xflbd0j1ZsX93vCUoZNGk/drTTtUb
 VrIp6vcAKSItXfVL2MDeWXsQ==

commit 41130c32f3a18fcc930316da17f3a5f3bc326aa1 upstream

This was not marked as stable (but has a Fixes: tag), but causes the USB stack
to crash with 6.1.x kernels.

The patch does not apply when cherry-picking because of the context.
Should I send the patch again with updated context so that it applies without
conflicts?

Best regards,
Georg


