Return-Path: <stable+bounces-139430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9217EAA69E8
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 06:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B1C4C12F0
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 04:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C15C38F91;
	Fri,  2 May 2025 04:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-sg.20230601.gappssmtp.com header.i=@starlabs-sg.20230601.gappssmtp.com header.b="KgJOg8cH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8530F1A239D
	for <stable@vger.kernel.org>; Fri,  2 May 2025 04:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746161402; cv=none; b=Gw+VcSTrV1JDwy9qkP62piH2VzoFeGRAQmJvnJvDfUCCfqQ0Riy5v/rGHzDE8gz7RN9tqLBr+cyGT0kmZgztI8GPmmv2YB3BZf3cE0iRN9jMYiDg8FtBKNn5WUNRgTo+agGszM685ULs7P8Ifdz9JoWrQ52O0YykIn1KKVjxdr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746161402; c=relaxed/simple;
	bh=t7GUHBJG2OfqdZA+Y8t+F1Mmh6ETegG4Nbvqo05qsKE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jYp83gOBzMu6Yo9YQnPsAaRs20OT5Nb8akCG7IRtGyaTkObHYkgkb5VKGgbF2jaNwjNyg1uQPxBsPLy6TzBZNPA/hxYa9CtPupOIARvrTud3zEGr+/ZbcpuuTAziO2M8O0koyqqnE6QBuRDdU/cEkEk1uDYLbvexk7kFXa+l0FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starlabs.sg; spf=pass smtp.mailfrom=starlabs.sg; dkim=pass (2048-bit key) header.d=starlabs-sg.20230601.gappssmtp.com header.i=@starlabs-sg.20230601.gappssmtp.com header.b=KgJOg8cH; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starlabs.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.sg
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-acbb85ce788so364299166b.3
        for <stable@vger.kernel.org>; Thu, 01 May 2025 21:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-sg.20230601.gappssmtp.com; s=20230601; t=1746161399; x=1746766199; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t7GUHBJG2OfqdZA+Y8t+F1Mmh6ETegG4Nbvqo05qsKE=;
        b=KgJOg8cHH7QqdjXHM3l3Tv9EPAQ8z53VB9XrS0wLXXrXwcEyuTfcw8jACBRHxrthKQ
         WmNaAC6R+K6dSrTQKPJbf3c65vwbNle0Tflq99Zxap3onGJtiAf8v/JoV3l/EYZfGHJG
         TJaELEdg0DsB+kIBSrIAvgWSpEir9DOrTDhlKfTDD4KH/XXDHnX4tmW8gbDX7a1ZjwBV
         RWAASnw7W/OYzNSIC4J/pU0MzXPxN4N8a79oj9tziM54sss3UCBAUL/aN5bUG59OUBbJ
         bMktvtJ6Weanz5iL56xcZ/0hC47WRQ5bf/fjgIGKqU5Kj5ideYRnksm8XJwwCSRJzFbl
         wpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746161399; x=1746766199;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7GUHBJG2OfqdZA+Y8t+F1Mmh6ETegG4Nbvqo05qsKE=;
        b=jibdZv9P46eiZuNTrunn24vjw0iAOp0H7VCGFWoixO42nw3Mffela2SB2sDzrCtZEM
         U6HrYwW5p9k/QV9oYmFlJoHoR3yr2m6fOjhZVOiGf6zgR9r2O6wN/nNEOGa8XMw4RvIH
         SulFXAXDebfKla1zYJ0WxczN4eCkYbbMF78hGzjdrwfKaZqiGXt0NtkWOyR6lOlQkvL6
         4mqghfb81OXpatYoZrX1w+PSd2r2YOgGqUQC9/Jmq0UhnIp/CkFLK+TzGcR5DaW4atY/
         mya5y5AgkFYMEdByzuAH3dwYL0iT+OvjlqXELw65Hd5w93wE+QIA6+Vo3e00mVRhjFFQ
         iRYQ==
X-Gm-Message-State: AOJu0YyQ7OH2tjIlPnVRUifyduQD5qlTnpmJrjplVnE/KiSqWZonNMDm
	hx+REWVXGPxDhiVgHhbbDvOHPsoMOtXEmRVBTFtrctcPu9q8/KOKb+IOJdZK02CkmBKEjS/ZoAq
	SMLYfHFDzhAyuToORgh7CdKDvOIx56ZH1/qX4BEZ36eotkv/YlEsL7A==
