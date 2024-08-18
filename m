Return-Path: <stable+bounces-69411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22088955C6A
	for <lists+stable@lfdr.de>; Sun, 18 Aug 2024 14:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5421C208F2
	for <lists+stable@lfdr.de>; Sun, 18 Aug 2024 12:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297851946B;
	Sun, 18 Aug 2024 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="Nn7uGKnk"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E881B978;
	Sun, 18 Aug 2024 12:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723984330; cv=none; b=i5bFKcdkAI+VTb1j9Yj0WIjwTxmS4LFfvcN9bwJbgiuXaa+W6hWtV2mcCr6jFBrQZzdqHOMtLt/aJdUtaqop7BweNx958mtteftTaE64Pf1qh8j/VXn39nWg//hm+G6L2w1CseoGkCEwXHBVeEYw5Yn7IGSWUoxtgbsnup6naOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723984330; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=ap3mW8M/57zlCoduSJhg2ovsTtnW7FCqoJRlCPFYI7mqgiQxxWTsE0f17Dx6Iw83SN3ZGC8rR8Y+pMO/e0t3wro/O5UbY5N0lX9LUgQP87oXBuMfgPpenEjaJPGatq7GDoCe0JtFSyUVGGwnUAf/KxBeE+1qdEUbGAYJCreaYPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=Nn7uGKnk; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1723984325; x=1724589125; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Nn7uGKnk/Ul1FkW2zYU8Yk+PYbb/EZGOrekQ3okxOfz5SFtz3fNqVP45Tq1Wjo26
	 axF9y01LH0h06PjxaGxuu7y9qSHDwrscD20Kjkg2Yv19k6NzyOpHP0D2h2NN5Z2Hm
	 q8IG/DKu+J4rm8Z8382Kapb/uLhe2n/gcqPuWfLvMzljm34e8Se/fzjQ3ILOpriZ1
	 1lbw1lxeqXWaBz0ojfJr+lxmbWn7HgRdkQOSNr+NqqJclFheaqxzvd7ITpF84ach+
	 D4erJSynfCNtMhrcaOesrmd6AGQk5Jacfq8fIvOFUKTlQmfZIikw/XPDSNbtl2Xij
	 pnrGzlqNgWTJHmHc4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.208]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPGVx-1sVQj22TfB-00LN4M; Sun, 18
 Aug 2024 14:32:05 +0200
Message-ID: <2962a37a-0dac-41db-9b97-1f2d58af3bff@gmx.de>
Date: Sun, 18 Aug 2024 14:32:05 +0200
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
Subject: Re: [PATCH 6.10 00/25] 6.10.6-rc3 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xJjvTaBnBICHK12ZTw034O3uOj7jFVCYkg9Tcxnhthng60rzUyR
 uvp34tgFoc1pY0rJfwMpC9j3+UrqWga3uiPjNfTF3PVdhVYXnv5gpo+ZCHloudLGydZFvzz
 M5favxzOn6QLk4k7EAshY8RopCyC98XNpbGsmb6lwKfYBBNXdvqVSWBxW6xQhFowKiBPukv
 e9k+XfJTdhyyXdv6GE4fQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dlTeiFxsmvA=;VxFCkSpiBSlBfo7ZQZ6hswT/Nyw
 tV8lUcPePAfmrtBP8puCmpz4IZaELlUDQeSTEQpYJQjy4mHeO7c2edtW1VPwxr8DJWqbRE3YV
 t7oBhxmNLILzKPdocK+jlIOd9z5YVFho/1P61fmY2b9dMOqO0a4VitLpRGUXzY0vVs+4oKJIA
 kH/mZE0hNxRRv6YBpsSZfIJmP6x5fMTAG+r7I3jk1bFgTDjoGy/2/qfRA9T9fwCYvKa9t3yZ4
 zYIG2Px39Ck6PIzjYUOQ1kpInnno6dKsHLy4Yr1C/gSsZPYyCYg8WHHx+/fWt3iCXj93FaEy/
 7DI/ojvLNm2MZwCHVMj1HmIXQMLxBLTnYEi4Fs//yXs4P5zyNazpjPK9tMi7YRudsDpHcdmxw
 qRcZZa4KtH9iVxMkaVPrgxAJafyJ33zpD1WauvgWkZpI4/bo3Dqgdic6CnvTugIO4MmcUwOKP
 JTToO6/myL+qV01HPhvxRvagBVc4LERkmRiLT5+BjPjDLCRVa1CkIyZnmxNJdyy2VpWCK44MR
 PhcLJApiYferJus2n1nohmfgjXPbTPuPI4+XrSdfRIJ8QGo9SfI3sqWAHG3YUOCC5byaRZy/L
 g275vJRvBs2QvBZwghidi6iE2NxEy44AJxrkzhAeb8Cpc9tBqYoZlinWSdAQ2107XxM5wonNH
 RT5G2UZCLpZxi5B7/8ukQIwZp8o6BEQCDMRETy4J9XpGPmeNKYroU2GT203iN+dBcDm8Z6mBl
 0teOt3yK5+bi3RS3brzgX0J87j0sUycEIF8IuwtCMlHmOPXXexEhcODnCuAWtYhQhiXyvj6lw
 JwnC+idv9GzQnnt2NUDYrmwA==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

