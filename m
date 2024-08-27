Return-Path: <stable+bounces-71326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AE6961437
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 18:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB861F24933
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B508F1CDA23;
	Tue, 27 Aug 2024 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="ZqcPvFD9"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF78B54767;
	Tue, 27 Aug 2024 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776747; cv=none; b=iaXmqC6yD7s2/GwKmvdTdFpxj0cCIr1tV0jO5P8hUdCAV1/llmCkCZhL9QsE7S8JHNmjuqQWL9E7W1pmRx11+j+04/C7jyNP+EJsXIVlpRo/FadjRnNmek4v0IlQcLyGwsiO5ojmLC/oZEBxYGoOUROYBmPHJK3D3kNMPvinVNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776747; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=a2s+R0ZuiFgsZJraaCJb4zXieCSphGeqI2kfvo42SksAdm9IdBx7/V/jbHPZ4OIqXmOkM1Olziu7+I6XmQWRjrBZ0d3H6w3ehGyfdql98UZgWSr9XJpD0Sif7xEfM0R/9vxSiwwtWnoJYA11VmreugtFfBmaL7A/f0fDhC6jk10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=ZqcPvFD9; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1724776741; x=1725381541; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZqcPvFD9AwAGvBjYnqtedUrJFnSuMUWRZaM78Sf/yPAhG1MbhGzqOTP1Mgdo8Q0t
	 QvS2EYaYHnfTMeJCQuzKH+G+KA9Ti52HYpN4C6DbrYgwfszjNt57CA5baPAkE4tpK
	 NiA47aczwZXQelqFZW0mgcUtgj2sdSnrfs6JvMLG2Hot9IuWQygHu2duKFeUKlRQX
	 NpbFHcAdUk685vUoOJPHHIoD5qa6BL+lVZed7rUvnk7AxwJJvmn1e5tpVBeqhaihV
	 /T5lGgbsifyLGFCRGus4CM69HrpYlNGeOqEKXgUblCQTrUc4iBUHdXJXVQPrh30R8
	 WlxN+NpxDhLtKwdRPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.88]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTiPl-1sXHFg3I9F-00Uu3Y; Tue, 27
 Aug 2024 18:39:01 +0200
Message-ID: <744c8dd4-8582-46ef-90ba-f1d287a30811@gmx.de>
Date: Tue, 27 Aug 2024 18:39:01 +0200
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
Subject: Re: [PATCH 6.10 000/273] 6.10.7-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:fFqltJmr+a5Ct5lTaeHXpE+mSzphtezXilDuDiRY019KzZhOZWd
 Z6IBDtBSIRxgR59upQArs35CdKB8H+5f7CwHTNwXrsf735DkjulacYDnaTNACGglitfjjDk
 ON18vcR22pgJkBB4kAmn3VmYzac0L9XpnYoUAaNQ4APXQb5VUX2jk28lkjXMcvSh4iS6anq
 qbfPwB9dT41tG3FNZvJUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h6cx2xtbEik=;dZFbRZdCeRxgwfGAz3MeHuVODna
 RCZAqC5zSRHzLqESlJs5RoHcj0GfelDpmlw9qCn1nRo07Tm4diONZ30A6T0HEZ2y3tLhYEfYy
 v7oW9qfbI4drAZ11o/tfATQFA7mYXXwgmlohdpqvXSrRpkQDI0Sb+ssOY7GAzDzLruboyGJe+
 F32Zdntf+xbVLxYlaC2Q7SC72AlojGavf0llEEU9vr3QTs4wNp0uu8DSOWO2yQMblOEhaY3lD
 a1WnRzoWtYV5/nd/mFO+vSU1mUC5zyy01uBLh+wmaemCIaoRphj5E4BRw/yacv8uBrquVUlCx
 y2SzTIwcXAjc3WeC9YJ14oz6d4YYD/eM61bRM5/xTUZYC59o4q4QrvyIyc8WGKSKzwnpsbAIo
 /lOIouCGw5WjH1+MHWnU6atlROREqTanl12XjQBPOMob0vqDp9Bbl8bf5SUoZV4D5geTTWF5j
 iVne0KyinFN/OGvHH0+u/fRmBSeooofUdXYelVtwqcNdlTf5Fc0xRF0B2lVPD62ZnbUGOhFrX
 sbq0LNUS7w/KdOtJKL5jUqnAG98IO9mpH6yOMwAXC4dKohx0hwRl7VOG3uQn/KDz2shdY4yWK
 0zSmgOAo0Bw+qZ0xjuPjlfiav6AUz0ctcgYHjrQucreQDwnwIvhWpO58P0dMWY2Ra1Ya9+uQF
 6rMSFAaHb+7i+mDm4jrm2VnIDcPsqZwVZ4UJyAvO8eUmslT78w3DnYrPIBJnWV6VD/Y8xUDf0
 tM5EM0jWPkW1hF9g/WW6ai8zRUSojiCDWemEbfhBwHAibRmqTcxLIFwj2bJ6nMZG4jlLFDDQd
 vm6ikd+IEyDbZI5FBlr6Xhbg==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

