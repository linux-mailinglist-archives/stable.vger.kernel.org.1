Return-Path: <stable+bounces-240344-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJohKUnl6GkHRQIAu9opvQ
	(envelope-from <stable+bounces-240344-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:12:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B71F2447BA7
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65DA63006922
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 15:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39C7311C1B;
	Wed, 22 Apr 2026 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hARLAlRu"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659C330DEB5
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870718; cv=pass; b=ZRAqLv1bzTTmK6ygngihZSzFBhCDSt7GgIqiX8/fH9N1M2iX7y09EUXr060ahKEP+QrazyCK2O+gtT7lZXKBCi+wXAZfFABxiSn45l1OXNvkXG8CsH6ZP4AS5lRqHU0V+w5SgWXCSv6RRPKh8+ObhzKn6IXrIthwJaaiQeo3LW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870718; c=relaxed/simple;
	bh=mhsSIyJljT1ri9cXEnM5p/ZpeffSYBc3tKbOFjC9Eqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anRfGlFoF1WxFrazOX9z4YcpttFZ1/EpCbjtdUH+mhqkiJBrZA7SJCNPUlf40+bUJtlkss8WR4YPyMiefBJpStjsGBwpCOpfFPmAca9CLY8HZwOwz4rA5VMQ7lgkCkH9ez8UNsh6FPVz2dUlPkIzpsRqZzg8cEMhF3QYzOc7BLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hARLAlRu; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6501c9903edso5700537d50.1
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 08:11:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776870716; cv=none;
        d=google.com; s=arc-20240605;
        b=QkM/MdAOUFcysP8oTbXeluvXW2CBECFUWAc2qDC05R4qaLx44yFp5GctBwplvQxmfx
         gxdS5r+Oho8BTsiwhodU5/pl87BrQ8t1xu4/40bKMmreeGaMJoN32d5/iM0+ds42YzuG
         KMpqLHs23u9vD0BAr35rsfNgEK9hYtl5Gx7gzafW7oy7zKpHCHeLW6WZGMlRGrI23gDD
         /epg3cJUehcy6nCC6XqFttZvmyKWYEf7p0RqnZzuce/z7UaYE3+gVqvC0+Q+gDRNwu75
         F1ME7Gke4k0wLUTKp120MlS16IaFU7vNTYiRheAECf1is7P0kpGhntrI7zirGIDnreqm
         nXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uJadbR8Ee8ex4TmlYfT2JJ0NYAt6/4fvgV47acLHcHU=;
        fh=USiN0pkvLo1Ayj8YaAVFvxasHoHNi7djAy8wTE+9/g4=;
        b=aCRr+NrXTONPEh/gbEdiVT4rQkARYdytlsRemFPxRtgkn6gyibVNKHr8G9z6oWmggv
         YhEYrZwn/eOqPny9dmJHGZLrFrMRNWYM6JJuzYB2NaYdPjt/lpMB0U0TzzRPKb+HiyMV
         xRAilal4y8+Y5599DRdD95Fyc5+x3FzvHX/9hz4JqvEaaKbfNOLEvVfcFzvRUt/EAPot
         pibbuAQtK9a7vBIsAyBXp1qYnJnBRLreAt1uBOzi1pgMPtVf7VuBp6vivz27DBR1Q31L
         I/lFlQP7LM+2Co51BSp2nwFFynCi7Rh4bpvEx3Ubmk2aLzB5uop6ZbgiozNVeKNkUiLh
         1Hmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776870716; x=1777475516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJadbR8Ee8ex4TmlYfT2JJ0NYAt6/4fvgV47acLHcHU=;
        b=hARLAlRuQJ2rKRIQe05edvkAUfSx0WHvTlH65V4ZcBDHI0hvF33zNEiLjVT3zVHKPQ
         p3iHjgJjkg9Tzydsviawc9jd35Ae5cZ/OxcqyBhIRsPJOFeXPh6wkqK9RAaEpkRQKc8h
         cmIXkyHzoSXvk4GIehuJU/Z+a+J8LCxlsQmfo5tuJ0TT6zlkpI8KEAbp2/q4xRS6ijmX
         VsxhDApo9njAieFxVntPa915xIYb8aRBAsfU/lqkHN7mZ9L/JMypQFzs8q77Hl9Nl7B1
         wlXmhJcLQue5GQarjt+dlqvO1omfuqvh0FABT9JRuPoRgjFM3d+MvtE7adbC70gwqQL+
         qkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776870716; x=1777475516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uJadbR8Ee8ex4TmlYfT2JJ0NYAt6/4fvgV47acLHcHU=;
        b=N2uiQrPEQDM5r1DK44jx28wvX4RizceWqMmHOuoGy89hIH92WLtSiZJDYJmYIJX94P
         xPtBtqdWlmIbgtaGCxzYuXhGCUzDIOoLn8Jng5zSa5cltLqV0+ijAuzd97w3FCkHc595
         4Wd9uxhECvm0Tk5twigfPTqFlvBtP8cbgrnt1ANm5wBrvjfHQlSLVUeQllVoYW5PV++v
         HCdterlyZ+YsZfuisEW3OH8ASmwMhDWu24ao1BFN7YAHHQ1e/RnzppgCwO44lHCpsGtz
         zggOFuzxzUaRxbtQzUiR3GIvqkDoo0joZJkA4dOR4D3NVmAiXvNO87QI4YgNcpm8TLUC
         taOw==
X-Forwarded-Encrypted: i=1; AFNElJ9ZUhbzzUo0O0Eo9H3iWvQ8qqirGKdofiNlFWpiA/wXS17mqYjP7kKAuaD29pU6MkrfUEx0/70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk/ixKR3YDAVykoGZgGyNL3gwkZ8HZUrUxEO9Lk08dQDlY2Cfy
	TfScvp/jGov+wn5cZX2r+kWKv4i+oasklF9cCwrJegWz10GfVl/VhsJvX28DFDT6DeYoeIPzqm0
	GxoWwBadjgk3RzulzM6f/LZ/GPxgBmGQ=
X-Gm-Gg: AeBDieu2DG6l+VQmQhZEV9zYZMk1m42HTxOvMBUoKOYZ2zRmQM3+9e+iep+aE8pnK3Z
	P3KoiLd6YzXtR/sLl73myupgiNwuvNgqto1mtgJX7wnfeAzcyuHQtSEWFKaHI6Q4ZUHkzR86k3n
	s7Y4JJRvq5UAkiSyw22kmntp6RZRNLW3jVxRnh2iv6IMqUc62hxh1BXFGg4Bx3h6JT50pmKV/oj
	UPJNkKEzvBKw+CneSeBBMfN44cQaZ1Xd8ezBKFqEKGaiQu7PNVCdGnPmUwJ5diGnPJQCjlhl69c
	iLMRC1vX7GHffIiJSDr/vz73n+chTf9+JLrb8x4aYkyKnB5S/tQm3p6eGw==
X-Received: by 2002:a53:d015:0:b0:652:cacb:ba15 with SMTP id
 956f58d0204a3-65310b7b907mr17950201d50.64.1776870716398; Wed, 22 Apr 2026
 08:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417221628.1674866-1-michael.bommarito@gmail.com>
 <CABBYNZ+f3pur4cSsanQ1kvv-yORp2E0qmVLt9si_+FnnJup4Ng@mail.gmail.com>
 <20260421135639.3185653-2-michael.bommarito@gmail.com> <CABBYNZKS5Prm+BTkpdPgArgODTEDgHXLjecfux=3ZW0r2x=UXw@mail.gmail.com>
 <CAJJ9bXy8CVjC4xG0zBcxi9xtiep33-uRGSysL1Q3FiqCN7Rt0w@mail.gmail.com> <CABBYNZK+o0wwOvjoz9w0ju4SoXpt6PM1xQwXU6OozVJLstWMGw@mail.gmail.com>
In-Reply-To: <CABBYNZK+o0wwOvjoz9w0ju4SoXpt6PM1xQwXU6OozVJLstWMGw@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 22 Apr 2026 11:11:44 -0400
X-Gm-Features: AQROBzAu4VbldwFPAE-MOIjgHMfiFTItXYow0k5lFdAXPvhF8M-n6NytunHWXUI
Message-ID: <CAJJ9bXzsEfzaRzbL35UQyeKF=00pq_c1x95ppTKod3wog7o7NQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: L2CAP: handle zero txwin_size in ERTM
 RFC option
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Mat Martineau <martineau@kernel.org>, 
	Hyunwoo Kim <imv4bel@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[holtmann.org,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-240344-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: B71F2447BA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 11:09=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> 100-200 is not too bad though, if there are splits in, let's say, 5
> changes that seem doable, especially now that we can sashiko review it
> and point out if we are missing something. Another approach would be
> to leave the pre-existing issues to be fixed in a separate set.

OK, if you're down with a bigger blast radius, I'll go through and put
together a bigger patch set so we just fix it instead of deferring.

Might be a few days, I need to block out more time to diagram the
state model and conditions here given my lack of familiarity.  Thanks
for your patience

Thanks,
Mike Bommarito

