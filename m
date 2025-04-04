Return-Path: <stable+bounces-128350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BF0A7C4DC
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 22:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87D21648EC
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 20:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AABB14F9F9;
	Fri,  4 Apr 2025 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cn9y9t1y"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEB7DDC1
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743798324; cv=none; b=tk0NZVijecqpuTWS+rvTo4ZsxpxibaNz+nq+bvV6wKt7w7Igxf8gZp2cAOU12XTnzOSG97Y0VLViK57H2bm6o7VF+4JYoSUJQdIVS2XaADdYyeKWKvYwzNg/KaUr/MQ8l/3+2MZS8JJkUTYFlznQrmAjeKKNl1Djjr90YL+6dSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743798324; c=relaxed/simple;
	bh=T9PVwiuPKqNeIe9rhxV+oX62DiMdBkkz9uxg11r+tbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPpUep8Q++BDVtIzJ5rGUpI6ESbouv2SQGEu1GApdW4DXBfAxJDJa9vERXAMG33a1a7r3c0RpIEkpeBUcGiUPUBr8/NH7mJgxYcls3oTf3k2sOaLrgSjAhRyyuAYvu/1yxqOkiI/0YuvGq6USA5BHmVRnydPYOieAnCyAjrrMEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cn9y9t1y; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6fedefb1c9cso22178447b3.0
        for <stable@vger.kernel.org>; Fri, 04 Apr 2025 13:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743798321; x=1744403121; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T9PVwiuPKqNeIe9rhxV+oX62DiMdBkkz9uxg11r+tbE=;
        b=Cn9y9t1yvkgwyABeE5bXkdJneQ0xA6pv7oL3fofj0dNTSsjC8biZbt7jO8a7Z8tQNg
         VhM98t99sOR3FHUVaW0Sr1wcuObB7tDVEL68REdSlWf6Be8Wqy4PdSS6L7vTwhZRG9YO
         StRul4tWPOIvFosM2UAbbZR7t371vTgVQddQI/wvOduVwQxv/yaAxIv6J7Sor1lHXJop
         tXKUAf4e7lvcjvP9MWqSIylaMpwoTqHkFDjd9l5FvDu62Ck6ZiXt81LPglzzdq8NVoIt
         r5rPWl6u7viAj4FHRDeZ8gVbGrNwPE6U/9WsMF0OcYPBneGJPCK35sueHNnH3M+aubEd
         RFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743798321; x=1744403121;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9PVwiuPKqNeIe9rhxV+oX62DiMdBkkz9uxg11r+tbE=;
        b=Hgn9ZAXneSGafbzN/s+CNhV6HrNXSAGFBUaZzJuPz2ZXDfb9FTQranfHYwS5Pl8+64
         C4kKRzSqN2p+qvtwH0Kw5q0wFkc/Qtzj/CwlC361xd+ueruoGGG89d6Kzy7XjdUhnB00
         pd5Endh2gLJVCcZ1bCEYXixe4XvY6EfMhciT1vQOBJKdgOFaScAIo2wjzGgLjMvfMthJ
         67KPliqf+nqDnfbrA1t9BQwctaAb8DVpyCL1/YCqi/BBz9B3ucQ8HsUAVV7qF++lInUy
         VB5UinjQa5GHkYbGqc7spGIMvhh7Pcg1NYQox7P1qTIbd8rosU1WBDhrRh/Sgba3HcaA
         X4Ew==
X-Forwarded-Encrypted: i=1; AJvYcCW+DKnWPDV/yRnReyUJoLxz7h6r1k7brOr1vJTfSPR+ht4OfXWOv03wh5BAXzR49JMbDMBRojQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAD3fKFZEbn13ED8iur4Hdwmwk2+Fu6TqYmUJEPn8VHgDbXT21
	g9puDIb4yqsGAi17LZO2HihCIDeoo7MtYkUJCbONYPEJKsCgLrfh64iO8wlT8D2rolwjAISqk2h
	ij2Y6fV40JlhsnZG3yqtRArCrB04=
X-Gm-Gg: ASbGnctBnGABkXzSpdeCwEj+bAi6dwy9DbTzyoA7m3nbQ9WFz6Zzal12tkXATdTFUjB
	UyksWqmJ5jXozfsvygBqajUZnzTO50r1gj/sCL5iK3RDhKzRnpy1gYunmebnlxjBGwpLx0GoXX9
	z/3Oxgbj35tNS/jJCzSoXnVrLXV8U=
X-Google-Smtp-Source: AGHT+IHRruYa+xBJGetY5pghpV3uARtVIOjiGY8OaG40pvj0aF/Lyegi9wv2ZON3E3dyWJwPQZv6liNj7D5QBHUOjG0=
X-Received: by 2002:a05:690c:60c7:b0:6d4:4a0c:fcf0 with SMTP id
 00721157ae682-703e1589ef8mr76738687b3.20.1743798321421; Fri, 04 Apr 2025
 13:25:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403032915.443616-1-bin.lan.cn@windriver.com>
 <20250403032915.443616-2-bin.lan.cn@windriver.com> <d808abf5-a999-4821-a24a-388fee184ffc@windriver.com>
 <CAAmqgVM--YEC=hNt5H8DVUwvN9G5p=UX86X-VqKQG2wH9Re7+w@mail.gmail.com> <2025040400-retool-spouse-0ecc@gregkh>
In-Reply-To: <2025040400-retool-spouse-0ecc@gregkh>
From: Justin Tee <justintee8345@gmail.com>
Date: Fri, 4 Apr 2025 13:23:49 -0700
X-Gm-Features: ATxdqUGhaciX6CWFos48LOyqCVFCukMzHP0qW_rM8Kim7ui__6dTKuu2T_5hK7M
Message-ID: <CABPRKS-WXKmSDyWbEtMHeTbRXctjc5GFwOWJAdzZ+vQHNZBLHw@mail.gmail.com>
Subject: Re: [PATCH 5.10.y] scsi: lpfc: Fix a possible data race in lpfc_unregister_fcf_rescan()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Justin Tee <justin.tee@broadcom.com>, Bin Lan <bin.lan.cn@windriver.com>, 
	stable@vger.kernel.org, bass@buaa.edu.cn, islituo@gmail.com, 
	loberman@redhat.com, martin.petersen@oracle.com
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

> > This electronic communication and the information and any files transmitted
> > with it, or attached to it, are confidential and are intended solely for
> > the use of the individual or entity to whom it is addressed and may contain
> > information that is confidential, legally privileged, protected by privacy
> > laws, or otherwise restricted from disclosure to anyone else. If you are
> > not the intended recipient or the person responsible for delivering the
> > e-mail to the intended recipient, you are hereby notified that any use,
> > copying, distributing, dissemination, forwarding, printing, or copying of
> > this e-mail is strictly prohibited. If you received this e-mail in error,
> > please return the e-mail to the sender, delete it from your computer, and
> > destroy any printed copy of it.
>
> Now deleted.

You and everyone on this mailing list are intended recipients, so
there is no need to delete.

Please help port this commit to stable branches 5.9 and up to resolve
the compilation issue Bin reported.
https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?id=fad0a16130b6b4eb0958f4142d82509f90efdcbd

Thanks,
Justin

