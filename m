Return-Path: <stable+bounces-2747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C329F7F9F3A
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 13:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005331C20D9D
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 12:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AEC1CF8D;
	Mon, 27 Nov 2023 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMYuadUz"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C244FE1
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 04:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701086669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KWNuo6JI/OYsTU4e3seiEKnPSTG4IX85SKhKR7+RBiE=;
	b=JMYuadUz3FqM4x0r1yXCsWhzdAdXzVjNY4D8D21nxlkFgznlkbNgajTXBZHlZvGN6hx4fu
	UX+cC7Ih6ap81m2cnCMq2KlbzkMm/BAagHOMbUDTgMWvEd12tPXCtCACc01pCtOw8Q6OKy
	b0TtIyOAoLCRg6zCeon9jp8NY1djnDI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-nDYczEEeP4yMToRKl1A7GQ-1; Mon, 27 Nov 2023 07:04:24 -0500
X-MC-Unique: nDYczEEeP4yMToRKl1A7GQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B767085C1A0;
	Mon, 27 Nov 2023 12:04:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.14])
	by smtp.corp.redhat.com (Postfix) with SMTP id 731645028;
	Mon, 27 Nov 2023 12:04:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 27 Nov 2023 13:03:18 +0100 (CET)
Date: Mon, 27 Nov 2023 13:03:14 +0100
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
Subject: Re: [PATCH 1/3] scripts/gdb/tasks: Fix lx-ps command error
Message-ID: <20231127120314.GA19669@redhat.com>
References: <20231127070404.4192-1-Kuan-Ying.Lee@mediatek.com>
 <20231127070404.4192-2-Kuan-Ying.Lee@mediatek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127070404.4192-2-Kuan-Ying.Lee@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 11/27, Kuan-Ying Lee wrote:
>
> @@ -25,13 +25,9 @@ def task_lists():
>      t = g = init_task
>  
>      while True:
> -        while True:
> -            yield t
> -
> -            t = utils.container_of(t['thread_group']['next'],
> -                                   task_ptr_type, "thread_group")
> -            if t == g:
> -                break
> +        thread_head = t['signal']['thread_head']
> +        for thread in lists.list_for_each_entry(thread_head, task_ptr_type, 'thread_node'):
> +            yield thread
>  
>          t = g = utils.container_of(g['tasks']['next'],
>                                     task_ptr_type, "tasks")

Thanks!

I do not know python, but it seems that with this patch we can kill g or t?
Can't

	def task_lists():
	    task_ptr_type = task_type.get_type().pointer()
	    init_task = gdb.parse_and_eval("init_task").address
	    t = init_task

	    while True:
		thread_head = t['signal']['thread_head']
		for thread in lists.list_for_each_entry(thread_head, task_ptr_type, 'thread_node'):
		    yield thread

		t = utils.container_of(t['tasks']['next'],
				       task_ptr_type, "tasks")
		if t == init_task:
		    return

work?

Oleg.


