Return-Path: <stable+bounces-201128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18717CC09E8
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 03:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41B723002E96
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 02:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB0C2BEC2E;
	Tue, 16 Dec 2025 02:39:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A111643B
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 02:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765852786; cv=none; b=rmH17F/gmM8Ke2JtL8g6uqA4ESH5LTq+hpGSIjyM4qrEKgUlOBjsUl6eex/6lVBTbI+JKsNUMFWsBlqWckrze4oWyz8waWsZLi6zk7obn1T1IKJ2iUkAWL7Z+lPATU0HNtIWOIRmU5yxEy9TuHvvr4dQZvwSnFEP6Q+kFNFKnzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765852786; c=relaxed/simple;
	bh=6+A8S3M6/gdqTPzGnQYeGZAkRFFddMC0RWi8Sbb/p3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McmOSLX3VnrDbefDghOnNAfOaf2zaIAUxp8T/wWKcKtQN+lZqMYi7l/KQ3FeHvrUxagfCsGPxoICZUbnKJK1QT7bnZOkY+3ApgLV9HNSBcF28xzuPgs19qmylWvka8pbGZ7+lTvu+NjZcAcq8CU9xBAWENDtwtDAoSFBjCRHcy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78e7cfd782aso17906167b3.0
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 18:39:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765852784; x=1766457584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+A8S3M6/gdqTPzGnQYeGZAkRFFddMC0RWi8Sbb/p3o=;
        b=QMrfBLquvPLWVegGqmhuTBdMHVqbjm/qAKNh7GTkjqd6Ma8Oy4ztbCz+mNBMxRQ2mA
         0MBgBaG5rnvONSdWg81HjwOyw1y48fp0icWMnpnigZNXMprAtvR1E0Qshw+jkhvbuzHz
         yN41SBGGs5s+kaqNghVol76+wQsi11G7/OzUG5lHX3uj9dMgBcvGCrmwNZIJPE9BRVBS
         u11KVa6XJDmLNr2dAmmOmS4olerU0n7s7Ina0EFefxPKW5h/bvjt4SED7ttOcwTAQHJN
         c4pFgIw0lV4bRW6Uuc5NGDAkB8oDK/L0sEpRnFhmckzaXTB/ygHPSc1sXQmHKdwvlN3u
         7XjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcd9lOE1WNVLCBwaLSo3xakPxI3eBIhn7uRAbZe+W9LaZrlEljLZUfTIFhkh1K/XPmx+vcowk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9MgGCBTym8E9Vp4nnb/SiX9BH14QBZ5WaAq667kUEVrGBpZiG
	8yTp6wRq0rjJRvsRylkyMWVcqqSJkHn3renAkoWw/T2MbsITKzcfp6SZrQpKBnSXcPI=
X-Gm-Gg: AY/fxX5R9vsSpX3eplWZGT1Nn/4hq0nYCMzS5gxOORyYPHWCCTUxsmztV2f6304Bv67
	uAo0xhgGh4mQsKm/LMiK6kDH86YRfTrFBN58ZEX5jO55BOF+0EWRdqtGIbrZDbzgGxqq23ezWlt
	ZyO9cW4xPRHDfIEYa7yI7+uIObIyFvzDtum6Bc/f4ZCnt7v+Dmzryacrlf8WLrcdjbFdd04Xja6
	nwk5r9Z3E2nB3v8vAtEfEyJa5uEXym5vSHhtcCzgyMUfNdscP7jUCT5AgOQneMmHFrLljPiLJ+J
	1vSQuHDlu7d94ApSEvw1STZ7DQE1wemD+4ndnIX79sHjoUY+sxZSj1sCu31xc01Mm4qKfLd9mgl
	He+Ao2iDynPJck9nUQVDfc7hV7lF9p9/dIHhgxBTwRkPB8zI5GFH0pVFP99Bo7CISRWy68a5g+w
	yrIZeyYk4oc8j2ZtpJOELiZN/61fABmFXuLH3nTz+ov18PdTM=
X-Google-Smtp-Source: AGHT+IE06iThQuslhu8aUoM3Ka/I3e1KnzectuLJWiWU/igo17Dr/MpY95zhBTIKdSJMrvlihsXTfw==
X-Received: by 2002:a05:690c:7484:b0:78c:2c7d:3c37 with SMTP id 00721157ae682-78e682ed9d5mr97564147b3.1.1765852783703;
        Mon, 15 Dec 2025 18:39:43 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e748d26b8sm34177587b3.11.2025.12.15.18.39.42
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 18:39:43 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7881b67da53so37009747b3.1
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 18:39:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhZrFEo6i0sXU0cDpzO9/WehPsgYoMxkDGjlqr7QF6WqRKmBA5uDULT351pIrucR0vpaVam8Q=@vger.kernel.org
X-Received: by 2002:a05:690e:4093:b0:644:39d9:8c39 with SMTP id
 956f58d0204a3-6455567e258mr9662377d50.84.1765852782739; Mon, 15 Dec 2025
 18:39:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251213-mount-ebusy-v1-1-7b2907b7b0b2@black-desk.cn>
 <k7kcsc6wljl32mik2qqwij23hjsqtxqbuq6a5gbu7r6z33vq5c@7jeeepio6jkd> <20251215-irdisch-aufkochen-d97a7a3ed4a3@brauner>
In-Reply-To: <20251215-irdisch-aufkochen-d97a7a3ed4a3@brauner>
From: Chen Linxuan <me@black-desk.cn>
Date: Tue, 16 Dec 2025 10:39:31 +0800
X-Gmail-Original-Message-ID: <CAC1kPDOLT5SXp6f=4ON1Z0kEvnHiCVq4-chyUvLfV-2LEW=Zmg@mail.gmail.com>
X-Gm-Features: AQt7F2oC7cQJhs_16xCMwLIiNvx09SHFk-EFa0dvlAzpcOl0wDlM_p9UfLrvgFU
Message-ID: <CAC1kPDOLT5SXp6f=4ON1Z0kEvnHiCVq4-chyUvLfV-2LEW=Zmg@mail.gmail.com>
Subject: Re: [PATCH] vfs: fix EBUSY on FSCONFIG_CMD_CREATE retry
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, me@black-desk.cn, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 7:55=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Uh, I'm not sure we should do this. If this only affects cgroup v1 then
> I say we should simply not care at all. It's a deprecated api and anyone
> using it uses something that is inherently broken and a big portion of
> userspace has already migrated. The current or upcoming systemd release
> has dropped all cgroup v1 support.

I am not quite sure if nfs will be affected by this or not.
It looks like vfs_get_tree -> nfs_get_tree -> nfs_try_get_tree ->
nfs_try_get_tree ->
nfs_request_mount -> nfs_mount -> rpc_call_sync -> rpc_run_task ->
rpc_execute ->
__rpc_execute -> rpc_wait_bit_killable might return -ERESTARTSYS.

