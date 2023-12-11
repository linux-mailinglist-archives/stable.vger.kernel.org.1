Return-Path: <stable+bounces-5237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B5F80C03C
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 05:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A388280C77
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 04:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2FE1773D;
	Mon, 11 Dec 2023 04:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH77WJn5"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8777F1
	for <stable@vger.kernel.org>; Sun, 10 Dec 2023 20:05:48 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5d226f51f71so38406287b3.3
        for <stable@vger.kernel.org>; Sun, 10 Dec 2023 20:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702267548; x=1702872348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6c5XEggOqw3xk9aoSU9rt14kv8urnuainESwl7WN7lo=;
        b=lH77WJn5V07OSNqtg6AHeCNZf8jiJVTctQXKx108yU7HkkIz2Yzk6z6Mir4d+xiIf9
         mEBc24VmWMisXq3pL4ZxJIAV6CGa7hMGF9H7eZGTXbELgalKDXzkKm20jKdE11pw10ul
         dvU9i+WmjyLd8RUJFhJqGafsRdWwZSBDxomMR39QCF1kbqQ0ig7XeZ3BHSobpKG31flm
         o1+8mys61YhTQgTxRjGkMHQvEqGQ8q+FqnO3eT6IBV5nWed3ZJqm0iXNfqrMy6QX68I3
         uUHBCswG3AGjfym0ppUiU1fLd0EHsVWe/cdFKgPubQ1kHLVszvrw6PGnIhRKV+50jEJF
         yitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702267548; x=1702872348;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6c5XEggOqw3xk9aoSU9rt14kv8urnuainESwl7WN7lo=;
        b=jlkED62koe9lRYB7ifKFcoQLblvHQhgvQPFOhzkC9hknTvKFdePpUM8G8ezZpOnrTl
         gdJDXuFjc7Uac+qT+EdzH9kA1lHhkRw/nSw7wEClxOwPdFcd9YNt91w2+5Stwkdvhdxw
         h4Jy9mclYWKmGMfBrn5c3EcUwsPAEwS9kwVrA8GAkTKupgAsKe36I56l60YdT84GGzGj
         fe+7Hmqw1wG0L2Yvoan60NC/OpHcUnoELI2l05V+RzB/oNefUJxx1WK6uR5SAroK0c7U
         zrkMNFgBcjoWSnHf+TwpwMlAGswne9h5Q7cDms64BP/UrmqVqQbZcxMIQNJQKZBLR3cj
         Ejsg==
X-Gm-Message-State: AOJu0YyAwHbOBAeW/P+j25lWYxe49momGMJITvVlqs972e13C3mjfqzP
	NEMcGHzqHJVxoR/T2g9gBx7SOLpfkWm77kn2/d//qaWb7G9weg==
X-Google-Smtp-Source: AGHT+IGbMT55xsUUhGQ1HM7u0rXiQOgklpYEX9qZI6z3e+8DmgG6ztCKLvda5CWlBoupdwLHcCEjGep3VTf6L8K/Xww=
X-Received: by 2002:a81:7c45:0:b0:5d9:50cc:b8ed with SMTP id
 x66-20020a817c45000000b005d950ccb8edmr2908389ywc.86.1702267547989; Sun, 10
 Dec 2023 20:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Simon Kaegi <simon.kaegi@gmail.com>
Date: Sun, 10 Dec 2023 23:05:37 -0500
Message-ID: <CACW2H-4FpZAizkp+U1aS94V_ODn8NUd1ta27BAz_zh0wo63_rQ@mail.gmail.com>
Subject: [REGRESSION] vsocket timeout with kata containers agent 3.2.0 and
 kernel 6.1.63
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Sasha Levin <sashal@kernel.org>, jpiotrowski@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"

#regzbot introduced v6.1.62..v6.1.63
#regzbot introduced: baddcc2c71572968cdaeee1c4ab3dc0ad90fa765

We hit this regression when updating our guest vm kernel from 6.1.62 to
6.1.63 -- bisecting, this problem was introduced
in baddcc2c71572968cdaeee1c4ab3dc0ad90fa765 -- virtio/vsock: replace
virtio_vsock_pkt with sk_buff --
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.1.63&id=baddcc2c71572968cdaeee1c4ab3dc0ad90fa765

We're getting a timeout when trying to connect to the vsocket in the
guest VM when launching a kata containers 3.2.0 agent. We haven't done
much more to understand the problem at this point.

We can reproduce 100% of the time but don't currently have a simple
reproducer as the problem was found in our build service which uses
kata-containers (with cloud-hypervisor).

We have not checked the mainline as we currently are tied to 6.1.x.

-Simon

