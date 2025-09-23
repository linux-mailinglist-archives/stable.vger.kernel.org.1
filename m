Return-Path: <stable+bounces-181465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FFBB95885
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 12:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438D34A3BD2
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 10:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB2632144D;
	Tue, 23 Sep 2025 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="obz8Q7fe"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872D4321444
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625048; cv=none; b=BO48MNA1guHSDDCwVw53FbZX2Lcw1W95Mmt86Y9Phb4InSR2+4VRlHM8zqkASqx+cFArcjTupb7sfWHyNQeKudal3bczDu/MAZoMqFOUw0m3kUxAn886BwTvDa4hmykGNygfA5CT28Xknda6T2Yt+3ZfOABxYPfWH8wPe9PYVgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625048; c=relaxed/simple;
	bh=2MeXdCvURTAzTkx6QMrHRp3S9A86YdzLDwHjZbC85GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYQTtRawZ73NuSViJLt9TcTrg/UIVL+Q/ZDVmc2mr/CFvE8xww83sV5AGLkibPEhdv3KAFLsbw8lZytS528wenE15plkXqWOelkn1Lb/sFAE2OOBQLOhCM1ZrARn81ZVeJUQA6z1yc24FGW9hSGD3oY4NTmGVM4iob2fgUk6A/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=obz8Q7fe; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b61161dd37so35463001cf.3
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 03:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758625045; x=1759229845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2MeXdCvURTAzTkx6QMrHRp3S9A86YdzLDwHjZbC85GA=;
        b=obz8Q7fe5LBkTIYZ3NmPerF6qas5s+UrHsjnvSndrBrgV0iPTJ74xVIMWZCpy7Fw6F
         EhRej21X55jgkWuxaSbt5uRPqlxK/vN9ZH1q9JU3lgduw9d+iBWeVbfqswDjlKvJIUQl
         kwseM2zeOykEi93MJYTkti7Sx8c17uOI17Weg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758625045; x=1759229845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2MeXdCvURTAzTkx6QMrHRp3S9A86YdzLDwHjZbC85GA=;
        b=TtxXV2TULtM+mvLF89c8ovvTYsPa7pb3yJ+0oS1G3fDkncM4P0aWsEvXVD9KWtL46W
         AA3uaeYUjhoaqZvJxUVpu/iDxTSpo2RSSOxT/c3lMvscKBITZItL5IvBzVFDQCVrraUE
         iZmFkex+bFtKO7AVnESyV2ukY09W9DzNAKR6Z6JpgrmciwJpL6+gMXx5QO7FeycLiIZD
         FDQtpsXElvz5e9JLILeCu5t89oVlXTRzaNItQ24tYDDjiF+gzk+YHuyJfeMqNkkb8nkg
         9rVefMhnrIJdizbOzw9IIspEM1POum1orkc2iDQgpDNoUlD7pTPa3pmJ8M7D0B23iez3
         MDsg==
X-Gm-Message-State: AOJu0Yyp+VrQC3y/u0SnJRGWT3QPdPfO6jdNqPPC8ac8p3ddcSm67Ali
	eYVgd6Pb670Rca2PEjeSXrf5Lv7YFQkgp20VFM2hh1YlmVlpI23ZvAzSMPe1yp7n6zbC6Eq5Fk0
	XObdWJ5zktIFxeBC/ItQGAVowDFJ8fhHG14N9GlEZKQ==
X-Gm-Gg: ASbGncv/25Whe0qwNtO5DzUva5HfJYpilvIPpttD4o1TxjahGiJ2kAwhMpR8RjpXgvn
	hn6ph9woeheLvtyra+dII9hxo3uyDvljZiRkL1PoFD+4EJZkIDch2KpXjYuq1LhcS7RAqfZS8hr
	vnHcU2/Pg5vGPK4+9GtRmvAvg3k+tYFlZcYVbBHusOwMiN57Z1KhPfb3jqfVV+JrIbOo7Fe9omd
	W6/EFnqHGBY6YVbLou5mEE0sfOV5IV6OPvqEYY=
X-Google-Smtp-Source: AGHT+IEX2FQnjqBT2nQROo/GmnwQJfhYdbUuQlAtXjIqq8yTbxUzJNVyAUEw1AzJLuqsGAuVc3X8Dzc7i/5z5z12nKQ=
X-Received: by 2002:a05:622a:1ba7:b0:4b7:964d:a473 with SMTP id
 d75a77b69052e-4d36e7cf86dmr22388341cf.52.1758625045299; Tue, 23 Sep 2025
 03:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs> <175798150049.381990.18237050995359031628.stgit@frogsfrogsfrogs>
In-Reply-To: <175798150049.381990.18237050995359031628.stgit@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Sep 2025 12:57:14 +0200
X-Gm-Features: AS18NWDgcLlZa783VDIvuFp9dEh3HG2MSYk9_Y7d4QE4zvlotxO9EgkDJG273xY
Message-ID: <CAJfpegvQogdf_NaiOk2GqCBYYL0qwOrJRLOV-b8HnUj0iPPXGQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] fuse: fix livelock in synchronous file put from
 fuseblk workers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: stable@vger.kernel.org, bernd@bsbernd.com, linux-xfs@vger.kernel.org, 
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Sept 2025 at 02:24, Darrick J. Wong <djwong@kernel.org> wrote:

> Fix this by only using asynchronous fputs when closing files, and leave
> a comment explaining why.
>
> Cc: <stable@vger.kernel.org> # v2.6.38
> Fixes: 5a18ec176c934c ("fuse: fix hang of single threaded fuseblk filesystem")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Applied, thanks.

Miklos

