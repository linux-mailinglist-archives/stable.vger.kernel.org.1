Return-Path: <stable+bounces-240435-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wADyOHfQ6Wm9kgIAu9opvQ
	(envelope-from <stable+bounces-240435-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 09:55:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3413544E370
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 09:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A11773013AAA
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 07:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4199333A9CF;
	Thu, 23 Apr 2026 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J24/qVdm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="no6V8h97"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E3E2FA0C7
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 07:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930930; cv=none; b=iFPnLkh3y4b25iRdMBcMPboXzUoFd+b6F3YvtzkhePteot38aNtviGUXOJ6XkfYrTjI16uStQhHaZqv7CFXmES7uLrfes1MmceL8sZ9GiJ5LsdAF1OulQ/PdhvPIoKIyYeO3smefVA1/+/wmVxsXMJqqqw8BFi49h0wQQCa2XK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930930; c=relaxed/simple;
	bh=L2WN3Mdkt+PLvtN1w07nhMKHoYH38g1usozRivR3K9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ri4VXiMhKCoWHQhlww14d6y9S49kBX6peXf4RZyGwz65aMvHMCvgQHvMLQgNdh/eaoeStbqKcunFVEX0leqSrKg4eFNgRSYpFLcdM6qIMjoMklSJrpxwqayT/FQHMbD5yoas21X393RsM5BpqwvnvP7vnBrXXSgGUXt6u/zcA9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J24/qVdm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=no6V8h97; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776930927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kw0NWAnxiHM/StsVSGBC26LNQSa2ifdysLtA6b6dLbI=;
	b=J24/qVdmEajfwEEUTsN1YuwK1PjS/DGwTjnZMHaVJZqALULG8XkYk/nERa+F4ayy7faGZ1
	IXv35KoItE2TCNsE4+EGGPkev7+wM3RoJ2zLtxJqVU6Bz+WNDmPU62pg5ogpZkiqbX9E5q
	95w1VkvQeKZymTqR5S0ewKevymhfE1k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-5ofM-tlXOqa2gga9WdhhTQ-1; Thu, 23 Apr 2026 03:55:26 -0400
X-MC-Unique: 5ofM-tlXOqa2gga9WdhhTQ-1
X-Mimecast-MFC-AGG-ID: 5ofM-tlXOqa2gga9WdhhTQ_1776930925
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-440d12a472eso3599198f8f.3
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 00:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776930925; x=1777535725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kw0NWAnxiHM/StsVSGBC26LNQSa2ifdysLtA6b6dLbI=;
        b=no6V8h97ykgC6cpJgVuBQ/LRCYpO3tCbV/JSThKrn0vmzG6RWFJ9nmN8vP9Ma4LUvO
         q12PgayYwC/MJAY8xE6rWNIzmKcXBt0fL6TtR2r/YeEtyO4P3w9lb49fxNWqxw5llugj
         0K3fo8uJ4vL5ndRznkJII771++DWXv4GUQwVtZNHY/z3o5w9WIXOfug1EH44GSr9TT+Z
         m5q3+4CxI7jLJkggcLp2lkQ2xWTbkvMpDg1r4qIVALZhUe0HS4UD6+GkhwwKD1mm5xsr
         99uDof/2Fhve5z44DPsitcqqp7hFXBHPCIRNJp503T2aVF48D9dN+t4YUFoAeBk1g79n
         O7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776930925; x=1777535725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kw0NWAnxiHM/StsVSGBC26LNQSa2ifdysLtA6b6dLbI=;
        b=B0ZtLOFCVRZuIbiq4Zvc/HDDyhVK65z7HJGNMEQ3UTuhGecdvyO2RqJpMPPF5qXogk
         lTSg9WbsaEscv3IqDdlryIYYQGFbHpi7oHPGowff8I0loPML0nfMQ41aK9cd8nZKjJwe
         ef5lQdmSOS4Y6HdEX50+5ug26SYkX7xa2oU6DQ3aSduX2MnU9DuCCoZBjikR2HdfUzM7
         XnFYBpYNUus9wXJmBbLXaQwqfP8VgKW9xw5j9DQsIycblCiOm2/JW9y5cPDXTN5XWehX
         omKBAXkDXPR3x6V7XxhVVtMvBOuHbqn4xKGDcy5Cg6co7tuePOc3hfWUL6wz+7D1Q0Z3
         4uMQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4vsVk6U9R+Iwl5i4eIhaBN7mvgyKeL1Cyf86koaPru0KqB0Nk2CpjWR5fl5rMFO8qvnaNI/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjVcT0nmzvHHBUxmq3XIJLidTZrpoNErvFBWrE9f1xugGX6LwV
	Yol8pBnH7EsGoz+Q8UcqWym5EW2vjphjxEqZ5m7xJF4xoo88OmUhMdmMpAbSrDlKc8x7AXuL3Ku
	Pv33bfD/o2oUnCM+FkM2NWq6WCwUxddOKmMf0xMnsx7OY3SlBDAJSNJc2CQ==
X-Gm-Gg: AeBDieu/y+2kefEA+ZR9EIbTPPjl+cuUXjkhgKJi+uclYHZGToOVP7OsPEjRoGZd5ls
	TzEbvDQoANCA9Glyy4k9NZZ11gAe0AnT30WE01AorelLzVBUwNs1C7LFJPw1phnp2o/czbUPq3f
	4Sgh0grgZi9YUzdYfMkmOgDhd1U8csoNNPdp4JPZ2BkUUGXIO73IONG5ErjPtX8AYsdRGRri74l
	cOcfHhOq1+F8fhWuFzYuH6w199r5t9M+LoA/GiXlXwrRDzuTlp+Twacghxp5NnwqNKx5BO93pEf
	30p214/5MeB/aELO8mgOmSQ5+rrf5hDZJe2FZz5q581dzLTS8/kUEaQKkMmjAUtPqN+WjIOMybY
	U1SRySyGyapB2keeJus0OTr14YoWojazga7G0krvzITA3h5yD/GQ9KGAgW9yOXcFrvvYcG6hzgR
	R0cMxImw==
X-Received: by 2002:a05:6000:610:b0:43d:1c21:ead5 with SMTP id ffacd0b85a97d-43fe3e0b4d8mr40520278f8f.22.1776930925156;
        Thu, 23 Apr 2026 00:55:25 -0700 (PDT)
X-Received: by 2002:a05:6000:610:b0:43d:1c21:ead5 with SMTP id ffacd0b85a97d-43fe3e0b4d8mr40520207f8f.22.1776930924637;
        Thu, 23 Apr 2026 00:55:24 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412e36ff8bsm2933844f8f.26.2026.04.23.00.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 00:55:23 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:55:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	longli@microsoft.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, niuxuewei.nxw@antgroup.com, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] hv_sock: Return -EIO for malformed/short packets
Message-ID: <aenQQpYW6j0BoC69@sgarzare-redhat>
References: <20260423064811.1371749-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260423064811.1371749-1-decui@microsoft.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240435-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3413544E370
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 11:48:11PM -0700, Dexuan Cui wrote:
>Commit f63152958994 fixes a regression, however it fails to report an
>error for malformed/short packets -- normally we should never see such
>packets, but let's report an error for them just in case.
>
>Fixes: f63152958994 ("hv_sock: Report EOF instead of -EIO for FIN")
>Cc: stable@vger.kernel.org
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>---
>
>Commit f63152958994 is currently only in net.git's master branch.
>
>Changes since v1:
>    Integrated comments from Stefano Garzarella:
>
>        1) access 'vsk' directly:
>           s/hvs->vsk->peer_shutdown/vsk->peer_shutdown/
>
>        2) test the error condition first and return -EIO for that.
>
>    NO other changes.

Thanks, LGTM!

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


