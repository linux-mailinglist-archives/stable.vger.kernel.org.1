Return-Path: <stable+bounces-35676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBDC896547
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 09:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4CB283ECD
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 07:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E68524B4;
	Wed,  3 Apr 2024 07:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtiuwaLI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3899F17BC2
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712127897; cv=none; b=PjzE9/BQWeebg1IzpbhZm8W5CSL/qd67cKGfuP1sQp/iGeKN1PBxZ0vfmZVE6/Jg3G0PksBSUK1NAnDBEvkiKv085wVvdgW50fb4vVA0jMsBDEF7q9nTLB0RPA0UqvYDz5KscZ8QuVlUbTxyq6j+1y3b7p6RyrE0pPhRdY6tPKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712127897; c=relaxed/simple;
	bh=0uWJzMULft747n+5c/jH6bnuuYZhYqNIQXDSFL6zn2U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=L+x3sDrZbVxZ7gv9P/JFmvfHCK0qO9jRt6O+zhqDCldpBI6aYh5WV2zFFpaU97UnJq2juIPRMXwLAK5wvrp2zWtx8XCSDYoTvcyT/pfLh8Tok1MsH8Ylh21IvQw57PzTWfqTYFp8kmTgbvYTcpaniBLRKAH48b7VwAppNaj0lJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtiuwaLI; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4702457ccbso756014866b.3
        for <stable@vger.kernel.org>; Wed, 03 Apr 2024 00:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712127894; x=1712732694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0uWJzMULft747n+5c/jH6bnuuYZhYqNIQXDSFL6zn2U=;
        b=ZtiuwaLIkXe1wX0bb4R/+Ah1XPj+txwFbgk4W9LRF5kPeOc0BodQViz63PKXkKadn/
         eEGyTt/050eOHPDKjGHGq1n0jgQoENKjBW3GpKUzrmCdEYPyFY7cs+vlclzwo7IyXJ1z
         vPnpqTACdgaUvBAsEr+4I0T2FLh4pISGea0oweaeOQxrFTVpBJWIwg5paD76uRuDKo41
         N5MPhSeWiOszxK9A8Q7cfq77NOuETSGFoNuhHw08ZmHls7EaK2EmiutIxyR9aA+RJ46L
         iKKAFJO+CHGNmSlGvjLIpb1Az99zyhucEAbEp+qwiGDMhHoGzyNFTXuru7s6DtJkM/aq
         h5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712127894; x=1712732694;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0uWJzMULft747n+5c/jH6bnuuYZhYqNIQXDSFL6zn2U=;
        b=al05mSWkeH2oN16qyb3+N52hfigb60hFfkOZkm78N3MUFzL35syix8nlfqgdnBhbDS
         m1QSO6pz4aLCoE0aDYa7gV42Z1t5XwoTym90YHAk5NuFapv7hmr1kUnNUQpaxGsv4cmS
         4zxRuOlQFPG0HycDO9ri5d5BQHlVDF2haVrFoHPWq1+2Z9Zcwpe6+IyfzJlJEKJUlcH+
         EndKDtDdGHaDOeUHfbU8XHKi7u7Sa9KgT7GhEHBoAHaaPMb/SAogNwgrO2J2gfpmbQV5
         ssugzifINEE6tRQ59jkMM9PQ5XZUmLoaeUmTryMjGq5nLKIXnKMRYwzts0TBLK5cPu3y
         T08g==
X-Gm-Message-State: AOJu0Yym783vqC3ow20TeKxsOFHXxtcTl/CcpVCLyYQ50LgTqph3sOdK
	5ECjV2pYkJT0iZ+Z6YJxUxnNvi/fedCb6cEGx9xZ+mRNRcNkVFIlCUUDyxqYD/VyK0bI1UBCOiY
	gpgw3tY2JWN378Olo1Bzm162JjobOMztnV6c=
X-Google-Smtp-Source: AGHT+IEZJ4c6T5ribNqRTIl6J5XrEna0+lCRNAT+bUsW4ZJuq+H4vlRtWt8KT6oYwP0lCYGnfbgPvE1ALaeCo8gfY/o=
X-Received: by 2002:a17:906:f202:b0:a4e:70f:dd11 with SMTP id
 gt2-20020a170906f20200b00a4e070fdd11mr8808196ejb.25.1712127894166; Wed, 03
 Apr 2024 00:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Meetakshi Setiya <meetakshisetiyaoss@gmail.com>
Date: Wed, 3 Apr 2024 12:34:43 +0530
Message-ID: <CAFTVevX=yujOXoDJYRJWuPgvWfVYUL5ZmoKfy_3u5qHi741Sag@mail.gmail.com>
Subject: Requesting backport for fc20c523211 (cifs: fixes for get_inode_info)
To: stable@vger.kernel.org
Cc: Steve French <smfrench@gmail.com>, Shyam Prasad N <nspmangalore@gmail.com>, bharathsm@microsoft.com, 
	Shyam Prasad N <sprasad@microsoft.com>, Meetakshi Setiya <msetiya@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

commit fc20c523211a38b87fc850a959cb2149e4fd64b0 upstream
cifs: fixes for get_inode_info
requesting backport to 6.8.x, 6.6.x, 6.5.x and 6.1.x

This patch fixes memory leaks, adds error checking, and performs some important
code modifications to the changes introduced by patch 2 of this patch series:
https://lore.kernel.org/stable/CAFTVevX6=4qFo6nwV14sCnfPRO9yb9q+YsP3XPaHMsP08E05iQ@mail.gmail.com/
commit ffceb7640cbfe6ea60e7769e107451d63a2fe3d3
(smb: client: do not defer close open handles to deleted files)

This patch and the three patches in the mails that precede this are related and
fix an important customer reported bug on the linux smb client (explained in the
mail for patch 1). Patches 2, 3 and 4 are meant to fix whatever regressions were
introduced/exposed by patch 1.
The patches have to be applied in the mentioned order and should be backported
together.

Patch 1: https://lore.kernel.org/stable/CAFTVevWEnEDAQbw59N-R03ppFgqa3qwTySfn61-+T4Vodq97Gw@mail.gmail.com/
Patch 2: https://lore.kernel.org/stable/CAFTVevX6=4qFo6nwV14sCnfPRO9yb9q+YsP3XPaHMsP08E05iQ@mail.gmail.com/
Patch 3: https://lore.kernel.org/stable/CAFTVevX6Yzjm40EoGZzex6G-f3T-YNG2CZMAuy=fBSwx9hm8Jw@mail.gmail.com/
Patch 4: The current patch

Thanks
Meetakshi

