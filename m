Return-Path: <stable+bounces-6811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B03218146F4
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 12:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5061F1F2116A
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 11:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402B41BDDC;
	Fri, 15 Dec 2023 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMdgPYn1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594DD250F3
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702639860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dcgfhD/ygPV8fKqWBjMohUKgj7tB52OmC7N7GcDXz/s=;
	b=PMdgPYn1hfJJxJxXhFG+NelHOjWbwU05+Sd7yPkArW28FM1z8RRhHq0kR1ym5+Reu/2uyd
	z2cnsy6nYkbvlekA1pBi8+SUw12UWvCkTEAjVEMHMYxK8gBENSB2G2CObQOn2+YD4eVWyi
	VsjTaI+rForO9tPgH98vrawD28lpkuI=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-KwUH4rMbMkWYMbqc3dz6sA-1; Fri, 15 Dec 2023 06:30:58 -0500
X-MC-Unique: KwUH4rMbMkWYMbqc3dz6sA-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7cade8197e7so154153241.1
        for <stable@vger.kernel.org>; Fri, 15 Dec 2023 03:30:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702639858; x=1703244658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcgfhD/ygPV8fKqWBjMohUKgj7tB52OmC7N7GcDXz/s=;
        b=SjZQOqeV5pbFrtdN5qwwmTYfbzdDP3IBUseCtLrXKbXsyuwY6s6qfkdjjtnFhFuak9
         uhBINrt4EngRJCAr0R3ZkCChZk29oFnp64SZCoJIMxrd15t9qZ00QNeXiGdynZy5vOGx
         r9U4ws4QMm7jcNKGUsSeBR7G1eIi7XXZ2TRGK2UxXJnhMeRccuHj7dGztp+3AaRAxNI0
         QD9TCzBQt4cnPg8JcqUAltfq60mutXewIOPv2IIMYw/w1/NFK008Drsbp992GDpDTP9U
         XdaZQyYOIj/HNErgpjrDr/l6mYLdRVkTJDGemFHTkqMWvhqdrwEgTleVCgctDwKq2ZXo
         QeNw==
X-Gm-Message-State: AOJu0YyYVy9Hat2ZLkKdyntp++//83F9vv3dY5ez8zzyZBpwVxTLfm0p
	uczkRC6ZzjoQ+uGPRO/4LvGFJUlL2FqCAXRghQgpcWQJsh0pgThV2YEBkJwmtoj+uAZiOb0lTIN
	X/ApaJRyV/LbWXZg8Ot+46thCsHD0Do3A
X-Received: by 2002:a05:6102:3a10:b0:464:7a10:6d2f with SMTP id b16-20020a0561023a1000b004647a106d2fmr9361120vsu.4.1702639858149;
        Fri, 15 Dec 2023 03:30:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5IJqCObqzVAxdPhYmsEVqc4a1gAchOPy0iXFo+mJ85JgIBdGQnEq/jQxiaBk73rUwwVfAp+SCyQ5Kw7jxYAg=
X-Received: by 2002:a05:6102:3a10:b0:464:7a10:6d2f with SMTP id
 b16-20020a0561023a1000b004647a106d2fmr9361107vsu.4.1702639857902; Fri, 15 Dec
 2023 03:30:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215103013.2879483-1-alexander.atanasov@virtuozzo.com>
In-Reply-To: <20231215103013.2879483-1-alexander.atanasov@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 15 Dec 2023 12:30:45 +0100
Message-ID: <CABgObfYcQtjeQ6R91m2JVod_eQcrW+Ksuz3Zz0zpcN9=WH8T7w@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: code: always send batch on reset or error
 handling command
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>, 
	Hannes Reinecke <hare@suse.com>, kernel@openvz.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 11:30=E2=80=AFAM Alexander Atanasov
<alexander.atanasov@virtuozzo.com> wrote:
> In commit 8930a6c20791 ("scsi: core: add support for request batching")
> blk-mq last flags was mapped to SCMD_LAST and used as an indicator to
> send the batch for the drivers that implement it but the error handling
> code was not updated.
>
> scsi_send_eh_cmnd(...) is used to send error handling commands and
> request sense. The problem is that request sense comes as a single
> command that gets into the batch queue and times out.  As result
> device goes offline after several failed resets. This was observed
> on virtio_scsi device resize operation.
>
> [  496.316946] sd 0:0:4:0: [sdd] tag#117 scsi_eh_0: requesting sense
> [  506.786356] sd 0:0:4:0: [sdd] tag#117 scsi_send_eh_cmnd timeleft: 0
> [  506.787981] sd 0:0:4:0: [sdd] tag#117 abort
>
> To fix this always set SCMD_LAST flag in scsi_send_eh_cmnd and
> scsi_reset_ioctl(...).
>
> Fixes: 8930a6c20791 ("scsi: core: add support for request batching")
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  drivers/scsi/scsi_error.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> v1->v2: fix it globally not only for virtio_scsi, as suggested by
> Paolo Bonzini, to avoid reintroducing the same bug.

Alexander,

The patch looks good to me but please resend including
linux-scsi@vger.kernel.org.

A similar patch was also sent yesterday:
https://lore.kernel.org/linux-scsi/ZXvdX6lWbdG+uqz8@infradead.org/T/#t
but yours is more complete.

Paolo


