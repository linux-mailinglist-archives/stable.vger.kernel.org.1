Return-Path: <stable+bounces-43519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456598C1DEE
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 08:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C64AB2116A
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 06:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40D11527A0;
	Fri, 10 May 2024 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekicQmn3"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06209153BE2
	for <stable@vger.kernel.org>; Fri, 10 May 2024 06:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715321615; cv=none; b=cTkWBwFtuIER9wVEcu39DLMCUE0ygEu64GnxS3WF6fb5Ad8f/A8WL2462zREj7PPOqKOnkQpNbotmQoqAIw3NXXYYuECMMsNWSTX+MyrsATNTiiDyB/CT6bI4ymVrlA1kS8QpxCq/P1KMqYvj+5Vd+/lo/6k9nj2vDRlYcb7IGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715321615; c=relaxed/simple;
	bh=kzukn/78bSXY5Dhhy5AMZbJ50Gz3t4CkRwtDVGuL+mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNPwuZfGXpxGMTkCPAXrENYMi08ROiVlpkCOh7NYQxeAUXBpO7T3wsDkgr0NaaLn7JhIQuN6iTFsLsyVlOWlnmUEnxkg/3fP3osYqd91ZkHbzerttYzUIv4ZSf4OtmKmdMzT0k9qWuDRxnezOEJYnDUle4Hd8jxJcQFQZpaNC8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ekicQmn3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715321612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kzukn/78bSXY5Dhhy5AMZbJ50Gz3t4CkRwtDVGuL+mQ=;
	b=ekicQmn3VX1RWLJJt64kY4AgaEh864kY6S0gY+FDpcliu5gYriA035u/YbHkxXGs8QTrjF
	lFXYodSzDBuqmNicXl/k1764S8/OBDt+UJUbp/Xny/wRam0EkVgNZ4B/XN72uuoi5FVPeR
	esNhGutswwEDUk3JuICqovzTlHrGhnQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-Xn8wAd2VPgKC4kJP3uTGqQ-1; Fri, 10 May 2024 02:08:31 -0400
X-MC-Unique: Xn8wAd2VPgKC4kJP3uTGqQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91B2081227E;
	Fri, 10 May 2024 06:08:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.109])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 731E81002048;
	Fri, 10 May 2024 06:08:27 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jefferymiller@google.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	inventor500@vivaldi.net,
	jarkko.palviainen@gmail.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH v2] net: usb: ax88179_178a: avoid writing the mac address before first reading
Date: Fri, 10 May 2024 08:08:24 +0200
Message-ID: <20240510060826.44673-1-jtornosm@redhat.com>
In-Reply-To: <CAAzPG9M+KNowPwkoYo+QftrN3u6zdN1cWq0XMvgS8UBEmWt+0g@mail.gmail.com>
References: <CAAzPG9M+KNowPwkoYo+QftrN3u6zdN1cWq0XMvgS8UBEmWt+0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Hello Jeffery,

Sorry for the inconveniences.

I am working on it, the fix will be very soon.

Best regards
José Ignacio


