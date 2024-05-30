Return-Path: <stable+bounces-47715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD8C8D4D9F
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 16:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46E0BB21BB2
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D077F186E5C;
	Thu, 30 May 2024 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eongPoxL"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361D8186E4C
	for <stable@vger.kernel.org>; Thu, 30 May 2024 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717078391; cv=none; b=LWp0ccMSwDnY+fFn8UXRU83ouBqb3atpS7ApEvqtLlPm8ks3KEWuoWQ2XG5H4WnWH3RjzZDU5IFWVWbn2t0L0gxC/jgse4l5fQdvcDuanX6OoWgjGr5bFKal1GsOCckK8pcvMM9WjM13U2LykG0o4LYsqrPqzea1/7geASGz4VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717078391; c=relaxed/simple;
	bh=r5a0FVlFB8dVilFIOOoYFbQUjONqa/y/kOAP8TysiEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2WgnrgLTFaDcG8scMfXgoHFXtPgJb8uNqOpvK8pVfsD8cOWE+gFrW+30mDNCyn5HbIdEDA6k0o7yNfCri4YsGhK8YvO14iM5sz6K/F8uLhY5itAad2cB+MbTXWF/lpCZdvYSM3gPrnejHuXwxDf2cB5RHJbVcA7+D0hoowvVgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eongPoxL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717078389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r5a0FVlFB8dVilFIOOoYFbQUjONqa/y/kOAP8TysiEk=;
	b=eongPoxL/WtJSJIruIZrUtEvzGkd/JKjV9Ya65/liJsZmfVw8yHwVI3dPMLRDbADh953NZ
	OOaTjmk7gWldrs7UEAzUIFNk7+SenHuYjLV29Z4ERuQ4xBmxCFtR9Nwf5qgOn6VbOC2/8m
	2RJA4gpLloyd/fUSN8PeGfAKWsbr5xc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-obrYYhtqPWON3sCjan7oEA-1; Thu, 30 May 2024 10:13:06 -0400
X-MC-Unique: obrYYhtqPWON3sCjan7oEA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D47C0800CA5;
	Thu, 30 May 2024 14:13:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.98])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 78FAA40C6CB2;
	Thu, 30 May 2024 14:13:02 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: yongqin.liu@linaro.org
Cc: amit.pundir@linaro.org,
	davem@davemloft.net,
	edumazet@google.com,
	inventor500@vivaldi.net,
	jstultz@google.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	sumit.semwal@linaro.org
Subject: Re: [PATCH] net: usb: ax88179_178a: fix link status when link is set to down/up
Date: Thu, 30 May 2024 16:13:00 +0200
Message-ID: <20240530141301.434601-1-jtornosm@redhat.com>
In-Reply-To: <CAMSo37U3Pree8XbHNBOzNXhFAiPss+8FQms1bLy06xeMeWfTcg@mail.gmail.com>
References: <CAMSo37U3Pree8XbHNBOzNXhFAiPss+8FQms1bLy06xeMeWfTcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Hello Yongqin,

> is there any message that I could check to make sure if the
> initialization is finished?
> or like with adding some printk lines for some kernel functions to hack
>
>> Anyway, I will try to reproduce here and analyze it.
>
> Thanks very much! And please feel free to let me know if there is
> anything I could help with on the Android build.

I have finally managed to reproduce an error similar to the one mentioned
during the boot stage. I created a systemd service with a similar
configuration script to do the same and it works (I can reconfigure the
mac address at boot time, the ip address is configured and the interface
works), because the driver is completely initialized. In order to reproduce,
I have introduced a big delay in the probe operation to get closer in time
to the configuration script and the problem is there.
Maybe, the script set_ethaddr.sh could be synchronized with the driver, but
I think, if possible, it is better to check in a better way in the driver;
I will try it. When I have something I can comment you, if you can test it,
to be sure about the solution.

By the way, I have tried with my other fix to avoid the spurious link
messages, but it didn't help.

Best regards
José Ignacio


