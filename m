Return-Path: <stable+bounces-111699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C5BA2305F
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B927C1887B04
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F253C13B7A3;
	Thu, 30 Jan 2025 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="ot7SORaC"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544A31E9916;
	Thu, 30 Jan 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738247545; cv=none; b=rgxLvAd0/2AXIEnaWnurnTr2C0WiZUdUdJH05/KdPDAV6N6DKe6Vy9bi29FjQdT6+ewUiNOdn992WrWQKhy5XDdRCiEdMmQG3FHrV2Bv8GP8rGbhQzSWLbjnKZ6ovwZzsbWsIOK8EIuYZ7TWfMtTp5M6eNeRGdhzB3XFr6f4OtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738247545; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=UYmdsOjb5vlN5KOF8YwCspbIlCqJ4I4qLmobbxx/mUTtmBNVCyYKkPkstaahvM2Xsg5NXRJ1zrjVya3r/edcfz7mR5iEklUSTfr8OfXLJB3C4YwOTGgb3kP+RnF1tfs/2oAuWA+ybXwtNhwrvBMiGLBJe+lh4AiGX20ddRMSbN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=ot7SORaC; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1738247540; x=1738852340; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ot7SORaCNOGdC/HDo+R/rdoGnWyFpuRXMBUxHj8of+AeE6atChqvnMlMAdCMFO9B
	 tqwc4FyfkMegac/yzc78vw2yTqVYAougpXN9gzJ2mfZ6WpBSChhafy4dfFenBZAwi
	 hUlkksUQ9EyQZbOXeO+yb/ZGcJZmyZgeyG534G/CLdbpy1jXA3GHhfrFexWDL677r
	 KB6lTO9DRq4tlqf62KeeU3b6NxGM+w/uvwi40ZtbBADb/tHkxbviGoql4hINXy1AI
	 3/oL4wSGzUFJJSos6m2V7fCDzmAxgStNKw1Io85Z5/dBRGPFxdstrvRGvJUc89oEJ
	 5UyH0h0uxmTJKqFBnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.33.199]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYLa-1sxaCC3LUO-00pRHF; Thu, 30
 Jan 2025 15:32:20 +0100
Message-ID: <09ddd9ca-4b3f-4f42-9d44-67ff0b5467d5@gmx.de>
Date: Thu, 30 Jan 2025 15:32:20 +0100
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
Subject: Re: [PATCH 6.13 00/25] 6.13.1-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:w/UvebSVJhUFe/jMaL8hLmWysYMmrY0t1qlyvh/j69pz/yfasGz
 uTrxUPtvkxHGlwy3sspqsQxxnuBgZ3pOnt7kH5fdmI9VrTCgUZsGA5XgIKRSsznhCJQD3FY
 gRkUior+YNRt4jcgjIkoDtsQZ714xYplsDMdajtoWUoG56lwB5kzR7ssih6YvOMSuGRUk3s
 9laVj4Uq1D3xusik8Fiqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+4/GsMXmssQ=;wN8pOPwVLi75bXzhukJR+Hnx8bl
 LTBbj1rmDghJxXdpTAZYHwdpVzjNID42qBYLn5iI1XOboBLrJ8fXzJtfnZUbW1gIyLmIxBE/I
 T0QE4v5ZcDXYhSKxBrYJvGZaB8R9gbmDFA1PZcm5sq8KQYW6ldukt42lg6ULNBOyaNsBAmpbV
 i1UnQgtbXrhhOE0OcLDuWtQoXU+XdY7YtBkdTX0b4+UyvZ8FcWsd66Xkzwrj9xo7JsOKaAZ4Y
 qtu+mZVBKTvKieZkMMxi/tj8uxw5/RU4SnnzGKIVUV0aEcQV2NDBCpT7a9idjQfwqq0K7sYJh
 q/EdyeBhr8p3P1BH85w6VgkEQqhTht8XVsIpFMPd4NxHw1qGJlxrsnKWM1fA9H/NpoKPRv2ue
 89BrCXPj0ov0jzKlC8SsQn3B1fIdKK1dq/9l63iZuzXmXUrIoPHwIwUsDC+qM2Ub31LKFqUvb
 3ZtjJpZ2Pf/Lzu4A2LG5cu8tkh5rLc5sbz0YxAGy0O9XjBvOLmOpP7yXQ5zZfIoDTVm2HMiVe
 rn9TxS79Y/Cj69stbHyKHiuMl8tmpGACvOntzZ/5aPfuORgCsf0Q2pzk4sUrwkxyAVZLvGUqv
 DIyB2L6aHP4WRdb7l8ScuilK+Xjr92RxthBN6zkMRabI2hzXTosXFYk5AvXGva71qFjAmV4sJ
 GUgrJmPsvBDn7lxSZKIoUuBpZqQKsNonoFO4QVUlEtB27/h+Y76EELe0FWi580uT3ZY6/4R95
 3ILWDBnmGhtTUcmnFBAGyfV8yryC+n/snasempMi/lmUxYnNPg3/5nyVu9Kcvf8+b/MxRu5M1
 bP8f/Ybezw2C9h7FdDhqW7dmarNJnm+5fcJmILPRGr+RMc5d6hz6+v45wulA3/LEMr9YJvz+l
 dIHGuPvQO5tFWWiwbSQjpkjgZ5rDaU29h5rdh8snA9yNnnBLRmIeqAClKAUSlKXwojp6OUd1w
 XRUepsa5d/aFpA8o6elzxrIK/tWIq1Ag07YSNZhEFVcXJ5vBRm8OBUszU8XWeUICIDzyPWYvr
 ez7BLFjvo49XkrKvAc411y5FZznC5+TOkWQdH9ThNaGlLwrADtthutg5/yishP9Px7Wo2+EGX
 VhOGvRzqso3oRVfut7BXejsgflVo3IGGIICOPnK7wNZtO53bFDfL6mBy3xZkOXEzsFPL9h40p
 5iIA0wgP7m4CFfYwwWpQkzoSn4r3C8G30Es36TZCwKQ==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