X-Gm-Gg: ASbGnctmB50bxiuo+pfIjJU5fz3Nbnj3pAssLxbRVYBr3aynmRbJtrBwEbgDBc1va7D
	jxAC3stisginpbyuPjyU7X+xRdaFJiJVUOeVEeIRSXSuivJImrmSnremBo3ITacdJCVQG8jHASb
	TB4cSHe5gzF/qQhqKz5Vv2WavRarVBtG1J9Is=
X-Google-Smtp-Source: AGHT+IE+hk2X2O/fVRf4sh+9f1WfxFpGg4L0tIaKr4WVhkmnqLXu1YKQY6l3x9CO9eBbemy4hHwACTh65/4bHXXCOMU=
X-Received: by 2002:a17:906:9fc5:b0:ac7:16ee:9112 with SMTP id
 a640c23a62f3a-ad17a83f6ccmr150706466b.0.1746161398503; Thu, 01 May 2025
 21:49:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Tai, Gerrard" <gerrard.tai@starlabs.sg>
Date: Fri, 2 May 2025 12:49:48 +0800
X-Gm-Features: ATxdqUGAhIQWCjWAh4JKMmRbPdbMypI3wXwhcpD2Y6XYiuqqWf68eUDNW4gK8uY
Message-ID: <CAHcdcOkW1D_zKh-HPsfjX-oGYhv-OwojPXVwcA=NYoO0hcCbZQ@mail.gmail.com>
Subject: net/sched: codel: Inclusion of patchset
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev, 
	Cong Wang <xiyou.wangcong@gmail.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Upstream commits:
01: 5ba8b837b522d7051ef81bacf3d95383ff8edce5 ("sch_htb: make
htb_qlen_notify() idempotent")
02: df008598b3a00be02a8051fde89ca0fbc416bd55 ("sch_drr: make
drr_qlen_notify() idempotent")
03: 51eb3b65544c9efd6a1026889ee5fb5aa62da3bb ("sch_hfsc: make
hfsc_qlen_notify() idempotent")
04: 55f9eca4bfe30a15d8656f915922e8c98b7f0728 ("sch_qfq: make
qfq_qlen_notify() idempotent")
05: a7a15f39c682ac4268624da2abdb9114bdde96d5 ("sch_ets: make
est_qlen_notify() idempotent")
06: 342debc12183b51773b3345ba267e9263bdfaaef ("codel: remove
sch->q.qlen check before qdisc_tree_reduce_backlog()")

These patches are patch 01-06 of the original patchset ([1]) authored by
Cong Wang. I have omitted patches 07-11 which are selftests. This patchset
addresses a UAF vulnerability.

Originally, only the last commit (06) was picked to merge into the latest
round of stable queues 5.15,5.10,5.4. For 6.x stable branches, that sole
commit has already been merged in a previous cycle.

From my understanding, this patch depends on the previous patches to work.
Without patches 01-05 which make various classful qdiscs' qlen_notify()
idempotent, if an fq_codel's dequeue() routine empties the fq_codel qdisc,
it will be doubly deactivated - first in the parent qlen_notify and then
again in the parent dequeue. For instance, in the case of parent drr,
the double deactivation will either cause a fault on an invalid address,
or trigger a splat if list checks are compiled into the kernel. This is
also why the original unpatched code included the qlen check in the first
place.

After discussion with Greg, he has helped to temporarily drop the patch
from the 5.x queues ([2]). My suggestion is to include patches 01-06 of the
patchset, as listed above, for the 5.x queues. For the 6.x queues that have
already merged patch 06, the earlier patches 01-05 should be merged too.

I'm not too familiar with the stable patch process, so I may be completely
mistaken here.

Cheers,
Gerrard

[1]: https://lore.kernel.org/netdev/174410343500.1831514.15019771038334698036.git-patchwork-notify@kernel.org/
[2]: https://lore.kernel.org/stable/2025050131-fragrant-famine-eb32@gregkh/

