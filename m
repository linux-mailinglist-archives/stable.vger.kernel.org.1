Return-Path: <stable+bounces-114143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D735FA2AE8A
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 18:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182E13A3100
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF135239577;
	Thu,  6 Feb 2025 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="pE1bMoMf"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D29623956E;
	Thu,  6 Feb 2025 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861890; cv=none; b=MuUJILO3o/l2IkO72IhOOopm2lkub/9/eQ3lyiUuYTLY8/als9WaCIExjtD8jc+QDLHwq4DzTrDlYni6vhmgkIZtidCJKIHGfgcKLnXhggLMrCSE3XsvOQCwyl5F1yePAQtOka3v2+RB2sfcEhEW5uF3S9xWLHDOhGL23Y5ec6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861890; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=r4/FPdFYktLgzGleLI6q7vs/dXtC2hBH/ywU4RUlTQoRGFwnEsH0NMUBVHM8VuCzLMCcOaOYyW2bd5HR0QCUjW80d2kncwnTREHaegxZDYvrQCByPcij/IN95qEMdjxxjeb9j1Q4QnncPk7/+fA65SmaGQTuSn7zDWurqWG2/PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=pE1bMoMf; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1738861885; x=1739466685; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pE1bMoMf7zcKkOxftH+VPjbii9wiLZ2aL0k5ASg9FMthl6BW0YZ/udRbBGXqrRW7
	 MJ/NEgGCN7LSOHFKmECPc1+XaqOXa7xjvI8MnZxSAR15sYvDlPlyUwsv8XhxomKp/
	 d0+B5iaHjEXbgHVCmaShkBaf2GUlrjUxPHw8/1xuqkkFcZnZZnFvbm293uRmR06rs
	 JfiiOs5ErHdTEhxNnSxnnv715Rm1+tAvbMG8mr6y23c28b/uVMf/mxT6C0CiX+8zs
	 XbNNqIEZKN8ZDgl8DaqV85bViBlhilBHPp7Byc3apk2I7cQSoXKpgVn3MrM8tLcOG
	 No4fuN51GW91h0fAng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.34.104]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hzZ-1tFAaY2koZ-014bMQ; Thu, 06
 Feb 2025 18:11:25 +0100
Message-ID: <95a57ca5-7167-4c53-9fd6-4b4158bfb42c@gmx.de>
Date: Thu, 6 Feb 2025 18:11:25 +0100
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
Subject: Re: [PATCH 6.13 000/619] 6.13.2-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:EAl5cUKh4x5wfDjRiRtVguHXUNpl7gzByOEEvPqghmbMPkb0jSg
 uCXgwjXGtkH6KxILt02Dmx1tHGDfqJv7ZlGVc+/3akUiD7T3iRxw3khcByKNRMBsfXYxKl6
 bHWTNq81IrWHHni31ps5YN2kihRC2o6VD99ezAuKQ+uzyCcrviNXWyDRzI/rXZ5TCyW6CS6
 ezc020TqGurtB6hRZnvWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:826pDFQyJyA=;wiLDuPVnQ9BHHIcVcN9i0biYIL6
 j/uRkHr4+JBgXqsxvDOOqTknbMSr/SCjocm4DIa8jdZh0p8M9PoJV5TMq06sfXORuXrNW8P9/
 FESl102YL+2fVdyXwb1fhYWp9kpYupraA9k3VMF3BFSPrccHoKBdXbdnXYSE0wLTRIVnUZdXb
 0eCFQNpbwb+1AgYU66RCE9ydMWbLtStln6tDYI/T1lLgaGL3RXAqa4cpvqlgY4cDAj+I+rg/L
 D8JBzfCFVnswja6yMTpe6Ph9R6N7uJpdxQz4ZQ8UyFyIRJ9n6mIDLX42w2oCW8ebUDAWeWlyX
 s6sGysUGkPbo3w6MHrZvZGGngV8XCFKVb6Bl96x5OkMuINGUd95HgedLvEwtjdOEK82J2wdo3
 w1XvoQRUR5MBIhK/Pl5VtjU2J2aYTuDphRlmoViFWv1RMFBAibIytKFurEG9TKpgCmProjy1e
 Y3MZ0MtJT8pHUuj2A+d5Ke8qxzf4FFe79uRoHKQOjXwT2cjDMTYULrsGP0I42IBCXu3GTY06v
 PWMmrXrLsJX7p6qWuPTF+iuKBHQDbuCtNRqN5lLZFYeqsnl8A4NEAbRupVzxi7ptex6Zk8a/R
 Z05VaPc0iPrEN/yrshk+gxFRUCBRfP24yI70tE1H80YWYJoJb+R5U+f42XVFNZVFhUyZeF3dM
 7MtUjyIueo8qG97Ri8tIURpxUmOif9/R8W/vicvXEFrDwzoLoFOxPb7cUXN70SCIva4qE3nMe
 uAsS50OTAuRRLaznX5kQ/jJaSjH4OoT7uSf+RM7nSEpiakDCa25cDl95hTm3QQKO+cbn4Qyfx
 VPjPHRm2aDylbVu61uG8H1c80AGBUWKP3B7SVpluXIe3GuXj4CZBqHN79kofHOqxWM1aGi1n2
 R64jcKF9MdntewIOOfbb8HGXiWY8PM/JnWh7NVIBVewTWq0Rd2My38EgQCldmCbJjdaowd2RN
 EEp5EQamgB0J6fZx1fins7j2CHufhLP+h7s2Eyx6TYn8+krp1Q7NGGOXb21nKlA391h13dcJo
 G+jh1tod86N0kQIvuZnojneUF4JSlU3pkBwLG24Qry3kkcMJUy/QmvIk6WQCcTf3NFzHfqEY6
 3bV3L7fYYrEnI6z5zRsZsfj/edfXF4vGdMfNd62iNjzlc3G59lNmgAlsCEIWanBi/P6mglVNL
 VPs8H3Xv1jpP9urccsiBRyksF8ueDTWdnsOwV4ahSSKnocC8BqQjUB6FqCetBvNuB8BrqVVBG
 mQ+MBSrLBIXW519FdiL1CVMFgnoVCPlkd3eskroGNyJdFbVamQwXOcW6Y2zBPk0EmUfMGxYxO
 OiAV3baHJhXAeRojQicSXZhrlbL3kaqi0gg66gf1t47kjhGdhLos/uRWaBqNm+GUg42wDBcP8
 Qs/KmqTkdAUEcnaYB5hMNKZzqHVXBUMN9GRJrlmYWAMa44wi56JzE4+1D+

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

