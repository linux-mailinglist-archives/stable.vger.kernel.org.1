Return-Path: <stable+bounces-105611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B27909FAE2C
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 13:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37BA3162934
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 12:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C409E1A8F7B;
	Mon, 23 Dec 2024 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6SPO3Zu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFC51A8F81
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734955933; cv=none; b=DrQwWFYosZwza5F5a/STx5+nL++ihtOgPu5qhpRqKb2G6dtNZFLqp2yyDPBeY52zPO8am3pGnugd0WYv36Af5ILAkq2Q8R/hO02S3nJwo2+D8E1LHUWeuUI75dL/GSQRCZItddCZDKaXKFYp8gUDErn+F1/WWka/9bmpAeiKk0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734955933; c=relaxed/simple;
	bh=mylY+Wh22V1R+60W9zEeniYBs/ztDkNLC07m3uYBNRI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=iG8gwoCz/5gwfW6+KFIKq6T7ILDZB5BHpLitoBfk0ul0qeSni+drBBGa5I46rEuw+YJxiWQFayw7kvR77qCvkF22wZRxYdvWgJnUMS3ETZNFvKayIV4B663k1QnugWKPq7eLxUws4Kbp0p+lAd4e+PgXNmTXsiXabnUqbkXN0yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6SPO3Zu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2161eb94cceso26104125ad.2
        for <stable@vger.kernel.org>; Mon, 23 Dec 2024 04:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734955931; x=1735560731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atjfnzBkjvD4W4mAaHRw9rPLla42LKHT/17JjiwTeTw=;
        b=k6SPO3Zu41s6TBpHJAo1J725GFl9SYQNCL+QpT4Fks9NhnqQxjaPVk1YWcOK6+vpih
         B16dt6H0PyFP8YejqYErSVwQtS3hanTXR6MRXkNFgaKnhbjeCzYNg14g95IS8h+GJlr2
         M5ITocn44jiD+c3U0OB6kkATUWAjxqE/X8KcOAwUxkr2LARcqhGg+fH54wEoEamjUvjg
         1ycM5bssZ3Z9VU9X1J5mv71m1kIROQQLdYdsNgpfN3tM1qp8Ukg9qcHwu6e1gtTNHjIH
         jXwWRA3jvcEgNiAhOjxjwhI754lcgIMZBkHAJ9O/OXqpemnVAI3w4jDRp5iYLq+e+xjh
         9sTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734955931; x=1735560731;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=atjfnzBkjvD4W4mAaHRw9rPLla42LKHT/17JjiwTeTw=;
        b=kgEA5FnesT+SV+RWqi3b2bfjgAqE3XBMQOXZoucu0CnOSdE1WSNobGTZjuSDDdxHwu
         eDNmBRdEsJQjTnsxqI4W2Coz+2V3ZtExxkPk4YZxzNziFZmEAP6DnlB4iMVSHsqLkz1o
         5SMEjmrCbUPbxMfx7QmRJvp8oOiux810vmGjW153ZZCUiAzKz4jMF0jlH2f4OMviCLoq
         5MLEyz+RnAnebWNHF4PYSVkU6Loh9pz6qCpmqSZj1Q1O2EAf/AzGEHEaTDfDV4D49ajP
         pi6zs3f6dg59Flha66Wisnqw+dmuaZNiWxXm+Dbt7oL0jI/3ISWHiN/5TTeuNHWUIpQM
         hCww==
X-Gm-Message-State: AOJu0Yz6IQQKZvo9o5TEZkW1KIP/nsJwbJ4rLWZAynWDUWSQaljWYFQf
	4jj7SSnjck2yC/GObCjq+yUDCI14iqGSrLLqPPlxNNn2SZ4De4/nssFPvA==
X-Gm-Gg: ASbGncv1hUXXlCn9/FU9md/TU1CsMeylfbz4QYZuybhO1CT2/k+b4LLw2XEACD61S4l
	qFdWjBzXnn44j5f6obHxh1UULgNer3Kwbe76DfBGZCcZ3ZcfDkEU29/TDgtSnTBGsWRsYISWZo1
	2evde6sF6EsLwfd13HvdZS0C+sarO977Ntg9Tfp8jiGt5zSZdWoVdgZV6jwSLnWIHc4YegJAj+B
	JmXYOxxaW+WqfTdph6N+S7O7H4EzfPj5SOrXfaoiIcsdMzZI0eTQoV/4jWqN0Rv0W2p+udBskvQ
	dp9Q6ljlDou/9FzKLLfBsE/JvGhBexre7Ywsj7LYoK9L
X-Google-Smtp-Source: AGHT+IGF+D7Pflo7uRm2s23lpNWOWkfWUsJWinIdATfpKV4oD4wowHhRqNYcqlUGhlLqd4Pts9LWLA==
X-Received: by 2002:a17:902:d510:b0:216:4dfe:3ebd with SMTP id d9443c01a7336-219e6f262f3mr162616065ad.50.1734955931167;
        Mon, 23 Dec 2024 04:12:11 -0800 (PST)
Received: from ?IPV6:2409:40f2:2086:5bc:38bc:6fa6:1ef8:a6fa? ([2409:40f2:2086:5bc:38bc:6fa6:1ef8:a6fa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc972ff1sm72043335ad.106.2024.12.23.04.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2024 04:12:10 -0800 (PST)
Message-ID: <773fd4e8-0de3-4a84-811b-8b2c5e2d7fab@gmail.com>
Date: Mon, 23 Dec 2024 17:42:07 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Shreenidhi Shedi <yesshedi@gmail.com>
Subject: [PATCH stable] udf: Fix directory iteration for longer tail extents
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, jack@suse.cz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Please consider applying the following patch to the 6.1.y stable tree.

Commit: 1ea1cd11c72d1405a6b98440a9d5ea82dfa07166
Subject: udf: Fix directory iteration for longer tail extents
Kernel Versions: 6.1.y

Reason for inclusion: This patch resolves a performance issue that slows 
down directory traversal in UDF ISO images. The problem affects systems 
running kernel version 6.1.y. The fix has been merged into the mainline 
as commit 1ea1cd11c. No prep patches are needed.

Link to upstream commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1ea1cd11c72d1405a6b98440a9d5ea82dfa07166

--
Shedi


