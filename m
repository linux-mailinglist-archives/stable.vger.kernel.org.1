Return-Path: <stable+bounces-56140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 811CB91D1AE
	for <lists+stable@lfdr.de>; Sun, 30 Jun 2024 14:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B315B2118C
	for <lists+stable@lfdr.de>; Sun, 30 Jun 2024 12:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BC013C819;
	Sun, 30 Jun 2024 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JDAZiGDw"
X-Original-To: stable@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD0513C3E6
	for <stable@vger.kernel.org>; Sun, 30 Jun 2024 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719752179; cv=none; b=iWnzNTuL2dpn9PlKCY6u1FN9hF8WRKuqsyiRU8HW4SMejJLqnKF4BMHIaHcxVush5X/Wh6QyY1TqcNHizCTn3pj2ICGWUMpaaVPoocWPQRVmI0KNE+Q3765Y7gdrtUnjxtRjm1fL30HhgikHj/qjCmRA08XMN3Kj0wKZd8Bw0mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719752179; c=relaxed/simple;
	bh=0fGGM/cnm8TLoI2UtGNDqB1b2u27qgt1I6bMTAbwuZ4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=umgm4yAq2oVl23Wg0jHc4kqi9sqh/vXtDsW+HdSgfEqiU4lAjDP7ugM9dRzYIvSAKELpUp7XzSitEU8Rxh+SsHGI5BDPny6q4OmM/nXWK1lfwE5CLjzZfDM1hTjvaEQzXYYSWbZxLfF7PnKDRkTobIZju70TtlehJLu4nzqeanU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JDAZiGDw; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719752168; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=0fGGM/cnm8TLoI2UtGNDqB1b2u27qgt1I6bMTAbwuZ4=;
	b=JDAZiGDwGS+wjr7mBT25qzMWcPQ18HFaGoPAvlZAcF/W2ZPKxqt9A8v7ig2CrrbQ5XSGSmxqk645vUx8aTz97wIi7sf2gT9Pv5qOEk4WrspLoAGYMcjABPMZIXVoxUIGM2RFV4cC9DqhA8nnMdmidlI5zH4P59uziIy9qH7wGT4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W9Vcche_1719752157;
Received: from 30.236.42.42(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W9Vcche_1719752157)
          by smtp.aliyun-inc.com;
          Sun, 30 Jun 2024 20:56:08 +0800
Message-ID: <d11bc7e6-a2c7-445a-8561-3599eafb07b0@linux.alibaba.com>
Date: Sun, 30 Jun 2024 20:55:56 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wen Gu <guwen@linux.alibaba.com>
Subject: Please backport d8616ee2affc ("bpf, sockmap: Fix sk->sk_forward_alloc
 warn_on in sk_stream_kill_queues") to linux-5.10.y
To: stable@vger.kernel.org
Cc: alikernel-developer@linux.alibaba.com, Wen Gu <guwen@linux.alibaba.com>,
 Dust Li <dust.li@linux.alibaba.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 mqaio@linux.alibaba.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi stable team,

Could you please backport [1] to linux-5.10.y?

I noticed a regression caused by [2], which was merged to linux-5.10.y since v5.10.80.

After sock_map_unhash() helper was removed in [2], sock elems added to the bpf sock map
via sock_hash_update_common() cannot be removed if they are in the icsk_accept_queue
of the listener sock. Since they have not been accept()ed, they cannot be removed via
sock_map_close()->sock_map_remove_links() either.

It can be reproduced in network test with short-lived connections. If the server is
stopped during the test, there is a probability that some sock elems will remain in
the bpf sock map.

And with [1], the sock_map_destroy() helper is introduced to invoke sock_map_remove_links()
when inet_csk_listen_stop()->inet_child_forget()->inet_csk_destroy_sock(), to remove the
sock elems from the bpf sock map in such situation.

[1] d8616ee2affc ("bpf, sockmap: Fix sk->sk_forward_alloc warn_on in sk_stream_kill_queues")
(link: https://lore.kernel.org/all/20220524075311.649153-1-wangyufen@huawei.com/)
[2] 8b5c98a67c1b ("bpf, sockmap: Remove unhash handler for BPF sockmap usage")
(link: https://lore.kernel.org/all/20211103204736.248403-3-john.fastabend@gmail.com/)

Thanks!
Wen Gu

