Return-Path: <stable+bounces-135035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A429A95E41
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B4F164CE5
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6789821A421;
	Tue, 22 Apr 2025 06:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCB86vpx"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0F1219A68
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303675; cv=none; b=AC2JuIYJi8oirIZZ1iTas9zibDvC1pRORUu1j2H26Z05aITzhO6S7IOyjTKonMLyTA9UG6ytJXitGSsVydKnmurbBDqBM2nWnc51LOFNGBXyzu5KJQx3mF7OXPSpQK6t4K93JIkHnpZLyaE8yYUa7LdP3gcUAdEDipITJtsbbYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303675; c=relaxed/simple;
	bh=U6nBzXRMv90EYxej8uB8N21+w5X6W981LODkoPMX1fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmVxA+B9LI74MZ9w4Be9glLTgm0ZwcIChh6u7euzalKF1hzykHP1hyyRrm4/db6WkmgxqLC2MV5oIep7kg7eEppqWxS16tpn2SAls03ENZZbxQiOJ/v9seUX6zsmrEbWLh0aVeU8ZbrvY0YUIR21QRkjQub5zdJs3URCKgq9+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCB86vpx; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e461015fbd4so3833418276.2
        for <stable@vger.kernel.org>; Mon, 21 Apr 2025 23:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745303672; x=1745908472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x109MM/LEQSES3KG/rdhfUYKuLpvMxje5L2Z2V+P+K8=;
        b=hCB86vpx9WSl9RA+0qM0Lb/30pidSzOkM3GXLPgeh0g9oC4a1VVzq7iSw7GpjPlaPL
         zAOrckKAli3+M6FxNBLOmKk80MMuHUlIP0mi3oadCJeeK5TvIKofrRy9OOejy1ltz7JB
         h5klw8aI03MVVfxbeWoSG3OmGYDu+iXufqaHgIBdegiurgeHguG939vVgpsrLOQbg3CA
         IzvdzwzWeBYBHkiv548p9Xb6qY0A9y76HYtRl4OQeOqNLRbP52ERU2WisKXKsQ+Yd54v
         30GRMlf88M4WE1g9CBlJtSIPzqqUDQNXtrX5flsMEC6XourVLQGXDToRujx1nrzspJFx
         gaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745303672; x=1745908472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x109MM/LEQSES3KG/rdhfUYKuLpvMxje5L2Z2V+P+K8=;
        b=oxeCxSO0iHuXZHwUWiCUF8CtWxLbYwfVQ2Sli24I/wkcYEudSe+RquXXtHEZrfGOE5
         Ppg5eOeaVKqHjdrnWP15w3jWqr9ClTA3I8F8rCTD10lLnYWOM0nL0OJzODiAPGGgYt8K
         CqB8zNyTUjUOkEjIzllrTOGHt++UtCcp28ordlI2ePoVBx3CAYIXYHrX+s8k+JXLhsZh
         9e5/j6DD+dhNgl/QUPOF2WWa8ALt5T3bXwPMXKocGgbmTbSTlYqMYS0Afu/qHxLfwPvV
         5iTF7oyNYOYSDX7Pjn+78CKgrN3fXkzHVt4/kYLWkvXMY7BuG4TyMfXaSf57dGt+V8m8
         heLg==
X-Forwarded-Encrypted: i=1; AJvYcCVEoyu1lxnEFLUbknqC9ErQocYEzep/7lNDqHYy6nIzTx3pGA3dgbfhgph3VmGefBJ/QAiDyg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YweD+xSpMcdCLwFwVRDszcSL3XUBX0kyQ0gMowk4crOIWbtngAZ
	ubvp0pL3o1ISkZMIH2fOk0jtholn5yLD2fiAbjjm/lVOBLunrYpLTV75C/K9/0nxqeUdGoIJXXo
	T0lRjR6iAFOXr+MT9iy8NvK688Os=
X-Gm-Gg: ASbGncuItNh0FC61/Gehxp8XlspTRdMLllVLip/VKnj1ihKdCam3q7b4RQOUPvhtPHK
	rVlGncPirYvxNvFslw6ejfrH+/4Jofo1aYeJSLVp0aGIst8x9iLj8MVX7MM27opKtZtVLjw9UeI
	dXrb9haNc/6ov0CiK209T6q8AGg9LuW1A3y581PQ==
X-Google-Smtp-Source: AGHT+IEHTHJuAs99MyxHsbjl9Hb/SESYs7jHHQ+ypQKpJtA1SYcdyI08d5xZI5fqY0RL4096/riMkjWT+g1IzluZf6s=
X-Received: by 2002:a05:6902:4484:b0:e72:b231:7b6d with SMTP id
 3f1490d57ef6-e72b2317c4dmr10576851276.34.1745303672577; Mon, 21 Apr 2025
 23:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALW65jbBY3EyRD-5vXz6w87Q+trxaod-QVy2NhVxLNcQHVw0hg@mail.gmail.com>
 <2025042251-energize-preorder-31cd@gregkh> <CALW65jbNq76JJsa9sH2GhRzn=Fe=+bBicW8XWmcj-rzjJSjCQg@mail.gmail.com>
 <2025042237-express-coconut-592c@gregkh>
In-Reply-To: <2025042237-express-coconut-592c@gregkh>
From: Qingfang Deng <dqfext@gmail.com>
Date: Tue, 22 Apr 2025 14:34:13 +0800
X-Gm-Features: ATxdqUG9KzxmFQTU5dvsPOlSeeVHxYbPrpuLBHDg2dXNw2vevgVZuH15SM26kvw
Message-ID: <CALW65jbEq250E1T=DpGWnP+_1QnPmfQ=q92NK8vo8n+jdqbDLg@mail.gmail.com>
Subject: Re: Please apply d2155fe54ddb to 5.10 and 5.4
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, linux-mm@kvack.org, 
	Zi Yan <ziy@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Brendan Jackman <jackmanb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Liu Xiang <liu.xiang@zlingsmart.com>, 
	David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 2:27=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Apr 22, 2025 at 02:10:53PM +0800, Qingfang Deng wrote:
> > On Tue, Apr 22, 2025 at 2:06=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > All mm patches MUST get approval from the mm maintainers/developers
> > > before we can apply them to stable kernels.
> > >
> > > Can you please do that here?
> >
> > Sure. Added to Cc list.
>
> They have no context here at all :(

Let me post it again:

Please consider applying d2155fe54ddb ("mm: compaction: remove
duplicate !list_empty(&sublist) check") to 5.10 and 5.4, as it
resolves a -Wdangling-pointer warning in recent GCC versions:

In function '__list_cut_position',
    inlined from 'list_cut_position' at ./include/linux/list.h:400:3,
    inlined from 'move_freelist_tail' at mm/compaction.c:1241:3:
./include/linux/list.h:370:21: warning: storing the address of local
variable 'sublist' in '*&freepage_6(D)->D.15621.D.15566.lru.next'
[-Wdangling-pointer=3D]

