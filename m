Return-Path: <stable+bounces-68244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18F6953150
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82005B20E47
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ABF19F49A;
	Thu, 15 Aug 2024 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="PiGrnevy"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A25B17BEA5;
	Thu, 15 Aug 2024 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729950; cv=none; b=FTRe7fxLtKJlUS3yV0mTb3rjEkCGFVOJK/9gCmJEB3KY6A8LomD30/qrszWLh8y4UUzKgXzf5DuT+OgsWqk2J5DrgaqkVvIdePA1+KrMTGqj7IaAwSNQ+8gkqAfZbL+w9Irv9ggJR0nCQW8cHekDoMHaJGJlzopX4+TridqqIQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729950; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=LnhWqaEFdKjFyXU/tM9UHu8S1GLGkhkMNRRQwC+dNeNxyZcU3Aq/7wUmbsMdacKpz6POn8rWWv2vjCbY6Iy6qtORcrF41QLYFSsR7seAIDu0va+coWH6jdaWkkelRTPuS9TmZdntDi3/y4gg7sWIJ1V4jMx2pXqKz2ZDhZvRW4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=PiGrnevy; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1723729945; x=1724334745; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PiGrnevyM/LiWyaPY79YSXP/wpQlJreYf0LwyvB4xMBZtcj9Vtzv615gdqcxNcGY
	 iLVjqzZiHVzI8p5Bwfr0Spsmk08MvrS3eTJYA3wCtumJ+bL2T0Q/gc63zvlQ/29rZ
	 FB2ISumaKaQ2ViHbOI3WxTgWYxXV8JOJF51+5CLrI6uDs0QXFbTRxGeOFmyXE/9i5
	 abzaerc6OaVGPL50xEXtm6ei0RbEaa5ryPhjmZdbGaSaYe11e0M3WI2ApQpucKOwb
	 ziqQTKOYdxgMtfTTGN5Ug+00SaPpnmyvWuUCaLYQaRwKmQTiU1iSvp3Rf6CJZWpbI
	 B2GC0xHX5zAOteJXXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.162]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbEp-1sVYcs29nn-00H624; Thu, 15
 Aug 2024 15:52:25 +0200
Message-ID: <67325f54-7807-4a78-819e-c968c17e7209@gmx.de>
Date: Thu, 15 Aug 2024 15:52:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.10 00/22] 6.10.6-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PYt1DwTIr0uJxeEE4KR1CVS/SuXpE8kQwqAz2U0W0Eg9MsRzuKX
 oa4QOx7WX2KjHx8nUJGTuxNHNBmqvGFJXYYVMJvba1ZdqG5bvn3HnYZarXE9pdbznGzAlEy
 WCfrfSqZ3mH0ctQ/s74ifXuKD8fnTLD1Xq/XpRakdwjV7bU0M2bX9dBG/yPJp7iqo6W/3vc
 pWxtmalsFzXLAdb/uSX7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lsjbrFqKIUM=;ev9YJCG3KyAiA/FVkEgLiYr7EnZ
 /ZNgFqB8EliGuJIqIh3pcszGAURlVyfeDJIc5QC8GmuTcuEA3FWWs/Qsk77TzZ1wJI8EdtFzR
 rXeYvCefg7XFY7EWN2aex2xdAudZDgkRVIJFSY+JqVOVxM5G0T8o9p+o8Tl+x16Jh+j3djkzu
 r+yeSv76XcexUF+vgEoHS0Gnt4pKgZl+8UxmcyFRdj9OnStKIJMjXeLx/AG04NvCjIr5IsBL7
 DHDN87nYfUGk0f3ow18KZIYf7Vt2ipVGCla1J1AmyMsYIpbsOGg/FXmfQcWBFGKc2EqR7zQK9
 yv3gWwBErt9ojF48VLzRx0Rr56pBaUt7teeARIT0wLmLGjS5SEt7O6n2UjhE/VXNNZKxx7fe0
 zYtBixnF4QhOtGwQkqnkverreFC5NwgSq2htrZ5m4dTGOdouHDQrAnZHulwOlwBf/N31mogG3
 yUd23KbypxWl9CYgZ4/oEwqgxcnC8Vov8vpQilvcQZzZpXnDLCYAmM2iCYW2m879/Tbk4z3wR
 Xt+2eBbYr7mRrTA1v+DNp8EwRP1Zpyx6E330oGh7uC1+zkSZbwJmEKaodyF61XWc4DT/S7TQL
 H/Lwfwr10HGJwa9UFb5YfJzNoJvormWw7lytkIGWrx9Z22t3ocpZqa4HZF7C8grHHy+wpMVyc
 mNnnZ+rhh9truKdLdBwKocLnGojXs1aKOEIZG97Y+ZGvTO9PLWWX5nZsUvxbnxmpZO4HaR30B
 vkJA08FcKwFkp8/zbvzRAbBM6KPsAkUyo8TDHnq/iHQjf/1rr13JfSAc05nf8unwWlUoPNtwf
 7Se5lgoGMu9qGbwHfVyrjRGQ==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

