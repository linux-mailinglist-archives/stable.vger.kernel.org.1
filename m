Return-Path: <stable+bounces-249474-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGsZOJAKDGo5UQUAu9opvQ
	(envelope-from <stable+bounces-249474-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:00:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C406578853
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A40B130DA52A
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 06:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDBB3A543E;
	Tue, 19 May 2026 06:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKdrR6Vb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="juy7JHjD"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B23E2D8793
	for <stable@vger.kernel.org>; Tue, 19 May 2026 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779173619; cv=pass; b=bkOsV1QWV7/ZBCrxb4E9CCLCxNzOFRS8+UHOpyIkrMAunulxSwMRirkT2E8CCcfM2zU/YeWywzGnVhBrfC8F/V1wOH33mn74FRUxZ0YHNsslcnfOou10q1vZJzxfKI4SW4wcykAj/mOkWpLkM1NlrZbouWhXMHRj8Maux9sEd6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779173619; c=relaxed/simple;
	bh=N/lGmecVFQx1iX5YAVmGsxFnOLxLeoX8M1NpGU8x1WE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZnW4gT1osXknfxRm1R57HUmTCVtRMjuiKPOubs0eg3WT0LJOlU0mEiai3odJ10n+QtP4H+O0GVig7Tkw2LyEkfSJYmKgozEo4/o3QNqIbljldCRrXmokzPmSna4Ac26uYLbN504WasQilR07CKqfST2rNjUkhjNLL6X/2qjL3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKdrR6Vb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=juy7JHjD; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779173617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NtTV0TkAJaGYmYe6q9yU060wD/g415BoN73BA4aTR2g=;
	b=GKdrR6VbfBSmPDTjCOBwt77jjFyXUQepjgcbqDYWE2g9YKnE5H7TET+XDeVz+iOgES4IST
	CkL9pVQLugGHJ1fpjTGSGNOY3C3ZfwJILqE62CgZrv3FHPX8XMgZD6XwEGZC6Hls42jPUm
	OJPIwIibobB+HLOLS793AckKLfBf/gM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-psJzVXbeMV-O3i49QpZjDg-1; Tue, 19 May 2026 02:53:35 -0400
X-MC-Unique: psJzVXbeMV-O3i49QpZjDg-1
X-Mimecast-MFC-AGG-ID: psJzVXbeMV-O3i49QpZjDg_1779173615
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-bcb28103aeeso203794166b.3
        for <stable@vger.kernel.org>; Mon, 18 May 2026 23:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779173614; cv=none;
        d=google.com; s=arc-20240605;
        b=a+VSH4K6NwmVFTXoBPoUpWyFBxGE3DBf9hpiujqQ/x+c455CVVPhqcHEQ+WXuJFbas
         ARDXcN3Fg0tK6XOdo+uMyrUvGfK3XqAIj9bvzbn7ev+nfE8f+PBdiYq84BjmAmJ0PN4x
         VOz8r6dN09CVkMy7Dpju+Nfj3bSwxHQnk7LLuygvixhOmLUJyhJVJf+DHROsdwR5rRps
         mjKT18X9kiNpt9TJPZUa6UPQ8cg18aL0SplmqYoRiHguD+Ko/9FDAKfxRwGTKaiW4mWG
         gSCEItFfgh0vXTQXNgBIVheZaWU1pEnntRhOAD43v8I3D6LIFmHJaLrKxR25s9Teaas8
         Wq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NtTV0TkAJaGYmYe6q9yU060wD/g415BoN73BA4aTR2g=;
        fh=oljLf+nu3h2MjRrLiWUXnQ4RRVo24oATOOda8o4VBfg=;
        b=CImE+M0ZS0qcK2gP15N1VaSADye5nKoQ+swHgQYOw3/23t2HY01GhqNV9oJPA38cYv
         9JlQ1rJ2jvZPVKb/Q4pLRZMQbi343tQ/MukikiddefaSGGRHEWGv4ChrS+SwTCyM+17d
         6l3rJmiRjVP8dlp04LFbcj6BfmuSAG0P14YEjF2oTLWE6Z39afo7Flxj/0TbtMSG0gfR
         QQqJFoc6aM7890M2xly2p6YHtGw9KhX2XoOiQlsE/NVZKJ8N/8g4IWJc25eA7ImQlTBL
         9HkiMmkB+z7qN4dMoeX4cK+O9isS13JpMf+gb3hLIk5a7lQJ+kcg96LaCfEoVsoYig75
         1OKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779173614; x=1779778414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtTV0TkAJaGYmYe6q9yU060wD/g415BoN73BA4aTR2g=;
        b=juy7JHjD2IPPVdQKvjjpnetInPgluDmSO+SPqCdeuHZGKxwpF642rkZadacxfvRcXm
         RrYcyqTBlZ2OfMQ2XWk6Nuo6Go2EikcFBEsM2B22PtTsaFGkNitPGD/FA0nq9muVqITA
         Zro3CvioGVRnPpHlJnXEn/FTkiBG1JfGpoR1fuK3Zm46qo8149qw1/WZIxNewegQUYHS
         pMCuKVqtmtGQjCGcBti2GETVV8XsAK65QV1UdMjtUVcXqrlfiy28lTfJe/Q7m8+lSl8z
         oTT1/4bVjtgc+ma7m/vmknqmSV1GblrefZX59WyxWxFY03UfsDl6Yr9vznpdVTA7yunq
         GJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779173614; x=1779778414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NtTV0TkAJaGYmYe6q9yU060wD/g415BoN73BA4aTR2g=;
        b=FFONPvTiYiTMuwLGy0GmD1O8PJ21QPPENGWlZlqKg3CLRiLf/izlf2WJ9Xx7jDY8o4
         w2W62Pczmhr1tA5pBKWLsgmM/5ZkrGc4Fq4mcJEG9uc9lPdlENV2uqKSnJ1cf3/xoXn+
         nSBV5w0AZLF86eFhqaGFTuaAzkbERA8+JrZHJ0nKODI7+g4yg0JSqfV9U+NTtH9iMIK/
         ln3CzCfecqRANXa1wEJq9d+ESGA6GxkV0z3mAwde1FWeOySJAmkrSityHzYQAC66LHSF
         EmcyrMmXlVlnrcIeUIk/ZUpnxuenT2nW8RABBeX+F4Vr1LaukIZ3JiE1JEHq+79xkIwE
         D60w==
X-Gm-Message-State: AOJu0YxrzKYDdC9VoWCBc7zQ1ZaO0ai/vz8++uj7vWde0/aQW6y/+c+e
	4pMaQDT5Smeicfgpx7blkw2cX3k6NwFgXS1KEAXWCyN72e0pEGHZ2vt2GTKICEsp4a0L9zPdETB
	L1pNofdhuBpM3mxftYg3voTLdSE6QjIYaE3qAQntaHrgEUxgWkTk1vNn5OV34FB6Qw/WlwdTj+6
	JeyG9NMRqNfToaF49wJPkK6dT0XPOoVAlegM87Fft+qOU=
X-Gm-Gg: Acq92OEIbieVK7KgrjPzgOyr+R6SYkeLpgCRFO+QfNGknPFzZ2dqHwnTKd0Yr0CcVE7
	+M8Ox2nRRM4HW+203jJIN5DmUKDdyzVHm/S18QS0Eer2fpV4caHfEhSvXv453FCpRGEYz3MuTLH
	DX5tIyfB6zNDuXdKS4gQDZ7ARukgKe/tev7UvMeisdVuvuudUPcRSi1HfucHF+6hkPtSSqN4/mB
	pkVmM2YgeeBD39Y
X-Received: by 2002:a17:906:6184:b0:bd4:e53f:699 with SMTP id a640c23a62f3a-bd517a98c94mr937089366b.37.1779173614378;
        Mon, 18 May 2026 23:53:34 -0700 (PDT)
X-Received: by 2002:a17:906:6184:b0:bd4:e53f:699 with SMTP id
 a640c23a62f3a-bd517a98c94mr937087966b.37.1779173613903; Mon, 18 May 2026
 23:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518121410.860269-1-sashal@kernel.org>
In-Reply-To: <20260518121410.860269-1-sashal@kernel.org>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 19 May 2026 08:53:23 +0200
X-Gm-Features: AVHnY4Jqg9PaXNKZ7auLkXyBpApYIy_CzglRIEObwp-AZrm3AUbpyzUhcfveGRU
Message-ID: <CAP4=nvTootCBXa1VxJLGACVtVNuY_RiiAWVOrh+jED=4OD0SSA@mail.gmail.com>
Subject: Re: Patch "rtla: Use str_has_prefix() for prefix checks" has been
 added to the 7.0-stable tree
To: stable@vger.kernel.org
Cc: wander@redhat.com, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tglozar@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-249474-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Queue-Id: 3C406578853
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

po 18. 5. 2026 v 14:14 odes=C3=ADlatel Sasha Levin <sashal@kernel.org> naps=
al:
>
> This is a note to let you know that I've just added the patch titled
>
>     rtla: Use str_has_prefix() for prefix checks
>
> to the 7.0-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      rtla-use-str_has_prefix-for-prefix-checks.patch
> and it can be found in the queue-7.0 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>

This patch breaks rtla build:

 LINK    /home/tglozar/dev/linux/tools/tracing/rtla/rtla
/usr/bin/ld: /tmp/cck91Z1j.ltrans0.ltrans.o: in function
`trace_event_disable_trigger':
/home/tglozar/dev/linux/tools/tracing/rtla/src/trace.c:375: undefined
reference to `str_has_prefix'
/usr/bin/ld: /tmp/cck91Z1j.ltrans0.ltrans.o: in function
`procfs_is_workload_pid':
/home/tglozar/dev/linux/tools/tracing/rtla/src/utils.c:319: undefined
reference to `str_has_prefix'
collect2: error: ld returned 1 exit status
make: *** [Makefile:94: /home/tglozar/dev/linux/tools/tracing/rtla/rtla] Er=
ror 1

as the required dependency:

commit 0f4bc9d67a643a6ea8b82faf724e44648b2c322d
Author: Wander Lairson Costa <wander@redhat.com>
Date:   Mon Mar 9 16:46:23 2026 -0300

   rtla: Add str_has_prefix() helper function

was not detected correctly and is not present in either the stable
tree nor the stable queue. Either 0f4bc9d67a6 ("rtla: Add
str_has_prefix() helper function") and its dependencies have to be
picked as well, or this (and its dependencies) have to be dropped.

I can send a rebased version of 4bf4ef5292b9 ("rtla/trace: Fix write
loop in trace_event_save_hist()") for 7.0-stable that does not depend
on this, if that would help.

Tomas


