Return-Path: <stable+bounces-120223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FA4A4DAC3
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 11:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E583A2E79
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 10:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A2A17BEB6;
	Tue,  4 Mar 2025 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b="VvF/7ktm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D801EC00F
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084409; cv=none; b=nTSxjMg56e6V5Imst8HiTA7UgXYNXrKeW6AtcVgKqbfCEp0qAfbe529Ttbg2GTVev9Hztk1ZFPzbcO/AIISXwF7uHgRUDWJYdjjWiTipQHHfaiH3uKJJFqX9TRbIH5XaaSviJyZj8qgcSlEceaCr9z/aRcT+FehtuJjIKEaXRD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084409; c=relaxed/simple;
	bh=XYQO0aGcai5r/Etb8m+HZhlol7Bo0XWaJF+1VWhGLJM=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=EHcE7l6lxG8ZjAnwtPrNH1F2Cth9CaAqFWTMD5uPAipK7jO1gDwCzPtwbOBg4NhAYHN9Z304N3CFJOZx/8JBu9cam4jk0RDCy1t6AJMGEPWyK2c4/PIwouZJKFoTqR+ONTOtEkNTZeT2crtBxn9XX55+44AAHkNACQ+4GDYwu0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=swine.de; spf=pass smtp.mailfrom=swine.de; dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b=VvF/7ktm; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=swine.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swine.de
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390df942558so4254024f8f.2
        for <stable@vger.kernel.org>; Tue, 04 Mar 2025 02:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swine.de; s=google; t=1741084406; x=1741689206; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYQO0aGcai5r/Etb8m+HZhlol7Bo0XWaJF+1VWhGLJM=;
        b=VvF/7ktmo8zWAO9FDeFfEYjTMwrkS3F9xzTJYaH1AhBydZCmGpcyzmpf6jSUi2ERc5
         LqqclGoumbrJIHZv6u8QpmDpYVjIwudXZ3TIwJ2+yMq/CfmgABhq/iY05zBIJLerb5mP
         h5tcwD1Msgm3OP9G19FTiPXh7cMOkM0KviyYYN0vqoCSVaXfZiaybWkKuIX4lhWCkSnW
         8xHIFidbhIy1IeVqkag50XLq9DQByhkf3S7g8UJYfpiT5wrRl/VVOfHydmLwwNap6r4A
         yjxZRv0e9EKLjpirZHJK+BmGnv+V+RuaE6btBbd4N0e3zOuXAY7MKQPmCOAC7JqH6vCG
         z2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741084406; x=1741689206;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XYQO0aGcai5r/Etb8m+HZhlol7Bo0XWaJF+1VWhGLJM=;
        b=vCUBH8wfh8zkhVCbQbTPdswrwyS3uZybioVCn8IZ99xSCqOKPAKR//7pSmV3MVSlDg
         JyajT/3XfBA8DBDPRn3uqcBuk1fyHlL6nQ1HiJg20+H0ckmrirtckYJKLdY5k+owx3OY
         rpkGgP5YIuhRxv9mjRvFkZWJRVOXReyecYs6cqbqx3m390SXcRgEduON6hNPXm3xnA2e
         cjJfJ8H0e6zXUM5oHNQiTLeGPBQ2yN1EGhR9P9GLxj3NCmytCNzhhyPvwuqzOMey6DLp
         +XfHsfJGpdrCgjhyrj25lGoey44E8rUBy9TNsvhOZyG2wzvMicMAsrTAxjO/Krkp8CFe
         aJSg==
X-Gm-Message-State: AOJu0YyGmo0j+S7j0L0YdWwfEHkknVZ1mud4CfDi9etyiPE7Phd/Is11
	vA+dgV+1t4X4m9KvWl5dZKExNm2qFXDHttQ9AYANwUD8sM4A8P1B9Jzi4IWkCiTUU3i1pCXdGzB
	2N9E=
X-Gm-Gg: ASbGncv/NXUFboLN3LFPg24WiRU0VB/hwUION1KSH1Z/QOhfoogBpVLmWksP/v9Clcy
	0+/j+NjHWUOC73ypOL7GoOqnDUQ6DVA1JB9xqmG1NQfxP5yfe+bg3AJD7y9OrBACUfspILCv7OP
	vqwCiC5KVqgYDyT/RtxWgyafwWLMbO7chqnGKOh26OVUXTRusPPxxWVmwtMqz5WT5Ao3ETbvF0j
	eJIOu8MyxxJsHuCJAvhdAbn+geuVkOxAdgkn1o/8k+baGnpb5c2KxSw75XTjCR0Ftk0z0sv9fnX
	rR1xNmYton8Uqf4CPlLfLFSX/WPg3xjo2+vKvtfNuupFq2ebfxR7HFWPxTpwUkOSdhR4+RXVJyb
	yI24IQxtlk6yzJ259nP94Fm53Um66MQ==
X-Google-Smtp-Source: AGHT+IGVMZo6vZ+6m+6BM/f63VhKf7ZZ84g2yeayp4xyDuWaoA5bfrmXVVwime6pCBYd6DiG2wMFmw==
X-Received: by 2002:a05:6000:2a1:b0:391:ae6:1312 with SMTP id ffacd0b85a97d-3910ae613e9mr6437829f8f.45.1741084405983;
        Tue, 04 Mar 2025 02:33:25 -0800 (PST)
Received: from ?IPV6:2a02:6b67:d118:f400:3597:9f03:622b:da8b? ([2a02:6b67:d118:f400:3597:9f03:622b:da8b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4847e62sm17441453f8f.67.2025.03.04.02.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 02:33:25 -0800 (PST)
Message-ID: <f32da38f-d313-48ed-9ca6-7da210b08f8b@swine.de>
Date: Tue, 4 Mar 2025 10:33:24 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: stable@vger.kernel.org
From: Christian Simon <simon@swine.de>
Cc: regressions@lists.linux.dev, jolsa@kernel.org
Subject: [6.1.y][6.6.y] uprobes: Fix race in uprobe_free_utask
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear stable team,

I noticed that cfa7f3d2c526 ("perf,x86: avoid missing caller address in stack traces captured in uprobe"), got backported into 6.1.113 and 6.6.55, but it contains a race condition which Jiri Olsa has fixed in mainline b583ef82b671 ("uprobes: Fix race in uprobe_free_utask"). I think this should be backported into those stable branches.

#regzbot title: uprobes: Fix race in uprobe_free_utask
#regzbot introduced: cfa7f3d2c526
#regzbot link: https://lore.kernel.org/all/20250109141440.2692173-1-jolsa@kernel.org/

Link: https://lore.kernel.org/all/20250109141440.2692173-1-jolsa@kernel.org/

Note: Sorry if I am using the wrong process/form/format, I tried to follow "Option 2" from the stable-kernel-rules.html.

Best regards,
Christian




