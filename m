Return-Path: <stable+bounces-78108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC46988572
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7433C1C23BC9
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A4518A957;
	Fri, 27 Sep 2024 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="TNP7zoUc"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A851A185931;
	Fri, 27 Sep 2024 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727441195; cv=none; b=TbTqpg5aTANHcVYRiGPK44E0XYQyEqSrjoy/YX5ZirSQda4En//1uU4IQ9BXZKjBVCeqHSa5FuC1Qi1wisa+mHCkXvvX81uA+mrsxM2wDxjJ1sjP+nvxwgAJpS5tR4aJ1/X0avFXfPg48CKJCJ1Vu5C07TPsIXdbaSStZz2pbhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727441195; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=NJ8izmn3FJfF4S6NZtWBUgw2e9eUdIp22S11kpi8ypTFtyFScFwscqI5x3/mcsF4XHXCK/4jfsUq5tiHiX5kfVDjvcVTRhnJz0KG0zZTJqv82qJQaX5N7wnEkHgAap5TDqQOEF9AwDwpgoESKaYDshUaeTpaXSubvybgkAn8Dtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=TNP7zoUc; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727441188; x=1728045988; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TNP7zoUcpeo4IY8gvMmsXC6pKglqwpMDNNVcu/l81E6yQLH3SumcYuLluNJylhOi
	 Bx7R+gN/ljuSyfmWRlUJwQd9NkQXQeMBAKIpKWC2bQYTVdOffxgxrgyE1hz8qEyUq
	 uBIgRL+TkQKG9+xc9svMrQId6sLdFyZF9w0Rzm6E5oy9fl2Xs3VIczqzPAuWlLIh1
	 +ftBRg9vFSyDiPYkJu2zdtaagmQ6cL4UzzkCO0hCfaGRuKGIUUAMye6xoLWHxNnrD
	 KTR4qj8IfsdfIoQGAmeQosU8olT3e4e08VYyV3vxgYqzknX7FrQEp2C3thKycSSwQ
	 YVhiJ6LNZisrqdndXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.160]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9dsV-1rpGOf2cQX-011bbF; Fri, 27
 Sep 2024 14:46:28 +0200
Message-ID: <4625690b-ea81-45e2-86ab-8dd41f3d7b00@gmx.de>
Date: Fri, 27 Sep 2024 14:46:28 +0200
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
Subject: Re: [PATCH 6.11 00/12] 6.11.1-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:GvO8w6cIpiLgWG9Yq4wJqKHExHOCNzzZHXjNhTxqbv62JQHfTxT
 tUaoe4VlF8XqI0BY9qZ0tjE2xK73UvQz4CLZbAJK10vS43PZAlpaT24tszMp3HPj9wvp6q/
 8tix2UZVCiGLaa/Ra7LyJK3LcpCsJXAjou+IP7U9WIjLOkQ6YjAx/KJaNIh5nIdFFsstrEV
 1tXM8FfoDnDChUogNL+2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ur0Mzrw4mpU=;0eY2ajW11VWDTpE19zS+5J578GB
 cneL3nHpl1kk8H6XK90q3A3WmRdE7LbfN2qNV+MWoh9mMgPVGmkHqaFDdEWR+cAk/6UHQZ5sM
 kbhuzZHy8T4SsO7hKQqCaPe5g2PIMTLAyxS8msPaaclPtxFNqLQuA4SDya1cfCR17PNqGt0As
 R9PygMMZBEyxe8X5dbnIbt5yPlVZ/2SU3QDxO8i9ZTF+ie9l+qw4ZA+4mVhP3zm/FkoQU5GCo
 NCDs65dDkbUseoy4ljejkYWqt8upDI2B2qYVMaew+o8ipM2RMJ7kesUvxtHW6KG6tWfFaw5lb
 LjqbLctFduZe0iDnGRlCsPoXzPvUgi8upRzz5gdmJ+lpTXqvlolFwuBXVUxgsAGZxOCHhBoKR
 kK2hp256QeLEKNhI71zUAbmmEnJWIPf51EsPDYtyreVgxzznXiNznrh5iuwLrrSgnoNX4pu0d
 NH0q0KNjCBHzlo9nlvTPr+DlKdwcO2JW/EWp8R6C6xMk70zANY+F+ktW6oolG6hRf4keD7TGi
 mAe7O5ad76anrUAXg3nHVQrW7cnc8CiFpZHGGRCBK8apb3yKBSUr8wKXo1aZfgiaYxB8vUYwr
 rcGvY/XiBGrSqi9On/tCjsKpGFGxBvcFpWQ/xg3rW4GdFBC5Uz16wdmS8ZJn8lZChUjXIbOM4
 QOb2Oyke3DHPck7e3eJGT8PLYLFsnBCQ9D17w6ygP7wlDfCjMwV3znYqpak2yRb8a6lRctubH
 nWwcfksUlNT4usqp52e9ZrXI7HmmwB92I3W7wi+IQnBztkX59u5O+znTYnic9ftk8a905P8vJ
 PNoJFrducG77tytPfR52ucZw==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

