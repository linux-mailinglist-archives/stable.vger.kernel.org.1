Return-Path: <stable+bounces-43447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90CD8BF7CF
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 09:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787381F22395
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 07:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9490528383;
	Wed,  8 May 2024 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqXFG/CS"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A15F2C6B2
	for <stable@vger.kernel.org>; Wed,  8 May 2024 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155030; cv=none; b=QDp/3YluTyYPz9IK0bPO10cwo71iY3B4nchysGXkWLyqwE4J+HJx0lLN167iH9YOeEcIooPNdpGZhqKN9aQLmoXpBtcIX1+G/ggAfN7ZgEyWnKdqBiTzPPLjtLUQ9+XBR0+8Q/CUWWJ+acMlnzOLXFjRiE8EwtJulbYDXUxDM7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155030; c=relaxed/simple;
	bh=V/YjDIQfRp2l7miiRrx3Z5IZQokNP9VXtuvlvHRlYG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XrtqhQYYnrsK3AXpE4gfTJS8sTFbHPtsHqa5Y5HYaponh4IGxeV1f82sVj5UGHahhoDGtz5oRhMszdkvGzWdWawR6/4ELDRH/ANKzzkKoHZycQLx7IRr84G/DM1H1zLKiIPGUNCEmbdcMdja1+YmMb8Q94YMx6PjqVjn2ReS4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cqXFG/CS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715155027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/YjDIQfRp2l7miiRrx3Z5IZQokNP9VXtuvlvHRlYG4=;
	b=cqXFG/CSBD6LccPWyADlYMzefywOkN8TJ0DZaIqshtGBtCDHCc6eEVr124jPmVYiduEV3g
	WpIiznaCHZsGRUAUsQ0w5w6iGGgEvItACvBc8MiHYhzfY68B4zIqkmn1BYXANb7WGG2ph5
	nJq3D5xMnj6YuGDxjkJV7lca6Xmkvl4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-9zIbIx_RPi2zsftI5GvHzw-1; Wed, 08 May 2024 03:57:04 -0400
X-MC-Unique: 9zIbIx_RPi2zsftI5GvHzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DAAA800262;
	Wed,  8 May 2024 07:57:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.44])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E6CE57414;
	Wed,  8 May 2024 07:56:59 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: yongqin.liu@linaro.org
Cc: amit.pundir@linaro.org,
	davem@davemloft.net,
	edumazet@google.com,
	inventor500@vivaldi.net,
	jarkko.palviainen@gmail.com,
	jstultz@google.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	sumit.semwal@linaro.org,
	vadim.fedorenko@linux.dev,
	vmartensson@google.com
Subject: Re: [PATCH v2] net: usb: ax88179_178a: avoid writing the mac address before first reading
Date: Wed,  8 May 2024 09:56:54 +0200
Message-ID: <20240508075658.7164-1-jtornosm@redhat.com>
In-Reply-To: <CAMSo37UN11V8UeDM4cyD+iXyRR1Us53a00e34wTy+zP6vx935A@mail.gmail.com>
References: <CAMSo37UN11V8UeDM4cyD+iXyRR1Us53a00e34wTy+zP6vx935A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hello Yongqin,

Sorry for the inconveniences.

I don't have the db845c, could you provide information about the type of
device and protocol used?
Related driver logs would be very helpful for this.

Best regards
José Ignacio


