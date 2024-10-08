Return-Path: <stable+bounces-83068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F859954C6
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 18:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973331C21766
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 16:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6473F1E0DC3;
	Tue,  8 Oct 2024 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="NTkdkP8w"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E816770E2;
	Tue,  8 Oct 2024 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405948; cv=none; b=jtDrCgHPFAgtwwzkZX2EEYmE5igdx9rXC/5wdp/NoIzynpfRSVs46zrsycRPsyHhgR9/BlvbW17dICY/gEQeRWSPqC9S7/wbB5oWb+si/bQtPZ8tvB3gxYLH7lOB6EvyBk5HONaCUIjKpInWrrfbZxZOlXkcz2MW/USUtzLphQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405948; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=FYbarnVaoj0AI+1ghtN22opqwfH5W9w3Kl6LUXl2jm4yKIduMVEa9pvNOzilm5hfriCUFBOAAhB1IN85bCqsflLTJDMXugDN3oAPczAYnKHm9k67Jy+WM3qWSpQu9qvi086l9cz3XcgaOXDrKlJEQylBh5WXNQlbMm2G/EenTIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=NTkdkP8w; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728405942; x=1729010742; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NTkdkP8wN/XOzv5BES6jlboRftYZoxvaBxCuTLcl54r2/k5DfaIQcMuq6Ly5AVe3
	 2KNhgPAj8oif2jBS0VxwINeZIP7rSPkHStQawtFdR3CYkHvU70Steg3jMLFWMvthc
	 jx1wqJsIYeeoSPo8JUEk+JETF2fbNGHR/e/G4vyWg5hUQCGz5TmfSnOjubxzRoQ+7
	 xoNUMVWSMpifYK4gYB6c1mErpny+rJDXtcvhue0QMXFRoLIFRxCeR3o/8OJ2VEGPu
	 TuYZfdveGp8fEQN1tbTzeMpp5oh6kxqqgCVsx00Dqfc9MkeEh8StJYxH529Z6nGQR
	 I8IUn/aJ1jXT+GNeTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.178]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBUmD-1t8MsT2Jvb-00GwO6; Tue, 08
 Oct 2024 18:45:42 +0200
Message-ID: <2b637494-5b50-4b6a-8c7c-087f3e16e277@gmx.de>
Date: Tue, 8 Oct 2024 18:45:42 +0200
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
Subject: Re: [PATCH 6.11 000/558] 6.11.3-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PDDq/KyNFE4hhMBB/bV5YQtJvRi/iHWCDZnQQWMKt97WsrDtfg9
 Q2jRsNzSEg6rOvvH/W3CSwnNCr/sUaCDDL7kGlXlDWryPAe4+bBqIgowTyIcMeGiOc5bkyU
 pvwTZ2KPvG/4vZRutT3bMDLPVTybLzbCJI3pPus//zk6bvQMOYya3pTN1qXT6IgTGta6Ql2
 WA4hJrNkAN0QKaddkF/CA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2WlQa3U/Kys=;ZMsVNWDEw+jke+vFvAAhi9EunCs
 gGyPy7eB9wZF4yiVurp7AHWp2c4KTHEBZpA5IG6JoRO+CqJUZjUXDu/9V5cq8zmDTkV+HosKX
 ZPSI2Ar0284+GXKgaKCITyo3nTwXE44RXZUjE7Xw3yWBIruK/wy54NPc/QkQoLdOeca84T8v1
 L6WAIF2svXTsjaYrvHcLIyVzP9se3qDOrz3s3sOwgF0aY4SmrjmkHR4UPSKjqC97lvfqp9aJk
 62QhbISMBA7Vx7lD8oIO+LC0/Rq+DECrw3xG8mhT9mjBpjbCn+QcQn3xFecbjEyX+pFlkvKe3
 A1oqLicjiKPubm01nIXJskLTaql6xHg4+LkpjgToiw1iRmwnP5NcaE9Vtvf/q8nVEAysdBZMt
 mBL7MWNr293X7M9k6fAYNqWHLRf58bol+Vgn2YiadFLJq5KSZavK6nNP+mex6pmWt+jc2MWes
 HbwLaskPYbVspVZJCSYNP7Q3ePxDL/885ossBGZkagrcmB/Ody6u4kEu3s8t/6JAgZNghMgod
 pmTFiQBY6lZU5YNm5P1iIXzb+qYmBoarWdK+ZI3W8qyJwOFfe/J7vBIuUsP8h9di2tVFt5d+b
 sMV4QbgHrvewGxNkW7vcqLmljZm4D2HvHbNrZtDB6RqK0wnMtKMn/qV0cCAsoKW+LI0w/0ALM
 QXZaZXKTtcvJZdK+jUyogPgz5s2JpIRGzVp7E/7taz+6g4cOIRD14zz0ml9TIiUp2KaLkMATw
 jC0QS2rqeEiNJKMFohYrqPisSqyWQaQpHFhOS6m1IzYhr++6VL3yURLqykxsimDdSAWy00wZr
 w/p01xfvexgl7yjwfkVdDkQw==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

