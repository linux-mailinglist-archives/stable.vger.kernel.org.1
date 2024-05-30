Return-Path: <stable+bounces-47697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 009148D492C
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 12:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769311F21808
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 10:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126911761A8;
	Thu, 30 May 2024 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ZjIUBXRA"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3F16F2E6;
	Thu, 30 May 2024 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717063364; cv=none; b=ts8ZF4moggt/QNrdmhx6PB4g5cvpKq8DSOz+41N/WsZgCsjRt1P9kvBmA03LQ7+9Py0fBl47LeKrzgAcEvLCCSJhVNEL/AxUPEoGxdTQKwhGjsBKwepaTU7INxkdP9dW3/Roeq+kh7ly6YqOyOl65q4MadzPJ+EWbhwF7IiiV60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717063364; c=relaxed/simple;
	bh=DKCn8idYu1vHktXieRhr32FGpakQmNwEfEL37/FE5Dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtv9m2gQFDE0Zn5n4WzyknaXS01/g72HbKW8C19MlJ/xbAFNPjb5B+CYMrj3DlONpzj7wv7aycFgOu2rd3gEAFGIgsdJ+YAfZ3czWxTsBHdOftZOwHJic2SfgTB4r2egbMfPa3VJuDGGUisUL1BlFQSt4OavDy284tCYXSUpQEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=ZjIUBXRA; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id BwXEs3PqZrtmgCccHsOo2o; Thu, 30 May 2024 10:02:37 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id CccFssunGqVixCccFsnraZ; Thu, 30 May 2024 10:02:36 +0000
X-Authority-Analysis: v=2.4 cv=KfzUsxYD c=1 sm=1 tr=0 ts=66584ebc
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=7eglLlv4HFOW3sTsDH6Jqg==:17
 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=wYkD_t78qR0A:10
 a=wEqYQv3dOdCw8QfXo94A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DKCn8idYu1vHktXieRhr32FGpakQmNwEfEL37/FE5Dk=; b=ZjIUBXRAbxd7YuFLrFymQGWgFR
	sCftGX6RPmhqmQ802FhA/OqnkVQ3j5onKBoXDVrjjGoiokYc+NInfGOOrfnG347/h/5+2qvh+ZnKO
	2uYPFMtx1Hcr084hltyAFuCh0A9EociAjt/XPJKozBnCmUajGHTq7LgHG+E4OMxOR1ohv4xUA4xK4
	sITPubykCzD9qfb3dEC5NjZdimmJ5hT7VOkoIAbb8jJKsnMoSx8Cnw4GCntCERzrIWcevOvKTcRqx
	C9pgrXqs/XO1tKj2y6m1YWkoqDFpkI6+EjDXd64BD2uoPZDxG6400uH5ObK+iFHgy4il8V/0iL8Kc
	Aei7+frA==;
Received: from d58c58c2.rev.dansknet.dk ([213.140.88.194]:38378 helo=[10.0.0.182])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sCbMg-000tFs-1A;
	Thu, 30 May 2024 03:42:27 -0500
Message-ID: <0899cab2-2772-4001-98de-9bd2306442f2@embeddedor.com>
Date: Thu, 30 May 2024 10:42:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: mxser: Remove __counted_by from mxser_board.ports[]
To: Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-serial@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev, patches@lists.linux.dev, stable@vger.kernel.org
References: <20240529-drop-counted-by-ports-mxser-board-v1-1-0ab217f4da6d@kernel.org>
 <d7c19866-6883-4f98-b178-a5ccf8726895@kernel.org>
 <2024053008-sadly-skydiver-92be@gregkh>
 <09445a96-4f86-4d34-9984-4769bd6f4bc1@embeddedor.com>
 <68293959-9141-4184-a436-ea67efa9aa7c@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <68293959-9141-4184-a436-ea67efa9aa7c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 213.140.88.194
X-Source-L: No
X-Exim-ID: 1sCbMg-000tFs-1A
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: d58c58c2.rev.dansknet.dk ([10.0.0.182]) [213.140.88.194]:38378
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFZjLDJIcgjkRVo6Xn3R/Zp1Q84Pejywswh7+guxve/gUCnOTUWxic9dIgvZOMLxodyiHKTm2UC4wvgUxue2VSTbPkEg0eCOIJjAeKJRqqCxR3w0YXDB
 kirOAwr+8fPgsV6M/roBOSQL2EVKZKd6bwIu2XdlUGXjWtg6VlZnu8/i8/2kzRh71F3kJEoYoYOghjuSuz3BvUzpNSLahu78rjIxuKc8BM3gejlGMLdHEwVr
 o9sFI6j16Q0jvqEDngPvLlNFYtCpmT9uVLlAMenX2xKOduXIp8wKpgrORD6SpJfa


> Ah, ok. The assumption is sentinel.data[] shall be unused.

This snippet is useful information.

Thanks
--
Gustavo

