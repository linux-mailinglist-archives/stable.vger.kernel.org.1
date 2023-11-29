Return-Path: <stable+bounces-3125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4AC7FD068
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 09:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F88282274
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 08:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1355D1173A;
	Wed, 29 Nov 2023 08:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbXPJc6y"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDBC10F0
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 00:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701245484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3TpNdnOe4L/8E2ZYsFFxMsmTtg8QSbXt5NgPNPOgE34=;
	b=RbXPJc6yP0DVdJ5BRC6V8oSdyqtZCw42E/Gdma0il0AG3OeVZek7+wdIJwVMiUOBqUwQXQ
	4YmHPsiDtZeXwbhogdXPYVED0lODPXS5pxpkjF7VRmSdQwF30yWkQUnapel+1W7nFGw1Ao
	vf1SeyHL7FagI28FpMBNbvq2J+9DZZI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-YJMkMR_vNOybQcjc5jCibQ-1; Wed, 29 Nov 2023 03:11:19 -0500
X-MC-Unique: YJMkMR_vNOybQcjc5jCibQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48F58185A781;
	Wed, 29 Nov 2023 08:11:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.14])
	by smtp.corp.redhat.com (Postfix) with SMTP id 56C6C492BFA;
	Wed, 29 Nov 2023 08:11:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 29 Nov 2023 09:10:13 +0100 (CET)
Date: Wed, 29 Nov 2023 09:10:09 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andrew Morton <akpm@linux-foundation.org>, casper.li@mediatek.com,
	chinwen.chang@mediatek.com, qun-wei.lin@mediatek.com,
	linux-mm@kvack.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/3] scripts/gdb/tasks: Fix lx-ps command error
Message-ID: <20231129081009.GF22743@redhat.com>
References: <20231129065142.13375-1-Kuan-Ying.Lee@mediatek.com>
 <20231129065142.13375-2-Kuan-Ying.Lee@mediatek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129065142.13375-2-Kuan-Ying.Lee@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 11/29, Kuan-Ying Lee wrote:
>
> Since commit 8e1f385104ac ("kill task_struct->thread_group") remove
> the thread_group, we will encounter below issue.
>
> (gdb) lx-ps
>       TASK          PID    COMM
> 0xffff800086503340   0   swapper/0
> Python Exception <class 'gdb.error'>: There is no member named thread_group.
> Error occurred in Python: There is no member named thread_group.
>
> We use signal->thread_head to iterate all threads instead.

Thanks again,

Acked-by: Oleg Nesterov <oleg@redhat.com>


> Fixes: 8e1f385104ac ("kill task_struct->thread_group")
> Cc: stable@vger.kernel.org

Is it possible to merge this simple change before v6.7 ?
Then "cc: stable" can be removed.

Oleg.


