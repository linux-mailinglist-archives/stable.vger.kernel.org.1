Return-Path: <stable+bounces-17665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5E9846CF2
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 10:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A557928691F
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 09:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97D276918;
	Fri,  2 Feb 2024 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0uw00WW"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D04D60DD1
	for <stable@vger.kernel.org>; Fri,  2 Feb 2024 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867467; cv=none; b=BnEmhyGB00pLLdXTKww1sIdnpmusI4HeCJuTPTo6mp0Wi53NSSORV5pHBtEKu/sNGtDXshgIKz6s0WXaPmLq/WeyWq11nKyo7oc9lgSqbaXmilrt2HEo3nCSG2VJkbZYuUBB6vKigpZ0H8xghDODmb3DB9NRROO5kHGS091mcEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867467; c=relaxed/simple;
	bh=mWtUN8+wyq37EYaboIAsGSBhthdMYojzUMsBsurvNLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhtVeUvvh1oE14+qbOyx/7UDEiUbiube+NNeVHw7X/hvP15LSii6TIY77l2woscTl7mAXxqRxLx/k9J5FnGSFlGIL+AIgly3SPoKWPSXXYz7IFM6+lMSI5mdkoPiVOsovSHiDwkmZB2bFENjZ15nn5R8RGplce1H4pEjFYFdqz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C0uw00WW; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4bda5740d2dso740808e0c.1
        for <stable@vger.kernel.org>; Fri, 02 Feb 2024 01:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706867465; x=1707472265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5O76Y5OEHyuJ5zbglzwN78Qq9NFvbF9mRabgoJIlFg=;
        b=C0uw00WW5arRW1aHNokruzzW6K3LQs7FYsB+zS+tp4E6qVmH7w6z2a1hRpxjYLennd
         B72g7TlsXt+JDxeZQns6IsFg/iwwy4DOfaswiITXDRI4DF+7k7kyntIVtp44Q4DkliCz
         4zU24aCPQY+cFD84istT9HUm+rewCCb3K5QS4oglTSWzYN5z1xm4cYWLXnWjUCL67b9u
         e8B/Hc2bRQTD4t7T9qYdtW6ZJUZhr9AGs0iV9p592PZbR+JZrnQD1tgvatJbBFnBPdVs
         V3LIkPJedKKQs6pMH/sTpw0ssS12HWp/C/NnoA747b/qrGsA4EkU1TGW+ytaOau9/EBL
         oTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706867465; x=1707472265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5O76Y5OEHyuJ5zbglzwN78Qq9NFvbF9mRabgoJIlFg=;
        b=Q/vWPd5gX2QTqtVMHLbPR/TtKwsnTNWskpCqDEYuNWu3j4+9IHIIP6ip8SQEYAQig3
         S7Bc3PB6MFcDBHN17GyRirNrsyR67lM5UY6F7R180hPqvTcWjbIsHpQCMHFl1rCoCQHU
         DlIfyot3eOIu6+JA0HewbBfiRZ9E0gMSpGByBZj4NRfU3G6Hmgn9DybxS+7qgtZfwvr3
         KxQV6ohXYOyXJQkUPoxN2Oks74JfVs+fxlin2DqKKIlAVfrChGoUQTfcst85U8NvefQQ
         VgNUtUxmMkiqL14EJMXB9dp09SdR7mQDbjQXoaYE0WoPgBHb47Co+Oc4AZ+PZSM4NNVI
         t/Iw==
X-Gm-Message-State: AOJu0YzTeAv5hC03PLGdoqw5rZBl0VgwkB+YXqjBv55l9NP6KQ8JGIEs
	EKya779ba416p6HWOWpSguPHktKj3jG14PdzP33U+3cmk3WKr1DbWvBpCjFHOZwosnc7urSJvCB
	jWXynUSXRQJcqhw4Dq8vtfnOB10w0Na6jZdw1
X-Google-Smtp-Source: AGHT+IEkvVp/7egcldbAsqYPdo1psTXXE0ba2s8MIkyNuWcUPbsousyYB2Td/Klh5jB/5oOxmTlqVmX91nXhIo/6oZc=
X-Received: by 2002:a1f:f84c:0:b0:4c0:1387:96df with SMTP id
 w73-20020a1ff84c000000b004c0138796dfmr1965vkh.5.1706867464732; Fri, 02 Feb
 2024 01:51:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129170016.356158639@linuxfoundation.org> <20240129170020.057681007@linuxfoundation.org>
 <81752462-c6c7-4a65-b9f2-371573e15499@kernel.org> <2024013044-snowiness-abreast-2a47@gregkh>
 <7d963e3f-2677-4459-b60e-2590d6cddc79@suse.cz>
In-Reply-To: <7d963e3f-2677-4459-b60e-2590d6cddc79@suse.cz>
From: Marco Elver <elver@google.com>
Date: Fri, 2 Feb 2024 10:50:26 +0100
Message-ID: <CANpmjNOdRXcok7oyQ=-G7iYthy7f6zHMjJ+TZqGP+vzwRT4+pg@mail.gmail.com>
Subject: Re: [PATCH 6.7 125/346] mm/sparsemem: fix race in accessing memory_section->usage
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Alexander Potapenko <glider@google.com>, stable@vger.kernel.org, patches@lists.linux.dev, 
	Charan Teja Kalla <quic_charante@quicinc.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Feb 2024 at 10:44, Vlastimil Babka <vbabka@suse.cz> wrote:
>
>
>
> On 1/30/24 17:21, Greg Kroah-Hartman wrote:
> > On Tue, Jan 30, 2024 at 07:00:36AM +0100, Jiri Slaby wrote:
> >> On 29. 01. 24, 18:02, Greg Kroah-Hartman wrote:
> >>> 6.7-stable review patch.  If anyone has any objections, please let me=
 know.
> >>>
> >>> ------------------
> >>>
> >>> From: Charan Teja Kalla <quic_charante@quicinc.com>
> >>>
> >>> commit 5ec8e8ea8b7783fab150cf86404fc38cb4db8800 upstream.
> >>
> >> Hi,
> >>
> >> our machinery (git-fixes) says, this is needed as a fix:
> >> commit f6564fce256a3944aa1bc76cb3c40e792d97c1eb
> >> Author: Marco Elver <elver@google.com>
> >> Date:   Thu Jan 18 11:59:14 2024 +0100
> >>
> >>     mm, kmsan: fix infinite recursion due to RCU critical section
> >>
> >>
> >> Leaving up to the recipients to decide, as I have no idea=E2=80=A6
>
> Let's Cc the people involved in f6564fce256a394
>
> > That commit just got merged into Linus's tree, AND it is not marked for
> > stable, which is worrying as I have to get the developers's approval to
> > add any non-cc-stable mm patch to the tree because they said they would
> > always mark them properly :)
> >
> > So I can't take it just yet...

So 5ec8e8ea8b7783fab150cf86404fc38cb4db8800 is being backported to
stable, which means that the issue that f6564fce256a394 fixed will be
present in stable. I didn't mark f6564fce256a394 as stable as the
problem doesn't exist in stable (yet), but if the problem-introducing
commit is being backported, then yes, please also backport
f6564fce256a394 to stable.

Thanks,
-- Marco

