Return-Path: <stable+bounces-28577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B263886213
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 21:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1906FB22170
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 20:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A38975809;
	Thu, 21 Mar 2024 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=khvoinitsky.org header.i=@khvoinitsky.org header.b="O9SRlsAt"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04395660
	for <stable@vger.kernel.org>; Thu, 21 Mar 2024 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711054221; cv=none; b=cTx08gOdNhxwZDnmeVdlDqhskkij+JnMJVnf/qff8UXluYJljteFq2fO91WpF/4p1G104aL5nqEpWZd6QaqH1tjgWX0qtYeKa142kU5AdBEmHZMjguKNAQhdAzRaIS4n0vXlnh6yhcatKvtiiCNVIO9dDfKwd6x3mlds5CVje8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711054221; c=relaxed/simple;
	bh=lyUypQrVN4O8tfJ0GFAGFkfxTL3j7sk4s2KlUY9ZkWc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=vBUfhosJ9POLV/t1B/fUSIH34f8gB86ChXNZVjATIRvCFLH1hk8cYDCl1ZilUrCpQ5GJgaGrPGxket74pcrvQZm5dZPZdnVtPpiYC4CvFc2gzS0rR6KfB/8kHAlwM2RqUsQ5aEA3ZCCPG1b/BzhHcgaZetMRSylS/QBj0pgo4BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khvoinitsky.org; spf=pass smtp.mailfrom=khvoinitsky.org; dkim=pass (1024-bit key) header.d=khvoinitsky.org header.i=@khvoinitsky.org header.b=O9SRlsAt; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khvoinitsky.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khvoinitsky.org
X-Gm-Message-State: AOJu0Yy7syLz+qEy8cwNpPQQeWTbkRlyHZpySj8DFMmU7/vTrva9BAft
	cy9RVvn2qWIc8JW8FLbzVRsqfiEsETepZDYe9ir9TV+HWNXFRxgTx3HhFf1+Z36KZW59koSS4GP
	oE81eA10seUj2haEvVNwUit8pUWY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khvoinitsky.org;
	s=key1; t=1711054212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=lyUypQrVN4O8tfJ0GFAGFkfxTL3j7sk4s2KlUY9ZkWc=;
	b=O9SRlsAtavy0oUW+/4YES+gTJwvpvnHmq5rsr4kOqtt3yqG2cOLqGAMI8s46HSpdpumuK2
	faTNGdr4KxjKaJ7dYjcR8UBuKJhUXG0SmY4Bm0sFbMRrPvBWXvI12Ociww3Jsaj1DLqm98
	jniki7rYt+kzYI/YjX/1JfaztsGILh0=
X-Google-Smtp-Source: AGHT+IHvG3vX3AyaXV2BPuThCv0GCxGhTV6OK04iAiP1XON8NpRbImEqhOD/drxVS7nHyE4oopHaqiBUCYspmVoh6Ok=
X-Received: by 2002:a2e:7013:0:b0:2d6:a8f7:b999 with SMTP id
 l19-20020a2e7013000000b002d6a8f7b999mr11887ljc.4.1711054209926; Thu, 21 Mar
 2024 13:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Mikhail Khvoinitsky <me@khvoinitsky.org>
Date: Thu, 21 Mar 2024 22:49:58 +0200
X-Gmail-Original-Message-ID: <CAMMabwOKjVhqvCRQOw==hJL80xCaUCJtr2O-5-Qbr=a7jNv51Q@mail.gmail.com>
Message-ID: <CAMMabwOKjVhqvCRQOw==hJL80xCaUCJtr2O-5-Qbr=a7jNv51Q@mail.gmail.com>
Subject: cherry-pick request into stable for: HID: lenovo: Add
 middleclick_workaround sysfs knob for cptkbd
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

Hello,
Please, add the following commit:
2814646f76f8518326964f12ff20aaee70ba154d HID: lenovo: Add
middleclick_workaround sysfs knob for cptkbd
Into stable versions: 5.10, 5.15, 6.1, 6.6, 6.7, 6.8
This versions received automatic backport of my previous attempts to
detect properly-behaving patched firmware which suffer from
false-positives causing regression for users of factory lenovo
firmware. The commit adds an explicit sysfs control hence avoids any
room for false positives and fixes the regression.
Thanks.

