Return-Path: <stable+bounces-50332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E52905C80
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 22:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6771C21775
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 20:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD4E52F62;
	Wed, 12 Jun 2024 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="IaMH4Jce"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678075025E
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 20:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718222684; cv=none; b=LZ66OZ4x9H0KT8O7riBU3qelJeC2waSeoetiXLppejos5Ftymxt/VK1hsKeT2F9MOEO9uYAyLF6z4D127o5y1rG9sBSSC87pCSRZbCeMAD1p3IEbvkhqaxFaBpA5V9hFa6FYrOJYwYI2yjEwUeu3N4O5tlG4xN5XcKLwMC6pbgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718222684; c=relaxed/simple;
	bh=5C6E8Y9SDchcIWwSmH36JEqE6WSYVVh9PjV5yurQ6WA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tNWDfMboQpoven+JzVpCDY7w/h35OSEzlKdnc80XSiCjdGRdy97OQOv4Cy7Y+NJlWTyK1pI5ljyvQB3Sd9y13p02ZFoB2RF46BcA/2ktAgp7HQiU0F9fVFaKlRqCYhjdBegYoNskL1r8RpfU7nlPhoEK2W8HdWSGoXyqQy126/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=IaMH4Jce; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id HTd8sVoWNSLKxHUCxsLm70; Wed, 12 Jun 2024 20:04:35 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id HUCxsARxqT4CbHUCxsG8e1; Wed, 12 Jun 2024 20:04:35 +0000
X-Authority-Analysis: v=2.4 cv=DPKJ4TNb c=1 sm=1 tr=0 ts=6669ff53
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=wYkD_t78qR0A:10 a=xGRsDScCAAAA:8
 a=pKTFDrzG_x3V9sfl7PQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zEVfNvAIcUWeczMkmY0T:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/QPeIjovkvV/E5oIolQo/mIlJ+pmqKXHutHu0+C0FVs=; b=IaMH4JcelzjtzZ8l052lUZoo73
	sI8xPNQtYOTq4SBbq7wbYV19M4bbN7/tIy0GGJ0daZKbJwwMBPgru1JOSJbZkKTTDHj0JkGj6CfDt
	hvpFYVQwNVSs+gUb3q2uK4cvQYtAxfknNNRP9/IGljJQJwQvF18bbmwdWdjPF3qHJVBySzDRqbMmP
	R/PTadZMsEQNP/1lFtMBtB/gWcW0n3l7fL+kWu3KgjClJyS963c82KeIRgpmL91Iheiihvd02mP7k
	A+x5MhXqNQVGRaXeDMCx8FkrVQayyvm0QZwzu0xmSKR1RFVQEvDn4K4AjQMI/Pc+P6Ek/OvMUyUID
	m04LJ4DQ==;
Received: from [201.172.173.139] (port=40652 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sHUCv-004Bhn-0e;
	Wed, 12 Jun 2024 15:04:33 -0500
Message-ID: <c80e41e6-793e-4311-8e15-f5eda91e723e@embeddedor.com>
Date: Wed, 12 Jun 2024 14:04:31 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: mxser: Remove __counted_by from mxser_board.ports[]
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Jiri Slaby <jirislaby@kernel.org>, Bill Wendling <morbo@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Justin Stitt <justinstitt@google.com>, linux-serial@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
 patches@lists.linux.dev, stable@vger.kernel.org
References: <20240529-drop-counted-by-ports-mxser-board-v1-1-0ab217f4da6d@kernel.org>
 <d7c19866-6883-4f98-b178-a5ccf8726895@kernel.org>
 <2024053008-sadly-skydiver-92be@gregkh>
 <09445a96-4f86-4d34-9984-4769bd6f4bc1@embeddedor.com>
 <68293959-9141-4184-a436-ea67efa9aa7c@kernel.org>
 <6170ad64-ee1c-4049-97d3-33ce26b4b715@kernel.org>
 <CAGG=3QU6kREyhAoRC+68UFX4txAKK-qK-HNvgzeqphj5-1te_g@mail.gmail.com>
 <bee7240b-d143-4613-bde4-822d9c598834@embeddedor.com>
 <1313c7a5-d074-4a8f-9ab9-07e4a7716fb9@kernel.org>
 <4da5ba72-6dff-46f1-b596-158c62b34f18@embeddedor.com>
Content-Language: en-US
In-Reply-To: <4da5ba72-6dff-46f1-b596-158c62b34f18@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sHUCv-004Bhn-0e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.139]:40652
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfH+uCIV0/3nPjC/9xHXipxvtJyphbPo2xcz4ycSsGACjm/20Ums9bjZdsGTRpHun7R353dV+tflGfYVblViP3nnP3iWig+HjT22AbPewb93kZNQwfT0I
 /AnXkn2c1jSbwWbvRmx+elq3ughyh354N9lI+YA7dK5fYFdkM+ySVkkTrk7eXjnl+Fw5Prj29V7wb8MFMaqKHmeOyjZWrStXXto=



On 6/3/24 02:26, Gustavo A. R. Silva wrote:
> 
>> FWIW undoing:
>> commit 7391ee16950e772076d321792d9fbf030f921345
>> Author: Peter Hurley <peter@hurleysoftware.com>
>> Date:   Sat Jun 15 09:36:07 2013 -0400
>>
>>      tty: Simplify flip buffer list with 0-sized sentinel
>>
>>
>> would do the job, IMO.
> 
> So, not even _sentinel_ is actually needed? Awesome!
> 

It seems that a clean revert is not possible at this point, as
the original patch is more than a decade old. If _sentinel_ is
not needed, and based on the original patch, would the following
suffice?

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 79f0ff94ce00..1b77019cc510 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -135,10 +135,7 @@ void tty_buffer_free_all(struct tty_port *port)
         llist_for_each_entry_safe(p, next, llist, free)
                 kfree(p);

-       tty_buffer_reset(&buf->sentinel, 0);
-       buf->head = &buf->sentinel;
-       buf->tail = &buf->sentinel;
-
+       buf->tail = NULL;
         still_used = atomic_xchg(&buf->mem_used, 0);
         WARN(still_used != freed, "we still have not freed %d bytes!",
                         still_used - freed);
@@ -578,9 +575,8 @@ void tty_buffer_init(struct tty_port *port)
         struct tty_bufhead *buf = &port->buf;

         mutex_init(&buf->lock);
-       tty_buffer_reset(&buf->sentinel, 0);
-       buf->head = &buf->sentinel;
-       buf->tail = &buf->sentinel;
+       buf->head = NULL;
+       buf->tail = NULL;
         init_llist_head(&buf->free);
         atomic_set(&buf->mem_used, 0);
         atomic_set(&buf->priority, 0);
diff --git a/include/linux/tty_buffer.h b/include/linux/tty_buffer.h
index 31125e3be3c5..75fb041e43fe 100644
--- a/include/linux/tty_buffer.h
+++ b/include/linux/tty_buffer.h
@@ -37,7 +37,6 @@ struct tty_bufhead {
         struct work_struct work;
         struct mutex       lock;
         atomic_t           priority;
-       struct tty_buffer sentinel;
         struct llist_head free;         /* Free queue head */
         atomic_t           mem_used;    /* In-use buffers excluding free list */
         int                mem_limit;

Thanks
--
Gustavo

