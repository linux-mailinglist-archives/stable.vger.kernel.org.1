Return-Path: <stable+bounces-217832-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPyFKsTFnGnJKAQAu9opvQ
	(envelope-from <stable+bounces-217832-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 22:25:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D272A17D904
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 22:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CD153008C96
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 21:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F16D36BCD6;
	Mon, 23 Feb 2026 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cueMh55B"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62584F881
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 21:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881920; cv=pass; b=DTfrKfrRVCnEnmbXpOufAe9JtXnbpKKraJ0ANwmrey0XhBqfGU128tI86YtpSwCyBsa8syGNJVNPg8yAGfs3fb1+lco9nRRBtj9x24TVmHT5tNWLw9fOQDGWjGLFM8yMzxvIZB9muw3gRBvySd5lQH6MS/C5eil/rUmEDaOuVSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881920; c=relaxed/simple;
	bh=lNwiP+yq+WCKO6q1xj4yFmFEyVGG0O673czMF78Wt64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LsyGBdrMZvFmPR5UIsgOLyJ1oPzDB8CuGR+VExSw4ebrExKRscuDcIO24oFTFSqXE/ejoZ82XwO7qBjmMBL/gSwuil+S05vobmNL+Ri9GvMQ75qSVC9Le2gm1dbR+MlWh1wY3hyFOuzE5BAONCY8jz6icMQwhDPPKfE0ySJKueo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cueMh55B; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ad019bbd4so4377715d50.0
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 13:25:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771881918; cv=none;
        d=google.com; s=arc-20240605;
        b=X5fYdsPaWZU5KJLwiB/A25cymb5jKVl1FoFbjt4/UCDwFxH+yidJuFM3dnx+y8JLId
         WtXcgWY+ch6DzILgFbQAMj9YGMkcvyGqmcq1wGue/14H5blzh8u48exUlJDRQ75YtFUL
         UlrB19qJcDkQMdEXg9uNrK5R1pEs2KUyq4sfU+BkHzGN2A8KUh2uSD5/bsAquCYxXzWv
         Xlni9BiNmEKfaVkJgrnm7XLieQj06iNf2ScbGFxbWh3H8zcr1TUofn0lTmVpWr0V3KCa
         yPuCC5SIfSqw/2F7BgXR2vvMPp421t8L9y5eUcWICPjxf17nJ87N4vD6zEvZVOSQgAU4
         t30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lNwiP+yq+WCKO6q1xj4yFmFEyVGG0O673czMF78Wt64=;
        fh=GZMaHABDBCy3eGlO2eORJ9AAtryZMBdl57ukUk/hs5k=;
        b=Cywxr//LnhaYN1hc3n9h0rLiND8iRr4U/VuUOUSnz29s95PmcOaCrOaQmtDoOQus+I
         Fad4EyamRqsDoUxRqse8YGYjv+CzJlz+pGWdtHHRxZunkAKvhR5ZiLTDZ1/zsHQBnYSx
         2OsoIQMeGM1tToFviDsYyuuR4wRkw4/JAiJsjHxoLG/TwPLxz2GefEKy1zwdWnOHN/9h
         0gFfZSpPhNB09i1ya5Ph71bh7yWhEqtvqY4uA5mC/3e2Dx2LswQ/CaeDF6xRPXs6llvi
         5DAiINGaI2N69EjVbaa0qlZQinnI9dEVYXWIc/lPPSVxIOQdIxwkF/SwS8tXdirnjuiC
         W0Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771881918; x=1772486718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lNwiP+yq+WCKO6q1xj4yFmFEyVGG0O673czMF78Wt64=;
        b=cueMh55B1nbA+Rz7eDJ5URRnFwXV6adznx2cY7LHTvKSQWCv+1EEVmPEJo3qaIsM4Z
         0HoggIe9IddZ7w1K94LWIYDOHhLI+7PnFLFDhNE2fvLreVvruuhzUgVw6Trt5FyKdeXl
         hUyGNY4F42bjBZUzBcL6Iu96SKk9KplroSYXJR8wsRSOzVCxpiZBEx351jF5GayuHuCg
         qa1dIxzSz66l/K3PQtqmGzmCyaGiM6ez0JKNrPwe/5oP9M/egcfiZJVaHZVtWP/O5FGR
         XKUVqoofxIVfRbrRk06i9doeLPOKBByftT5sKn2XSOmYhVw+uQqakKN4Ntu+jymg6Aqt
         TjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771881918; x=1772486718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNwiP+yq+WCKO6q1xj4yFmFEyVGG0O673czMF78Wt64=;
        b=biNbxmU/1WbMrMP+c5EpwVEewHrHbBXuVRYhn8/34tPfwzKGPckxbNe57Yms8yr7+t
         vObsUfMQTCj6gwnVuv2BXh/15oNoecubY7AQm0LfueOdcs9ZojEJjAO18yZOK6/xehMs
         n7XBv21hk7b+MkJCV8CHkpH42oeaVramLdLokFWnPS8daghDPP5ya5dLjuo1UBubQvvj
         nFSam6GYOY/yzpGNLnhas4nSeGRuO2Aqflocx+zy8etoEdSbuexEM3n+OuP9dU0oV8AJ
         8H5hzeEpxZdAA7T6xflyoTwd5+Qyo/IKhcvCxzT/OAumq/Azq+Ktx5kcYrqGplDGsGIp
         CLmA==
X-Gm-Message-State: AOJu0YwL3t2V9pVAgDS8WJb+0Vd+LvSZtNafxCS70XQAs5FPBAeZRQSs
	fKp2cOYXmDpX5H1jT6MiMUMy7tWo04ouHFrRFcFHPkiSzo+wTwWBOTQUioS/5zmCL6X0qCnq+8J
	EdF/9DZDUUsPXFldsMSEYXMeBWlWu+eM=
X-Gm-Gg: ATEYQzwo7rgAHjcB92t5SpdCrGy1YG+eX5GbW7kSy+qO7IVUniQ5aG1VmqDunv3uVlw
	1oHWafl5z5+he36QfBVTv1ELmL4mAIBulKjHdXpIBBqYCVUVcaEcQB8HkPxZ6Nbql/K8srB1fbr
	Hs7oUlkktvBz+HSF7tfJZ8AKehbkMA3R32u9CVYilmQ9lHBnIzdCvNbUhbAUn/Xi9EMjc1WjVN7
	1GXfFHsdjVAp/JC9Rr6ge7Hvfl3Pn98cqfOaSdVpvn2w+WIJYxYFzPhW3wahKI+txz39opedCQ6
	/pdsel0jq8SVk6z5+KZ/7xIyM5RNN8GpCHK2MFcJPjQizSHNzF36CG2RfA8rIUBJnCXCNtc=
X-Received: by 2002:a05:690e:134b:b0:649:d59f:dccc with SMTP id
 956f58d0204a3-64c789d4163mr8198956d50.25.1771881917993; Mon, 23 Feb 2026
 13:25:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223074357.7507-1-aminekhemissi61@gmail.com> <ce957e8c-a73c-4259-a040-a1679e9caad6@oracle.com>
In-Reply-To: <ce957e8c-a73c-4259-a040-a1679e9caad6@oracle.com>
From: Amine Khemissi <aminekhemissi61@gmail.com>
Date: Mon, 23 Feb 2026 22:25:07 +0100
X-Gm-Features: AaiRm50Ps-eluzG-Sq5c_erL9ZtT8Y6naiG7GyV79RDW-F25wIAt0fKWBui7yL4
Message-ID: <CAEc6xTXq+WTvZFx8FoGhJE4NLbj6p-R7VMyCq7Vj_1O6_WBYOw@mail.gmail.com>
Subject: Re: [PATCH] scsi: backport fix for NULL deref in scsi_queue_rq to 5.10.y
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217832-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aminekhemissi61@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D272A17D904
X-Rspamd-Action: no action

Hi Harshit,

Thank you again for your patience and detailed feedback.

I want to be fully transparent: this is my first time submitting a
kernel patch, and I made several mistakes I now understand:

- CVE-2021-47552 is unrelated to this bug (blk-mq race, not NULL dereference)
- The commits I referenced do not fix this specific issue
- This is an original fix, not a backport

I also have a practical problem: I am not yet familiar with git
send-email, and when I paste the patch manually, the whitespace gets
corrupted.

Could you kindly advise me on the correct way to submit this patch as
a beginner? I want to do this properly.

The bug itself is real and 100% reproducible. I just want to
contribute it correctly.

Thank you,
Amine

