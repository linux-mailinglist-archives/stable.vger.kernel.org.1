Return-Path: <stable+bounces-203185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FEBCD4A10
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 04:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 234D53006638
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 03:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E984262808;
	Mon, 22 Dec 2025 03:30:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E16419992C
	for <stable@vger.kernel.org>; Mon, 22 Dec 2025 03:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766374206; cv=none; b=ZXsPfG552Ky5GY0V+Cd/i93qv5kgQWctzY8bJcbxiW3GGMiFxRbMNbydjzjsmrW4ZtEXkzDBdMvMHssWrJm9boLJ9nz3udf6+BEm04ko5SDl5DG0GCoaLMKumr3VBIBR+T6IHr3IP55vaMJHaZqv9saFRcqCdmfOaJtcUDzHjZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766374206; c=relaxed/simple;
	bh=uH4UtAkf8iUZI4dOy47MKLzYfCX/Ef0xfvPgJ97O5h4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hN+HQr6PvxmN/CZ18Homo1RZj58Bql8HyHkjlqC2s31NlZMfTVGvEF3d0X1b7wddXdvxK712W+yQUNmZPGU1+FfMUs93Ha3AFRTaqKqNcKxmTfkHIAZZmIalcLHu9hSWhq4O796nkITTJL0RbXeSY2VfhlBE4EV6IDZRevWihRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrADnlzgeu0hp_WEOAA--.28286S2;
	Mon, 22 Dec 2025 11:29:34 +0800 (CST)
Received: from ubuntu.localdomain (unknown [10.12.190.56])
	by gateway (Coremail) with SMTP id _____wCnr6seu0hpDu4GAA--.1830S4;
	Mon, 22 Dec 2025 11:29:34 +0800 (CST)
From: Zhaoyang Li <lizy04@hust.edu.cn>
To: gregkh@linuxfoundation.org
Cc: broonie@kernel.org,
	d-gole@ti.com,
	dzm91@hust.edu.cn,
	lizy04@hust.edu.cn,
	stable@vger.kernel.org,
	theo.lebrun@bootlin.com
Subject: Re: [PATCH 6.1.y] spi: cadence-qspi: fix pointer reference in runtime PM hooks
Date: Mon, 22 Dec 2025 11:29:33 +0800
Message-Id: <20251222032933.7104-1-lizy04@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025122106-value-precook-634a@gregkh>
References: <2025122106-value-precook-634a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrADnlzgeu0hp_WEOAA--.28286S2
Authentication-Results: app2; spf=neutral smtp.mail=lizy04@hust.edu.cn
	;
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr4rWFWfXr4rJF1UCr45Jrb_yoW3uFbE9a
	1FvrykCr1YkFy2qanIya4fZFs5Gay5uw18Z348XFnrGFnYy3s2vFsaq3s8A348uFZxCF1D
	t3ZIqw4akr1akjkaLaAFLSUrUUUUeb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbmkYjsxI4VW3JwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
	0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMx
	AIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IUnb4S5UUUUU==
X-CM-SenderInfo: rpsqjjixsriko6kx23oohg3hdfq/1tbiAQAEB2lHdLc5pgAAsw

After using an LLM tool to generate an initial version of the patch, 
we conducted a strict and thorough manual review to avoid any potential 
issues. We ultimately confirmed that the final patch is identical to 
what would have been produced by a purely human-written approach before 
submitting it.

At the time, we had similar concerns regarding AI-assisted contributions, 
but we did not observe a clear consensus within the community on this 
matter. As a result, we chose to mitigate any potential impact through 
rigorous human review.

That said, we appreciate the discussion and understand the importance of 
transparency in this area. We are happy to follow any community guidance 
or emerging best practices regarding disclosure of AI-assisted development 
going forward.

--
best regards,
Zhaoyang Li


