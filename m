Return-Path: <stable+bounces-47557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B658D1729
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 11:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387871F2453D
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 09:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737E8142E7B;
	Tue, 28 May 2024 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kk7FMs2e"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D4E3F9CC
	for <stable@vger.kernel.org>; Tue, 28 May 2024 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887923; cv=none; b=Vy8NMndjFZLITTkg/CWjz87o85Vrha0JEg4FXZfQPX7UL0RmFfI6yLITJu+IPrK8bb4D/O2C7iVR+YBlWR9X78yNyPqKT1uuINPWPqcoYTddYqu7y+RxaxRduHs9WZzbxKzCK8bWErTyFciAer+dSmHBX+hEYDqBoxKSO9vPskU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887923; c=relaxed/simple;
	bh=2F/mo2WDzaQW6C2ZAM3/M+Fb/tJqcO0PUGS4DUgpA4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERJyuowBLPrap0hYfLq9abH6XIUJMxexfgAW4fyJfIHxUr40J+jjJ6HsamOGrJXW5m7k8Xmke1qLfIxfcjPj0gkY7BwdAg18XH+/gxp8pwg/Wb0WXKNvmbzghRykOrX1ALZq3O2lZBxDLDct1miAvvYKAm0TA2q7tJw1eWbsc8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kk7FMs2e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716887919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SF2VHywssduunP+Z6gsdQkqjFggocJO3TA5NC7P5wKE=;
	b=Kk7FMs2eegKEC63NabUHMZhoAgYfLnj9Etgr7QrDcm9WdNp79Pth+1SS+HaoPeHEW7MkIe
	5ETuWTuiFuqdLKsfaEep5OrRpBgjDw4o/pXed5uNHjVJYt/vOBT+BSBRS0BAAPt2rkeZCi
	SEXDF0+QIWIx4UMLpiyAhLc4xc8Q3JI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-s57wUi4qOM6ElkWW8y4R_w-1; Tue,
 28 May 2024 05:18:35 -0400
X-MC-Unique: s57wUi4qOM6ElkWW8y4R_w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51F4829AA382;
	Tue, 28 May 2024 09:18:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.5])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C59032026D68;
	Tue, 28 May 2024 09:18:32 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: yongqin.liu@linaro.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	inventor500@vivaldi.net,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: usb: ax88179_178a: fix link status when link is set to down/up
Date: Tue, 28 May 2024 11:18:30 +0200
Message-ID: <20240528091831.13674-1-jtornosm@redhat.com>
In-Reply-To: <CAMSo37UyC-JRfZjd83Vx2+W-K-WqxAN9sHJ88Jev67Fnwci_pg@mail.gmail.com>
References: <CAMSo37UyC-JRfZjd83Vx2+W-K-WqxAN9sHJ88Jev67Fnwci_pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Hello Yongqin,

> When I tried the down and up operations manually from the command line,
> it worked.
> But it only worked after I ran the down and up operations after the boot.
> It fails to work by default after the boot for both the fresh deployment,
> and for the later reboot
Ok, so it works as well for you after the initialization.

> One thing I noticed is that the following message was printed twice
>     "ax88179_178a 2-3:1.0 eth0: ax88179 - Link status is: 1"
> after I ran the up operation,
>
> Is that expected?
> 
> For details, please check the log here:
> https://gist.github.com/liuyq/be8f5305d538067a344001f1d35f677b
That is another thing that I am analyzing, to clean those spurious.
But they are appearing in my case too, and I am not modifying anything at
boot time.

> The scripts are simple, here are the two scripts for Android build:
>    https://android.googlesource.com/device/linaro/dragonboard/+/refs/heads/main/shared/utils/ethaddr/ethaddr.rc
>    https://android.googlesource.com/device/linaro/dragonboard/+/refs/heads/main/shared/utils/ethaddr/set_ethaddr.sh
>
> Is the one to run the down/change mac/up operations script.
>
> Not sure why the up in the script does not work, but works when run manually.
Ok, I am not working with Android but it doesn't seem spscial, the only
doubt is when the script is executed, if the driver initialization is
complete, ...
Anyway, I will try to reproduce here and analyze it.

Best regards
José Ignacio


